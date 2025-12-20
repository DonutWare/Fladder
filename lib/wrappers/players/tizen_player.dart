import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/screens/video_player/video_player.dart' as video_screen;
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class TizenPlayer extends BasePlayer {
  VideoPlayerController? _controller;
  bool externalSubEnabled = false;

  final StreamController<PlayerState> _stateController = StreamController.broadcast();

  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

  @override
  Future<void> init(VideoPlayerSettingsModel settings) async {
    await dispose();
  }

  @override
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }

  @override
  Future<void> loadVideo(String url, bool play) async {
    await _controller?.dispose();

    final validUrl = Uri.tryParse(url)?.isAbsolute ?? false;
    _controller = validUrl
        ? VideoPlayerController.network(url)
        : VideoPlayerController.file(File(url));

    await _controller?.initialize();
    _controller?.addListener(_updateState);

    if (play) {
      await _controller?.play();
    }

    _updateState();
  }

  void _updateState() {
    if (_controller == null) return;

    final value = _controller!.value;
    _stateController.add(
      lastState.update(
        playing: value.isPlaying,
        completed: value.position >= (value.duration ?? Duration.zero),
        position: value.position,
        duration: value.duration ?? Duration.zero,
        volume: (value.volume) * 100,
        rate: value.playbackSpeed,
        buffering: value.isBuffering,
        buffer: _calculateBufferedDuration(value),
      ),
    );
  }

  Duration _calculateBufferedDuration(VideoPlayerValue value) {
    if (value.buffered.isEmpty) return Duration.zero;
    return value.buffered.fold(value.position, (total, range) => total + (range.end - range.start));
  }

  @override
  Future<void> open(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => const video_screen.VideoPlayer(),
      ),
    );
  }

  @override
  Future<void> pause() => _controller?.pause() ?? Future.value();

  @override
  Future<void> play() => _controller?.play() ?? Future.value();

  @override
  Future<void> playOrPause() async {
    if (_controller?.value.isPlaying ?? false) {
      await _controller?.pause();
    } else {
      await _controller?.play();
    }
  }

  @override
  Future<void> seek(Duration position) async => _controller?.seekTo(position);

  @override
  Future<void> stop() async => await _controller?.pause();

  @override
  Future<void> setVolume(double volume) async => _controller?.setVolume(volume / 100);

  @override
  Future<void> loop(bool loop) async => _controller?.setLooping(loop);

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async {
    // Not supported by video_player_tizen
    return model?.index ?? 0;
  }

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async {
    // External subtitles not supported by video_player_tizen
    return model?.index ?? 0;
  }

  @override
  Future<void> setSpeed(double speed) async => _controller?.setPlaybackSpeed(speed);

  @override
  Future<Uint8List?> takeScreenshot() async {
    // Not supported natively
    return null;
  }

  @override
  Widget? videoWidget(Key key, BoxFit fit) {
    if (_controller == null) return null;

    return Container(
      key: key,
      color: Colors.transparent,
      child: ValueListenableBuilder<VideoPlayerValue>(
        valueListenable: _controller!,
        builder: (context, value, child) {
          final aspectRatio = value.isInitialized ? value.aspectRatio : 16 / 9;
          return AspectRatio(
            aspectRatio: aspectRatio,
            child: VideoPlayer(_controller!),
          );
        },
      ),
    );
  }

  @override
  Widget? subtitles(bool showOverlay, {GlobalKey? controlsKey}) => null;
}
