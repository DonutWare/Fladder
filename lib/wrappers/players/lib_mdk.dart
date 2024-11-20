import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fvp/fvp.dart' as fvp;
import 'package:fvp/mdk.dart';
import 'package:video_player/video_player.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class LibMDK implements BasePlayer {
  VideoPlayerController? _controller;
  late final player = Player();

  bool externalSubEnabled = false;

  final StreamController<PlayerState> _stateController = StreamController.broadcast();
  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

  @override
  PlayerState lastState = PlayerState();

  @override
  Future<void> init(Ref ref) async {
    dispose();
    fvp.registerWith();
    updateState();
  }

  @override
  Future<void> dispose() async {
    _controller?.dispose();
    _controller = null;
  }

  @override
  Future<void> open(String url, bool play) async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _controller?.initialize();
    _controller?.addListener(() => updateState());
    if (play) {
      _controller?.play();
    }
  }

  void updateState() {
    final newState = PlayerState(
      playing: _controller?.value.isPlaying ?? false,
      completed: _controller?.value.isCompleted ?? false,
      position: _controller?.value.position ?? Duration.zero,
      duration: _controller?.value.duration ?? Duration.zero,
      volume: (_controller?.value.volume ?? 1.0) * 100,
      rate: _controller?.value.playbackSpeed ?? 1.0,
      buffering: _controller?.value.isBuffering ?? false,
      buffer: _controller?.value.buffered.last.end ?? Duration.zero,
    );
    _stateController.add(newState);
    lastState = newState;
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
    if (model == AudioStreamModel.no() || model == null) {
      _controller?.setAudioTracks([-1]);
      return -1;
    } else {
      final indexOf = playbackModel.audioStreams?.indexOf(model);
      if (indexOf != null) {
        _controller?.setAudioTracks([indexOf - 1]);
      }
      return model.index;
    }
  }

  @override
  Future<void> setSpeed(double speed) async => _controller?.setPlaybackSpeed(speed);

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async {
    if (model == SubStreamModel.no()) {
      externalSubEnabled = false;
      _controller?.setSubtitleTracks([-1]);
      return -1;
    }
    if (model != null) {
      if (model.isExternal && model.url != null) {
        externalSubEnabled = true;
        _controller?.setExternalSubtitle(model.url!);
        return model.index;
      } else {
        if (externalSubEnabled) {
          externalSubEnabled = false;
          _controller?.setExternalSubtitle("");
        }
        final indexOf = playbackModel.subStreams?.indexOf(model);
        if (indexOf != null) {
          _controller?.setSubtitleTracks([indexOf - 1]);
        }
        return model.index;
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
