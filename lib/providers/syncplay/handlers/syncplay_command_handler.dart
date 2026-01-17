import 'dart:async';
import 'dart:developer';

import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/time_sync_service.dart';

/// Callback types for player control commands from SyncPlay
typedef SyncPlayPlayerCallback = Future<void> Function();
typedef SyncPlaySeekCallback = Future<void> Function(int positionTicks);
typedef SyncPlayPositionCallback = int Function();
typedef SyncPlayReportReadyCallback = Future<void> Function();

/// Handles scheduling and execution of SyncPlay commands
class SyncPlayCommandHandler {
  SyncPlayCommandHandler({
    required this.timeSync,
    required this.onStateUpdate,
  });

  final TimeSyncService? Function() timeSync;
  final void Function(SyncPlayState Function(SyncPlayState)) onStateUpdate;

  // Last command for duplicate detection
  LastSyncPlayCommand? _lastCommand;

  // Pending command timer
  Timer? _commandTimer;

  // Player callbacks
  SyncPlayPlayerCallback? onPlay;
  SyncPlayPlayerCallback? onPause;
  SyncPlaySeekCallback? onSeek;
  SyncPlayPlayerCallback? onStop;
  SyncPlayPositionCallback? getPositionTicks;
  bool Function()? isPlaying;
  bool Function()? isBuffering;
  
  // Report ready callback (to tell server we're ready after seek)
  SyncPlayReportReadyCallback? onReportReady;

  /// Handle incoming SyncPlay command from WebSocket
  void handleCommand(Map<String, dynamic> data, SyncPlayState currentState) {
    final command = data['Command'] as String?;
    final whenStr = data['When'] as String?;
    final positionTicks = data['PositionTicks'] as int? ?? 0;
    final playlistItemId = data['PlaylistItemId'] as String? ?? '';

    if (command == null || whenStr == null) return;

    // Check for duplicate command
    if (_isDuplicateCommand(whenStr, positionTicks, command, playlistItemId)) {
      log('SyncPlay: Ignoring duplicate command: $command');
      return;
    }

    _lastCommand = LastSyncPlayCommand(
      when: whenStr,
      positionTicks: positionTicks,
      command: command,
      playlistItemId: playlistItemId,
    );

    onStateUpdate((state) => state.copyWith(
          positionTicks: positionTicks,
          playlistItemId: playlistItemId,
        ));

    final when = DateTime.parse(whenStr);
    _scheduleCommand(command, when, positionTicks);
  }

  bool _isDuplicateCommand(
      String when, int positionTicks, String command, String playlistItemId) {
    if (_lastCommand == null) return false;
    return _lastCommand!.when == when &&
        _lastCommand!.positionTicks == positionTicks &&
        _lastCommand!.command == command &&
        _lastCommand!.playlistItemId == playlistItemId;
  }

  void _scheduleCommand(String command, DateTime serverTime, int positionTicks) {
    final timeSyncService = timeSync();
    if (timeSyncService == null) {
      log('SyncPlay: Cannot schedule command without time sync');
      _executeCommand(command, positionTicks);
      return;
    }

    final localTime = timeSyncService.remoteDateToLocal(serverTime);
    final now = DateTime.now().toUtc();
    final delay = localTime.difference(now);

    _commandTimer?.cancel();

    // Show processing indicator
    onStateUpdate((state) => state.copyWith(
          isProcessingCommand: true,
          processingCommandType: command,
        ));

    if (delay.isNegative) {
      // Command is in the past - execute immediately
      // Estimate where playback should be now
      final estimatedTicks = _estimateCurrentTicks(positionTicks, serverTime);
      log('SyncPlay: Executing late command: $command (${delay.inMilliseconds}ms late)');
      _executeCommand(command, estimatedTicks);
    } else if (delay.inMilliseconds > 5000) {
      // Suspiciously large delay - might indicate time sync issue
      log('SyncPlay: Warning - large delay: ${delay.inMilliseconds}ms');
      _commandTimer = Timer(delay, () => _executeCommand(command, positionTicks));
    } else {
      log('SyncPlay: Scheduling command: $command in ${delay.inMilliseconds}ms');
      _commandTimer = Timer(delay, () => _executeCommand(command, positionTicks));
    }
  }

  int _estimateCurrentTicks(int ticks, DateTime when) {
    final timeSyncService = timeSync();
    if (timeSyncService == null) return ticks;
    final remoteNow = timeSyncService.localDateToRemote(DateTime.now().toUtc());
    final elapsedMs = remoteNow.difference(when).inMilliseconds;
    return ticks + millisecondsToTicks(elapsedMs);
  }

  Future<void> _executeCommand(String command, int positionTicks) async {
    log('SyncPlay: Executing command: $command at $positionTicks ticks');

    try {
      switch (command) {
        case 'Pause':
          await onPause?.call();
          // Only seek if position is significantly different (>1 second)
          final currentTicks = getPositionTicks?.call() ?? 0;
          if ((positionTicks - currentTicks).abs() > ticksPerSecond) {
            await onSeek?.call(positionTicks);
          }
          break;

        case 'Unpause':
          // Play first - getting playback started quickly is more important than perfect position
          await onPlay?.call();
          // Only seek if position is significantly different (>1 second)
          // Small differences will self-correct during playback
          final currentTicks = getPositionTicks?.call() ?? 0;
          if ((positionTicks - currentTicks).abs() > ticksPerSecond) {
            await onSeek?.call(positionTicks);
          }
          break;

        case 'Seek':
          // Pause first to stop any ongoing playback
          await onPause?.call();
          // Seek to the target position
          await onSeek?.call(positionTicks);
          // Report ready after seek so server knows to send unpause
          // If we're buffering, the buffering state handler will report ready when done
          // If we're not buffering, report ready immediately
          if (isBuffering?.call() != true) {
            await onReportReady?.call();
          }
          break;

        case 'Stop':
          await onPause?.call();
          await onSeek?.call(0);
          break;
      }
    } finally {
      // Clear processing state after command completes
      onStateUpdate((state) => state.copyWith(
            isProcessingCommand: false,
            processingCommandType: null,
          ));
    }
  }

  /// Cancel any pending commands
  void cancelPendingCommands() {
    _commandTimer?.cancel();
  }

  /// Dispose resources
  void dispose() {
    _commandTimer?.cancel();
  }
}
