import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/subtitle_settings_model.dart';
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
    bool showOverlay, {
    GlobalKey? controlsKey,
  });
  Future<void> dispose();
  Future<void> open(BuildContext context);
  Future<void> loadVideo(String url, bool play, {Duration startPosition = Duration.zero});
  Future<void> loadAudioQueue(
    List<ItemBaseModel> queue,
    int initialIndex,
    Duration startPosition,
    Uri Function(ItemBaseModel item) urlBuilder,
  ) async {
    throw UnimplementedError('[BasePlayer.loadAudioQueue] is not implemented');
  }

  Future<void> seek(Duration position);
  Future<void> play();
  Future<void> setVolume(double volume);
  Future<void> setSpeed(double speed);
  Future<void> pause();
  Future<void> stop();
  Future<void> playOrPause();
  Future<void> loop(bool loop);
  Future<void> setShuffleModeEnabled(bool enabled) async {}
  Future<void> setAudioRepeatMode(AudioRepeatMode mode) async {}
  Future<void> reorderAudioQueue(List<ItemBaseModel> queue) async {}
  Future<void> skipToNext() async {}
  Future<void> skipToPrevious() async {}
  Future<Uint8List?> takeScreenshot();
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel);
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel);
  void applySubtitleSettings(SubtitleSettingsModel settings) {}

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
