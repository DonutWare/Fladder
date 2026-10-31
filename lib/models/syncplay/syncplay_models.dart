import 'package:freezed_annotation/freezed_annotation.dart';

part 'syncplay_models.freezed.dart';

@Freezed(copyWith: true)
abstract class TimeSyncMeasurement with _$TimeSyncMeasurement {
  const TimeSyncMeasurement._();

  factory TimeSyncMeasurement({
    required DateTime requestSent,
    required DateTime requestReceived,
    required DateTime responseSent,
    required DateTime responseReceived,
  }) = _TimeSyncMeasurement;

  /// Positive means the server is ahead of the client.
  Duration get offset {
    final t1 = requestSent.millisecondsSinceEpoch;
    final t2 = requestReceived.millisecondsSinceEpoch;
    final t3 = responseSent.millisecondsSinceEpoch;
    final t4 = responseReceived.millisecondsSinceEpoch;
    final offsetMs = ((t2 - t1) + (t3 - t4)) / 2;
    return Duration(milliseconds: offsetMs.round());
  }

  /// Round-trip delay
  Duration get delay {
    final t1 = requestSent.millisecondsSinceEpoch;
    final t2 = requestReceived.millisecondsSinceEpoch;
    final t3 = responseSent.millisecondsSinceEpoch;
    final t4 = responseReceived.millisecondsSinceEpoch;
    final delayMs = (t4 - t1) - (t3 - t2);
    return Duration(milliseconds: delayMs);
  }

  /// One-way ping (half of round-trip)
  Duration get ping => Duration(milliseconds: delay.inMilliseconds ~/ 2);
}

enum SyncPlayGroupState {
  idle,
  waiting,
  paused,
  playing,
}

enum SyncPlayCommand {
  pause('Pause'),
  unpause('Unpause'),
  seek('Seek'),
  stop('Stop');

  const SyncPlayCommand(this.wire);

  final String wire;

  /// Returns `null` for unknown values so callers can ignore the message instead of crashing.
  static SyncPlayCommand? fromWire(String? value) {
    if (value == null) {
      return null;
    }
    for (final command in SyncPlayCommand.values) {
      if (command.wire == value) {
        return command;
      }
    }
    return null;
  }
}

/// Reason field reported alongside `StateUpdate` group updates.
enum SyncPlayStateReason {
  newPlaylist('NewPlaylist'),
  setCurrentItem('SetCurrentItem'),
  unpause('Unpause'),
  pause('Pause'),
  seek('Seek'),
  buffer('Buffer'),
  ready('Ready'),
  stop('Stop');

  const SyncPlayStateReason(this.wire);

  final String wire;

  static SyncPlayStateReason? fromWire(String? value) {
    if (value == null) {
      return null;
    }
    for (final reason in SyncPlayStateReason.values) {
      if (reason.wire == value) {
        return reason;
      }
    }
    return null;
  }
}

enum SyncCorrectionStrategy {
  none,
  speedToSync,
  skipToSync,
}

/// Defaults match the official Jellyfin SyncPlay thresholds.
class SyncCorrectionConfig {
  const SyncCorrectionConfig({
    this.minDelaySpeedToSyncMs = 60,
    this.maxDelaySpeedToSyncMs = 3000,
    this.speedToSyncDurationMs = 1000,
    this.minDelaySkipToSyncMs = 400,
    this.useSpeedToSync = true,
    this.useSkipToSync = true,
    this.enableSyncCorrection = true,
  });

  final double minDelaySpeedToSyncMs;
  final double maxDelaySpeedToSyncMs;
  final double speedToSyncDurationMs;
  final double minDelaySkipToSyncMs;
  final bool useSpeedToSync;
  final bool useSkipToSync;
  final bool enableSyncCorrection;

  SyncCorrectionConfig copyWith({
    double? minDelaySpeedToSyncMs,
    double? maxDelaySpeedToSyncMs,
    double? speedToSyncDurationMs,
    double? minDelaySkipToSyncMs,
    bool? useSpeedToSync,
    bool? useSkipToSync,
    bool? enableSyncCorrection,
  }) {
    return SyncCorrectionConfig(
      minDelaySpeedToSyncMs: minDelaySpeedToSyncMs ?? this.minDelaySpeedToSyncMs,
      maxDelaySpeedToSyncMs: maxDelaySpeedToSyncMs ?? this.maxDelaySpeedToSyncMs,
      speedToSyncDurationMs: speedToSyncDurationMs ?? this.speedToSyncDurationMs,
      minDelaySkipToSyncMs: minDelaySkipToSyncMs ?? this.minDelaySkipToSyncMs,
      useSpeedToSync: useSpeedToSync ?? this.useSpeedToSync,
      useSkipToSync: useSkipToSync ?? this.useSkipToSync,
      enableSyncCorrection: enableSyncCorrection ?? this.enableSyncCorrection,
    );
  }
}

class SyncCorrectionState {
  const SyncCorrectionState({
    this.syncEnabled = true,
    this.playerIsBuffering = false,
    this.playbackDiffMillis = 0,
    this.syncAttempts = 0,
    this.lastSyncAt,
    this.activeStrategy = SyncCorrectionStrategy.none,
  });

