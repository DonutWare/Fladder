import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/router_provider.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_command_handler.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_message_handler.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/time_sync_service.dart';
import 'package:fladder/providers/syncplay/websocket_manager.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/video_player/video_player.dart';

/// Controller for SyncPlay synchronized playback
class SyncPlayController {
  SyncPlayController(this._ref) {
    _commandHandler = SyncPlayCommandHandler(
      timeSync: () => _timeSync,
      onStateUpdate: _updateStateWith,
    );
    _messageHandler = SyncPlayMessageHandler(
      onStateUpdate: _updateStateWith,
      reportReady: ({bool isPlaying = true}) => reportReady(isPlaying: isPlaying),
      startPlayback: _startPlayback,
      isBuffering: () => _commandHandler.isBuffering?.call() ?? false,
      getContext: () => getNavigatorKey(_ref)?.currentContext,
    );
  }

  final Ref _ref;

  WebSocketManager? _wsManager;
  TimeSyncService? _timeSync;
  StreamSubscription? _wsMessageSubscription;
  StreamSubscription? _wsStateSubscription;

  late final SyncPlayCommandHandler _commandHandler;
  late final SyncPlayMessageHandler _messageHandler;

  SyncPlayState _state = SyncPlayState();
  final _stateController = StreamController<SyncPlayState>.broadcast();
  Stream<SyncPlayState> get stateStream => _stateController.stream;
  SyncPlayState get state => _state;

  // Lifecycle state for reconnection
  String? _lastGroupId;
  bool _wasConnected = false;

  // Player callbacks (delegated to command handler)
  set onPlay(SyncPlayPlayerCallback? callback) => _commandHandler.onPlay = callback;
  set onPause(SyncPlayPlayerCallback? callback) => _commandHandler.onPause = callback;
  set onSeek(SyncPlaySeekCallback? callback) => _commandHandler.onSeek = callback;
  set onStop(SyncPlayPlayerCallback? callback) => _commandHandler.onStop = callback;
  set getPositionTicks(SyncPlayPositionCallback? callback) =>
      _commandHandler.getPositionTicks = callback;
  set isPlaying(bool Function()? callback) => _commandHandler.isPlaying = callback;
  set isBuffering(bool Function()? callback) => _commandHandler.isBuffering = callback;

  JellyfinOpenApi get _api => _ref.read(jellyApiProvider).api;

  /// Initialize and connect to SyncPlay
  Future<void> connect() async {
    final user = _ref.read(userProvider);
    if (user == null) {
      log('SyncPlay: Cannot connect without user');
      return;
    }

    final serverUrl = _ref.read(serverUrlProvider);
    if (serverUrl == null || serverUrl.isEmpty) {
      log('SyncPlay: Cannot connect without server URL');
      return;
    }

    // Initialize time sync
    _timeSync = TimeSyncService(_api);
    _timeSync!.start();

    // Initialize WebSocket
    _wsManager = WebSocketManager(
      serverUrl: serverUrl,
      token: user.credentials.token,
      deviceId: user.credentials.deviceId,
    );

    _wsStateSubscription = _wsManager!.connectionState.listen(_handleConnectionState);
    _wsMessageSubscription = _wsManager!.messages.listen(_handleMessage);

    await _wsManager!.connect();
  }

  /// Disconnect from SyncPlay
  Future<void> disconnect() async {
    await leaveGroup();
    _commandHandler.cancelPendingCommands();
    _wsMessageSubscription?.cancel();
    _wsStateSubscription?.cancel();
    _timeSync?.dispose();
    await _wsManager?.dispose();
    _wsManager = null;
    _timeSync = null;
    _updateState(SyncPlayState());
  }

  /// List available SyncPlay groups
  Future<List<GroupInfoDto>> listGroups() async {
    try {
      final response = await _api.syncPlayListGet();
      return response.body ?? [];
    } catch (e) {
      log('SyncPlay: Failed to list groups: $e');
      return [];
    }
  }

  /// Create a new SyncPlay group
  Future<GroupInfoDto?> createGroup(String groupName) async {
    try {
      final response = await _api.syncPlayNewPost(
        body: NewGroupRequestDto(groupName: groupName),
      );
      return response.body;
    } catch (e) {
      log('SyncPlay: Failed to create group: $e');
      return null;
    }
  }

  /// Join an existing SyncPlay group
  Future<bool> joinGroup(String groupId) async {
    try {
      await _api.syncPlayJoinPost(
        body: JoinGroupRequestDto(groupId: groupId),
      );
      _lastGroupId = groupId;
      return true;
    } catch (e) {
      log('SyncPlay: Failed to join group: $e');
      return false;
    }
  }

