import 'dart:developer';

import 'package:background_downloader/background_downloader.dart';
import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/playback/direct_playback_model.dart';
import 'package:fladder/models/playback/offline_playback_model.dart';
import 'package:fladder/models/playback/playback_options_dialogue.dart';
import 'package:fladder/models/playback/transcode_playback_model.dart';
import 'package:fladder/models/playback/tv_playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/profiles/default_profile.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/util/streams_selection.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Media {
  final String url;

  const Media({
    required this.url,
  });
}

extension PlaybackModelExtension on PlaybackModel? {
  SubStreamModel? get defaultSubStream => this?.subStreams?.firstWhereOrNull(
      (element) => element.index == this?.mediaStreams?.defaultSubStreamIndex);

  AudioStreamModel? get defaultAudioStream =>
      this?.audioStreams?.firstWhereOrNull((element) =>
          element.index == this?.mediaStreams?.defaultAudioStreamIndex);

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
  final List<ItemBaseModel> queue;
  final MediaSegmentsModel? mediaSegments;
  final PlaybackInfoResponse? playbackInfo;

  Map<Bitrate, bool> bitRateOptions;

  List<Chapter>? chapters = [];
  TrickPlayModel? trickPlay;

  Future<PlaybackModel?> updatePlaybackPosition(
          Duration position, bool isPlaying, Ref ref) =>
      throw UnimplementedError();
  Future<PlaybackModel?> playbackStarted(Duration position, Ref ref) =>
      throw UnimplementedError();
  Future<PlaybackModel?> playbackStopped(
          Duration position, Duration? totalDuration, Ref ref) =>
      throw UnimplementedError();

  final MediaStreamsModel? mediaStreams;
  List<SubStreamModel>? get subStreams => throw UnimplementedError();
  List<AudioStreamModel>? get audioStreams => throw UnimplementedError();

  Future<Duration>? startDuration() async => item.userData.playBackPosition;

  PlaybackModel? updateUserData(UserData userData) =>
      throw UnimplementedError();

  Future<PlaybackModel>? setSubtitle(
          SubStreamModel? model, MediaControlsWrapper player) =>
      throw UnimplementedError();
  Future<PlaybackModel>? setAudio(
          AudioStreamModel? model, MediaControlsWrapper player) =>
      throw UnimplementedError();
  Future<PlaybackModel>? setQualityOption(Map<Bitrate, bool> map) =>
      throw UnimplementedError();

  ItemBaseModel? get nextVideo => queue.nextOrNull(item);
  ItemBaseModel? get previousVideo => queue.previousOrNull(item);

  PlaybackModel copyWith() => throw UnimplementedError();