  final bool syncEnabled;
  final bool playerIsBuffering;
  final double playbackDiffMillis;
  final int syncAttempts;
  final DateTime? lastSyncAt;
  final SyncCorrectionStrategy activeStrategy;

  SyncCorrectionState copyWith({
    bool? syncEnabled,
    bool? playerIsBuffering,
    double? playbackDiffMillis,
    int? syncAttempts,
    DateTime? lastSyncAt,
    SyncCorrectionStrategy? activeStrategy,
  }) {
    return SyncCorrectionState(
      syncEnabled: syncEnabled ?? this.syncEnabled,
      playerIsBuffering: playerIsBuffering ?? this.playerIsBuffering,
      playbackDiffMillis: playbackDiffMillis ?? this.playbackDiffMillis,
      syncAttempts: syncAttempts ?? this.syncAttempts,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      activeStrategy: activeStrategy ?? this.activeStrategy,
    );
  }
}

/// SpeedToSync first, then SkipToSync, mirroring the official precedence.
SyncCorrectionStrategy selectSyncCorrectionStrategy({
  required SyncCorrectionConfig config,
  required SyncCorrectionState state,
  required double diffMillis,
  required bool hasPlaybackRate,
}) {
  if (!config.enableSyncCorrection || !state.syncEnabled) {
    return SyncCorrectionStrategy.none;
  }

  if (state.activeStrategy != SyncCorrectionStrategy.none) {
    return SyncCorrectionStrategy.none;
  }

  final absDiffMillis = diffMillis.abs();

  final canUseSpeedToSync = (config.useSpeedToSync &&
      hasPlaybackRate &&
      absDiffMillis >= config.minDelaySpeedToSyncMs &&
      absDiffMillis < config.maxDelaySpeedToSyncMs);
  if (canUseSpeedToSync) {
    return SyncCorrectionStrategy.speedToSync;
  }

  final canUseSkipToSync = (config.useSkipToSync && absDiffMillis >= config.minDelaySkipToSyncMs);
  if (canUseSkipToSync) {
    return SyncCorrectionStrategy.skipToSync;
  }

  return SyncCorrectionStrategy.none;
}

/// `playlistItemId` is the server-generated id used by NextItem/PreviousItem/SetPlaylistItem.
class SyncPlayQueueEntry {
  const SyncPlayQueueEntry({
    required this.itemId,
    required this.playlistItemId,
  });

  final String itemId;
  final String playlistItemId;

  @override
  bool operator ==(Object other) {
    return other is SyncPlayQueueEntry && other.itemId == itemId && other.playlistItemId == playlistItemId;
  }

  @override
  int get hashCode => Object.hash(itemId, playlistItemId);
}

/// How a local "play this item" request maps onto the group queue.
enum SyncPlayQueueNavigation {
  /// Target is the entry right after the playing one: `NextItem`.
  next,

  /// Target is the entry right before the playing one: `PreviousItem`.
  previous,

  /// Target is elsewhere in the queue: `SetPlaylistItem`.
  setCurrentItem,

  /// Target is not in the group queue: `SetNewQueue`.
  newQueue,
}

/// Using the server-side queue keeps every participant's context intact and lets the server de-duplicate.
SyncPlayQueueNavigation resolveQueueNavigation({
  required List<SyncPlayQueueEntry> playlist,
  required int playingItemIndex,
  required String targetItemId,
}) {
  final targetIndex = playlist.indexWhere((entry) => entry.itemId == targetItemId);
  if (targetIndex < 0) {
    return SyncPlayQueueNavigation.newQueue;
  }
  if (targetIndex == playingItemIndex + 1) {
    return SyncPlayQueueNavigation.next;
  }
  if (targetIndex == playingItemIndex - 1) {
    return SyncPlayQueueNavigation.previous;
  }
  return SyncPlayQueueNavigation.setCurrentItem;
}

/// Shared by the Flutter player and the native Android activity so every participant sees the same thing.
enum SyncPlayOverlay {
  none,

  /// A queue switch is loading the next item.
  switching,

  /// A command from the server is being applied on this device.
  command,

  /// The server is holding the group for a participant to buffer.
  waiting,
}

SyncPlayOverlay resolveSyncPlayOverlay(SyncPlayState state) {
  if (!state.isInGroup || !state.isFollowingGroupPlayback) {
    return SyncPlayOverlay.none;
  }
  if (state.startPlaybackInProgress) {
    return SyncPlayOverlay.switching;
  }
  if (state.isProcessingCommand && state.processingCommandType != null) {
    return SyncPlayOverlay.command;
  }
  if (state.groupState == SyncPlayGroupState.waiting) {
    return SyncPlayOverlay.waiting;
  }
  return SyncPlayOverlay.none;
}

/// Lets a device that stopped following the group estimate the live position when it resumes.
@Freezed(copyWith: true)
abstract class SyncPlayQueueTiming with _$SyncPlayQueueTiming {
  const SyncPlayQueueTiming._();