  /// Leave the current SyncPlay group
  Future<void> leaveGroup() async {
    if (!_state.isInGroup) return;
    try {
      await _api.syncPlayLeavePost();
      _lastGroupId = null;
      _updateState(_state.copyWith(
        isInGroup: false,
        groupId: null,
        groupName: null,
        groupState: SyncPlayGroupState.idle,
        participants: [],
      ));
    } catch (e) {
      log('SyncPlay: Failed to leave group: $e');
    }
  }

  /// Request pause
  Future<void> requestPause() async {
    if (!_state.isInGroup) return;
    try {
      await _api.syncPlayPausePost();
    } catch (e) {
      log('SyncPlay: Failed to request pause: $e');
    }
  }

  /// Request unpause/play
  Future<void> requestUnpause() async {
    if (!_state.isInGroup) return;
    try {
      await _api.syncPlayUnpausePost();
    } catch (e) {
      log('SyncPlay: Failed to request unpause: $e');
    }
  }

  /// Request seek
  Future<void> requestSeek(int positionTicks) async {
    if (!_state.isInGroup) return;
    try {
      await _api.syncPlaySeekPost(
        body: SeekRequestDto(positionTicks: positionTicks),
      );
    } catch (e) {
      log('SyncPlay: Failed to request seek: $e');
    }
  }

  /// Report buffering state
  Future<void> reportBuffering() async {
    if (!_state.isInGroup) return;
    try {
      final when = _timeSync?.localDateToRemote(DateTime.now().toUtc());
      await _api.syncPlayBufferingPost(
        body: BufferRequestDto(
          when: when,
          positionTicks: _commandHandler.getPositionTicks?.call() ?? 0,
          isPlaying: false,
          playlistItemId: _state.playlistItemId,
        ),
      );
    } catch (e) {
      log('SyncPlay: Failed to report buffering: $e');
    }
  }

  /// Report ready state
  Future<void> reportReady({bool isPlaying = true}) async {
    if (!_state.isInGroup) return;
    try {
      final when = _timeSync?.localDateToRemote(DateTime.now().toUtc());
      await _api.syncPlayReadyPost(
        body: ReadyRequestDto(
          when: when,
          positionTicks: _commandHandler.getPositionTicks?.call() ?? 0,
          isPlaying: isPlaying,
          playlistItemId: _state.playlistItemId,
        ),
      );
    } catch (e) {
      log('SyncPlay: Failed to report ready: $e');
    }
  }

  /// Report ping to server
  Future<void> reportPing() async {
    if (!_state.isInGroup || _timeSync == null) return;
    try {
      await _api.syncPlayPingPost(
        body: PingRequestDto(ping: _timeSync!.ping.inMilliseconds),
      );
    } catch (e) {
      log('SyncPlay: Failed to report ping: $e');
    }
  }

  /// Set a new queue/playlist
  Future<void> setNewQueue({
    required List<String> itemIds,
    int playingItemPosition = 0,
    int startPositionTicks = 0,
  }) async {
    if (!_state.isInGroup) {
      log('SyncPlay: Cannot set queue - not in group');
      return;
    }
    try {
      final body = PlayRequestDto(
        playingQueue: itemIds,
        playingItemPosition: playingItemPosition,
        startPositionTicks: startPositionTicks,
      );
      log('SyncPlay: Setting new queue: ${body.toJson()}');
      final response = await _api.syncPlaySetNewQueuePost(body: body);
      log('SyncPlay: SetNewQueue response: ${response.statusCode} - ${response.body}');
    } catch (e) {
      log('SyncPlay: Failed to set new queue: $e');
    }
  }

  void _handleConnectionState(WebSocketConnectionState wsState) {
    final isConnected = wsState == WebSocketConnectionState.connected;
    _updateState(_state.copyWith(isConnected: isConnected));
  }

  void _handleMessage(Map<String, dynamic> message) {
    final messageType = message['MessageType'] as String?;
    final data = message['Data'];

    switch (messageType) {
      case 'SyncPlayCommand':
        _commandHandler.handleCommand(data as Map<String, dynamic>, _state);
        break;
      case 'SyncPlayGroupUpdate':
        _messageHandler.handleGroupUpdate(data as Map<String, dynamic>, _state);
        break;
    }
  }

