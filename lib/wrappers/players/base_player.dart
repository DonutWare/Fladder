import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/wrappers/players/player_states.dart';

const libassFallbackFont = "assets/mp-font.ttf";

/// Lets the full-screen player route be found and removed from the navigator (SyncPlay leave/kick/stop).
const String videoPlayerRouteName = 'fladder/video_player';

abstract class BasePlayer {
  Stream<PlayerState> get stateStream;
  PlayerState lastState = PlayerState();

  /// Whether the backend is really playing: on mpv [lastState.playing] only means "not paused by the user",
  /// so anything that must know whether a `play()` took reads this instead. media-kit overrides it.
  bool get isPlaying => lastState.playing;

  /// Route pushed by [open] for Flutter-rendered players; null for the native activity and once popped.
  Route<void>? playerRoute;

  Future<void> init(VideoPlayerSettingsModel settings);
  Widget? videoWidget(Key key, BoxFit fit);
  Widget? subtitles(bool showOverlay, {GlobalKey? controlsKey});
  Future<void> dispose();
  Future<void> open(BuildContext context);
  Future<void> loadVideo(String url, bool play, {Duration startPosition = Duration.zero});
  Future<void> seek(Duration position);
  Future<void> play();
  Future<void> setVolume(double volume);
  Future<void> setSpeed(double speed);
  Future<void> pause();
  Future<void> stop();
  Future<void> playOrPause();
  Future<void> loop(bool loop);
  Future<void> skipToNext() async {}
  Future<void> skipToPrevious() async {}
  Future<void> addToPlaylist(String url) async {}
  Future<void> removeFromPlaylist(int index) async {}
  Future<void> playerNext() async {}
  Future<void> playerPrevious() async {}
  Stream<int> get playlistIndexStream => const Stream<int>.empty();
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
