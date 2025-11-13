import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fladder/main.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/direct_playback_model.dart';
import 'package:fladder/models/playback/offline_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/playback/transcode_playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/src/video_player_helper.g.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class NativePlayer extends BasePlayer implements VideoPlayerListenerCallback {
  final player = VideoPlayerApi();
  final activity = NativeVideoActivity();

  @override
  Future<void> dispose() async {
    nativeActivityStarted = false;
    return activity.disposeActivity();
  }

  @override
  Future<void> init(VideoPlayerSettingsModel settings) async => VideoPlayerListenerCallback.setUp(this);

  @override
  Future<void> loop(bool loop) {
    return player.setLooping(loop);
  }

  @override
  Future<void> loadVideo(String url, bool play) async => player.open(url, play);

  @override
  Future<StartResult> open(BuildContext newContext) async {
    nativeActivityStarted = true;
    return activity.launchActivity();
  }

  @override
  Future<void> pause() {
    return player.pause();
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> playOrPause() async {
    if (lastState.playing) {
      return player.pause();
    } else {
      return player.play();
    }
  }

  @override
  Future<void> seek(Duration position) {
    return player.seekTo(position.inMilliseconds);
  }

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async {
    return model?.index ?? 0;
  }

  @override
  Future<void> setSpeed(double speed) async {}

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async {
    return model?.index ?? 0;
  }

  @override
  Future<void> setVolume(double volume) async {
    return player.setVolume(volume);
  }

  @override
  Future<void> adjustSubtitleOffset(double offsetSeconds) async {}

  @override
  Future<double> getSubtitleOffset() async {
    return 0.0;
  }

  @override
  Future<void> stop() async {
    nativeActivityStarted = false;
    return player.stop();
  }

  @override
  Widget? subtitles(bool showOverlay, {GlobalKey<State<StatefulWidget>>? controlsKey}) => null;

  @override
  Widget? videoWidget(Key key, BoxFit fit) => null;

  @override
  void onPlaybackStateChanged(PlaybackState state) {
    lastState = lastState.update(
      playing: state.playing,
      position: Duration(milliseconds: state.position),
      buffer: Duration(milliseconds: state.buffered),
      buffering: state.buffering,
    );
    _stateController.add(lastState);
  }

  final StreamController<PlayerState> _stateController = StreamController.broadcast();

  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

  Future<void> sendPlaybackDataToNative(
    BuildContext? context,
    PlaybackModel model,
    Duration startPosition,
  ) async {
    final playableData = PlayableData(
      currentItem: model.item.toSimpleItem(context),
      startPosition: startPosition.inMilliseconds,
      description: model.item.overview.summary,
      defaultAudioTrack: model.mediaStreams?.defaultAudioStreamIndex ?? 1,
      nextVideo: model.nextVideo?.toSimpleItem(context),
      previousVideo: model.previousVideo?.toSimpleItem(context),
      audioTracks: model.audioStreams
              ?.map(
                (audio) => AudioTrack(
                  name: audio.displayTitle,
                  languageCode: audio.language,
                  codec: audio.codec,
                  index: audio.index,
                  external: false,
                ),
              )
              .toList() ??
          [],
      defaultSubtrack: model.mediaStreams?.defaultSubStreamIndex ?? 1,
      subtitleTracks: model.subStreams
              ?.map(
                (sub) => SubtitleTrack(
                  name: sub.displayTitle,
                  languageCode: sub.language,
                  codec: sub.codec,
                  index: sub.index,
                  external: sub.isExternal,
                  url: sub.url,
                ),
              )
              .toList() ??
          [],
      segments: model.mediaSegments?.segments
              .map(
                (e) => MediaSegment(
                  type: MediaSegmentType.values.firstWhere((element) => element.name == e.type.name),
                  name: context != null ? e.type.label(context) : e.type.name,
                  start: e.start.inMilliseconds,
                  end: e.end.inMilliseconds,
                ),
              )
              .toList() ??
          [],
      trickPlayModel: model.trickPlay != null
          ? TrickPlayModel(
              width: model.trickPlay!.width,
              height: model.trickPlay!.height,
              tileWidth: model.trickPlay!.tileWidth,
              tileHeight: model.trickPlay!.tileHeight,
              thumbnailCount: model.trickPlay!.thumbnailCount,
              interval: model.trickPlay!.interval.inMilliseconds,
              images: model.trickPlay?.images ?? [])
          : null,
      chapters: model.chapters
              ?.map((e) => Chapter(name: e.name, url: e.imageUrl, time: e.startPosition.inMilliseconds))
              .toList() ??
          [],
      mediaInfo: MediaInfo(
        playbackType: switch (model) {
          DirectPlaybackModel() => PlaybackType.direct,
          OfflinePlaybackModel() => PlaybackType.offline,
          TranscodePlaybackModel() => PlaybackType.transcoded,
          _ => PlaybackType.direct,
        },
        videoInformation: model.item.streamModel?.mediaInfoTag ?? " ",
      ),
      url: model.media?.url ?? "",
    );
    await player.sendPlayableModel(playableData);
  }
}
