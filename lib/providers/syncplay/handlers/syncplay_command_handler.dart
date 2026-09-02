import 'dart:async';
import 'dart:developer';
import 'dart:math' show Random;

import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/time_sync_service.dart';

typedef SyncPlayPlayerCallback = Future<void> Function();
typedef SyncPlaySeekCallback = Future<void> Function(int positionTicks);
typedef SyncPlayPositionCallback = int Function();
typedef SyncPlayReportReadyCallback = Future<void> Function({required bool isPlaying, required int positionTicks});
typedef SyncPlaySetSpeedCallback = Future<void> Function(double speed);

class _ParsedCommand {
  const _ParsedCommand({
    required this.command,
    required this.when,
    required this.whenStr,
    required this.positionTicks,
    required this.playlistItemId,
  });

  final SyncPlayCommand command;
  final DateTime when;
  final String whenStr;
  final int positionTicks;
  final String playlistItemId;
}

class _PendingCommand {
  const _PendingCommand(this.command, this.when, this.positionTicks);

  final SyncPlayCommand command;
  final DateTime when;
  final int positionTicks;
}

class SyncPlayCommandHandler {
  SyncPlayCommandHandler({
    required this.timeSync,
    required this.onStateUpdate,
    Random? random,
    this.clockFallback = const Duration(seconds: 2),
  }) : _random = random ?? Random();

  /// How long a command may wait for the first clock measurement before it is applied with the unsynced
  /// clock; a broken `/GetUtcTime` must not freeze the group forever.
  final Duration clockFallback;
  Timer? _clockFallbackTimer;

  /// Commands later than this are dropped (typically the server replaying its backlog after a long
  /// disconnect); the server's `StateUpdate` resyncs us.
  static const _staleCommandThreshold = Duration(seconds: 30);

  /// Matches the server's `MaxPlaybackOffset` (500 ms) so we never sit outside the window it accepts.
  static const int positionToleranceTicks = 500 * ticksPerMillisecond;

  /// Jitter applied when re-seeking on a duplicate Seek so the server sees a fresh position.
  static const int _duplicateSeekJitterMs = 100;

  final SyncPlayClock? Function() timeSync;
  final void Function(SyncPlayState Function(SyncPlayState)) onStateUpdate;
  final Random _random;

  LastSyncPlayCommand? _lastCommand;

  Timer? _commandTimer;

  // Command received before the clock was ready.
  _PendingCommand? _queuedCommand;

  SyncPlayPlayerCallback? onPlay;
  SyncPlayPlayerCallback? onPause;
  SyncPlaySeekCallback? onSeek;
  SyncPlayPlayerCallback? onStop;
  SyncPlayPositionCallback? getPositionTicks;
  bool Function()? isPlaying;
  bool Function()? isBuffering;

  SyncPlaySeekCallback? onSeekRequested;

  SyncPlayReportReadyCallback? onReportReady;

  SyncPlaySetSpeedCallback? onSetSpeed;
  bool Function()? hasPlaybackRate;

  LastSyncPlayCommand? get lastCommand => _lastCommand;

  /// True while a command is armed or executing; callers must not drive the player themselves meanwhile.
  bool get hasPendingCommand => _commandTimer?.isActive == true || _isExecuting;

  bool _isExecuting = false;

  /// True while a command is parked waiting for the first clock measurement.
  bool get hasQueuedCommand => _queuedCommand != null;

  /// Records without executing, used while not following group playback: [lastCommand] must keep
  /// describing the group's playhead or a later resume starts from a stale position.
  void recordCommand(Map<String, dynamic> data) {
    final parsed = _parseCommand(data);
    if (parsed == null) {
      return;
    }
    _lastCommand = LastSyncPlayCommand(
      when: parsed.whenStr,
      positionTicks: parsed.positionTicks,
      command: parsed.command,
      playlistItemId: parsed.playlistItemId,
    );
    onStateUpdate((state) => state.copyWith(positionTicks: parsed.positionTicks));
    log('SyncPlay: Recorded ${parsed.command.wire} at ${parsed.positionTicks} ticks (not following)');
  }