  const factory SyncPlayQueueTiming({
    required int startPositionTicks,
    DateTime? lastUpdate,
    @Default(false) bool isPlaying,
  }) = _SyncPlayQueueTiming;

  /// Frozen while paused, extrapolated from [lastUpdate] while playing.
  int positionTicksAt(DateTime remoteNow) {
    final since = lastUpdate;
    if (!isPlaying || since == null) {
      return startPositionTicks;
    }
    return startPositionTicks + millisecondsToTicks(remoteNow.difference(since).inMilliseconds);
  }
}

/// Prefers the last command for the current item (recorded even while not following), then the last
/// `PlayQueue` timing; [fallbackPositionTicks] can be tens of seconds stale.
int estimateGroupPositionTicks({
  required LastSyncPlayCommand? lastCommand,
  required String? currentPlaylistItemId,
  required SyncPlayQueueTiming? queueTiming,
  required int fallbackPositionTicks,
  required DateTime remoteNow,
}) {
  if (lastCommand != null) {
    final forCurrentItem = lastCommand.playlistItemId.isEmpty ||
        currentPlaylistItemId == null ||
        lastCommand.playlistItemId == currentPlaylistItemId;
    final when = DateTime.tryParse(lastCommand.when);
    if (forCurrentItem && when != null) {
      // Only Unpause moves the playhead; Pause/Seek leave it at the command's position.
      if (lastCommand.command != SyncPlayCommand.unpause) {
        return lastCommand.positionTicks;
      }
      return lastCommand.positionTicks + millisecondsToTicks(remoteNow.difference(when).inMilliseconds);
    }
  }
  if (queueTiming != null) {
    return queueTiming.positionTicksAt(remoteNow);
  }
  return fallbackPositionTicks;
}

@Freezed(copyWith: true)
abstract class SyncPlayState with _$SyncPlayState {
  const SyncPlayState._();

  factory SyncPlayState({
    @Default(false) bool isConnected,
    @Default(false) bool isInGroup,
    String? groupId,
    String? groupName,
    @Default(SyncPlayGroupState.idle) SyncPlayGroupState groupState,
    String? stateReason,
    @Default([]) List<String> participants,
    String? playingItemId,
    String? playlistItemId,
    @Default(0) int positionTicks,
    DateTime? lastCommandTime,
    @Default(false) bool isProcessingCommand,
    SyncPlayCommand? processingCommandType,
    @Default(SyncCorrectionConfig()) SyncCorrectionConfig correctionConfig,
    @Default(SyncCorrectionState()) SyncCorrectionState correctionState,

    /// True while a `_startPlayback` call is in flight (loader UX).
    @Default(false) bool startPlaybackInProgress,

    /// Dedup key for concurrent PlayQueue updates racing each other.
    String? startingPlaylistItemId,

    /// While > 0, `reportBuffering`/`reportReady` are suppressed so local reloads don't pause the group.
    @Default(0) int localOnlyOperationCount,

    /// False after the user halted group playback on this device (`SetIgnoreWait(true)`): commands are
    /// ignored until the user resumes or a new playlist is set.
    @Default(true) bool isFollowingGroupPlayback,

    /// Local copy of the group play queue from the last `PlayQueue` frame.
    @Default([]) List<SyncPlayQueueEntry> playlist,

    /// Index of the playing entry in [playlist], -1 when nothing plays.
    @Default(-1) int playingItemIndex,

    /// Timing of the last `PlayQueue` frame; null until one arrived.
    SyncPlayQueueTiming? queueTiming,
  }) = _SyncPlayState;

  bool get isActive => isConnected && isInGroup;

  /// Entry after the playing one, if any.
  SyncPlayQueueEntry? get nextQueueEntry {
    final index = playingItemIndex + 1;
    return index > 0 && index < playlist.length ? playlist[index] : null;
  }

  /// Entry before the playing one, if any.
  SyncPlayQueueEntry? get previousQueueEntry {
    final index = playingItemIndex - 1;
    return index >= 0 && index < playlist.length ? playlist[index] : null;
  }

  /// True when local-only mode is active (audio/subtitle switch, etc.).
  bool get isInLocalOnlyMode => localOnlyOperationCount > 0;

  /// The group has an item the local user could re-attach to ("Resume playback" outside the player route).
  bool get hasActivePlayback => isInGroup && playingItemId != null && groupState != SyncPlayGroupState.idle;
}

/// Last executed command for duplicate detection
@Freezed(copyWith: true)
abstract class LastSyncPlayCommand with _$LastSyncPlayCommand {
  factory LastSyncPlayCommand({
    required String when,
    required int positionTicks,
    required SyncPlayCommand command,
    required String playlistItemId,
  }) = _LastSyncPlayCommand;
}

const int ticksPerMillisecond = 10000;
const int ticksPerSecond = 10000000;

int secondsToTicks(double seconds) => (seconds * ticksPerSecond).round();

double ticksToSeconds(int ticks) => ticks / ticksPerSecond;

int millisecondsToTicks(int ms) => ms * ticksPerMillisecond;

int ticksToMilliseconds(int ticks) => ticks ~/ ticksPerMillisecond;
