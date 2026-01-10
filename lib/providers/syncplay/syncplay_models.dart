import 'package:freezed_annotation/freezed_annotation.dart';

part 'syncplay_models.freezed.dart';

/// Time sync measurement for NTP-like clock synchronization
@Freezed(copyWith: true)
abstract class TimeSyncMeasurement with _$TimeSyncMeasurement {
  const TimeSyncMeasurement._();

  factory TimeSyncMeasurement({
    required DateTime requestSent,
    required DateTime requestReceived,
    required DateTime responseSent,
    required DateTime responseReceived,
  }) = _TimeSyncMeasurement;

  /// Clock offset between client and server
  /// Positive = server is ahead of client
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

/// SyncPlay group state
enum SyncPlayGroupState {
  idle,
  waiting,
  paused,
  playing,
}

/// Current SyncPlay session state
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
  }) = _SyncPlayState;

  bool get isActive => isConnected && isInGroup;
}

/// Last executed command for duplicate detection
@Freezed(copyWith: true)
abstract class LastSyncPlayCommand with _$LastSyncPlayCommand {
  factory LastSyncPlayCommand({
    required String when,
    required int positionTicks,
    required String command,
    required String playlistItemId,
  }) = _LastSyncPlayCommand;
}

/// WebSocket connection state
enum WebSocketConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
}

/// Ticks conversion constants
const int ticksPerMillisecond = 10000;
const int ticksPerSecond = 10000000;

/// Convert seconds to ticks
int secondsToTicks(double seconds) => (seconds * ticksPerSecond).round();

/// Convert ticks to seconds
double ticksToSeconds(int ticks) => ticks / ticksPerSecond;

/// Convert milliseconds to ticks
int millisecondsToTicks(int ms) => ms * ticksPerMillisecond;

/// Convert ticks to milliseconds
int ticksToMilliseconds(int ticks) => ticks ~/ ticksPerMillisecond;
