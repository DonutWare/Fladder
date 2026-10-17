import 'dart:developer';

import 'package:flutter/material.dart' hide ConnectionState;

import 'package:background_downloader/background_downloader.dart';
import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/items/video_part_model.dart';
import 'package:fladder/models/playback/direct_playback_model.dart';
import 'package:fladder/models/playback/multipart_playback.dart';
import 'package:fladder/models/playback/offline_playback_model.dart';
import 'package:fladder/models/playback/playback_options_dialogue.dart';
import 'package:fladder/models/playback/playback_queue_source.dart';
import 'package:fladder/models/playback/playback_queue_state.dart';
import 'package:fladder/models/playback/transcode_playback_model.dart';
import 'package:fladder/models/playback/tv_playback_model.dart';
export 'playback_queue_source.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/profiles/default_profile.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/incognito_mode_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/util/streams_selection.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class Media {
  final String url;

  const Media({
    required this.url,
  });
}

extension PlaybackModelExtension on PlaybackModel? {
  SubStreamModel? get defaultSubStream {
    final streams = this?.subStreams;
    if (streams == null) return null;
    return streams.firstWhereOrNull((element) => element.index == this?.mediaStreams?.defaultSubStreamIndex) ??
        SubStreamModel.no();
  }

  AudioStreamModel? get defaultAudioStream {
    final streams = this?.audioStreams;
    if (streams == null) return null;
    return streams.firstWhereOrNull((element) => element.index == this?.mediaStreams?.defaultAudioStreamIndex) ??
        AudioStreamModel.no();
  }

  String? label(BuildContext context) => switch (this) {
        DirectPlaybackModel _ => PlaybackType.directStream.name(context),
        TranscodePlaybackModel _ => PlaybackType.transcode.name(context),
        OfflinePlaybackModel _ => PlaybackType.offline.name(context),
        TvPlaybackModel _ => PlaybackType.tv.name(context),
        _ => context.localized.unknown,
      };
}

class PlaybackModel {
  final ItemBaseModel item;
  final Media? media;
  final PlaybackQueueState playbackQueue;
  List<ItemBaseModel> get queue => playbackQueue.queue;
  List<ItemBaseModel> get nextUpQueue => playbackQueue.nextUpQueue;
  final PlaybackQueueSource? queueSource;
  final MediaSegmentsModel? mediaSegments;
  final PlaybackInfoResponse? playbackInfo;

  Map<Bitrate, bool> bitRateOptions;

  List<Chapter>? chapters = [];
  TrickPlayModel? trickPlay;

  Future<PlaybackModel?> updatePlaybackPosition(Duration position, bool isPlaying, Ref ref) =>
      throw UnimplementedError();
  Future<PlaybackModel?> playbackStarted(Duration position, Ref ref) => throw UnimplementedError();
  Future<PlaybackModel?> playbackStopped(Duration position, Duration? totalDuration, Ref ref) =>
      throw UnimplementedError();

  void dispose() {}

  final MediaStreamsModel? mediaStreams;
  List<SubStreamModel>? get subStreams => throw UnimplementedError();
  List<AudioStreamModel>? get audioStreams => throw UnimplementedError();

  bool get isAudioPlayback => item is AudioModel || item.type == FladderItemType.audio;

  Duration resolvedStopPosition(Duration position, Duration? totalDuration) {
    if (!isAudioPlayback) return position;
    return totalDuration ?? item.overview.runTime ?? position;
  }

  Future<Duration> resolvedStartPosition([Duration? requestedStartPosition]) async {
    if (isAudioPlayback) return Duration.zero;
    return requestedStartPosition ?? await startDuration() ?? Duration.zero;
  }

  Future<Duration>? startDuration() async => isAudioPlayback ? Duration.zero : item.userData.playBackPosition;

  MultipartGroup? get multipartGroup => MultipartGroup.fromQueue(queue, item);

  /// Writes the aggregated parent progress for the current part.
  ///
  /// Part 1 keeps its local position: Jellyfin's session progress call already
  /// stores it on the parent item.
  Future<void> updateMultipartProgress(Duration position, Ref ref) async {
    final group = multipartGroup;
    if (group == null) return;

    final update = group.progressUpdate(item, position);
    if (update == null) return;

    await _postMultipartUpdate(update, ref);
  }

