import 'dart:async';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/syncplay_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'syncplay_provider.freezed.dart';
part 'syncplay_provider.g.dart';

/// Provider for SyncPlay controller instance
@Riverpod(keepAlive: true)
class SyncPlay extends _$SyncPlay {
  SyncPlayController? _controller;
  StreamSubscription? _stateSubscription;

  @override
  SyncPlayState build() {
    ref.onDispose(() {
      _stateSubscription?.cancel();
      _controller?.dispose();
    });
    return SyncPlayState();
  }

  SyncPlayController get controller {
    _controller ??= SyncPlayController(ref);
    return _controller!;
  }

  /// Initialize and connect to SyncPlay WebSocket
  Future<void> connect() async {
    await controller.connect();
    _stateSubscription?.cancel();
    _stateSubscription = controller.stateStream.listen((newState) {
      state = newState;
    });
  }

  /// Disconnect from SyncPlay
  Future<void> disconnect() async {
    await controller.disconnect();
    state = SyncPlayState();
  }

  /// List available SyncPlay groups
  Future<List<GroupInfoDto>> listGroups() => controller.listGroups();

  /// Create a new SyncPlay group
  Future<GroupInfoDto?> createGroup(String groupName) => controller.createGroup(groupName);

  /// Join an existing group
  Future<bool> joinGroup(String groupId) => controller.joinGroup(groupId);

  /// Leave current group
  Future<void> leaveGroup() => controller.leaveGroup();

  /// Request pause
  Future<void> requestPause() => controller.requestPause();

  /// Request unpause/play
  Future<void> requestUnpause() async => await controller.requestUnpause();

  /// Request seek
  Future<void> requestSeek(int positionTicks) => controller.requestSeek(positionTicks);

  /// Advance to the next item in the SyncPlay queue.
  Future<void> requestNextItem() => controller.requestNextItem();

  /// Step back to the previous item in the SyncPlay queue.
  Future<void> requestPreviousItem() => controller.requestPreviousItem();

  /// Report buffering state. See [SyncPlayController.reportBuffering].
  Future<void> reportBuffering({int? positionTicks}) => controller.reportBuffering(positionTicks: positionTicks);

  /// Report ready state. See [SyncPlayController.reportReady].
  Future<void> reportReady({bool isPlaying = true, int? positionTicks}) =>
      controller.reportReady(isPlaying: isPlaying, positionTicks: positionTicks);

  /// Mark local execution of a SyncPlay command for cooldown handling.
  void markCommandExecuted([DateTime? at]) => controller.markCommandExecuted(at);

  /// Update buffering/reloading status inside SyncPlay state.
  void setPlayerBufferingState(bool isBuffering) => controller.setPlayerBufferingState(isBuffering);

  /// Reset correction state and timers.
  void resetCorrectionState({
    String reason = 'manual',
    bool syncEnabled = true,
  }) =>
      controller.resetCorrectionState(
        reason: reason,
        syncEnabled: syncEnabled,
      );

  /// Update playback drift using current local position ticks.
  void updatePlaybackDrift({
    required int currentPositionTicks,
    DateTime? at,
  }) =>
      controller.updatePlaybackDrift(
        currentPositionTicks: currentPositionTicks,
        at: at,
      );

  /// Estimate the group's current playhead position in ticks. See
  /// [SyncPlayController.estimateCurrentGroupPositionTicks].
  int estimateCurrentGroupPositionTicks() => controller.estimateCurrentGroupPositionTicks();

  /// Returns a Future that completes the next time `_startPlayback`
  /// finishes (success or failure). Used by the loader UX.
  Future<bool> awaitNextStartPlayback({
    Duration timeout = const Duration(seconds: 20),
  }) =>
      controller.awaitNextStartPlayback(timeout: timeout);

  /// Re-attach to the currently playing group item from outside the
  /// player route ("Resume playback" button).
  Future<bool> rejoinPlayback() => controller.rejoinPlayback();

  /// Run [body] while suppressing `Buffering`/`Ready` reports so the
  /// rest of the group is not paused (used for audio/subtitle reload).
  Future<T> runLocalOnly<T>(Future<T> Function() body) => controller.runLocalOnly(body);

