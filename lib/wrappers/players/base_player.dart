import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/wrappers/players/player_states.dart';

abstract class BasePlayer {
  Future<void> init(Ref ref);
  Widget? videoWidget(
    BuildContext context,
    Key key,
    BoxFit fit,
  );
  Future<void> open(String url, bool play);
  Future<void> seek(Duration position);
  Future<void> play();
  Future<void> setVolume(double volume);
  Future<void> fastForward();
  Future<void> rewind();
  Future<void> setSpeed(double speed);
  Future<void> pause();
  Future<void> stop();
  Future<void> playOrPause();
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel);
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel);

  PlayerStream? stream;
  late PlayerState state;
}
