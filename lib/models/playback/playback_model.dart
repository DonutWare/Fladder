import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/playback/direct_playback_model.dart';
import 'package:fladder/models/playback/offline_playback_model.dart';
import 'package:fladder/models/playback/transcode_playback_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/profiles/default_profile.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class Media {
  final String url;

  const Media({
    required this.url,
  });
}

extension PlaybackModelExtension on PlaybackModel? {
  SubStreamModel? get defaultSubStream =>
      this?.subStreams?.firstWhereOrNull((element) => element.index == this?.mediaStreams?.defaultSubStreamIndex);

  AudioStreamModel? get defaultAudioStream =>
      this?.audioStreams?.firstWhereOrNull((element) => element.index == this?.mediaStreams?.defaultAudioStreamIndex);

  String? get label => switch (this) {
        DirectPlaybackModel _ => PlaybackType.directStream.name,
        TranscodePlaybackModel _ => PlaybackType.transcode.name,
        OfflinePlaybackModel _ => PlaybackType.offline.name,
        _ => null
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

  Future<PlaybackModel?> updatePlaybackPosition(Duration position, bool isPlaying, Ref ref) =>
      throw UnimplementedError();
  Future<PlaybackModel?> playbackStarted(Duration position, Ref ref) => throw UnimplementedError();
  Future<PlaybackModel?> playbackStopped(Duration position, Duration? totalDuration, Ref ref) =>
      throw UnimplementedError();

  final MediaStreamsModel? mediaStreams;
  List<SubStreamModel>? get subStreams => throw UnimplementedError();
  List<AudioStreamModel>? get audioStreams => throw UnimplementedError();

  Future<Duration>? startDuration() async => item.userData.playBackPosition;

  Future<PlaybackModel>? setSubtitle(SubStreamModel? model, MediaControlsWrapper player) => throw UnimplementedError();
  Future<PlaybackModel>? setAudio(AudioStreamModel? model, MediaControlsWrapper player) => throw UnimplementedError();
  Future<PlaybackModel>? setQualityOption(Map<Bitrate, bool> map) => throw UnimplementedError();

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
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(buffering: true));
    final currentModel = ref.read(playBackModel);
    final newModel = (await createServerPlaybackModel(
          newItem,
          null,
          oldModel: currentModel,
        )) ??
        await createOfflinePlaybackModel(
          newItem,
          ref.read(syncProvider.notifier).getSyncedItem(newItem),
          oldModel: currentModel,
        );
    if (newModel == null) return null;
    ref.read(videoPlayerProvider.notifier).loadPlaybackItem(newModel, startPosition: Duration.zero);
    return newModel;
  }

  Future<OfflinePlaybackModel?> createOfflinePlaybackModel(
    ItemBaseModel item,
    SyncedItem? syncedItem, {
    PlaybackModel? oldModel,
  }) async {
    final ItemBaseModel? syncedItemModel = ref.read(syncProvider.notifier).getItem(syncedItem);
    if (syncedItemModel == null || syncedItem == null || !syncedItem.dataFile.existsSync()) return null;

    final children = ref.read(syncChildrenProvider(syncedItem));
    final syncedItems = children.where((element) => element.videoFile.existsSync()).toList();
    final itemQueue = syncedItems.map((e) => e.createItemModel(ref));

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

  Future<EpisodeModel?> getNextUpEpisode(String itemId) async {
    final response = await api.showsNextUpGet(parentId: itemId, fields: [ItemFields.overview]);
    final episode = response.body?.items?.firstOrNull;
    if (episode == null) {
      return null;
    } else {
      return EpisodeModel.fromBaseDto(episode, ref);
    }
  }

  Future<PlaybackModel?> createServerPlaybackModel(
    ItemBaseModel? item,
    PlaybackType? type, {
    PlaybackModel? oldModel,
    List<ItemBaseModel>? libraryQueue,
    Duration? startPosition,
  }) async {
    try {
      if (item == null) return null;
      final userId = ref.read(userProvider)?.id;
      if (userId?.isEmpty == true) return null;

      final queue = oldModel?.queue ?? libraryQueue ?? await collectQueue(item);

      final firstItemToPlay = switch (item) {
        SeriesModel _ || SeasonModel _ => (await getNextUpEpisode(item.id) ?? queue.first),
        _ => item,
      };

      final fullItem = await api.usersUserIdItemsItemIdGet(itemId: firstItemToPlay.id);

      Map<Bitrate, bool> qualityOptions = getVideoQualityOptions(
        VideoQualitySettings(
          maxBitRate: ref.read(videoPlayerSettingsProvider.select((value) => value.maxHomeBitrate)),
          videoBitRate: firstItemToPlay.streamModel?.videoStreams.first.bitRate ?? 0,
          videoCodec: firstItemToPlay.streamModel?.videoStreams.first.codec,
        ),
      );

      final streamModel = firstItemToPlay.streamModel;

      final Response<PlaybackInfoResponse> response = await api.itemsItemIdPlaybackInfoPost(
        itemId: firstItemToPlay.id,
        body: PlaybackInfoDto(
          startTimeTicks: startPosition?.toRuntimeTicks,
          audioStreamIndex: streamModel?.defaultAudioStreamIndex,
          subtitleStreamIndex: streamModel?.defaultSubStreamIndex,
          enableTranscoding: true,
          autoOpenLiveStream: true,
          deviceProfile: ref.read(videoProfileProvider),
          userId: userId,
          enableDirectPlay: type != PlaybackType.transcode,
          enableDirectStream: type != PlaybackType.transcode,
          maxStreamingBitrate: qualityOptions.enabledFirst.keys.firstOrNull?.bitRate,
          mediaSourceId: streamModel?.currentVersionStream?.id,
        ),
      );

      PlaybackInfoResponse? playbackInfo = response.body;
      if (playbackInfo == null) return null;

      final mediaSource = playbackInfo.mediaSources?.first;

      final mediaStreamsWithUrls = MediaStreamsModel.fromMediaStreamsList(playbackInfo.mediaSources, ref).copyWith(
        defaultAudioStreamIndex: streamModel?.defaultAudioStreamIndex,
        defaultSubStreamIndex: streamModel?.defaultSubStreamIndex,
      );

      final mediaSegments = await api.mediaSegmentsGet(id: item.id);
      final trickPlay = (await api.getTrickPlay(item: fullItem.body, ref: ref))?.body;
      final chapters = fullItem.body?.overview.chapters ?? [];

      final mediaPath = isValidVideoUrl(mediaSource?.path ?? "");

      if (mediaSource == null) return null;

      if ((mediaSource.supportsDirectStream ?? false) || (mediaSource.supportsDirectPlay ?? false)) {
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

        final params = Uri(queryParameters: directOptions).query;
        final playbackUrl = joinAll([ref.read(userProvider)!.server, "Videos", mediaSource.id!, "stream?$params"]);

        return DirectPlaybackModel(
          item: fullItem.body ?? item,
          queue: queue,
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
          item: fullItem.body ?? item,
          queue: queue,
          mediaSegments: mediaSegments?.body,
          chapters: chapters,
          trickPlay: trickPlay,
          playbackInfo: playbackInfo,
          media: Media(url: "${ref.read(userProvider)?.server ?? ""}${mediaSource.transcodingUrl ?? ""}"),
          mediaStreams: mediaStreamsWithUrls,
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

    final audioIndex = playbackModel.mediaStreams?.defaultAudioStreamIndex;
    final subIndex = playbackModel.mediaStreams?.defaultSubStreamIndex;

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
        'api_key': ref.read(userProvider)?.credentials.token,
      };

      if (mediaSource.eTag != null) {
        directOptions['Tag'] = mediaSource.eTag;
      }

      if (mediaSource.liveStreamId != null) {
        directOptions['LiveStreamId'] = mediaSource.liveStreamId;
      }

      final params = Uri(queryParameters: directOptions).query;

      final directPlay = '${ref.read(userProvider)?.server ?? ""}/Videos/${mediaSource.id}/stream?$params';

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
    } else if ((mediaSource.supportsTranscoding ?? false) && mediaSource.transcodingUrl != null) {
      newModel = TranscodePlaybackModel(
        item: playbackModel.item,
        queue: playbackModel.queue,
        mediaSegments: playbackModel.mediaSegments,
        chapters: playbackModel.chapters,
        playbackInfo: playbackInfo,
        trickPlay: playbackModel.trickPlay,
        media: Media(url: "${ref.read(userProvider)?.server ?? ""}${mediaSource.transcodingUrl ?? ""}"),
        mediaStreams: mediaStreamsWithUrls,
        bitRateOptions: playbackModel.bitRateOptions,
      );
    }
    if (newModel == null) return;
    if (newModel.runtimeType != playbackModel.runtimeType || newModel is TranscodePlaybackModel) {
      ref.read(videoPlayerProvider.notifier).loadPlaybackItem(newModel, startPosition: currentPosition);
    }
  }
}
