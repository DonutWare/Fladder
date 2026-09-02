import 'dart:developer';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:flutter/material.dart';

/// [reason] is the server's `PlayQueueUpdateReason` wire value (`NewPlaylist`, `NextItem`, ...).
typedef StartPlaybackCallback = Future<void> Function(String itemId, int startPositionTicks, String? reason);

/// Never answers a `StateUpdate` with a request: the server only needs `Ready` from sessions it flagged
/// as buffering, and replying from here produced an N-client cascade of Ready/Pause exchanges.
class SyncPlayMessageHandler {
  SyncPlayMessageHandler({
    required this.onStateUpdate,
    required this.startPlayback,
    required this.getContext,
    required this.onGroupJoined,
    required this.onGroupJoinFailed,
    this.onGroupLeftOrKicked,
    this.onStateUpdateToPlaying,
    this.onGroupGone,
  });

  final void Function(SyncPlayState Function(SyncPlayState)) onStateUpdate;
  final StartPlaybackCallback startPlayback;
  final BuildContext? Function() getContext;
  final void Function() onGroupJoined;
  final void Function() onGroupJoinFailed;

  final void Function()? onGroupLeftOrKicked;

  /// Lets the controller run its missed-Unpause recovery check.
  final void Function()? onStateUpdateToPlaying;

  /// The server no longer considers us part of the group (kicked, group disposed).
  final void Function({required bool wasKicked})? onGroupGone;

  bool _wasInGroupAtLastUpdate = false;

