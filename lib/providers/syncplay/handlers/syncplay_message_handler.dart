import 'dart:developer';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:flutter/material.dart';

/// Callback for reporting ready state after seek
typedef ReportReadyCallback = Future<void> Function({bool isPlaying});

/// Callback for starting playback of an item
typedef StartPlaybackCallback = Future<void> Function(String itemId, int startPositionTicks);

/// Callback that pauses the local player without sending a SyncPlay
/// pause request. Used when the group enters Waiting because another
/// client is buffering — we must mirror the group state locally.
typedef LocalPauseCallback = Future<void> Function();

/// Handles SyncPlay group update messages from WebSocket
class SyncPlayMessageHandler {
  SyncPlayMessageHandler({
    required this.onStateUpdate,
    required this.reportReady,
    required this.startPlayback,
    required this.isBuffering,
    required this.getContext,
    required this.onGroupJoined,
    required this.onGroupJoinFailed,
    this.onGroupLeftOrKicked,
    this.onStateUpdateToPlaying,
    this.onGroupGone,
    this.onLocalPauseForBuffer,
  });

  final void Function(SyncPlayState Function(SyncPlayState)) onStateUpdate;
  final ReportReadyCallback reportReady;
  final StartPlaybackCallback startPlayback;
  final bool Function() isBuffering;
  final BuildContext? Function() getContext;
  final void Function() onGroupJoined;
  final void Function() onGroupJoinFailed;

  /// Called when we leave or are kicked so controller can cancel pending commands and clear processing state.
  final void Function()? onGroupLeftOrKicked;

  /// Called when group state becomes Playing so controller can ensure player is actually playing (per docs).
  final void Function()? onStateUpdateToPlaying;

  /// Called when the user is no longer part of the group from the
  /// server's perspective (kicked, group disposed, etc.) so that the
  /// controller can surface a user-visible notification.
  final void Function({required bool wasKicked})? onGroupGone;

  /// Called when the group enters Waiting because another client is
  /// buffering. Mirrors the group state locally before reporting Ready
  /// so we don't keep playing while the group is logically paused.
  final LocalPauseCallback? onLocalPauseForBuffer;

  /// Handle group update message
  void handleGroupUpdate(Map<String, dynamic> data, SyncPlayState currentState) {
    _wasInGroupAtLastUpdate = currentState.isInGroup;
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
      case 'NotInGroup':
        _handleNotInGroup();
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
    final positionTicks = data['PositionTicks'] as int? ?? 0;
    final playingItemId = data['PlayingItemId'] as String?;

    onStateUpdate((state) => state.copyWith(
          isInGroup: true,
          groupId: groupId,
          groupName: groupName,
          groupState: _parseGroupState(stateStr),
          participants: participants,
          positionTicks: positionTicks,
          playingItemId: playingItemId ?? state.playingItemId,
        ));

    log('SyncPlay: Joined group "$groupName" ($groupId)');

    // Notify controller that group join was confirmed
    onGroupJoined();
  }

  /// Note: SyncPlay's `UserJoined` / `UserLeft` payloads carry the
  /// participant's display name directly in `Data` (a plain string),
  /// not a userId. No `usersUserIdGet` lookup is needed - calling that
  /// endpoint with the username returns a 400.
  void _handleUserJoined(String? userName, SyncPlayState currentState) {
    if (userName == null) {
      return;
    }
    // The server re-broadcasts `UserJoined` on every `Join` POST —
    // including reconnects, silent rejoins and retries after a
    // false-negative "Failed to join". Appending unconditionally is
    // what stacked the same user multiple times. Ignore if already a
    // participant.
    if (currentState.participants.contains(userName)) {
      log('SyncPlay: Duplicate UserJoined ignored (already a participant): $userName');
      return;
    }
    final participants = [...currentState.participants, userName];
    onStateUpdate((state) => state.copyWith(participants: participants));

    _showSnackbar((l) => l.syncPlayUserJoined(userName));
    log('SyncPlay: User joined: $userName');
  }

  void _handleUserLeft(String? userName, SyncPlayState currentState) {
    if (userName == null) {
      return;
    }
    final participants = currentState.participants.where((p) => p != userName).toList();
    onStateUpdate((state) => state.copyWith(participants: participants));

    _showSnackbar((l) => l.syncPlayUserLeft(userName));
    log('SyncPlay: User left: $userName');
  }

