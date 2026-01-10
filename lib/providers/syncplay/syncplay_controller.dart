import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/router_provider.dart';
import 'package:fladder/providers/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/time_sync_service.dart';
import 'package:fladder/providers/syncplay/websocket_manager.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/video_player/video_player.dart';

/// Callback for player control commands from SyncPlay
typedef SyncPlayPlayerCallback = Future<void> Function();
typedef SyncPlaySeekCallback = Future<void> Function(int positionTicks);
typedef SyncPlayPositionCallback = int Function();

/// Controller for SyncPlay synchronized playback
class SyncPlayController {
  SyncPlayController(this._ref);

  final Ref _ref;

  WebSocketManager? _wsManager;
  TimeSyncService? _timeSync;
  StreamSubscription? _wsMessageSubscription;
  StreamSubscription? _wsStateSubscription;

  SyncPlayState _state = SyncPlayState();
  final _stateController = StreamController<SyncPlayState>.broadcast();
  Stream<SyncPlayState> get stateStream => _stateController.stream;
  SyncPlayState get state => _state;

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
    _commandTimer?.cancel();
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
          positionTicks: getPositionTicks?.call() ?? 0,
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
          positionTicks: getPositionTicks?.call() ?? 0,
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
        _handleSyncPlayCommand(data as Map<String, dynamic>);
        break;
      case 'SyncPlayGroupUpdate':
        _handleGroupUpdate(data as Map<String, dynamic>);
        break;
    }
  }

  void _handleSyncPlayCommand(Map<String, dynamic> data) {
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

    _updateState(_state.copyWith(
      positionTicks: positionTicks,
      playlistItemId: playlistItemId,
    ));

    final when = DateTime.parse(whenStr);
    _scheduleCommand(command, when, positionTicks);
  }

  bool _isDuplicateCommand(String when, int positionTicks, String command, String playlistItemId) {
    if (_lastCommand == null) return false;
    return _lastCommand!.when == when &&
        _lastCommand!.positionTicks == positionTicks &&
        _lastCommand!.command == command &&
        _lastCommand!.playlistItemId == playlistItemId;
  }

  void _scheduleCommand(String command, DateTime serverTime, int positionTicks) {
    if (_timeSync == null) {
      log('SyncPlay: Cannot schedule command without time sync');
      _executeCommand(command, positionTicks);
      return;
    }

    final localTime = _timeSync!.remoteDateToLocal(serverTime);
    final now = DateTime.now().toUtc();
    final delay = localTime.difference(now);

    _commandTimer?.cancel();

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
    if (_timeSync == null) return ticks;
    final remoteNow = _timeSync!.localDateToRemote(DateTime.now().toUtc());
    final elapsedMs = remoteNow.difference(when).inMilliseconds;
    return ticks + millisecondsToTicks(elapsedMs);
  }

  Future<void> _executeCommand(String command, int positionTicks) async {
    log('SyncPlay: Executing command: $command at $positionTicks ticks');

    switch (command) {
      case 'Pause':
        await onPause?.call();
        // Seek to position if significantly different
        final currentTicks = getPositionTicks?.call() ?? 0;
        if ((positionTicks - currentTicks).abs() > ticksPerSecond ~/ 2) {
          await onSeek?.call(positionTicks);
        }
        break;

      case 'Unpause':
        // Seek to position if significantly different
        final currentTicks = getPositionTicks?.call() ?? 0;
        if ((positionTicks - currentTicks).abs() > ticksPerSecond ~/ 2) {
          await onSeek?.call(positionTicks);
        }
        await onPlay?.call();
        break;

      case 'Seek':
        await onPlay?.call();
        await onSeek?.call(positionTicks);
        await onPause?.call();
        // Report ready after seek
        await reportReady(isPlaying: true);
        break;

      case 'Stop':
        await onPause?.call();
        await onSeek?.call(0);
        break;
    }
  }

  void _handleGroupUpdate(Map<String, dynamic> data) {
    final updateType = data['Type'] as String?;
    // final groupId = data['GroupId'] as String?; // Not needed - group info is in updateData
    final updateData = data['Data'];

    switch (updateType) {
      case 'GroupJoined':
        _handleGroupJoined(updateData as Map<String, dynamic>);
        break;
      case 'UserJoined':
        _handleUserJoined(updateData as String?);
        break;
      case 'UserLeft':
        _handleUserLeft(updateData as String?);
        break;
      case 'GroupLeft':
        _handleGroupLeft();
        break;
      case 'GroupDoesNotExist':
        _handleGroupDoesNotExist();
        break;
      case 'StateUpdate':
        _handleStateUpdate(updateData as Map<String, dynamic>);
        break;
      case 'PlayQueue':
        _handlePlayQueue(updateData as Map<String, dynamic>);
        break;
    }
  }

  void _handleGroupJoined(Map<String, dynamic> data) {
    final groupId = data['GroupId'] as String?;
    final groupName = data['GroupName'] as String?;
    final stateStr = data['State'] as String?;
    final participants = (data['Participants'] as List?)?.cast<String>() ?? [];

    _updateState(_state.copyWith(
      isInGroup: true,
      groupId: groupId,
      groupName: groupName,
      groupState: _parseGroupState(stateStr),
      participants: participants,
    ));

    log('SyncPlay: Joined group "$groupName" ($groupId)');
  }

  void _handleUserJoined(String? userId) {
    if (userId == null) return;
    final participants = [..._state.participants, userId];
    _updateState(_state.copyWith(participants: participants));
    log('SyncPlay: User joined: $userId');
  }

  void _handleUserLeft(String? userId) {
    if (userId == null) return;
    final participants = _state.participants.where((p) => p != userId).toList();
    _updateState(_state.copyWith(participants: participants));
    log('SyncPlay: User left: $userId');
  }

  void _handleGroupLeft() {
    _updateState(_state.copyWith(
      isInGroup: false,
      groupId: null,
      groupName: null,
      groupState: SyncPlayGroupState.idle,
      participants: [],
    ));
    log('SyncPlay: Left group');
  }

  void _handleGroupDoesNotExist() {
    _updateState(_state.copyWith(
      isInGroup: false,
      groupId: null,
      groupName: null,
      groupState: SyncPlayGroupState.idle,
      participants: [],
    ));
    log('SyncPlay: Group does not exist');
  }

  void _handleStateUpdate(Map<String, dynamic> data) {
    final stateStr = data['State'] as String?;
    final reason = data['Reason'] as String?;
    final positionTicks = data['PositionTicks'] as int? ?? 0;

    _updateState(_state.copyWith(
      groupState: _parseGroupState(stateStr),
      stateReason: reason,
      positionTicks: positionTicks,
    ));

    log('SyncPlay: State update: $stateStr (reason: $reason)');

    // Handle waiting state
    if (_parseGroupState(stateStr) == SyncPlayGroupState.waiting) {
      _handleWaitingState(reason);
    }
  }

  void _handleWaitingState(String? reason) {
    switch (reason) {
      case 'Buffer':
      case 'Unpause':
        // Report ready if we're ready
        if (!(isBuffering?.call() ?? false)) {
          reportReady(isPlaying: true);
        }
        break;
    }
  }

  void _handlePlayQueue(Map<String, dynamic> data) {
    final playlist = data['Playlist'] as List? ?? [];
    final playingItemIndex = data['PlayingItemIndex'] as int? ?? 0;
    final startPositionTicks = data['StartPositionTicks'] as int? ?? 0;
    final isPlayingNow = data['IsPlaying'] as bool? ?? false;
    final reason = data['Reason'] as String?;

    String? playingItemId;
    String? playlistItemId;

    if (playlist.isNotEmpty && playingItemIndex < playlist.length) {
      final item = playlist[playingItemIndex] as Map<String, dynamic>;
      playingItemId = item['ItemId'] as String?;
      playlistItemId = item['PlaylistItemId'] as String?;
    }

    final previousItemId = _state.playingItemId;

    _updateState(_state.copyWith(
      playingItemId: playingItemId,
      playlistItemId: playlistItemId,
      positionTicks: startPositionTicks,
    ));

    log('SyncPlay: PlayQueue update - playing: $playingItemId (reason: $reason, isPlaying: $isPlayingNow, previousItemId: $previousItemId)');

    // Trigger playback for NewPlaylist/SetCurrentItem regardless of whether item changed
    // (the same user who set the queue also receives the update and needs to start playing)
    final shouldTrigger = playingItemId != null &&
        (reason == 'NewPlaylist' || reason == 'SetCurrentItem' || 
         (playingItemId != previousItemId && isPlayingNow));
    
    log('SyncPlay: shouldTrigger=$shouldTrigger (reason: $reason)');
    
    if (shouldTrigger) {
      log('SyncPlay: Triggering playback for item: $playingItemId');
      _startPlayback(playingItemId!, startPositionTicks);
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

  SyncPlayGroupState _parseGroupState(String? state) {
    switch (state?.toLowerCase()) {
      case 'idle':
        return SyncPlayGroupState.idle;
      case 'waiting':
        return SyncPlayGroupState.waiting;
      case 'paused':
        return SyncPlayGroupState.paused;
      case 'playing':
        return SyncPlayGroupState.playing;
      default:
        return SyncPlayGroupState.idle;
    }
  }

  void _updateState(SyncPlayState newState) {
    _state = newState;
    _stateController.add(newState);
  }

  /// Dispose resources
  Future<void> dispose() async {
    await disconnect();
    await _stateController.close();
  }
}