  PlaybackModel({
    required this.playbackInfo,
    this.mediaStreams,
    required this.item,
    required this.media,
    this.queue = const [],
    this.bitRateOptions = const {},
    this.mediaSegments,
    this.chapters,
    this.trickPlay,
  });
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
    ref
        .read(mediaPlaybackProvider.notifier)
        .update((state) => state.copyWith(buffering: true));
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
    ref
        .read(videoPlayerProvider.notifier)
        .loadPlaybackItem(newModel, Duration.zero);
    return newModel;
  }

  Future<void> loadTVChannel(ChannelModel? channel) async {
    if (channel == null) return;
    ref.read(videoPlayerProvider).pause();
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(buffering: true));
    final currentModel = ref.read(playBackModel);
    final newModel = (await createPlaybackModel(
          null,
          channel,
          forcedPlaybackType: PlaybackType.tv,
          oldModel: currentModel,
        )) ??
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
  }) async {
    final ItemBaseModel? syncedItemModel = syncedItem?.itemModel;
    if (syncedItemModel == null ||
        syncedItem == null ||
        !await syncedItem.videoFile.exists()) return null;

    final children =
        await ref.read(syncProvider.notifier).getSiblings(syncedItem);
    final syncedItems = children
        .where((element) =>
            element.videoFile.existsSync() && element.id != syncedItem.id)
        .toList();
    final itemQueue = syncedItems.map((e) => e.itemModel).nonNulls;

    return OfflinePlaybackModel(
      item: syncedItemModel,
      syncedItem: syncedItem,
      trickPlay: syncedItem.trickPlayModel,
      mediaSegments: syncedItem.mediaSegments,
      media: Media(url: syncedItem.videoFile.path),
      queue: itemQueue.nonNulls.toList(),
      syncedQueue: children,
      mediaStreams: item.streamModel ?? syncedItemModel.streamModel,
    );
  }

  Future<PlaybackModel?> createPlaybackModel(
    BuildContext? context,
    ItemBaseModel? item, {
    PlaybackModel? oldModel,
    List<ItemBaseModel>? libraryQueue,
    bool showPlaybackOptions = false,
    PlaybackType? forcedPlaybackType,
    Duration? startPosition,
  }) async {
    try {
      if (item == null) return null;
      final userId = ref.read(userProvider)?.id;
      if (userId?.isEmpty == true) return null;

      final queue = oldModel?.queue ?? libraryQueue ?? await collectQueue(item);

      final firstItemToPlay = switch (item) {
        SeriesModel _ ||
        SeasonModel _ =>
          (queue.whereType<EpisodeModel>().toList().nextUp),
        _ => item,
      };

      if (firstItemToPlay == null) return null;

      final fullItem =
          (await api.usersUserIdItemsItemIdGet(itemId: firstItemToPlay.id))
              .body;

      if (fullItem == null) return null;

      SyncedItem? syncedItem =
          await ref.read(syncProvider.notifier).getSyncedItem(fullItem.id);

      final firstItemIsSynced =
          syncedItem != null && syncedItem.status == TaskStatus.complete;

      final options = {
        PlaybackType.directStream,
        PlaybackType.transcode,
        if (firstItemIsSynced) PlaybackType.offline,
      };

      final isOffline = ref.read(connectivityStatusProvider
          .select((value) => value == ConnectionState.offline));

      if (((showPlaybackOptions || firstItemIsSynced) && !isOffline) &&
          context != null) {
        final playbackType = await showPlaybackTypeSelection(
          context: context,
          options: options,
        );

        if (!context.mounted) return null;

        return switch (playbackType) {
          PlaybackType.directStream ||
          PlaybackType.transcode || PlaybackType.tv =>
            await _createServerPlaybackModel(
              fullItem,
              item.streamModel,
              forcedPlaybackType ?? playbackType,
              oldModel: oldModel,
              libraryQueue: queue,
              startPosition: startPosition,
            ),
          PlaybackType.offline => await _createOfflinePlaybackModel(
              fullItem,
              item.streamModel,
              syncedItem,
            ),
          null => null
        };
      } else {
        return (await _createServerPlaybackModel(
              fullItem,
              item.streamModel,
              forcedPlaybackType ?? PlaybackType.directStream,
              startPosition: startPosition,
              oldModel: oldModel,
              libraryQueue: queue,
            )) ??
            await _createOfflinePlaybackModel(
              fullItem,
              item.streamModel,
              syncedItem,
            );
      }
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
    Duration? startPosition,
  }) async {
    try {
      final userId = ref.read(userProvider)?.id;
      if (userId?.isEmpty == true) return null;

      final newStreamModel = streamModel ?? item.streamModel;

      Map<Bitrate, bool> qualityOptions = getVideoQualityOptions(
        VideoQualitySettings(
          maxBitRate: ref.read(videoPlayerSettingsProvider
              .select((value) => value.maxHomeBitrate)),
          videoBitRate: newStreamModel?.videoStreams.firstOrNull?.bitRate ?? 0,
          videoCodec: newStreamModel?.videoStreams.firstOrNull?.codec,
        ),
      );

      final audioStreamIndex = selectAudioStream(
          ref.read(userProvider.select((value) =>
              value?.userConfiguration?.rememberAudioSelections ?? true)),
          oldModel?.mediaStreams?.currentAudioStream,
          newStreamModel?.audioStreams,
          newStreamModel?.defaultAudioStreamIndex);

      final subStreamIndex = selectSubStream(
          ref.read(userProvider.select((value) =>
              value?.userConfiguration?.rememberSubtitleSelections ?? true)),
          oldModel?.mediaStreams?.currentSubStream,
          newStreamModel?.subStreams,
          newStreamModel?.defaultSubStreamIndex);

      //Native player does not allow for loading external subtitles with transcoding
      final isNativePlayer = ref.read(videoPlayerSettingsProvider
          .select((value) => value.wantedPlayer == PlayerOptions.nativePlayer));
      final isExternalSub =
          newStreamModel?.currentSubStream?.isExternal == true;

      final Response<PlaybackInfoResponse> response =
          await api.itemsItemIdPlaybackInfoPost(
        itemId: item.id,
        body: PlaybackInfoDto(
          startTimeTicks: startPosition?.toRuntimeTicks,
          audioStreamIndex: audioStreamIndex,
          subtitleStreamIndex: subStreamIndex,
          enableTranscoding: true,
          autoOpenLiveStream: true,
          deviceProfile: ref.read(videoProfileProvider),
          userId: userId,
          enableDirectPlay: type != PlaybackType.transcode,
          enableDirectStream: type != PlaybackType.transcode,
          alwaysBurnInSubtitleWhenTranscoding: isNativePlayer && isExternalSub,
          maxStreamingBitrate:
              qualityOptions.enabledFirst.keys.firstOrNull?.bitRate,
          mediaSourceId: newStreamModel?.currentVersionStream?.id,
        ),
      );

      PlaybackInfoResponse? playbackInfo = response.body;

      if (playbackInfo == null) return null;

      final mediaSource =
          playbackInfo.mediaSources?[newStreamModel?.versionStreamIndex ?? 0];

      if (mediaSource == null) return null;

      final mediaStreamsWithUrls =
          MediaStreamsModel.fromMediaStreamsList(playbackInfo.mediaSources, ref)
              .copyWith(
        defaultAudioStreamIndex: audioStreamIndex,
        defaultSubStreamIndex: subStreamIndex,
      );

      final mediaSegments = await api.mediaSegmentsGet(id: item.id);
      final trickPlay = (await api.getTrickPlay(item: item, ref: ref))?.body;
      final chapters = item.overview.chapters ?? [];

      final mediaPath = isValidVideoUrl(mediaSource.path ?? "");

      if ((mediaSource.supportsDirectStream ?? false) ||
          (mediaSource.supportsDirectPlay ?? false)) {
        final Map<String, String?> directOptions = {
          'Static': 'true',
          'mediaSourceId': mediaSource.id,
          'api_key': ref.read(userProvider)?.credentials.token,
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

        if (type == PlaybackType.tv) {
          final tvModel = TvPlaybackModel(
            channel: item as ChannelModel,
            item: item,
            queue: libraryQueue,
            playbackInfo: playbackInfo,
            media: Media(url: mediaPath ?? playbackUrl),
          );
          tvModel.startTracking(ref);
          return tvModel;
        } else {
          return DirectPlaybackModel(
            item: item,
            queue: libraryQueue,
            mediaSegments: mediaSegments?.body,
            chapters: chapters,
            playbackInfo: playbackInfo,
            trickPlay: trickPlay,
            media: Media(url: mediaPath ?? playbackUrl),
            mediaStreams: mediaStreamsWithUrls,
            bitRateOptions: qualityOptions,
          );
        }
      } else if ((mediaSource.supportsTranscoding ?? false) &&
          mediaSource.transcodingUrl != null) {
        return TranscodePlaybackModel(
          item: item,
          queue: libraryQueue,
          mediaSegments: mediaSegments?.body,
          chapters: chapters,
          trickPlay: trickPlay,
          playbackInfo: playbackInfo,
          media: Media(
              url:
                  buildServerUrl(ref, relativeUrl: mediaSource.transcodingUrl)),
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
        List<EpisodeModel> episodeList =
            ((await fetchEpisodesFromSeries(model.streamId)).body ?? [])
              ..removeWhere(
                  (element) => element.status != EpisodeStatus.available);
        return episodeList;
      default:
        return [];
    }
  }

  Future<Response<List<EpisodeModel>>> fetchEpisodesFromSeries(
      String seriesId) async {
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
    return Response(
        response.base,
        (response.body?.items
                ?.map((e) => EpisodeModel.fromBaseDto(e, ref))
                .toList() ??
            []));
  }

  Future<void> shouldReload(PlaybackModel playbackModel) async {
    if (playbackModel is OfflinePlaybackModel) {
      return;
    }

    final item = playbackModel.item;

    final userId = ref.read(userProvider)?.id;
    if (userId?.isEmpty == true) return;

    // Check if syncplay is active and get position from syncplay if so
    final isSyncPlayActive = ref.read(isSyncPlayActiveProvider);
    final Duration currentPosition;

    if (isSyncPlayActive) {
      // Set reloading state in the player notifier to prevent premature ready reporting
      ref.read(videoPlayerProvider.notifier).setReloading(true);

      // Get syncplay position FIRST before any state changes
      final syncPlayState = ref.read(syncPlayProvider);
      final positionTicks = syncPlayState.positionTicks;
      // Convert ticks to Duration: 1 tick = 100 nanoseconds, 10000 ticks = 1 millisecond
      currentPosition =
          Duration(milliseconds: ticksToMilliseconds(positionTicks));

      // Report buffering to syncplay BEFORE stopping/reloading to pause other group members
      await ref.read(syncPlayProvider.notifier).reportBuffering();
    } else {
      currentPosition =
          ref.read(mediaPlaybackProvider.select((value) => value.position));
    }

    final audioIndex = selectAudioStream(
        ref.read(userProvider.select((value) =>
            value?.userConfiguration?.rememberAudioSelections ?? true)),
        playbackModel.mediaStreams?.currentAudioStream,
        playbackModel.audioStreams,
        playbackModel.mediaStreams?.defaultAudioStreamIndex);
    final subIndex = selectSubStream(
        ref.read(userProvider.select((value) =>
            value?.userConfiguration?.rememberSubtitleSelections ?? true)),
        playbackModel.mediaStreams?.currentSubStream,
        playbackModel.subStreams,
        playbackModel.mediaStreams?.defaultSubStreamIndex);

    Response<PlaybackInfoResponse> response =
        await api.itemsItemIdPlaybackInfoPost(
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
        maxStreamingBitrate: playbackModel
            .bitRateOptions.enabledFirst.entries.firstOrNull?.key.bitRate,
        mediaSourceId: playbackModel.mediaStreams?.currentVersionStream?.id,
      ),
    );

    PlaybackInfoResponse playbackInfo = response.bodyOrThrow;

    final mediaSource = playbackInfo.mediaSources?.first;

    final mediaStreamsWithUrls =
        MediaStreamsModel.fromMediaStreamsList(playbackInfo.mediaSources, ref)
            .copyWith(
      defaultAudioStreamIndex: audioIndex,
      defaultSubStreamIndex: subIndex,
    );

    if (mediaSource == null) return;

    PlaybackModel? newModel;

    if ((mediaSource.supportsDirectStream ?? false) ||
        (mediaSource.supportsDirectPlay ?? false)) {
      final Map<String, String?> directOptions = {
        'Static': 'true',
        'mediaSourceId': mediaSource.id,
        'api_key': ref.read(userProvider)?.credentials.token,
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
        mediaSegments: playbackModel.mediaSegments,
        chapters: playbackModel.chapters,
        playbackInfo: playbackInfo,
        trickPlay: playbackModel.trickPlay,
        media: Media(url: mediaPath ?? directPlay),
        mediaStreams: mediaStreamsWithUrls,
        bitRateOptions: playbackModel.bitRateOptions,
      );
    } else if ((mediaSource.supportsTranscoding ?? false) &&
        mediaSource.transcodingUrl != null) {
      newModel = TranscodePlaybackModel(
        item: playbackModel.item,
        queue: playbackModel.queue,
        mediaSegments: playbackModel.mediaSegments,
        chapters: playbackModel.chapters,
        playbackInfo: playbackInfo,
        trickPlay: playbackModel.trickPlay,
        media: Media(
            url: buildServerUrl(ref, relativeUrl: mediaSource.transcodingUrl)),
        mediaStreams: mediaStreamsWithUrls,
        bitRateOptions: playbackModel.bitRateOptions,
      );
    }
    if (newModel == null) {
      if (isSyncPlayActive) {
        ref.read(videoPlayerProvider.notifier).setReloading(false);
      }
      return;
    }
    if (newModel.runtimeType != playbackModel.runtimeType ||
        newModel is TranscodePlaybackModel) {
      ref
          .read(videoPlayerProvider.notifier)
          .loadPlaybackItem(newModel, currentPosition);
    } else if (isSyncPlayActive) {
      // If we didn't call loadPlaybackItem, we must reset reloading state
      ref.read(videoPlayerProvider.notifier).setReloading(false);
    }
  }
}
