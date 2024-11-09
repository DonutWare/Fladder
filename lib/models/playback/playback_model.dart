import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

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
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart'
    if (dart.library.html) 'package:fladder/wrappers/media_control_wrapper_web.dart';

extension PlaybackModelExtension on PlaybackModel? {
  String? get label => switch (this) {
        DirectPlaybackModel _ => PlaybackType.directStream.name,
        TranscodePlaybackModel _ => PlaybackType.transcode.name,
        OfflinePlaybackModel _ => PlaybackType.offline.name,
        _ => null
      };
}

abstract class PlaybackModel {
  final ItemBaseModel item = throw UnimplementedError();
  final Media? media = throw UnimplementedError();
  final List<ItemBaseModel> queue = const [];
  final MediaSegmentsModel? mediaSegments = null;
  final PlaybackInfoResponse? playbackInfo = throw UnimplementedError();

  List<Chapter>? get chapters;
  TrickPlayModel? get trickPlay;

  Future<PlaybackModel?> updatePlaybackPosition(Duration position, bool isPlaying, Ref ref) =>
      throw UnimplementedError();
  Future<PlaybackModel?> playbackStarted(Duration position, Ref ref) => throw UnimplementedError();
  Future<PlaybackModel?> playbackStopped(Duration position, Duration? totalDuration, Ref ref) =>
      throw UnimplementedError();

  final MediaStreamsModel? mediaStreams = throw UnimplementedError();
  List<SubStreamModel>? get subStreams;
  List<AudioStreamModel>? get audioStreams;

  Future<Duration>? startDuration() async => item.userData.playBackPosition;
  Future<PlaybackModel>? setSubtitle(SubStreamModel? model, MediaControlsWrapper player) {
    return null;
  }

  Future<PlaybackModel>? setAudio(AudioStreamModel? model, MediaControlsWrapper player) => null;

  ItemBaseModel? get nextVideo => throw UnimplementedError();
  ItemBaseModel? get previousVideo => throw UnimplementedError();

  PlaybackModel copyWith();
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
      media: Media(syncedItem.videoFile.path),
      queue: itemQueue.whereNotNull().toList(),
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

  Future<PlaybackModel?> createServerPlaybackModel(ItemBaseModel? item, PlaybackType? type,
      {PlaybackModel? oldModel, List<ItemBaseModel>? libraryQueue, Duration? startPosition}) async {
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

      final streamModel = firstItemToPlay.streamModel;

      Response<PlaybackInfoResponse> response = await api.itemsItemIdPlaybackInfoPost(
        itemId: firstItemToPlay.id,
        enableDirectPlay: type != PlaybackType.transcode,
        enableDirectStream: type != PlaybackType.transcode,
        enableTranscoding: true,
        autoOpenLiveStream: true,
        startTimeTicks: startPosition?.toRuntimeTicks,
        audioStreamIndex: streamModel?.defaultAudioStreamIndex,
        subtitleStreamIndex: streamModel?.defaultSubStreamIndex,
        mediaSourceId: firstItemToPlay.id,
        body: PlaybackInfoDto(
          startTimeTicks: startPosition?.toRuntimeTicks,
          audioStreamIndex: streamModel?.defaultAudioStreamIndex,
          subtitleStreamIndex: streamModel?.defaultSubStreamIndex,
          enableTranscoding: true,
          autoOpenLiveStream: true,
          deviceProfile: defaultProfile,
          userId: userId,
          mediaSourceId: firstItemToPlay.id,
        ),
      );

      PlaybackInfoResponse? playbackInfo = response.body;
      if (playbackInfo == null) return null;

      final mediaSource = playbackInfo.mediaSources?.first;

      final mediaStreamsWithUrls = MediaStreamsModel.fromMediaStreamsList(
              playbackInfo.mediaSources?.firstOrNull, playbackInfo.mediaSources?.firstOrNull?.mediaStreams ?? [], ref)
          .copyWith(
        defaultAudioStreamIndex: streamModel?.defaultAudioStreamIndex,
        defaultSubStreamIndex: streamModel?.defaultSubStreamIndex,
      );

      final mediaSegments = await api.mediaSegmentsGet(id: item.id);
      final trickPlay = (await api.getTrickPlay(item: fullItem.body, ref: ref))?.body;
      final chapters = fullItem.body?.overview.chapters ?? [];

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

        return DirectPlaybackModel(
          item: fullItem.body ?? item,
          queue: queue,
          mediaSegments: mediaSegments?.body,
          chapters: chapters,
          playbackInfo: playbackInfo,
          trickPlay: trickPlay,
          media: Media('${ref.read(userProvider)?.server ?? ""}/Videos/${mediaSource.id}/stream?$params'),
          mediaStreams: mediaStreamsWithUrls,
        );
      } else if ((mediaSource.supportsTranscoding ?? false) && mediaSource.transcodingUrl != null) {
        return TranscodePlaybackModel(
          item: fullItem.body ?? item,
          queue: queue,
          mediaSegments: mediaSegments?.body,
          chapters: chapters,
          trickPlay: trickPlay,
          playbackInfo: playbackInfo,
          media: Media("${ref.read(userProvider)?.server ?? ""}${mediaSource.transcodingUrl ?? ""}"),
          mediaStreams: mediaStreamsWithUrls,
        );
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
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
      enableDirectPlay: true,
      enableDirectStream: true,
      enableTranscoding: true,
      autoOpenLiveStream: true,
      startTimeTicks: currentPosition.toRuntimeTicks,
      audioStreamIndex: audioIndex,
      subtitleStreamIndex: subIndex,
      mediaSourceId: item.id,
      body: PlaybackInfoDto(
        startTimeTicks: currentPosition.toRuntimeTicks,
        audioStreamIndex: audioIndex,
        subtitleStreamIndex: subIndex,
        enableTranscoding: true,
        autoOpenLiveStream: true,
        deviceProfile: defaultProfile,
        userId: userId,
        mediaSourceId: item.id,
      ),
    );

    PlaybackInfoResponse playbackInfo = response.bodyOrThrow;

    final mediaSource = playbackInfo.mediaSources?.first;

    final mediaStreamsWithUrls = MediaStreamsModel.fromMediaStreamsList(
            playbackInfo.mediaSources?.firstOrNull, playbackInfo.mediaSources?.firstOrNull?.mediaStreams ?? [], ref)
        .copyWith(
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

      newModel = DirectPlaybackModel(
        item: playbackModel.item,
        queue: playbackModel.queue,
        mediaSegments: playbackModel.mediaSegments,
        chapters: playbackModel.chapters,
        playbackInfo: playbackInfo,
        trickPlay: playbackModel.trickPlay,
        media: Media(directPlay),
        mediaStreams: mediaStreamsWithUrls,
      );
    } else if ((mediaSource.supportsTranscoding ?? false) && mediaSource.transcodingUrl != null) {
      newModel = TranscodePlaybackModel(
        item: playbackModel.item,
        queue: playbackModel.queue,
        mediaSegments: playbackModel.mediaSegments,
        chapters: playbackModel.chapters,
        playbackInfo: playbackInfo,
        trickPlay: playbackModel.trickPlay,
        media: Media("${ref.read(userProvider)?.server ?? ""}${mediaSource.transcodingUrl ?? ""}"),
        mediaStreams: mediaStreamsWithUrls,
      );
    }
    if (newModel == null) return;
    if (newModel.runtimeType != playbackModel.runtimeType || newModel is TranscodePlaybackModel) {
      ref.read(videoPlayerProvider.notifier).loadPlaybackItem(newModel, startPosition: currentPosition);
    }
  }
}