  _ParsedCommand? _parseCommand(Map<String, dynamic> data) {
    final commandWire = data['Command'] as String?;
    final whenStr = data['When'] as String?;
    final positionTicks = data['PositionTicks'] as int? ?? 0;
    final playlistItemId = data['PlaylistItemId'] as String? ?? '';

    final command = SyncPlayCommand.fromWire(commandWire);
    if (command == null || whenStr == null) {
      log('SyncPlay: Ignoring unknown command "$commandWire"');
      return null;
    }

    final when = DateTime.tryParse(whenStr);
    if (when == null) {
      log('SyncPlay: Ignoring ${command.wire} with unparsable When "$whenStr"');
      return null;
    }
    return _ParsedCommand(
      command: command,
      when: when,
      whenStr: whenStr,
      positionTicks: positionTicks,
      playlistItemId: playlistItemId,
    );
  }

  void handleCommand(Map<String, dynamic> data, SyncPlayState currentState) {
    final parsed = _parseCommand(data);
    if (parsed == null) {
      return;
    }
    final command = parsed.command;
    final when = parsed.when;
    final whenStr = parsed.whenStr;
    final positionTicks = parsed.positionTicks;
    final playlistItemId = parsed.playlistItemId;

    // A late command for the previous item must not be applied to the new one around an item switch.
    // Stop is exempt: the server sends it with an empty playlist item.
    final currentPlaylistItemId = currentState.playlistItemId;
    final isForOtherItem = command != SyncPlayCommand.stop &&
        playlistItemId.isNotEmpty &&
        currentPlaylistItemId != null &&
        currentPlaylistItemId != playlistItemId;
    if (isForOtherItem) {
      log('SyncPlay: Ignoring ${command.wire} for playlist item $playlistItemId '
          '(current item is $currentPlaylistItemId)');
      return;
    }

    // A resend of the command parked behind the clock gate has not been applied yet; re-queue it.
    if (!hasQueuedCommand && _isDuplicateCommand(whenStr, positionTicks, command, playlistItemId)) {
      _handleDuplicateCommand(command, when, positionTicks);
      return;
    }

    _lastCommand = LastSyncPlayCommand(
      when: whenStr,
      positionTicks: positionTicks,
      command: command,
      playlistItemId: playlistItemId,
    );

    onStateUpdate((state) => state.copyWith(positionTicks: positionTicks));

    // Let the player report buffering right away on Seek.
    if (command == SyncPlayCommand.seek) {
      onSeekRequested?.call(positionTicks);
    }

    _scheduleCommand(command, when, positionTicks);
  }

  bool _isDuplicateCommand(
    String when,
    int positionTicks,
    SyncPlayCommand command,
    String playlistItemId,
  ) {
    final last = _lastCommand;
    if (last == null) {
      return false;
    }
    return last.when == when &&
        last.positionTicks == positionTicks &&
        last.command == command &&
        last.playlistItemId == playlistItemId;
  }

  /// The server re-sends a byte-identical command as "you got lost, here is the current state":
  /// a duplicate whose time is still in the future is already armed; a past duplicate is a correction check.
  void _handleDuplicateCommand(SyncPlayCommand command, DateTime when, int positionTicks) {
    final clock = timeSync();
    final localWhen = clock?.remoteDateToLocal(when) ?? when;
    if (localWhen.isAfter(DateTime.now().toUtc())) {
      log('SyncPlay: Duplicate ${command.wire} is already scheduled');
      return;
    }

    final playing = isPlaying?.call() ?? false;
    final currentTicks = getPositionTicks?.call() ?? 0;
    final offPosition = (currentTicks - positionTicks).abs() > positionToleranceTicks;

    switch (command) {
      case SyncPlayCommand.unpause:
        if (!playing) {
          log('SyncPlay: Duplicate Unpause while paused - resuming');
          _runNow(command, _estimateCurrentTicks(positionTicks, when));
        }
        break;
      case SyncPlayCommand.pause:
        if (playing || offPosition) {
          log('SyncPlay: Duplicate Pause while playing/off-position - correcting');
          _runNow(command, positionTicks);
        }
        break;
      case SyncPlayCommand.seek:
        if (playing || offPosition) {
          final jitterMs = ((_random.nextDouble() - 0.5) * _duplicateSeekJitterMs).round();
          log('SyncPlay: Duplicate Seek while playing/off-position - re-seeking (${jitterMs}ms jitter)');
          _runNow(command, positionTicks + millisecondsToTicks(jitterMs));
        } else {
          log('SyncPlay: Duplicate Seek already satisfied - reporting ready');
          unawaited(onReportReady?.call(isPlaying: false, positionTicks: currentTicks));
        }
        break;
      case SyncPlayCommand.stop:
        if (playing) {
          _runNow(command, positionTicks);
        }
        break;
    }
  }

