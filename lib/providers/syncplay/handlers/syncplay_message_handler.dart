import 'dart:developer';

import 'package:fladder/models/syncplay/syncplay_models.dart';

/// Callback for reporting ready state after seek
typedef ReportReadyCallback = Future<void> Function({bool isPlaying});

/// Callback for starting playback of an item
typedef StartPlaybackCallback = Future<void> Function(
    String itemId, int startPositionTicks);

/// Handles SyncPlay group update messages from WebSocket
class SyncPlayMessageHandler {
  SyncPlayMessageHandler({
    required this.onStateUpdate,
    required this.reportReady,
    required this.startPlayback,
    required this.isBuffering,
  });

  final void Function(SyncPlayState Function(SyncPlayState)) onStateUpdate;
  final ReportReadyCallback reportReady;
  final StartPlaybackCallback startPlayback;
  final bool Function() isBuffering;

  /// Handle group update message
  void handleGroupUpdate(Map<String, dynamic> data, SyncPlayState currentState) {
    final updateType = data['Type'] as String?;
    final updateData = data['Data'];

    switch (updateType) {
      case 'GroupJoined':
        _handleGroupJoined(updateData as Map<String, dynamic>);
        break;
      case 'UserJoined':
        _handleUserJoined(updateData as String?, currentState);
        break;
      case 'UserLeft':
        _handleUserLeft(updateData as String?, currentState);
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
        _handlePlayQueue(updateData as Map<String, dynamic>, currentState);
        break;
    }
  }

  void _handleGroupJoined(Map<String, dynamic> data) {
    final groupId = data['GroupId'] as String?;
    final groupName = data['GroupName'] as String?;
    final stateStr = data['State'] as String?;
    final participants = (data['Participants'] as List?)?.cast<String>() ?? [];

    onStateUpdate((state) => state.copyWith(
          isInGroup: true,
          groupId: groupId,
          groupName: groupName,
          groupState: _parseGroupState(stateStr),
          participants: participants,
        ));

    log('SyncPlay: Joined group "$groupName" ($groupId)');
  }

  void _handleUserJoined(String? userId, SyncPlayState currentState) {
    if (userId == null) return;
    final participants = [...currentState.participants, userId];
    onStateUpdate((state) => state.copyWith(participants: participants));
    log('SyncPlay: User joined: $userId');
  }

  void _handleUserLeft(String? userId, SyncPlayState currentState) {
    if (userId == null) return;
    final participants =
        currentState.participants.where((p) => p != userId).toList();
    onStateUpdate((state) => state.copyWith(participants: participants));
    log('SyncPlay: User left: $userId');
  }

  void _handleGroupLeft() {
    onStateUpdate((state) => state.copyWith(
          isInGroup: false,
          groupId: null,
          groupName: null,
          groupState: SyncPlayGroupState.idle,
          participants: [],
        ));
    log('SyncPlay: Left group');
  }

  void _handleGroupDoesNotExist() {
    onStateUpdate((state) => state.copyWith(
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

    onStateUpdate((state) => state.copyWith(
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
        if (!isBuffering()) {
          reportReady(isPlaying: true);
        }
        break;
    }
  }

  void _handlePlayQueue(
      Map<String, dynamic> data, SyncPlayState currentState) {
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

    final previousItemId = currentState.playingItemId;

    onStateUpdate((state) => state.copyWith(
          playingItemId: playingItemId,
          playlistItemId: playlistItemId,
          positionTicks: startPositionTicks,
        ));

    log('SyncPlay: PlayQueue update - playing: $playingItemId (reason: $reason, isPlaying: $isPlayingNow, previousItemId: $previousItemId)');

    // Trigger playback for NewPlaylist/SetCurrentItem regardless of whether item changed
    // (the same user who set the queue also receives the update and needs to start playing)
    final shouldTrigger = playingItemId != null &&
        (reason == 'NewPlaylist' ||
            reason == 'SetCurrentItem' ||
            (playingItemId != previousItemId && isPlayingNow));

    log('SyncPlay: shouldTrigger=$shouldTrigger (reason: $reason)');

    if (shouldTrigger) {
      log('SyncPlay: Triggering playback for item: $playingItemId');
      startPlayback(playingItemId, startPositionTicks);
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
}
