import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/playback/multipart_playback.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/playback/playback_queue_state.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/incognito_mode_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class OfflinePlaybackModel extends PlaybackModel {
  OfflinePlaybackModel({
    required this.syncedItem,
    super.mediaStreams,
    super.playbackInfo,
    required super.item,
    required super.media,
    super.mediaSegments,
    super.trickPlay,
    super.queue = const [],
    super.playbackQueue,
    super.queueSource,
    this.syncedQueue = const [],
  });

  final SyncedItem syncedItem;
  final List<SyncedItem> syncedQueue;

  @override
  List<Chapter>? get chapters => syncedItem.chapters;

  @override
  Future<Duration>? startDuration() async => isAudioPlayback ? Duration.zero : item.userData.playBackPosition;

  @override
  ItemBaseModel? get nextVideo => queue.nextOrNull(item);

  @override
  ItemBaseModel? get previousVideo => queue.previousOrNull(item);

  @override
  List<SubStreamModel> get subStreams => [SubStreamModel.no(), ...syncedItem.subtitles];

  @override
  Future<OfflinePlaybackModel> setSubtitle(SubStreamModel? model, MediaControlsWrapper player) async {
    final newIndex = await player.setSubtitleTrack(model, this);
    return copyWith(mediaStreams: () => mediaStreams?.copyWith(defaultSubStreamIndex: newIndex));
  }

  @override
  List<AudioStreamModel> get audioStreams => [AudioStreamModel.no(), ...mediaStreams?.audioStreams ?? []];

  @override
  Future<OfflinePlaybackModel>? setAudio(AudioStreamModel? model, MediaControlsWrapper player) async {
    final newIndex = await player.setAudioTrack(model, this);
    return copyWith(mediaStreams: () => mediaStreams?.copyWith(defaultAudioStreamIndex: newIndex));
  }

  @override
  Future<PlaybackModel?> playbackStarted(Duration position, Ref ref) async {
    return null;
  }

  @override
  Future<PlaybackModel?> playbackStopped(Duration position, Duration? totalDuration, Ref ref) async {
    if (ref.read(incognitoModeProvider) == true) return null;

    final effectiveDuration = totalDuration ?? item.overview.runTime ?? Duration.zero;
    final effectivePosition = resolvedStopPosition(position, totalDuration);
    final group = multipartGroup;

    if (group == null) {
      await _persistUserData(
        syncedItem,
        _userDataAfterPlayback(syncedItem, effectivePosition, effectiveDuration),
        ref,
      );
      return null;
    }

    if (group.isFirstPart(item)) {
      // Part 1 keeps its local position and must not mark the logical item as
      // played while additional parts remain.
      await _persistUserData(
        syncedItem,
        MultipartGroup.part1UserData(syncedItem.userData, effectivePosition, effectiveDuration),
        ref,
      );
      return null;
    }

    final currentPart = _syncedItemFor(item.id) ?? syncedItem;
    await _persistUserData(
      currentPart,
      _userDataAfterPlayback(currentPart, effectivePosition, effectiveDuration),
      ref,
    );

    final parentUpdate = group.stopUpdate(item, effectivePosition);
    final parent = _syncedItemFor(group.main.id);
    if (parentUpdate != null && parent != null) {
      await _persistUserData(
        parent,
        MultipartGroup.parentProgressUserData(
          parent.userData,
          parentUpdate.playbackPositionTicks,
          group.aggregateProgress(item, effectivePosition),
          now: parentUpdate.lastPlayed,
        ),
        ref,
      );
    }

    if (group.shouldMarkCompleted(item, effectivePosition)) {
      await _completeGroup(group, ref);
    }
    return null;
  }

  @override
  Future<PlaybackModel?> updatePlaybackPosition(Duration position, bool isPlaying, Ref ref) async {
    if (ref.read(incognitoModeProvider) == true) return null;

    final group = multipartGroup;
    if (group == null) {
      await _persistUserData(
        syncedItem,
        _userDataAfterPlayback(syncedItem, position, item.overview.runTime ?? Duration.zero),
        ref,
      );
      return null;
    }

    final duration = item.overview.runTime ?? Duration.zero;

    if (group.isFirstPart(item)) {
      await _persistUserData(
        syncedItem,
        MultipartGroup.part1UserData(syncedItem.userData, position, duration),
        ref,
      );
      return null;
    }

    final currentPart = _syncedItemFor(item.id) ?? syncedItem;
    await _persistUserData(
      currentPart,
      _userDataAfterPlayback(currentPart, position, duration),
      ref,
    );

    final parentUpdate = group.progressUpdate(item, position);
    final parent = _syncedItemFor(group.main.id);
    if (parentUpdate != null && parent != null) {
      await _persistUserData(
        parent,
        MultipartGroup.parentProgressUserData(
          parent.userData,
          parentUpdate.playbackPositionTicks,
          group.aggregateProgress(item, position),
          now: parentUpdate.lastPlayed,
        ),
        ref,
      );
    }
    return null;
  }

  SyncedItem? _syncedItemFor(String id) {
    if (syncedItem.id == id) return syncedItem;
    return syncedQueue.firstWhereOrNull((element) => element.id == id);
  }

  UserData? _userDataAfterPlayback(SyncedItem target, Duration position, Duration duration) {
    final progress = _progressFor(position, duration);
    final isPlayed = UserData.isPlayed(position, duration);
    return target.userData?.copyWith(
      playbackPositionTicks: isPlayed != false ? 0 : position.toRuntimeTicks,
      progress: isPlayed != false ? 0.0 : progress,
      played: isPlayed,
      lastPlayed: DateTime.now().toUtc(),
    );
  }

  Future<void> _persistUserData(SyncedItem target, UserData? userData, Ref ref) async {
    if (userData == null) return;
    await ref.read(syncProvider.notifier).updateItem(
          target.copyWith(userData: userData),
          upload: !ref.read(offlineStateProvider),
        );
  }

  Future<void> _completeGroup(MultipartGroup group, Ref ref) async {
    final now = DateTime.now().toUtc();
    final updates = <SyncedItem>[];

    final parent = _syncedItemFor(group.main.id);
    if (parent != null) {
      updates.add(parent.copyWith(
        userData: MultipartGroup.completedParentUserData(parent.userData, now: now),
        unSyncedData: true,
      ));
    }

    for (final part in group.additionalParts) {
      final synced = _syncedItemFor(part.id);
      if (synced == null) continue;
      final partData = synced.userData ?? const UserData();
      updates.add(synced.copyWith(
        userData: partData.copyWith(played: true, playbackPositionTicks: 0),
        unSyncedData: true,
      ));
    }

    if (updates.isEmpty) return;
    await ref.read(syncProvider.notifier).updateLocalItems(
          updates,
          upload: !ref.read(offlineStateProvider),
        );
  }

  double _progressFor(Duration position, Duration totalDuration) {
    if (totalDuration.inMilliseconds <= 0) return 0;
    final progress = position.inMilliseconds / totalDuration.inMilliseconds * 100;
    return progress.clamp(0.0, 100.0).toDouble();
  }

  @override
  OfflinePlaybackModel? updateUserData(UserData userData) {
    return copyWith(
      item: item.copyWith(
        userData: userData,
      ),
    );
  }

  @override
  OfflinePlaybackModel updatePlaybackQueue(PlaybackQueueState newQueue) {
    return copyWith(playbackQueue: newQueue);
  }

  @override
  String toString() => 'OfflinePlaybackModel(item: $item, syncedItem: $syncedItem)';

  @override
  OfflinePlaybackModel copyWith({
    ItemBaseModel? item,
    ValueGetter<Media?>? media,
    SyncedItem? syncedItem,
    ValueGetter<MediaStreamsModel?>? mediaStreams,
    ValueGetter<MediaSegmentsModel?>? mediaSegments,
    ValueGetter<TrickPlayModel?>? trickPlay,
    List<ItemBaseModel>? queue,
    PlaybackQueueState? playbackQueue,
    PlaybackQueueSource? queueSource,
    List<SyncedItem>? syncedQueue,
  }) {
    return OfflinePlaybackModel(
      item: item ?? this.item,
      media: media != null ? media() : this.media,
      syncedItem: syncedItem ?? this.syncedItem,
      mediaStreams: mediaStreams != null ? mediaStreams() : this.mediaStreams,
      mediaSegments: mediaSegments != null ? mediaSegments() : this.mediaSegments,
      trickPlay: trickPlay != null ? trickPlay() : this.trickPlay,
      queue: queue ?? this.queue,
      playbackQueue: playbackQueue ?? this.playbackQueue,
      queueSource: queueSource ?? this.queueSource,
      syncedQueue: syncedQueue ?? this.syncedQueue,
    );
  }
}