  bool canAttemptSyncCorrection(SyncPlayState currentState) {
    final command = _lastCommand;
    if (command == null) {
      return false;
    }
    if (command.command != SyncPlayCommand.unpause) {
      return false;
    }
    if (isBuffering?.call() == true) {
      return false;
    }

    final commandItemId = command.playlistItemId;
    final currentItemId = currentState.playlistItemId;
    if (commandItemId.isNotEmpty && currentItemId != null && commandItemId != currentItemId) {
      return false;
    }

    return true;
  }

  /// The group's word is final once nothing of our own is in the way: no command armed/queued/executing,
  /// not buffering, no Pause/Stop as last command, and not before a scheduled Unpause's `When`.
  bool shouldRecoverPlayback(DateTime remoteNow) {
    if (hasPendingCommand || hasQueuedCommand) {
      return false;
    }
    if (isBuffering?.call() == true) {
      return false;
    }
    final last = _lastCommand;
    if (last != null) {
      if (last.command == SyncPlayCommand.pause || last.command == SyncPlayCommand.stop) {
        return false;
      }
      final when = DateTime.tryParse(last.when);
      if (last.command == SyncPlayCommand.unpause && when != null && remoteNow.isBefore(when)) {
        return false;
      }
    }
    return isPlaying?.call() == false;
  }

  /// Schedules the command parked while the clock was not ready; [force] applies it with the unsynced
  /// clock (fallback timer, or the group already reports Playing).
  void flushQueuedCommand({bool force = false}) {
    _clockFallbackTimer?.cancel();
    _clockFallbackTimer = null;
    final queued = _queuedCommand;
    _queuedCommand = null;
    if (queued == null) {
      return;
    }
    log('SyncPlay: ${force ? 'Clock wait over' : 'Clock ready'} - applying queued ${queued.command.wire}');
    _scheduleCommand(queued.command, queued.when, queued.positionTicks, requireClockReady: !force);
  }

  void _scheduleCommand(
    SyncPlayCommand command,
    DateTime serverTime,
    int positionTicks, {
    bool requireClockReady = true,
  }) {
    // A newer command always replaces whatever is armed, queued or not.
    _commandTimer?.cancel();

    final clock = timeSync();
    if (clock == null) {
      log('SyncPlay: Cannot schedule command without time sync');
      _runNow(command, positionTicks);
      return;
    }

    if (requireClockReady && !clock.isReady) {
      // Without a measurement the scheduled time would be off by the whole clock skew; park the latest
      // command until the first measurement lands, but never longer than [clockFallback].
      log('SyncPlay: Clock not ready - queueing ${command.wire}');
      _queuedCommand = _PendingCommand(command, serverTime, positionTicks);
      _clockFallbackTimer?.cancel();
      _clockFallbackTimer = Timer(clockFallback, () {
        log('SyncPlay: Clock still not ready after ${clockFallback.inMilliseconds}ms - applying unsynced');
        flushQueuedCommand(force: true);
      });
      return;
    }

    final localTime = clock.remoteDateToLocal(serverTime);
    final now = DateTime.now().toUtc();
    final delay = localTime.difference(now);

    // Executing stale commands extrapolates far past EOF and starts a buffer oscillation.
    if (delay.isNegative && -delay > _staleCommandThreshold) {
      log('SyncPlay: Discarding stale ${command.wire} command '
          '(${(-delay).inSeconds}s late > '
          '${_staleCommandThreshold.inSeconds}s threshold). '
          'Server StateUpdate will resync.');
      return;
    }

    if (delay.isNegative) {
      // Only Unpause extrapolates by the elapsed delay (the group kept playing); Pause/Seek/Stop are
      // static targets, and extrapolating them would seek past EOF and trigger a real buffer cycle.
      final ticksToUse =
          command == SyncPlayCommand.unpause ? _estimateCurrentTicks(positionTicks, serverTime) : positionTicks;
      log('SyncPlay: Executing late command: ${command.wire} '
          '(${delay.inMilliseconds}ms late)');
      _runNow(command, ticksToUse);
      return;
    }

    if (delay.inMilliseconds > 5000) {
      log('SyncPlay: Warning - large delay: ${delay.inMilliseconds}ms');
    } else {
      log('SyncPlay: Scheduling command: ${command.wire} '
          'in ${delay.inMilliseconds}ms');
    }

    onStateUpdate((state) => state.copyWith(
          isProcessingCommand: true,
          processingCommandType: command,
        ));
    _commandTimer = Timer(delay, () => _executeCommand(command, positionTicks));
  }