  /// Render a snackbar through the global notification overlay. We
  /// deliberately do NOT pass the navigator-key context here: that
  /// context lives under `Navigator` but not under any `Overlay`, so
  /// `Overlay.of(context)` throws. `FladderSnack` keeps a stored root
  /// context (set by `NotificationManagerInitializer`) that already
  /// resolves to the root overlay.
  void _showSnackbar(String Function(AppLocalizations l) builder) {
    final context = getContext();
    if (context != null) {
      FladderSnack.show(builder(context.localized));
      return;
    }
    try {
      final loc = lookupAppLocalizations(const Locale('en'));
      FladderSnack.show(builder(loc));
    } catch (_) {
      // No fallback available - silently swallow.
    }
  }

  void _handleGroupLeft() {
    onStateUpdate((state) => state.copyWith(
          isInGroup: false,
          groupId: null,
          groupName: null,
          groupState: SyncPlayGroupState.idle,
          participants: [],
          isProcessingCommand: false,
          processingCommandType: null,
        ));
    onGroupLeftOrKicked?.call();
    log('SyncPlay: Left group');
  }

  void _handleGroupDoesNotExist() {
    final wasInGroup = _wasInGroupAtLastUpdate;
    onStateUpdate((state) => state.copyWith(
          isInGroup: false,
          groupId: null,
          groupName: null,
          groupState: SyncPlayGroupState.idle,
          participants: [],
          isProcessingCommand: false,
          processingCommandType: null,
        ));
    onGroupLeftOrKicked?.call();
    log('SyncPlay: Group does not exist');

    if (wasInGroup) {
      onGroupGone?.call(wasKicked: false);
    }

    // Notify controller that group join failed
    onGroupJoinFailed();
  }

  void _handleNotInGroup() {
    final wasInGroup = _wasInGroupAtLastUpdate;
    onStateUpdate((state) => state.copyWith(
          isInGroup: false,
          groupId: null,
          groupName: null,
          groupState: SyncPlayGroupState.idle,
          participants: [],
          isProcessingCommand: false,
          processingCommandType: null,
        ));
    onGroupLeftOrKicked?.call();
    log('SyncPlay: Not in group - server rejected operation');

    if (wasInGroup) {
      onGroupGone?.call(wasKicked: true);
    }

    // Notify controller that group join failed
    onGroupJoinFailed();
  }

  bool _wasInGroupAtLastUpdate = false;

  void _handleStateUpdate(Map<String, dynamic> data) {
    final stateStr = data['State'] as String?;
    final reasonStr = data['Reason'] as String?;
    final positionTicks = data['PositionTicks'] as int? ?? 0;
    final newGroupState = _parseGroupState(stateStr);
    final reason = SyncPlayStateReason.fromWire(reasonStr);

    onStateUpdate((state) => state.copyWith(
          groupState: newGroupState,
          stateReason: reasonStr,
          positionTicks: positionTicks,
        ));

    log('SyncPlay: State update: $stateStr (reason: $reasonStr, positionTicks: $positionTicks)');

    if (newGroupState == SyncPlayGroupState.waiting) {
      _handleWaitingState(reason);
    }

    // Per docs: when state becomes Playing, ensure player is actually
    // playing (recover if Unpause was missed).
    if (newGroupState == SyncPlayGroupState.playing) {
      onStateUpdateToPlaying?.call();
    }
  }

  void _handleWaitingState(SyncPlayStateReason? reason) {
    if (reason == SyncPlayStateReason.buffer) {
      // Per spec: another client is buffering — pause locally first, then
      // report ready so the server knows we're aligned.
      final pauseFuture = onLocalPauseForBuffer?.call() ?? Future<void>.value();
      pauseFuture.then((_) {
        if (!isBuffering()) {
          reportReady(isPlaying: true);
        }
      });
      return;
    }
    if (reason == SyncPlayStateReason.unpause) {
      if (!isBuffering()) {
        reportReady(isPlaying: true);
      }
    }
  }

  void _handlePlayQueue(Map<String, dynamic> data, SyncPlayState currentState) {
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

    // Trigger playback for NewPlaylist/SetCurrentItem/NextItem/PreviousItem regardless of
    // whether the item changed (the same user who set the queue also receives the update
    // and needs to start playing).
    final shouldTrigger = playingItemId != null &&
        (reason == 'NewPlaylist' ||
            reason == 'SetCurrentItem' ||
            reason == 'NextItem' ||
            reason == 'PreviousItem' ||
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
