import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fvp/fvp.dart' as fvp;
import 'package:fvp/mdk.dart';
import 'package:video_player/video_player.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class LibMDK extends BasePlayer {
  VideoPlayerController? _controller;
  late final player = Player();

  bool externalSubEnabled = false;

  final StreamController<PlayerState> _stateController = StreamController.broadcast();

  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

  @override
  Future<void> init(VideoPlayerSettingsModel settings) async {
    dispose();
    fvp.registerWith(options: {
      'global': {'log': 'off'},
      'subtitleFontFile': libassFallbackFont,
    });
  }

  @override
  Future<void> dispose() async {
    _controller?.dispose();
    _controller = null;
  }

  @override
  Future<void> open(String url, bool play) async {
    if (_controller != null) {
      _controller?.dispose();
    }
    final validUrl = isValidUrl(url);
    if (validUrl != null) {
      _controller = VideoPlayerController.networkUrl(validUrl);
    } else {
      _controller = VideoPlayerController.file(File(url));
    }

    await _controller?.initialize();
    _controller?.addListener(() => updateState());

    if (play) {
      await _controller?.play();
    }
    _controller?.setBufferRange(
      min: const Duration(seconds: 15).inMilliseconds,
      max: const Duration(seconds: 30).inMilliseconds,
    );
    return setState(lastState.update(
      buffering: true,
    ));
  }

  void setState(PlayerState state) {
    lastState = state;
    _stateController.add(state);
  }

  void updateState() {
    setState(lastState.update(
      playing: _controller?.value.isPlaying ?? false,
      completed: _controller?.value.isCompleted ?? false,
      position: _controller?.value.position ?? Duration.zero,
      duration: _controller?.value.duration ?? Duration.zero,
      volume: (_controller?.value.volume ?? 1.0) * 100,
      rate: _controller?.value.playbackSpeed ?? 1.0,
      buffering: _controller?.value.isBuffering ?? true,
      buffer: calculateBufferedDuration(_controller?.value),
    ));
  }

  Duration calculateBufferedDuration(VideoPlayerValue? value) {
    if (value == null) return Duration.zero;
    if (value.buffered.isEmpty) {
      return Duration.zero;
    }

    return value.buffered.fold(value.position, (total, range) {
      return (total + (range.end - range.start));
    });
  }

  @override
  Future<void> pause() async => _controller?.pause();
  @override
  Future<void> play() async => _controller?.play();
  @override
  Future<void> playOrPause() async => lastState.playing ? _controller?.pause() : _controller?.play();

  @override
  Future<void> seek(Duration position) async => _controller?.seekTo(position);

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async {
    final wantedAudioStream = model ?? playbackModel.defaultAudioStream;
    if (wantedAudioStream == AudioStreamModel.no() || wantedAudioStream == null) {
      _controller?.setAudioTracks([-1]);
      return -1;
    } else {
      final indexOf = playbackModel.audioStreams?.indexOf(wantedAudioStream);
      if (indexOf != null) {
        _controller?.setAudioTracks([indexOf - 1]);
      }
      return wantedAudioStream.index;
    }
  }

  @override
  Future<void> setSpeed(double speed) async => _controller?.setPlaybackSpeed(speed);

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async {
    final wantedSubtitle = model ?? playbackModel.defaultSubStream;
    if (wantedSubtitle == SubStreamModel.no()) {
      externalSubEnabled = false;
      _controller?.setSubtitleTracks([-1]);
      return -1;
    }
    if (wantedSubtitle != null) {
      if (wantedSubtitle.isExternal && wantedSubtitle.url != null) {
        externalSubEnabled = true;
        _controller?.setExternalSubtitle(wantedSubtitle.url!);
        return wantedSubtitle.index;
      } else {
        if (externalSubEnabled) {
          externalSubEnabled = false;
          _controller?.setExternalSubtitle("");
        }
        final indexOf = playbackModel.subStreams?.indexOf(wantedSubtitle);
        if (indexOf != null) {
          _controller?.setSubtitleTracks([indexOf - 1]);
        }
        return wantedSubtitle.index;
      }
    }
    return -1;
  }

  @override
  Future<void> stop() async => _controller?.dispose();

  @override
  Widget? videoWidget(
    Key key,
    BoxFit fit,
  ) =>
      _controller == null
          ? null
          : Container(
              key: key,
              color: Colors.transparent,
              child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                      fit: fit,
                      alignment: Alignment.center,
                      child: ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: _controller!,
                        builder: (context, value, child) {
                          final aspectRatio = value.isInitialized ? value.aspectRatio : 1.77;
                          return SizedBox(
                            width: constraints.maxWidth,
                            child: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: VideoPlayer(_controller!),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );

  @override
  Widget? subtitles(bool showOverlay) => null;

  @override
  Future<void> setVolume(double volume) async => _controller?.setVolume(volume / 100);

  @override
  Future<void> loop(bool loop) async => _controller?.setLooping(loop);
}
