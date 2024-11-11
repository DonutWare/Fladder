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
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart'
    if (dart.library.html) 'package:fladder/wrappers/media_control_wrapper_web.dart';
import 'package:flutter/widgets.dart';

class TranscodePlaybackModel implements PlaybackModel {
  TranscodePlaybackModel({
    required this.item,
    required this.media,
    required this.playbackInfo,
    this.mediaStreams,
    this.mediaSegments,
    this.chapters,
    this.trickPlay,
    this.queue = const [],
  });

  @override
  final ItemBaseModel item;

  @override
  final Media? media;

  @override
  final PlaybackInfoResponse playbackInfo;

  @override
  final MediaStreamsModel? mediaStreams;

  @override
  final MediaSegmentsModel? mediaSegments;

  @override
  final List<Chapter>? chapters;

  @override
  final TrickPlayModel? trickPlay;

  @override
  ItemBaseModel? get nextVideo => queue.nextOrNull(item);

  @override
  ItemBaseModel? get previousVideo => queue.previousOrNull(item);

  @override
  Future<Duration>? startDuration() async => item.userData.playBackPosition;

  @override
  List<SubStreamModel> get subStreams => [SubStreamModel.no(), ...mediaStreams?.subStreams ?? []];

  List<QueueItem> get itemsInQueue =>
      queue.mapIndexed((index, element) => QueueItem(id: element.id, playlistItemId: "playlistItem$index")).toList();

  @override
  Future<TranscodePlaybackModel> setSubtitle(SubStreamModel? model, MediaControlsWrapper player) async {
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
  Future<TranscodePlaybackModel>? setAudio(AudioStreamModel? model, MediaControlsWrapper player) async {
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
    await ref.read(jellyApiProvider).sessionsPlayingPost(
          body: PlaybackStartInfo(
            canSeek: true,
            itemId: item.id,
            mediaSourceId: item.id,
            playSessionId: playbackInfo.playSessionId,
            sessionId: playbackInfo.playSessionId,
            subtitleStreamIndex: item.streamModel?.defaultSubStreamIndex,
            audioStreamIndex: item.streamModel?.defaultAudioStreamIndex,
            volumeLevel: 100,
            playbackStartTimeTicks: position.toRuntimeTicks,
            playMethod: PlayMethod.transcode,
            isMuted: false,
            isPaused: false,
            repeatMode: RepeatMode.repeatall,
          ),
        );
    return null;
  }

  @override
  Future<PlaybackModel?> playbackStopped(Duration position, Duration? totalDuration, Ref ref) async {
    ref.read(playBackModel.notifier).update((state) => null);

    await ref.read(jellyApiProvider).sessionsPlayingStoppedPost(
          body: PlaybackStopInfo(
            itemId: item.id,
            mediaSourceId: item.id,
            playSessionId: playbackInfo.playSessionId,
            positionTicks: position.toRuntimeTicks,
            failed: false,
          ),
          totalDuration: totalDuration,
        );

    return null;
  }

  @override
  Future<PlaybackModel?> updatePlaybackPosition(Duration position, bool isPlaying, Ref ref) async {
    final api = ref.read(jellyApiProvider);
    await api.sessionsPlayingProgressPost(
      body: PlaybackProgressInfo(
        canSeek: true,
        itemId: item.id,
        mediaSourceId: item.id,
        playSessionId: playbackInfo.playSessionId,
        sessionId: playbackInfo.playSessionId,
        subtitleStreamIndex: item.streamModel?.defaultSubStreamIndex,
        audioStreamIndex: item.streamModel?.defaultAudioStreamIndex,
        volumeLevel: 100,
        positionTicks: position.toRuntimeTicks,
        playMethod: PlayMethod.transcode,
        isPaused: !isPlaying,
        isMuted: false,
        repeatMode: RepeatMode.repeatall,
      ),
    );
    return this;
  }

  @override
  String toString() => 'TranscodePlaybackModel(item: $item, playbackInfo: $playbackInfo)';

  @override
  final List<ItemBaseModel> queue;

  @override
  TranscodePlaybackModel copyWith({
    ItemBaseModel? item,
    ValueGetter<Media?>? media,
    ValueGetter<Duration>? lastPosition,
    PlaybackInfoResponse? playbackInfo,
    ValueGetter<MediaStreamsModel?>? mediaStreams,
    ValueGetter<MediaSegmentsModel?>? mediaSegments,
    ValueGetter<List<Chapter>?>? chapters,
    ValueGetter<TrickPlayModel?>? trickPlay,
    List<ItemBaseModel>? queue,
  }) {
    return TranscodePlaybackModel(
      item: item ?? this.item,
      media: media != null ? media() : this.media,
      playbackInfo: playbackInfo ?? this.playbackInfo,
      mediaStreams: mediaStreams != null ? mediaStreams() : this.mediaStreams,
      mediaSegments: mediaSegments != null ? mediaSegments() : this.mediaSegments,
      chapters: chapters != null ? chapters() : this.chapters,
      trickPlay: trickPlay != null ? trickPlay() : this.trickPlay,
      queue: queue ?? this.queue,
    );
  }
}
