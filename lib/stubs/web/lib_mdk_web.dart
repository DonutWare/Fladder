import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

// This is a stub class that provides the same method signatures as the original
// implementation, ensuring web builds compile without requiring changes elsewhere.
class LibMDK extends BasePlayer {
  final StreamController<PlayerState> _stateController = StreamController.broadcast();

  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

  @override
  Future<void> init(VideoPlayerSettingsModel settings) async {}

  @override
  Future<void> dispose() async {}

  @override
  Future<void> open(String url, bool play) async {}

  void setState(PlayerState state) {}

  void updateState() {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> play() async {}
  @override
  Future<void> playOrPause() async {}

  @override
  Future<void> seek(Duration position) async {}

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async {
    return -1;
  }

  @override
  Future<void> setSpeed(double speed) async {}

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async {
    return -1;
  }

  @override
  Future<void> stop() async {}

  @override
  Widget? videoWidget(
    Key key,
    BoxFit fit,
  ) =>
      null;

  @override
  Widget? subtitles(bool showOverlay) => null;

  @override
  Future<void> setVolume(double volume) async {}

  @override
  Future<void> loop(bool loop) async {}
}
