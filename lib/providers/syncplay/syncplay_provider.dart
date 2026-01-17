import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/syncplay/syncplay_controller.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';

part 'syncplay_provider.g.dart';

/// Lifecycle observer for SyncPlay - handles app background/resume
class _SyncPlayLifecycleObserver with WidgetsBindingObserver {
  _SyncPlayLifecycleObserver(this._controller);

  final SyncPlayController _controller;

  void register() {
    WidgetsBinding.instance.addObserver(this);
  }

  void unregister() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _controller.handleAppLifecycleChange(state);
  }
}

/// Provider for SyncPlay controller instance
@Riverpod(keepAlive: true)
class SyncPlay extends _$SyncPlay {
  SyncPlayController? _controller;
  StreamSubscription? _stateSubscription;
  _SyncPlayLifecycleObserver? _lifecycleObserver;

  @override
  SyncPlayState build() {
    ref.onDispose(() {
      _lifecycleObserver?.unregister();
      _stateSubscription?.cancel();
      _controller?.dispose();
    });
    return SyncPlayState();
  }

  SyncPlayController get controller {
    if (_controller == null) {
      _controller = SyncPlayController(ref);
      // Register lifecycle observer when controller is created
      _lifecycleObserver = _SyncPlayLifecycleObserver(_controller!);
      _lifecycleObserver!.register();
    }
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
  Future<void> requestUnpause() => controller.requestUnpause();

  /// Request seek
  Future<void> requestSeek(int positionTicks) => controller.requestSeek(positionTicks);

  /// Report buffering state
  Future<void> reportBuffering() => controller.reportBuffering();

  /// Report ready state
  Future<void> reportReady({bool isPlaying = true}) => 
      controller.reportReady(isPlaying: isPlaying);

  /// Set a new queue/playlist
  Future<void> setNewQueue({
    required List<String> itemIds,
    int playingItemPosition = 0,
    int startPositionTicks = 0,
  }) => controller.setNewQueue(
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
    required int Function() getPositionTicks,
    required bool Function() isPlaying,
    required bool Function() isBuffering,
  }) {
    controller.onPlay = onPlay;
    controller.onPause = onPause;
    controller.onSeek = onSeek;
    controller.onStop = onStop;
    controller.getPositionTicks = getPositionTicks;
    controller.isPlaying = isPlaying;
    controller.isBuffering = isBuffering;
    // Wire up reportReady callback so command handler can report ready after seek
    controller.onReportReady = () => controller.reportReady();
  }

  /// Unregister player callbacks
  void unregisterPlayer() {
    controller.onPlay = null;
    controller.onPause = null;
    controller.onSeek = null;
    controller.onStop = null;
    controller.getPositionTicks = null;
    controller.isPlaying = null;
    controller.isBuffering = null;
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