  /// Start playback of an item from SyncPlay
  Future<void> _startPlayback(String itemId, int startPositionTicks) async {
    log('SyncPlay: _startPlayback called for item: $itemId, ticks: $startPositionTicks');

    try {
      // Fetch the item from Jellyfin
      log('SyncPlay: Fetching item from API...');
      final api = _ref.read(jellyApiProvider);
      final itemResponse = await api.usersUserIdItemsItemIdGet(itemId: itemId);
      final itemModel = itemResponse.body;

      if (itemModel == null) {
        log('SyncPlay: Failed to fetch item $itemId - response body was null');
        return;
      }
      log('SyncPlay: Fetched item: ${itemModel.name}');

      // Create playback model (context is optional - null for SyncPlay auto-play)
      log('SyncPlay: Creating playback model...');
      final playbackHelper = _ref.read(playbackModelHelper);
      final startPosition = Duration(microseconds: startPositionTicks ~/ 10);

      final playbackModel = await playbackHelper.createPlaybackModel(
        null, // No context needed for SyncPlay
        itemModel,
        startPosition: startPosition,
      );

      if (playbackModel == null) {
        log('SyncPlay: Failed to create playback model for $itemId');
        return;
      }
      log('SyncPlay: Playback model created successfully');

      // Load and play
      log('SyncPlay: Loading playback item...');
      final loadedCorrectly = await _ref.read(videoPlayerProvider.notifier).loadPlaybackItem(
            playbackModel,
            startPosition,
          );

      if (!loadedCorrectly) {
        log('SyncPlay: Failed to load playback item $itemId');
        return;
      }
      log('SyncPlay: Playback item loaded successfully');

      // Set state to fullScreen and push the VideoPlayer route
      _ref.read(mediaPlaybackProvider.notifier).update(
            (state) => state.copyWith(state: VideoPlayerState.fullScreen),
          );
      log('SyncPlay: Set state to fullScreen');

      // Push VideoPlayer using the global router's navigator key
      final navigatorKey = getNavigatorKey(_ref);
      log('SyncPlay: Navigator key: ${navigatorKey != null ? "exists" : "null"}, currentState: ${navigatorKey?.currentState != null ? "exists" : "null"}');
      if (navigatorKey?.currentState != null) {
        navigatorKey!.currentState!.push(
          MaterialPageRoute(
            builder: (context) => const VideoPlayer(),
          ),
        );
        log('SyncPlay: Successfully pushed VideoPlayer route for $itemId');
      } else {
        log('SyncPlay: No navigator available, player loaded but not opened fullscreen');
      }
    } catch (e, stackTrace) {
      log('SyncPlay: Error starting playback: $e\n$stackTrace');
    }
  }

  void _updateState(SyncPlayState newState) {
    _state = newState;
    _stateController.add(newState);
  }

  void _updateStateWith(SyncPlayState Function(SyncPlayState) updater) {
    _state = updater(_state);
    _stateController.add(_state);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Lifecycle Handling (for mobile background/resume)
  // ─────────────────────────────────────────────────────────────────────────

  /// Handle app lifecycle state changes
  /// Call this from a WidgetsBindingObserver when app state changes
  Future<void> handleAppLifecycleChange(AppLifecycleState lifecycleState) async {
    switch (lifecycleState) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // App going to background - remember state for reconnection
        _wasConnected = _wsManager?.currentState == WebSocketConnectionState.connected;
        log('SyncPlay: App paused, wasConnected=$_wasConnected, lastGroupId=$_lastGroupId');
        break;

      case AppLifecycleState.resumed:
        // App returning to foreground - attempt reconnection if needed
        log('SyncPlay: App resumed, wasConnected=$_wasConnected, isInGroup=${_state.isInGroup}');
        if (_wasConnected || _state.isInGroup) {
          await _handleAppResume();
        }
        break;

      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // No action needed
        break;
    }
  }

  /// Handle app resume - reconnect WebSocket and optionally rejoin group
  Future<void> _handleAppResume() async {
    // Force reconnect WebSocket
    if (_wsManager != null) {
      log('SyncPlay: Force reconnecting WebSocket on resume');
      await _wsManager!.forceReconnect();

      // Wait for connection to establish
      await Future.delayed(const Duration(milliseconds: 500));

      // Restart time sync if it was active
      if (_timeSync != null) {
        _timeSync!.start();
        await _timeSync!.forceUpdate();
      }

      // If we were in a group but got disconnected, try to rejoin
      if (_lastGroupId != null && !_state.isInGroup) {
        log('SyncPlay: Attempting to rejoin group $_lastGroupId');
        final success = await joinGroup(_lastGroupId!);
        if (!success) {
          log('SyncPlay: Failed to rejoin group, clearing lastGroupId');
          _lastGroupId = null;
        }
      }
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    _commandHandler.dispose();
    await disconnect();
    await _stateController.close();
  }
}
