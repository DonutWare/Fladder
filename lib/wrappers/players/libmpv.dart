import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart' as mpv;
import 'package:media_kit_video/media_kit_video.dart' as video;
import 'package:media_kit_video/media_kit_video.dart' as controller;

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class Libmpv implements BasePlayer {
  mpv.Player? _player;
  controller.VideoController? _controller;

  @override
  Future<void> init(Ref ref) async {
    if (_player != null) {
      _player?.stop();
      _player?.dispose();
    }

    _player = mpv.Player(
      configuration: mpv.PlayerConfiguration(
        title: "nl.jknaapen.fladder",
        bufferSize: 64 * 1024 * 1024,
        libassAndroidFont: 'assets/fonts/mp-font.ttf',
        libass: !kIsWeb &&
            ref.read(
              videoPlayerSettingsProvider.select((value) => value.useLibass),
            ),
      ),
    );

    if (_player != null) {
      _controller = controller.VideoController(
        _player!,
        configuration: video.VideoControllerConfiguration(
          enableHardwareAcceleration: ref.read(
            videoPlayerSettingsProvider.select((value) => value.hardwareAccel),
          ),
        ),
      );

      state = PlayerState(
        _player!.state.playing,
        _player!.state.playing,
        _player!.state.position,
        _player!.state.duration,
        _player!.state.volume,
        _player!.state.rate,
        _player!.state.buffering,
        _player!.state.buffer,
      );

      stream = PlayerStream(
        _player!.stream.playing,
        _player!.stream.playing,
        _player!.stream.position,
        _player!.stream.duration,
        _player!.stream.volume,
        _player!.stream.rate,
        _player!.stream.buffering,
        _player!.stream.buffer,
      );

      stream?.bindToState(state);
    }

    if (_player?.platform is mpv.NativePlayer) {
      await (_player?.platform as dynamic).setProperty(
        'force-seekable',
        'yes',
      );
    }
  }

  @override
  Future<void> open(String url, bool play) async {
    log('Opening stream');
    return _player?.open(mpv.Media(url), play: play);
  }

  @override
  Future<void> fastForward() {
    throw UnimplementedError();
  }

  List<mpv.SubtitleTrack> get subTracks => _player?.state.tracks.subtitle ?? [];
  mpv.SubtitleTrack get subtitleTrack => _player?.state.track.subtitle ?? mpv.SubtitleTrack.no();

  List<mpv.AudioTrack> get audioTracks => _player?.state.tracks.audio ?? [];
  mpv.AudioTrack get audioTrack => _player?.state.track.audio ?? mpv.AudioTrack.no();

  @override
  Future<void> pause() async => _player?.pause();
  @override
  Future<void> play() async => _player?.play();
  @override
  Future<void> playOrPause() async => _player?.playOrPause();
  @override
  Future<void> rewind() {
    throw UnimplementedError();
  }

  @override
  Future<void> seek(Duration position) async => _player?.seek(position);

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async {
    final wantedAudioStream = model ??
        playbackModel.audioStreams
            ?.firstWhereOrNull((element) => element.index == playbackModel.mediaStreams?.defaultAudioStreamIndex);
    if (wantedAudioStream == null) return -1;
    if (wantedAudioStream.index == AudioStreamModel.no().index) {
      await _player?.setAudioTrack(mpv.AudioTrack.no());
    } else {
      final internalTracks = audioTracks.getRange(2, audioTracks.length).toList();
      final audioTrack =
          internalTracks.elementAtOrNull((playbackModel.audioStreams?.indexOf(wantedAudioStream) ?? -1) - 1);
      if (audioTrack != null) {
        await _player?.setAudioTrack(audioTrack);
      }
    }
    return wantedAudioStream.index;
  }

  @override
  Future<void> setSpeed(double speed) async => _player?.setRate(speed);

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async {
    if (_player == null) return -1;
    final wantedSubtitle = model ??
        playbackModel.subStreams
            ?.firstWhereOrNull((element) => element.index == playbackModel.mediaStreams?.defaultSubStreamIndex);
    if (wantedSubtitle == null) return -1;
    if (wantedSubtitle.index == SubStreamModel.no().index) {
      await _player?.setSubtitleTrack(mpv.SubtitleTrack.no());
    } else {
      final internalTrack = subTracks.getRange(2, subTracks.length).toList();
      final index = playbackModel.subStreams?.sublist(1).indexWhere((element) => element.id == wantedSubtitle.id);
      final subTrack = internalTrack.elementAtOrNull(index ?? -1);
      if (wantedSubtitle.isExternal && wantedSubtitle.url != null && subTrack == null) {
        await _player?.setSubtitleTrack(mpv.SubtitleTrack.uri(wantedSubtitle.url!));
      } else if (subTrack != null) {
        await _player?.setSubtitleTrack(subTrack);
      }
    }
    return wantedSubtitle.index;
  }

  @override
  Future<void> stop() async => _player?.stop();

  @override
  Widget? videoWidget(
    BuildContext context,
    Key key,
    BoxFit fit,
  ) =>
      _controller == null
          ? null
          : controller.Video(
              key: key,
              controller: _controller!,
              wakelock: true,
              fill: Colors.transparent,
              fit: fit,
              subtitleViewConfiguration: const controller.SubtitleViewConfiguration(visible: false),
              controls: controller.NoVideoControls,
            );

  @override
  late PlayerState state;

  @override
  PlayerStream? stream;

  @override
  Future<void> setVolume(double volume) async => _player?.setVolume(volume);
}
