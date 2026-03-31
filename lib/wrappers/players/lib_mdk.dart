import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:fvp/fvp.dart' as fvp;
import 'package:fvp/mdk.dart';
import 'package:image/image.dart' as img;
import 'package:video_player/video_player.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/screens/video_player/video_player.dart' as video_screen;
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

    final advancedOptions = {
      'ffmpeg.enable.all': '1',
      'video.decoders': [
        'D3D11VA',
        'Metal',
        'NVDEC',
        'VAAPI',
        'VideoToolbox',
        'AMediaCodec',
        'FFmpeg',
      ],
      'videoout.hdr': 'yes',
      'videoout.hdr10_metadata': 'yes',
      'videoout.tone_mapping': 'hable', // (or 'mobius', 'reinhard')
      'videoout.tone_mapping.mode': 'auto',
      'videoout.color_space': 'auto',
      'videoout.color_transfer': 'auto',
    };

    fvp.registerWith(
      options: {
        'global': {'log': 'off'},
        'subtitleFontFile': libassFallbackFont,
        if (settings.enableAdvancedVideoOptions) ...advancedOptions,
      },
    );
  }

  @override
  Future<void> dispose() async {
    final oldController = _controller;
    _controller = null;
    oldController?.dispose();
  }

  @override
  Future<void> loadVideo(String url, bool play, {Duration startPosition = Duration.zero}) async {
    _controller?.dispose();

    final validUrl = isValidUrl(url);
    if (validUrl != null) {
      _controller = VideoPlayerController.networkUrl(validUrl);
    } else {
      _controller = VideoPlayerController.file(File(url));
    }

    await _controller?.initialize();
    _controller?.addListener(() => updateState());

    if (startPosition != Duration.zero) {
      await _controller?.seekTo(startPosition);
    }

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
  Future<void> open(BuildContext context) async => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => const video_screen.VideoPlayer(),
        ),
      );

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
  Future<Uint8List?> takeScreenshot() async {
    final snapshotData = await _controller?.snapshot();
    final videoCodec = _controller?.getMediaInfo()?.video?[0].codec;

    if (snapshotData != null && videoCodec != null) {
      final imgWidth = videoCodec.width;
      final imgHeight = videoCodec.height;
      final image = img.Image.fromBytes(
          width: imgWidth, height: imgHeight, bytes: snapshotData.buffer, numChannels: 4, order: img.ChannelOrder.rgba);

      return img.encodePng(image);
    } else {
      return null;
    }
  }

  @override
  Future<void> stop() async => dispose();

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
                        valueListenable: _controller ?? ValueNotifier(const VideoPlayerValue.uninitialized()),
                        builder: (context, value, child) {
                          final aspectRatio = value.isInitialized ? value.aspectRatio : 1.77;
                          final controller = _controller;
                          if (controller == null) return const SizedBox.shrink();
                          return SizedBox(
                            width: constraints.maxWidth,
                            child: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: VideoPlayer(controller),
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
  Widget? subtitles(bool showOverlay, {GlobalKey? controlsKey}) => null;

  @override
  void applySubtitleSettings(SubtitleSettingsModel settings) {
    final c = _controller;
    if (c == null) return;
    c.setProperty('subtitle.font.size', (settings.fontSize * 0.3).toStringAsFixed(1));
    c.setProperty('subtitle.font.bold', settings.fontWeight.value >= FontWeight.bold.value ? '1' : '0');
    c.setProperty('subtitle.color', _colorToMdkRgba(settings.color));
    c.setProperty('subtitle.color.outline', _colorToMdkRgba(settings.outlineColor));
    c.setProperty('subtitle.border', (settings.outlineSize / 2).toStringAsFixed(1));
    c.setProperty('subtitle.color.background', _colorToMdkRgba(settings.backGroundColor));
    c.setProperty('subtitle.alignment.y', '1');
    c.setProperty('subtitle.margin.y', (settings.verticalOffset * 200).round().toString());

    if (settings.backGroundColor.a > 0) {
      c.setProperty('subtitle.shadow', '-1.0');
      c.setProperty('subtitle.box', '1.0');
    } else {
      c.setProperty('subtitle.shadow', (settings.shadow * 3.0).toStringAsFixed(1));
      c.setProperty('subtitle.box', '-1.0');
    }
  }

  static String _colorToMdkRgba(Color c) {
    final r = (c.r * 255).round();
    final g = (c.g * 255).round();
    final b = (c.b * 255).round();
    final a = (c.a * 255).round();
    final rgba = (r << 24) | (g << 16) | (b << 8) | a;
    return '0x${rgba.toRadixString(16).padLeft(8, '0')}';
  }

  @override
  Future<void> setVolume(double volume) async => _controller?.setVolume(volume / 100);

  @override
  Future<void> loop(bool loop) async => _controller?.setLooping(loop);
}