  /// After the per-part session stop, writes the parent aggregate state and
  /// completes the logical item when the final part finished.
  Future<void> handleMultipartStopped(Duration stopPosition, Ref ref) async {
    final group = multipartGroup;
    if (group == null) return;

    final update = group.stopUpdate(item, stopPosition);
    if (update != null) {
      await _postMultipartUpdate(update, ref);
    }

    if (group.shouldMarkCompleted(item, stopPosition)) {
      await _completeMultipartGroup(group, ref);
    }
  }

  Future<void> _postMultipartUpdate(MultipartUserDataUpdate update, Ref ref) async {
    try {
      await ref.read(jellyApiProvider).updateItemUserData(
            itemId: update.itemId,
            playbackPositionTicks: update.playbackPositionTicks,
            played: update.played,
            lastPlayed: update.lastPlayed,
          );
    } catch (e, st) {
      log("Failed to update aggregate progress for ${update.itemId}: $e\n$st");
    }
  }

  Future<void> _completeMultipartGroup(MultipartGroup group, Ref ref) async {
    if (ref.read(incognitoProvider)) return;

    try {
      await ref.read(userProvider.notifier).markAsPlayed(true, group.main.id);
    } catch (e, st) {
      log("Failed to mark multipart parent ${group.main.id} as played: $e\n$st");
    }

    for (final part in group.additionalParts) {
      try {
        await ref.read(jellyApiProvider).updateItemUserData(
              itemId: part.id,
              playbackPositionTicks: 0,
              played: true,
            );
      } catch (e, st) {
        log("Failed to mark part ${part.id} as played: $e\n$st");
      }
    }
  }

  PlaybackModel? updateUserData(UserData userData) => throw UnimplementedError();

  Future<PlaybackModel>? setSubtitle(SubStreamModel? model, MediaControlsWrapper player) => throw UnimplementedError();
  Future<PlaybackModel>? setAudio(AudioStreamModel? model, MediaControlsWrapper player) => throw UnimplementedError();
  Future<PlaybackModel>? setQualityOption(Map<Bitrate, bool> map) => throw UnimplementedError();

  PlaybackModel updatePlaybackQueue(PlaybackQueueState newQueue) => throw UnimplementedError();

  ItemBaseModel? get nextVideo => playbackQueue.nextItem(item.id);
  ItemBaseModel? get previousVideo => playbackQueue.previousItem(item.id);

  PlaybackModel copyWith() => throw UnimplementedError();

  PlaybackModel({
    required this.playbackInfo,
    this.mediaStreams,
    required this.item,
    required this.media,
    List<ItemBaseModel> queue = const [],
    PlaybackQueueState? playbackQueue,
    this.queueSource,
    this.bitRateOptions = const {},
    this.mediaSegments,
    this.chapters,
    this.trickPlay,
  }) : playbackQueue = playbackQueue ??
            PlaybackQueueState.fromQueue(
              queue,
              initialItemId: item.id,
            );
}

final playbackModelHelper = Provider<PlaybackModelHelper>((ref) {
  return PlaybackModelHelper(ref: ref);
});

class PlaybackModelHelper {
  const PlaybackModelHelper({required this.ref});

  final Ref ref;

  JellyService get api => ref.read(jellyApiProvider);

