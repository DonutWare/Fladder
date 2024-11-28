import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/wrappers/players/player_states.dart';

const libassFallbackFont = "assets/mp-font.ttf";

abstract class BasePlayer {
  Stream<PlayerState> get stateStream;
  PlayerState lastState = PlayerState();

  Future<void> init(VideoPlayerSettingsModel settings);
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

  Uri? isValidUrl(String input) {
    try {
      final uri = Uri.tryParse(input);
      if (uri != null && uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https')) {
        return uri;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