  /// `LastUpdate` of the most recent applied `PlayQueue` frame; older frames are ignored.
  DateTime? _lastQueueUpdate;

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
      case 'LibraryAccessDenied':
        _handleLibraryAccessDenied();
        break;
      case 'StateUpdate':
        _handleStateUpdate(updateData as Map<String, dynamic>);
        break;
      case 'PlayQueue':
        _handlePlayQueue(updateData as Map<String, dynamic>, currentState);
        break;
      default:
        log('SyncPlay: Unhandled group update type: $updateType');
    }
  }

  /// The playing item arrives in the `PlayQueue` frame that follows.
  void _handleGroupJoined(Map<String, dynamic> data) {
    final groupId = data['GroupId'] as String?;
    final groupName = data['GroupName'] as String?;
    final stateStr = data['State'] as String?;
    final participants = (data['Participants'] as List?)?.cast<String>() ?? [];

    // A (re)join's fresh PlayQueue frame may carry the LastUpdate we already applied; accept it.
    _lastQueueUpdate = null;

    // `isFollowingGroupPlayback` is left alone: the controller sets it for user-initiated joins, and a
    // silent rejoin must not un-halt a device the user halted.
    onStateUpdate((state) => state.copyWith(
          isInGroup: true,
          groupId: groupId,
          groupName: groupName,
          groupState: _parseGroupState(stateStr),
          participants: participants,
        ));

    log('SyncPlay: Joined group "$groupName" ($groupId)');

    onGroupJoined();
  }

  /// `UserJoined` / `UserLeft` carry the participant's display name in `Data`, not a userId.
  void _handleUserJoined(String? userName, SyncPlayState currentState) {
    if (userName == null) {
      return;
    }
    // The server re-broadcasts `UserJoined` on every `Join` POST (reconnects, silent rejoins, retries).
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

  /// Never pass the navigator-key context: it is not under an `Overlay`, so `Overlay.of` throws.
  /// `FladderSnack` resolves the root overlay from its own stored context.
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

  SyncPlayState _clearGroup(SyncPlayState state) {
    return state.copyWith(
      isInGroup: false,
      isFollowingGroupPlayback: true,
      groupId: null,
      groupName: null,
      groupState: SyncPlayGroupState.idle,
      participants: [],
      isProcessingCommand: false,
      processingCommandType: null,
      playlist: [],
      playingItemIndex: -1,
      queueTiming: null,
    );
  }

  void _handleGroupLeft() {
    _lastQueueUpdate = null;
    onStateUpdate(_clearGroup);
    onGroupLeftOrKicked?.call();
    log('SyncPlay: Left group');
  }

  void _handleGroupDoesNotExist() {
    final wasInGroup = _wasInGroupAtLastUpdate;
    _lastQueueUpdate = null;
    onStateUpdate(_clearGroup);
    log('SyncPlay: Group does not exist');

    // A failed join must not stop what the user is watching; only a real member has playback to tear down.
    if (wasInGroup) {
      onGroupLeftOrKicked?.call();
      onGroupGone?.call(wasKicked: false);
    }

    onGroupJoinFailed();
  }

  void _handleNotInGroup() {
    final wasInGroup = _wasInGroupAtLastUpdate;
    _lastQueueUpdate = null;
    onStateUpdate(_clearGroup);
    log('SyncPlay: Not in group - server rejected operation');

    if (wasInGroup) {
      onGroupLeftOrKicked?.call();
      onGroupGone?.call(wasKicked: true);
    }

    onGroupJoinFailed();
  }

  /// Sent instead of `GroupJoined` when the user lacks access to an item in the queue.
  void _handleLibraryAccessDenied() {
    _lastQueueUpdate = null;
    onStateUpdate(_clearGroup);
    log('SyncPlay: Join refused - library access denied');
    _showSnackbar((l) => l.syncPlayLibraryAccessDenied);
    onGroupJoinFailed();
  }

  void _handleStateUpdate(Map<String, dynamic> data) {
    final stateStr = data['State'] as String?;
    final reasonStr = data['Reason'] as String?;
    final newGroupState = _parseGroupState(stateStr);

    onStateUpdate((state) => state.copyWith(
          groupState: newGroupState,
          stateReason: reasonStr,
        ));

    log('SyncPlay: State update: $stateStr (reason: $reasonStr)');

    // The controller decides whether a missed Unpause needs recovering (see shouldRecoverPlayback).
    if (newGroupState == SyncPlayGroupState.playing) {
      onStateUpdateToPlaying?.call();
    }
  }

  void _handlePlayQueue(Map<String, dynamic> data, SyncPlayState currentState) {
    final playlist = data['Playlist'] as List? ?? [];
    final playingItemIndex = data['PlayingItemIndex'] as int? ?? -1;
    final startPositionTicks = data['StartPositionTicks'] as int? ?? 0;
    final isPlayingNow = data['IsPlaying'] as bool? ?? false;
    final reason = data['Reason'] as String?;
    final lastUpdate = DateTime.tryParse(data['LastUpdate'] as String? ?? '');

    final previousUpdate = _lastQueueUpdate;
    if (lastUpdate != null && previousUpdate != null && !lastUpdate.isAfter(previousUpdate)) {
      log('SyncPlay: Ignoring old PlayQueue update ($reason, $lastUpdate <= $previousUpdate)');
      return;
    }
    if (lastUpdate != null) {
      _lastQueueUpdate = lastUpdate;
    }

    final entries = <SyncPlayQueueEntry>[];
    for (final raw in playlist) {
      if (raw is! Map<String, dynamic>) {
        continue;
      }
      final itemId = raw['ItemId'] as String?;
      final playlistItemId = raw['PlaylistItemId'] as String?;
      if (itemId == null || playlistItemId == null) {
        continue;
      }
      entries.add(SyncPlayQueueEntry(itemId: itemId, playlistItemId: playlistItemId));
    }

    final hasPlayingEntry = playingItemIndex >= 0 && playingItemIndex < entries.length;
    final playingEntry = hasPlayingEntry ? entries[playingItemIndex] : null;
    final playingItemId = playingEntry?.itemId;
    final playlistItemId = playingEntry?.playlistItemId;

    final previousItemId = currentState.playingItemId;

    onStateUpdate((state) => state.copyWith(
          playingItemId: playingItemId,
          playlistItemId: playlistItemId,
          positionTicks: startPositionTicks,
          playlist: entries,
          playingItemIndex: hasPlayingEntry ? playingItemIndex : -1,
          queueTiming: SyncPlayQueueTiming(
            startPositionTicks: startPositionTicks,
            lastUpdate: lastUpdate,
            isPlaying: isPlayingNow,
          ),
        ));

    log('SyncPlay: PlayQueue update - playing: $playingItemId '
        '(reason: $reason, isPlaying: $isPlayingNow, previousItemId: $previousItemId, '
        'queue: ${entries.length} items)');

    // Trigger regardless of whether the item changed: the user who set the queue also receives the update.
    final shouldTrigger = playingItemId != null &&
        (reason == 'NewPlaylist' ||
            reason == 'SetCurrentItem' ||
            reason == 'NextItem' ||
            reason == 'PreviousItem' ||
            (playingItemId != previousItemId && isPlayingNow));

    log('SyncPlay: shouldTrigger=$shouldTrigger (reason: $reason)');

    if (shouldTrigger) {
      log('SyncPlay: Triggering playback for item: $playingItemId');
      startPlayback(playingItemId, startPositionTicks, reason);
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