  Future<PlaybackModel?> loadNewVideo(ItemBaseModel newItem) async {
    ref.read(videoPlayerProvider).pause();
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(buffering: true));
    final currentModel = ref.read(playBackModel);
    final newModel = (await createPlaybackModel(
          null,
          newItem,
          oldModel: currentModel,
        )) ??
        await _createOfflinePlaybackModel(
          newItem,
          null,
          await ref.read(syncProvider.notifier).getSyncedItem(newItem.id),
          oldModel: currentModel,
        );
    if (newModel == null) return null;
    final advancedQueue = currentModel?.playbackQueue.advanceFromCurrentTo(currentModel.item.id, newItem.id);
    final modelToLoad = advancedQueue != null ? newModel.updatePlaybackQueue(advancedQueue) : newModel;
    ref.read(videoPlayerProvider.notifier).loadPlaybackItem(modelToLoad, Duration.zero);
    return modelToLoad;
  }

  Future<void> loadTVChannel(ChannelModel? channel) async {
    if (channel == null) return;
    ref.read(videoPlayerProvider).pause();
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(buffering: true));
    final currentModel = ref.read(playBackModel);

    PlaybackModel? serverModel;
    try {
      serverModel = await createPlaybackModel(
        null,
        channel,
        forcedPlaybackType: PlaybackType.tv,
        oldModel: currentModel,
      ).timeout(const Duration(seconds: 8), onTimeout: () {
        return null;
      });
    } catch (e) {
      serverModel = null;
    }

    final newModel = serverModel ??
        await _createOfflinePlaybackModel(
          channel,
          null,
          await ref.read(syncProvider.notifier).getSyncedItem(channel.id),
          oldModel: currentModel,
        );

    if (newModel == null) return;
    ref.read(videoPlayerProvider.notifier).loadPlaybackItem(newModel, Duration.zero);
  }

  Future<OfflinePlaybackModel?> _createOfflinePlaybackModel(
    ItemBaseModel item,
    MediaStreamsModel? streamModel,
    SyncedItem? syncedItem, {
    PlaybackModel? oldModel,
    PlaybackQueueSource? queueSource,
    List<ItemBaseModel>? libraryQueue,
    List<SyncedItem>? syncedQueue,
  }) async {
    final ItemBaseModel? syncedItemModel = syncedItem?.itemModel;
    if (syncedItemModel == null || syncedItem == null || !await syncedItem.videoFile.exists()) return null;

    final syncNotifier = ref.read(syncProvider.notifier);
    final isAudio = syncedItemModel is AudioModel;

    final List<SyncedItem> effectiveSyncedQueue;
    if (syncedQueue != null) {
      effectiveSyncedQueue = syncedQueue;
    } else if (isAudio) {
      final children = await syncNotifier.getSiblings(syncedItem);
      effectiveSyncedQueue = children.where((element) => element.videoFile.existsSync()).toList();
    } else {
      effectiveSyncedQueue = await syncNotifier.getVideoPlaybackQueue(syncedItem);
    }

    final itemQueue = libraryQueue ?? effectiveSyncedQueue.map((element) => element.itemModel).nonNulls.toList();

    return OfflinePlaybackModel(
      item: syncedItemModel,
      syncedItem: syncedItem,
      trickPlay: syncedItem.trickPlayModel,
      mediaSegments: syncedItem.mediaSegments,
      media: Media(url: syncedItem.videoFile.path),
      queue: itemQueue,
      playbackQueue: oldModel?.playbackQueue,
      queueSource: queueSource ?? oldModel?.queueSource,
      syncedQueue: effectiveSyncedQueue,
      mediaStreams: streamModel ?? item.streamModel ?? syncedItemModel.streamModel,
    );
  }

  /// Inserts the additional parts of multi-part movies and episodes directly
  /// after their parent item, preserving the queue order.
  ///
  /// The method is idempotent: parents that already have parts in the queue are
  /// not fetched again, and existing item IDs are never inserted twice.
  Future<List<ItemBaseModel>> expandQueueWithParts(List<ItemBaseModel> queue) async {
    if (queue.isEmpty) return queue;

    final expandedParentIds = queue.whereType<VideoPartModel>().map((part) => part.parentItemId).toSet();

    final parentsToExpand = queue
        .whereType<ItemStreamModel>()
        .where((item) => item is! VideoPartModel)
        .where((item) => item.hasMultipleParts)
        .where((item) => !expandedParentIds.contains(item.id))
        .toList();

    if (parentsToExpand.isEmpty) return queue;

    final partsByParentId = <String, List<VideoPartModel>>{};
    await Future.wait(
      parentsToExpand.map((parent) async {
        final parts = await _fetchAdditionalParts(parent.id);
        if (parts.isNotEmpty) {
          partsByParentId[parent.id] = parts;
        }
      }),
    );

    if (partsByParentId.isEmpty) return queue;
    return interleaveParts(queue, partsByParentId);
  }

  /// Pure queue interleaving helper, exposed for tests.
  ///
  /// Parts are inserted after their parent and only when their ID is not already
  /// present in the queue. Re-running this on an expanded queue is a no-op.
  static List<ItemBaseModel> interleaveParts(
    List<ItemBaseModel> queue,
    Map<String, List<VideoPartModel>> partsByParentId,
  ) {
    final queueIds = queue.map((item) => item.id).toSet();

    // Parts that are already in the queue but appear after their parent are
    // re-inserted in the correct position instead of being duplicated.
    final relocatablePartIds = <String>{
      for (final entry in partsByParentId.entries)
        if (queueIds.contains(entry.key))
          for (final part in entry.value)
            if (queueIds.contains(part.id)) part.id,
    };

    final addedIds = <String>{};
    final result = <ItemBaseModel>[];

    for (final item in queue) {
      if (relocatablePartIds.contains(item.id)) continue;

      if (addedIds.add(item.id)) {
        result.add(item);
      }

      final parts = partsByParentId[item.id];
      if (parts == null) continue;

      for (final part in parts) {
        if (addedIds.add(part.id)) {
          result.add(part);
        }
      }
    }

    return result;
  }

  Future<List<VideoPartModel>> _fetchAdditionalParts(String itemId) async {
    try {
      final response = await api.getAdditionalParts(itemId: itemId);
      final items = response.body?.items ?? const [];
      if (items.isEmpty) return const [];

      return VideoPartModel.fromDtos(
        items,
        ref,
        parentItemId: itemId,
        totalParts: items.length + 1,
      );
    } catch (e) {
      log("Failed to load additional parts for $itemId: $e");
      return const [];
    }
  }

  /// Builds the queue around the logical parent of [part].
  ///
  /// Starting a specific part should still allow previous/next to move across
  /// the parent item and its siblings.
  Future<List<ItemBaseModel>> _buildQueueForPart(VideoPartModel part) async {
    try {
      final parentResponse = await api.usersUserIdItemsItemIdGet(itemId: part.parentItemId);
      final parent = parentResponse.body;
      if (parent == null) return [part];

      final parentQueue = await collectQueue(parent);
      return parentQueue.isNotEmpty ? parentQueue : [parent];
    } catch (e) {
      log("Failed to build the queue for part ${part.id}: $e");
      return [part];
    }
  }

  /// Builds the offline video queue for [item] from the sync database.
  ///
  /// Returns null for item types that do not use the video queue so the caller
  /// can fall back to the regular queue collection.
  Future<List<SyncedItem>?> _buildOfflineQueue(ItemBaseModel item) async {
    final syncNotifier = ref.read(syncProvider.notifier);

    SyncedItem? target;
    if (item is VideoPartModel) {
      target = await syncNotifier.getSyncedItem(item.id) ?? await syncNotifier.getSyncedItem(item.parentItemId);
    } else if (item is MovieModel || item is EpisodeModel) {
      target = await syncNotifier.getSyncedItem(item.id);
    } else if (item is SeriesModel || item is SeasonModel) {
      final episodes = (await collectQueue(item)).whereType<EpisodeModel>().toList();
      final nextUp = episodes.nextUp;
      if (nextUp != null) {
        target = await syncNotifier.getSyncedItem(nextUp.id);
      }
    }

    if (target == null) return null;
    return syncNotifier.getVideoPlaybackQueue(target);
  }

  /// Clears the aggregate and per-part progress before a rewatch.
  Future<void> _resetMultipartGroup(MultipartGroup group) async {
    if (ref.read(incognitoProvider)) return;

    if (ref.read(offlineStateProvider)) {
      await ref.read(syncProvider.notifier).resetMultipartProgress([
        group.main.id,
        ...group.additionalParts.map((part) => part.id),
      ]);
      return;
    }

    for (final update in group.resetUpdates()) {
      try {
        await ref.read(jellyApiProvider).updateItemUserData(
              itemId: update.itemId,
              playbackPositionTicks: update.playbackPositionTicks,
              played: update.played,
            );
      } catch (e, st) {
        log("Failed to reset multipart item ${update.itemId}: $e\n$st");
      }
    }
  }

  Future<PlaybackModel?> createPlaybackModel(
    BuildContext? context,
    ItemBaseModel? item, {
    PlaybackModel? oldModel,
    List<ItemBaseModel>? libraryQueue,
    PlaybackQueueSource? queueSource,
    bool showPlaybackOptions = false,
    PlaybackType? forcedPlaybackType,
    Duration? startPosition,
    bool restart = false,
  }) async {
    try {
      if (item == null) return null;
      final userId = ref.read(userProvider)?.id;
      if (userId?.isEmpty == true) return null;

      final isOffline = ref.read(offlineStateProvider);

      List<ItemBaseModel> queue;
      List<SyncedItem>? offlineQueue;
      if (oldModel != null) {
        queue = oldModel.queue;
      } else if (libraryQueue != null) {
        queue = libraryQueue;
      } else if (isOffline) {
        offlineQueue = await _buildOfflineQueue(item);
        queue = offlineQueue?.map((element) => element.itemModel).nonNulls.toList() ?? [];
      } else if (item is VideoPartModel) {
        queue = await _buildQueueForPart(item);
      } else {
        queue = await collectQueue(item);
      }

      // Movies have no collected queue; seed it so their parts can be expanded
      // and next/previous keep working. Episodes fall back to themselves when
      // their series queue could not be loaded.
      if (queue.isEmpty && (item is MovieModel || item is EpisodeModel)) {
        queue = [item];
      }

      if (!isOffline) {
        queue = await expandQueueWithParts(queue);
      }

      // The requested part must stay playable even when the server does not
      // return it as part of the logical parent's queue.
      if (item is VideoPartModel && !queue.any((queueItem) => queueItem.id == item.id)) {
        queue = [...queue, item];
      }

      final effectiveQueueSource = oldModel?.queueSource ?? queueSource;

      final firstItemToPlay = switch (item) {
        SeriesModel _ || SeasonModel _ => (queue.whereType<EpisodeModel>().toList().nextUp),
        _ => item,
      };

      if (firstItemToPlay == null) return null;

      var resolvedItem = firstItemToPlay;
      Duration? resolvedStartPosition = startPosition;
      MultipartGroup? multipartGroup;
      var resetMultipartGroup = false;

      // Part-aware resume selection (plan §4.5). An explicit start position or
      // an explicitly selected part bypasses auto-selection.
      if (!restart && !MultipartGroup.bypassesAutoResume(firstItemToPlay, startPosition)) {
        final isMovieOrEpisode = firstItemToPlay is MovieModel || firstItemToPlay is EpisodeModel;
        final streamItem = isMovieOrEpisode ? firstItemToPlay as ItemStreamModel : null;
        if (streamItem != null) {
          final group = MultipartGroup.fromQueue(queue, streamItem);
          if (group != null) {
            multipartGroup = group;
            final decision = group.resumeDecision();
            resolvedItem = decision.item;
            resolvedStartPosition = decision.startPosition;
            resetMultipartGroup = decision.resetGroup;
          } else if (streamItem.hasMultipleParts) {
            // The parts could not be loaded; do not trust a potentially
            // scaled parent position.
            resolvedStartPosition = Duration.zero;
          }
        }
      }

      if (restart) {
        final group = multipartGroup ?? MultipartGroup.fromQueue(queue, firstItemToPlay);
        if (group != null) {
          multipartGroup = group;
          resetMultipartGroup = true;
        }
        resolvedStartPosition = Duration.zero;
      }

      if (resetMultipartGroup && multipartGroup != null) {
        await _resetMultipartGroup(multipartGroup);
      }

      // Additional parts are already fully populated by the AdditionalParts
      // response. Refetching them would map the `video` item through
      // `ItemBaseModel.fromBaseDto`, turning it into a PhotoModel.
      final ItemBaseModel playableItem;
      if (resolvedItem is VideoPartModel) {
        playableItem = resolvedItem;
      } else {
        final fullItemResponse = await api.usersUserIdItemsItemIdGet(itemId: resolvedItem.id);
        final fullItem = fullItemResponse.body;
        if (fullItem == null) {
          return null;
        }
        playableItem = fullItem;
      }

      SyncedItem? syncedItem = await ref.read(syncProvider.notifier).getSyncedItem(playableItem.id);

      final firstItemIsSynced = syncedItem != null && syncedItem.status == TaskStatus.complete;

      final actualStartPosition = resolvedStartPosition ?? playableItem.userData.playBackPosition;

      final options = {
        PlaybackType.directStream,
        PlaybackType.transcode,
        if (firstItemIsSynced) PlaybackType.offline,
      };

      // Explicit stream selections made on the details screen belong to the
      // requested item. When resume selection redirects to a different part or
      // episode, use that item's own streams instead of the original item's
      // Part 1 streams.
      final selectedStreamModel = resolvedItem.id == item.id ? item.streamModel : playableItem.streamModel;

      if (firstItemToPlay is AudioModel && firstItemIsSynced) {
        final offlinePlayback = await _createOfflinePlaybackModel(
          playableItem,
          selectedStreamModel,
          syncedItem,
          oldModel: oldModel,
          queueSource: effectiveQueueSource,
        );

        if (offlinePlayback != null) {
          return offlinePlayback;
        }
      }

      Future<PlaybackModel?> getOfflineModel() => _createOfflinePlaybackModel(
            playableItem,
            selectedStreamModel,
            syncedItem,
            oldModel: oldModel,
            queueSource: effectiveQueueSource,
            libraryQueue: offlineQueue?.map((element) => element.itemModel).nonNulls.toList(),
            syncedQueue: offlineQueue,
          );

      Future<PlaybackModel?> getServerModel(PlaybackType type) => _createServerPlaybackModel(
            playableItem,
            selectedStreamModel,
            forcedPlaybackType ?? type,
            oldModel: oldModel,
            libraryQueue: queue,
            queueSource: effectiveQueueSource,
            startPosition: actualStartPosition,
          );

      if (((showPlaybackOptions || firstItemIsSynced) && !isOffline) && context != null) {
        final playbackType = await showPlaybackTypeSelection(
          context: context,
          options: options,
        );

        if (!context.mounted) return null;

        return switch (playbackType) {
          PlaybackType.directStream || PlaybackType.transcode || PlaybackType.tv => await getServerModel(playbackType!),
          PlaybackType.offline => await getOfflineModel(),
          null => null,
        };
      }

      if (isOffline) {
        return await getOfflineModel();
      }

      return await getServerModel(PlaybackType.directStream) ?? await getOfflineModel();
    } catch (e) {
      log("Error creating playback model: ${e.toString()}");
      return null;
    }
  }

  Future<PlaybackModel?> _createServerPlaybackModel(
    ItemBaseModel item,
    MediaStreamsModel? streamModel,
    PlaybackType? type, {
    PlaybackModel? oldModel,
    required List<ItemBaseModel> libraryQueue,
    PlaybackQueueSource? queueSource,
    Duration? startPosition,
  }) async {
    try {
      final userId = ref.read(userProvider)?.id;
      if (userId?.isEmpty == true) return null;

      final newStreamModel = streamModel ?? item.streamModel;
      final videoPlayerSettings = ref.read(videoPlayerSettingsProvider);
      final maxBitRate = selectPlaybackBitrate(
        homeInternet: ref.read(connectivityStatusProvider).homeInternet,
        maxHomeBitrate: videoPlayerSettings.maxHomeBitrate,
        maxInternetBitrate: videoPlayerSettings.maxInternetBitrate,
      );

      Map<Bitrate, bool> qualityOptions = getVideoQualityOptions(
        VideoQualitySettings(
          maxBitRate: maxBitRate,
          videoBitRate: newStreamModel?.videoStreams.firstOrNull?.bitRate ?? 0,
          videoCodec: newStreamModel?.videoStreams.firstOrNull?.codec,
        ),
      );

      final audioStreamIndex = selectAudioStream(
          ref.read(userProvider.select((value) => value?.userConfiguration?.rememberAudioSelections ?? true)),
          oldModel?.mediaStreams?.currentAudioStream,
          newStreamModel?.audioStreams,
          newStreamModel?.defaultAudioStreamIndex);

      final subStreamIndex = selectSubStream(
          ref.read(userProvider.select((value) => value?.userConfiguration?.rememberSubtitleSelections ?? true)),
          oldModel?.mediaStreams?.currentSubStream,
          newStreamModel?.subStreams,
          newStreamModel?.defaultSubStreamIndex);

//Native player does not allow for loading external subtitles with transcoding
      final isNativePlayer =
          ref.read(videoPlayerSettingsProvider.select((value) => value.wantedPlayer == PlayerOptions.nativePlayer));
      final isExternalSub = newStreamModel?.currentSubStream?.isExternal == true;

      final Response<PlaybackInfoResponse> response = await api.itemsItemIdPlaybackInfoPost(
        itemId: item.id,
        body: PlaybackInfoDto(
          startTimeTicks: startPosition?.toRuntimeTicks,
          audioStreamIndex: audioStreamIndex,
          subtitleStreamIndex: subStreamIndex,
          enableTranscoding: true,
          autoOpenLiveStream: true,
          deviceProfile: type != PlaybackType.tv ? ref.read(videoProfileProvider) : null,
          userId: userId,
          enableDirectPlay: type != PlaybackType.transcode,
          enableDirectStream: type != PlaybackType.transcode,
          alwaysBurnInSubtitleWhenTranscoding: isNativePlayer && isExternalSub,
          maxStreamingBitrate: qualityOptions.enabledFirst.keys.firstOrNull?.bitRate,
          mediaSourceId: newStreamModel?.currentVersionStream?.id,
        ),
      );

      PlaybackInfoResponse? playbackInfo = response.body;

      if (playbackInfo == null) {
        return null;
      }

      final mediaSource = playbackInfo.mediaSources?[newStreamModel?.versionStreamIndex ?? 0];

      if (mediaSource == null) {
        return null;
      }

      final mediaStreamsWithUrls = MediaStreamsModel.fromMediaStreamsList(playbackInfo.mediaSources, ref).copyWith(
        defaultAudioStreamIndex: audioStreamIndex,
        defaultSubStreamIndex: subStreamIndex,
      );

      final mediaSegments = await api.mediaSegmentsGet(id: item.id);

      final trickPlayResp = await api.getTrickPlay(item: item, ref: ref);

      final trickPlay = trickPlayResp?.body;
      final chapters = item.overview.chapters ?? [];

      final mediaPath = isValidVideoUrl(mediaSource.path ?? "");

      if (type == PlaybackType.tv && mediaPath != null) {
        final tvModel = TvPlaybackModel(
          channel: item as ChannelModel,
          isNativePlayerBackend: isNativePlayer,
          item: item,
          queue: libraryQueue,
          playbackQueue: oldModel?.playbackQueue,
          queueSource: queueSource,
          playbackInfo: playbackInfo,
          media: Media(url: mediaPath),
        );
        return tvModel;
      }

      if ((mediaSource.supportsDirectStream ?? false) || (mediaSource.supportsDirectPlay ?? false)) {
        final Map<String, String?> directOptions = {
          'Static': 'true',
          'mediaSourceId': mediaSource.id,
          'ApiKey': ref.read(userProvider)?.credentials.token,
        };

        if (mediaSource.eTag != null) {
          directOptions['Tag'] = mediaSource.eTag;
        }

        if (mediaSource.liveStreamId != null) {
          directOptions['LiveStreamId'] = mediaSource.liveStreamId;
        }

        final playbackUrl = buildServerUrl(
          ref,
          pathSegments: ['Videos', mediaSource.id!, 'stream'],
          queryParameters: directOptions,
        );

        return DirectPlaybackModel(
          item: item,
          queue: libraryQueue,
          playbackQueue: oldModel?.playbackQueue,
          queueSource: queueSource,
          mediaSegments: mediaSegments?.body,
          chapters: chapters,
          playbackInfo: playbackInfo,
          trickPlay: trickPlay,
          media: Media(url: mediaPath ?? playbackUrl),
          mediaStreams: mediaStreamsWithUrls,
          bitRateOptions: qualityOptions,
        );
      } else if ((mediaSource.supportsTranscoding ?? false) && mediaSource.transcodingUrl != null) {
        return TranscodePlaybackModel(
          item: item,
          queue: libraryQueue,
          playbackQueue: oldModel?.playbackQueue,
          queueSource: queueSource,
          mediaSegments: mediaSegments?.body,
          chapters: chapters,
          trickPlay: trickPlay,
          playbackInfo: playbackInfo,
          media: Media(url: buildServerUrl(ref, relativeUrl: mediaSource.transcodingUrl)),
          mediaStreams: mediaStreamsWithUrls,
          bitRateOptions: qualityOptions,
        );
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  String? isValidVideoUrl(String path) {
    Uri? uri = Uri.tryParse(path);
    return (uri != null && uri.hasScheme && uri.hasAuthority) ? path : null;
  }

  Future<List<ItemBaseModel>> collectQueue(ItemBaseModel model) async {
    switch (model) {
      case EpisodeModel _:
      case SeriesModel _:
      case SeasonModel _:
        List<EpisodeModel> episodeList = ((await fetchEpisodesFromSeries(model.streamId)).body ?? [])
          ..removeWhere((element) => element.status != EpisodeStatus.available);
        return episodeList;
      default:
        return [];
    }
  }

  Future<Response<List<EpisodeModel>>> fetchEpisodesFromSeries(String seriesId) async {
    final response = await api.showsSeriesIdEpisodesGet(
      seriesId: seriesId,
      fields: [
        ItemFields.overview,
        ItemFields.originaltitle,
        ItemFields.mediastreams,
        ItemFields.mediasources,
        ItemFields.mediasourcecount,
        ItemFields.width,
        ItemFields.height,
      ],
    );
    return Response(response.base, (response.body?.items?.map((e) => EpisodeModel.fromBaseDto(e, ref)).toList() ?? []));
  }

  Future<void> shouldReload(PlaybackModel playbackModel) async {
    if (playbackModel is OfflinePlaybackModel) {
      return;
    }

    final item = playbackModel.item;

    final userId = ref.read(userProvider)?.id;
    if (userId?.isEmpty == true) return;

    final currentPosition = ref.read(mediaPlaybackProvider.select((value) => value.position));

    final audioIndex = selectAudioStream(
        ref.read(userProvider.select((value) => value?.userConfiguration?.rememberAudioSelections ?? true)),
        playbackModel.mediaStreams?.currentAudioStream,
        playbackModel.audioStreams,
        playbackModel.mediaStreams?.defaultAudioStreamIndex);
    final subIndex = selectSubStream(
        ref.read(userProvider.select((value) => value?.userConfiguration?.rememberSubtitleSelections ?? true)),
        playbackModel.mediaStreams?.currentSubStream,
        playbackModel.subStreams,
        playbackModel.mediaStreams?.defaultSubStreamIndex);

    Response<PlaybackInfoResponse> response = await api.itemsItemIdPlaybackInfoPost(
      itemId: item.id,
      body: PlaybackInfoDto(
        startTimeTicks: currentPosition.toRuntimeTicks,
        audioStreamIndex: audioIndex,
        enableDirectPlay: true,
        enableDirectStream: true,
        subtitleStreamIndex: subIndex,
        enableTranscoding: true,
        autoOpenLiveStream: true,
        deviceProfile: ref.read(videoProfileProvider),
        userId: userId,
        maxStreamingBitrate: playbackModel.bitRateOptions.enabledFirst.entries.firstOrNull?.key.bitRate,
        mediaSourceId: playbackModel.mediaStreams?.currentVersionStream?.id,
      ),
    );

    PlaybackInfoResponse playbackInfo = response.bodyOrThrow;

    final mediaSource = playbackInfo.mediaSources?.first;

    final mediaStreamsWithUrls = MediaStreamsModel.fromMediaStreamsList(playbackInfo.mediaSources, ref).copyWith(
      defaultAudioStreamIndex: audioIndex,
      defaultSubStreamIndex: subIndex,
    );

    if (mediaSource == null) return;

    PlaybackModel? newModel;

    if ((mediaSource.supportsDirectStream ?? false) || (mediaSource.supportsDirectPlay ?? false)) {
      final Map<String, String?> directOptions = {
        'Static': 'true',
        'mediaSourceId': mediaSource.id,
        'ApiKey': ref.read(userProvider)?.credentials.token,
      };

      if (mediaSource.eTag != null) {
        directOptions['Tag'] = mediaSource.eTag;
      }

      if (mediaSource.liveStreamId != null) {
        directOptions['LiveStreamId'] = mediaSource.liveStreamId;
      }

      final directPlay = buildServerUrl(
        ref,
        pathSegments: ['Videos', mediaSource.id ?? '', 'stream'],
        queryParameters: directOptions,
      );

      final mediaPath = isValidVideoUrl(mediaSource.path ?? "");

      newModel = DirectPlaybackModel(
        item: playbackModel.item,
        queue: playbackModel.queue,
        playbackQueue: playbackModel.playbackQueue,
        mediaSegments: playbackModel.mediaSegments,
        chapters: playbackModel.chapters,
        playbackInfo: playbackInfo,
        trickPlay: playbackModel.trickPlay,
        media: Media(url: mediaPath ?? directPlay),
        mediaStreams: mediaStreamsWithUrls,
        bitRateOptions: playbackModel.bitRateOptions,
      );
    } else if ((mediaSource.supportsTranscoding ?? false) && mediaSource.transcodingUrl != null) {
      newModel = TranscodePlaybackModel(
        item: playbackModel.item,
        queue: playbackModel.queue,
        playbackQueue: playbackModel.playbackQueue,
        mediaSegments: playbackModel.mediaSegments,
        chapters: playbackModel.chapters,
        playbackInfo: playbackInfo,
        trickPlay: playbackModel.trickPlay,
        media: Media(url: buildServerUrl(ref, relativeUrl: mediaSource.transcodingUrl)),
        mediaStreams: mediaStreamsWithUrls,
        bitRateOptions: playbackModel.bitRateOptions,
      );
    }
    if (newModel == null) return;
    if (newModel.runtimeType != playbackModel.runtimeType || newModel is TranscodePlaybackModel) {
      ref.read(videoPlayerProvider.notifier).loadPlaybackItem(newModel, currentPosition);
    }
  }
}
