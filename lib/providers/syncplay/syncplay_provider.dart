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

  /// Subscribes before connecting: `connect()` seeds `isConnected` synchronously on a broadcast
  /// stream, and an event emitted before anyone listens is lost.
  Future<void> connect() async {
    _stateSubscription ??= controller.stateStream.listen((newState) {
      state = newState;
    });
    await controller.connect();
  }

  Future<void> disconnect() async {
    await controller.disconnect();
    state = SyncPlayState();
  }

  Future<List<GroupInfoDto>> listGroups() => controller.listGroups();

  Future<GroupInfoDto?> createGroup(String groupName) => controller.createGroup(groupName);

  Future<bool> joinGroup(String groupId) => controller.joinGroup(groupId);

  Future<void> leaveGroup() => controller.leaveGroup();

  Future<void> requestPause() => controller.requestPause();

  Future<void> requestUnpause() async => await controller.requestUnpause();

  Future<void> requestSeek(int positionTicks) => controller.requestSeek(positionTicks);

  Future<void> requestNextItem() => controller.requestNextItem();

  Future<void> requestPreviousItem() => controller.requestPreviousItem();

  Future<void> requestSetPlaylistItem(String playlistItemId) => controller.requestSetPlaylistItem(playlistItemId);

  Future<void> haltPlayback({bool stopLocalPlayer = true}) => controller.haltPlayback(stopLocalPlayer: stopLocalPlayer);

  Future<void> reportBuffering({int? positionTicks}) => controller.reportBuffering(positionTicks: positionTicks);

  Future<void> reportReady({required bool isPlaying, int? positionTicks}) =>
      controller.reportReady(isPlaying: isPlaying, positionTicks: positionTicks);

  void markCommandExecuted([DateTime? at]) => controller.markCommandExecuted(at);

  void setPlayerBufferingState(bool isBuffering) => controller.setPlayerBufferingState(isBuffering);

  void resetCorrectionState({
    String reason = 'manual',
    bool syncEnabled = true,
  }) =>
      controller.resetCorrectionState(
        reason: reason,
        syncEnabled: syncEnabled,
      );

  void updatePlaybackDrift({
    required int currentPositionTicks,
    DateTime? at,
    bool force = false,
  }) =>
      controller.updatePlaybackDrift(
        currentPositionTicks: currentPositionTicks,
        at: at,
        force: force,
      );

  int estimateCurrentGroupPositionTicks() => controller.estimateCurrentGroupPositionTicks();

  Future<bool> awaitNextStartPlayback({
    Duration timeout = const Duration(seconds: 20),
  }) =>
      controller.awaitNextStartPlayback(timeout: timeout);

  Future<bool> rejoinPlayback() => controller.rejoinPlayback();

  Future<T> runLocalOnly<T>(Future<T> Function() body) => controller.runLocalOnly(body);

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
    controller.onReportReady = ({required bool isPlaying, required int positionTicks}) =>
        controller.reportReady(isPlaying: isPlaying, positionTicks: positionTicks);
  }

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

@riverpod
bool isSyncPlayActive(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.isActive));
}

@riverpod
String? syncPlayGroupName(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.groupName));
}

@riverpod
SyncPlayGroupState syncPlayGroupState(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.groupState));
}

@riverpod
SyncCorrectionState syncCorrectionState(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.correctionState));
}

@riverpod
SyncCorrectionStrategy syncCorrectionStrategy(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.correctionState.activeStrategy));
}

/// True while a SyncPlay-driven `_startPlayback` is in flight (initial play, episode switch, rejoin).
@riverpod
bool syncPlayStartPlaybackInProgress(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.startPlaybackInProgress));
}

/// True when the group has an active item the local user could resume from outside the player route.
@riverpod
bool syncPlayHasActivePlayback(Ref ref) {
  return ref.watch(syncPlayProvider.select((s) => s.hasActivePlayback));
}

@Freezed(copyWith: true)
abstract class SyncPlayGroupsState with _$SyncPlayGroupsState {
  const factory SyncPlayGroupsState({
    List<GroupInfoDto>? groups,
    @Default(false) bool isLoading,
    String? error,
  }) = _SyncPlayGroupsState;
}

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
