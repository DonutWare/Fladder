import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/src/video_player_helper.g.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class NativePlayer extends BasePlayer implements VideoPlayerListener {
  final player = VideoPlayerApi();
  MediaControlsWrapper? ref;

  @override
  Future<void> dispose() async {
    // return NativeVideoPlayerApi().disposeActivity();
  }

  @override
  Future<void> init(VideoPlayerSettingsModel settings) async => VideoPlayerListener.setUp(this);

  @override
  Future<void> loop(bool loop) {
    return player.setLooping(loop);
  }

  @override
  Future<void> open(String url, bool play) async {
    final result = await NativeVideoActivity().launchActivity();
    log(result.resultValue ?? "No result");
    return;
  }

  @override
  Future<void> pause() {
    return player.pause();
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> playOrPause() async {
    return;
  }

  @override
  Future<void> seek(Duration position) {
    return player.seekTo(position.inMilliseconds);
  }

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async {
    return 0;
  }

  @override
  Future<void> setSpeed(double speed) async {}

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async {
    return 0;
  }

  @override
  Future<void> setVolume(double volume) async {
    return player.setVolume(volume);
  }

  @override
  Future<void> stop() async {
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
    );
    _stateController.add(lastState);
  }

  final StreamController<PlayerState> _stateController = StreamController.broadcast();

  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

  @override
  void loadNextVideo() {
    // final previousVideo = ref?.read(playBackModel.select((value) => value?.previousVideo));
    // final buffering = ref?.read(mediaPlaybackProvider.select((value) => value.buffering)) ?? true;
    // previousVideo != null && !buffering ? () => ref?.read(playbackModelHelper).loadNewVideo(previousVideo) : null;
  }

  @override
  void loadPreviousVideo() {
    // final nextVideo = ref?.read(playBackModel.select((value) => value?.nextVideo));
    // final buffering = ref?.read(mediaPlaybackProvider.select((value) => value.buffering)) ?? true;
    // nextVideo != null && !buffering ? () => ref?.read(playbackModelHelper).loadNewVideo(nextVideo) : null;
  }

  @override
  void onStop() {
    ref?.stop();
  }

  Future<bool> sendPlaybackData(
    PlaybackModel model,
    Duration startPosition,
    MediaControlsWrapper playerProvider,
  ) async {
    ref = playerProvider;
    final playableData = PlayableData(
      id: model.item.id,
      title: model.item.title,
      startPosition: startPosition.inMilliseconds,
      description: model.item.overview.summary,
      audioTracks:
          model.audioStreams?.map((e) => AudioTrack(name: e.name, index: e.index, external: false)).toList() ?? [],
      subtitleTracks: model.subStreams
              ?.map((e) => SubtitleTrack(name: e.name, index: e.index, external: e.isExternal, url: e.url))
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
      chapters: [],
      url: model.media?.url ?? "",
    );
    return player.sendPlayableModel(playableData);
  }
}
