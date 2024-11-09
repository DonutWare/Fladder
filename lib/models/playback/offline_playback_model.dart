import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart'
    if (dart.library.html) 'package:fladder/wrappers/media_control_wrapper_web.dart';
import 'package:flutter/widgets.dart';

class OfflinePlaybackModel implements PlaybackModel {
  OfflinePlaybackModel({
    required this.item,
    required this.media,
    required this.syncedItem,
    this.mediaStreams,
    this.playbackInfo,
    this.mediaSegments,
    this.trickPlay,
    this.queue = const [],
    this.syncedQueue = const [],
  });

  @override
  final ItemBaseModel item;

  @override
  final PlaybackInfoResponse? playbackInfo;

  @override
  final Media? media;

  final SyncedItem syncedItem;

  @override
  final MediaStreamsModel? mediaStreams;

  @override
  final MediaSegmentsModel? mediaSegments;

  @override
  List<Chapter>? get chapters => syncedItem.chapters;

  @override
  final TrickPlayModel? trickPlay;

  @override
  Future<Duration>? startDuration() async => item.userData.playBackPosition;

  @override
  ItemBaseModel? get nextVideo => queue.nextOrNull(item);
  @override
  ItemBaseModel? get previousVideo => queue.previousOrNull(item);

  @override
  List<SubStreamModel> get subStreams => [SubStreamModel.no(), ...syncedItem.subtitles];

  @override
  Future<OfflinePlaybackModel> setSubtitle(SubStreamModel? model, MediaControlsWrapper player) async {
    final wantedSubtitle =
        model ?? subStreams.firstWhereOrNull((element) => element.index == mediaStreams?.defaultSubStreamIndex);
    if (wantedSubtitle == null) return this;
    if (wantedSubtitle.index == SubStreamModel.no().index) {
      await player.setSubtitleTrack(SubtitleTrack.no());
    } else {
      final subTracks = player.subTracks.getRange(2, player.subTracks.length).toList();
      final index = subStreams.sublist(1).indexWhere((element) => element.id == wantedSubtitle.id);
      final subTrack = subTracks.elementAtOrNull(index);
      if (wantedSubtitle.isExternal && wantedSubtitle.url != null && subTrack == null) {
        await player.setSubtitleTrack(SubtitleTrack.uri(wantedSubtitle.url!));
      } else if (subTrack != null) {
        await player.setSubtitleTrack(subTrack);
      }
    }
    return copyWith(mediaStreams: () => mediaStreams?.copyWith(defaultSubStreamIndex: wantedSubtitle.index));
  }

  @override
  List<AudioStreamModel> get audioStreams => [AudioStreamModel.no(), ...mediaStreams?.audioStreams ?? []];

  @override
  Future<OfflinePlaybackModel>? setAudio(AudioStreamModel? model, MediaControlsWrapper player) async {
    final wantedAudioStream =
        model ?? audioStreams.firstWhereOrNull((element) => element.index == mediaStreams?.defaultAudioStreamIndex);
    if (wantedAudioStream == null) return this;
    if (wantedAudioStream.index == AudioStreamModel.no().index) {
      await player.setAudioTrack(AudioTrack.no());
    } else {
      final audioTracks = player.audioTracks.getRange(2, player.audioTracks.length).toList();
      final audioTrack = audioTracks.elementAtOrNull(audioStreams.indexOf(wantedAudioStream) - 1);
      if (audioTrack != null) {
        await player.setAudioTrack(audioTrack);
      }
    }
    return copyWith(mediaStreams: () => mediaStreams?.copyWith(defaultAudioStreamIndex: wantedAudioStream.index));
  }

  @override
  Future<PlaybackModel?> playbackStarted(Duration position, Ref ref) async {
    return null;
  }

  @override
  Future<PlaybackModel?> playbackStopped(Duration position, Duration? totalDuration, Ref ref) async {
    return null;
  }

  @override
  Future<PlaybackModel?> updatePlaybackPosition(Duration position, bool isPlaying, Ref ref) async {
    final progress = position.inMilliseconds / (item.overview.runTime?.inMilliseconds ?? 0) * 100;
    final newItem = syncedItem.copyWith(
      userData: syncedItem.userData?.copyWith(
        playbackPositionTicks: position.toRuntimeTicks,
        progress: progress,
        played: isPlayed(position, item.overview.runTime ?? Duration.zero),
      ),
    );
    await ref.read(syncProvider.notifier).updateItem(newItem);
    return this;
  }

  bool isPlayed(Duration position, Duration totalDuration) {
    Duration startBuffer = totalDuration * 0.05;
    Duration endBuffer = totalDuration * 0.90;

    Duration validStart = startBuffer;
    Duration validEnd = endBuffer;

    if (position >= validStart && position <= validEnd) {
      return true;
    }

    return false;
  }

  @override
  String toString() => 'OfflinePlaybackModel(item: $item, syncedItem: $syncedItem)';

  @override
  final List<ItemBaseModel> queue;

  final List<SyncedItem> syncedQueue;

  @override
  OfflinePlaybackModel copyWith({
    ItemBaseModel? item,
    ValueGetter<Media?>? media,
    SyncedItem? syncedItem,
    ValueGetter<MediaStreamsModel?>? mediaStreams,
    ValueGetter<MediaSegmentsModel?>? mediaSegments,
    ValueGetter<TrickPlayModel?>? trickPlay,
    List<ItemBaseModel>? queue,
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
      syncedQueue: syncedQueue ?? this.syncedQueue,
    );
  }
}