  void _runNow(SyncPlayCommand command, int positionTicks) {
    onStateUpdate((state) => state.copyWith(
          isProcessingCommand: true,
          processingCommandType: command,
        ));
    unawaited(_executeCommand(command, positionTicks));
  }

  int _estimateCurrentTicks(int ticks, DateTime when) {
    final clock = timeSync();
    if (clock == null) {
      return ticks;
    }
    final remoteNow = clock.localDateToRemote(DateTime.now().toUtc());
    final elapsedMs = remoteNow.difference(when).inMilliseconds;
    return ticks + millisecondsToTicks(elapsedMs);
  }

  Future<void> _executeCommand(
    SyncPlayCommand command,
    int positionTicks,
  ) async {
    log('SyncPlay: Executing command: ${command.wire} at $positionTicks ticks');

    _isExecuting = true;
    try {
      switch (command) {
        case SyncPlayCommand.pause:
          await onPause?.call();
          // Correct the position outside the server's tolerance so all participants freeze on the same frame.
          final currentTicks = getPositionTicks?.call() ?? 0;
          final needsCorrectionSeek = (positionTicks - currentTicks).abs() > positionToleranceTicks;
          if (needsCorrectionSeek) {
            await onSeek?.call(positionTicks);
            // Seek can put native ExoPlayer through STATE_BUFFERING; hold isProcessingCommand until it clears.
            if (isBuffering?.call() == true) {
              await _waitUntilNotBuffering();
            }
          }
          break;

        case SyncPlayCommand.unpause:
          // Seek first, then play; drift correction handles anything inside the tolerance.
          final currentTicks = getPositionTicks?.call() ?? 0;
          if ((positionTicks - currentTicks).abs() > positionToleranceTicks) {
            await onSeek?.call(positionTicks);
          }
          await onPlay?.call();
          // Native ExoPlayer buffers for a few hundred ms after resume; holding isProcessingCommand prevents
          // the player-state listener from leaking a stale Buffering report (a feedback loop with any TV).
          if (isBuffering?.call() == true) {
            await _waitUntilNotBuffering();
          }
          break;

        case SyncPlayCommand.seek:
          await onPause?.call();
          await onSeek?.call(positionTicks);
          // We own the Ready signal here (the buffering listener is suppressed while processing). Cap at 2 s:
          // libmpv keeps `paused-for-cache` true while paused until the cache is fully topped up.
          if (isBuffering?.call() == true) {
            await _waitUntilNotBuffering(timeout: const Duration(seconds: 2));
          }
          // Report the requested position, not the live one: libmpv can land a hair off on keyframe-bound
          // media and a value outside the server's 500 ms window would trigger another corrective Seek.
          await onReportReady?.call(isPlaying: false, positionTicks: positionTicks);
          break;

        case SyncPlayCommand.stop:
          // The group went idle, playback ends.
          final stop = onStop;
          if (stop != null) {
            await stop();
          } else {
            await onPause?.call();
            await onSeek?.call(0);
          }
          break;
      }
    } finally {
      _isExecuting = false;
      onStateUpdate((state) => state.copyWith(
            isProcessingCommand: false,
            processingCommandType: null,
          ));
    }
  }

  Future<void> _waitUntilNotBuffering({
    Duration timeout = const Duration(seconds: 10),
    Duration pollInterval = const Duration(milliseconds: 100),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (isBuffering?.call() == true && DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(pollInterval);
    }
  }

  void cancelPendingCommands() {
    _commandTimer?.cancel();
    _clockFallbackTimer?.cancel();
    _clockFallbackTimer = null;
    _queuedCommand = null;
  }

  void clearLastCommand() {
    _lastCommand = null;
  }

  void dispose() {
    _commandTimer?.cancel();
    _clockFallbackTimer?.cancel();
    _clockFallbackTimer = null;
    _queuedCommand = null;
  }

  /// Runs as an Unpause so the overlay shows it and [hasPendingCommand] owns the player meanwhile.
  void recoverPlayback() {
    _runNow(SyncPlayCommand.unpause, getPositionTicks?.call() ?? 0);
  }
}