  /// Set a new queue/playlist. Returns `true` when the request was
  /// actually sent to the server, `false` if it was suppressed.
  Future<bool> setNewQueue({
    required List<String> itemIds,
    int playingItemPosition = 0,
    int startPositionTicks = 0,
  }) =>
      controller.setNewQueue(
        itemIds: itemIds,
        playingItemPosition: playingItemPosition,
        startPositionTicks: startPositionTicks,
      );

  /// Register player callbacks
  void registerPlayer({
    required Future<void> Function() onPlay,
    required Future<void> Function() onPause,
    required Future<void> Function(int positionTicks) onSeek,
    required Future<void> Function() onStop,
    required Future<void> Function(double speed) onSetSpeed,
    required int Function() getPositionTicks,
    required bool Function() isPlaying,
    required bool Function() isBuffering,
    required bool Function() hasPlaybackRate,
    Future<void> Function(int positionTicks)? onSeekRequested,
  }) {
    controller.onPlay = onPlay;
    controller.onPause = onPause;
    controller.onSeek = onSeek;
    controller.onStop = onStop;
    controller.onSetSpeed = onSetSpeed;
    controller.getPositionTicks = getPositionTicks;
    controller.isPlaying = isPlaying;
    controller.isBuffering = isBuffering;
    controller.hasPlaybackRate = hasPlaybackRate;
    controller.onSeekRequested = onSeekRequested;
    // Wire up reportReady callback so command handler can report ready after seek
    controller.onReportReady = () => controller.reportReady();
  }

  /// Unregister player callbacks
  void unregisterPlayer() {
    controller.onPlay = null;
    controller.onPause = null;
    controller.onSeek = null;
    controller.onStop = null;
    controller.onSetSpeed = null;
    controller.getPositionTicks = null;
    controller.isPlaying = null;
    controller.isBuffering = null;
    controller.hasPlaybackRate = null;
    controller.onSeekRequested = null;
    controller.onReportReady = null;
  }
}

/// Provider to check if currently in a SyncPlay session
@riverpod
bool isSyncPlayActive(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.isActive));
}

/// Provider for current SyncPlay group name
@riverpod
String? syncPlayGroupName(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.groupName));
}

/// Provider for SyncPlay group state
@riverpod
SyncPlayGroupState syncPlayGroupState(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.groupState));
}

/// Provider for SyncPlay correction runtime state (UI + diagnostics).
@riverpod
SyncCorrectionState syncCorrectionState(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.correctionState));
}

/// Provider for active correction strategy.
@riverpod
SyncCorrectionStrategy syncCorrectionStrategy(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.correctionState.activeStrategy));
}

/// True when a SyncPlay-driven `_startPlayback` is currently in flight
/// (initial play, episode switch, rejoin). UI can use this to display
/// a loading indicator while the local player is being prepared.
@riverpod
bool syncPlayStartPlaybackInProgress(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.startPlaybackInProgress));
}

/// True when the group has an active item the local user could
/// resume from outside the player route.
@riverpod
bool syncPlayHasActivePlayback(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.hasActivePlayback));
}

/// Immutable state for the SyncPlay groups list (used by group sheet).
/// Lists are stored unmodifiable so the state cannot be mutated.
@Freezed(copyWith: true)
abstract class SyncPlayGroupsState with _$SyncPlayGroupsState {
  const factory SyncPlayGroupsState({
    List<GroupInfoDto>? groups,
    @Default(false) bool isLoading,
    String? error,
  }) = _SyncPlayGroupsState;
}

/// Provider for the list of SyncPlay groups (load/refresh from sheet).
@Riverpod(keepAlive: false)
class SyncPlayGroups extends _$SyncPlayGroups {
  @override
  SyncPlayGroupsState build() => const SyncPlayGroupsState(isLoading: true);

  Future<void> loadGroups() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(syncPlayProvider.notifier).connect();
      final groups = await ref.read(syncPlayProvider.notifier).listGroups();
      state = state.copyWith(
        groups: List.unmodifiable(groups),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}
