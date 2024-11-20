import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/wrappers/players/player_states.dart';

abstract class BasePlayer {
  Stream<PlayerState> get stateStream;
  late PlayerState lastState;

  Future<void> init(Ref ref);
  Widget? videoWidget(
    Key key,
    BoxFit fit,
  );
  Widget? subtitles(
    bool showOverlay,
  );
  Future<void> dispose();
  Future<void> open(String url, bool play);
  Future<void> seek(Duration position);
  Future<void> play();
  Future<void> setVolume(double volume);
  Future<void> setSpeed(double speed);
  Future<void> pause();
  Future<void> stop();
  Future<void> playOrPause();
  Future<void> loop(bool loop);
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel);
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel);
}
