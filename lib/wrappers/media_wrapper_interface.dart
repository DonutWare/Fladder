import 'package:flutter/material.dart';

import 'package:audio_service/audio_service.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MediaPlayback extends BaseAudioHandler {
  Player? _player;
  VideoController? _controller;

  Player setPlayer(Player player) => _player = player;
  VideoController setController(VideoController controller) => _controller = controller;

  Future<void> setVolume(double volume) async => _player?.setVolume(volume);

  Future<void> setSubtitleTrack(SubtitleTrack track) async => _player?.setSubtitleTrack(track);
  List<SubtitleTrack> get subTracks => _player?.state.tracks.subtitle ?? [];
  SubtitleTrack get subtitleTrack => _player?.state.track.subtitle ?? SubtitleTrack.no();

  Future<void> setAudioTrack(AudioTrack track) async => _player?.setAudioTrack(track);
  List<AudioTrack> get audioTracks => _player?.state.tracks.audio ?? [];
  AudioTrack get audioTrack => _player?.state.track.audio ?? AudioTrack.no();

  Widget? widget(
    BuildContext context,
    Key key,
    BoxFit fit,
  ) =>
      _controller == null
          ? null
          : Video(
              key: key,
              controller: _controller!,
              wakelock: true,
              fill: Colors.transparent,
              fit: fit,
              subtitleViewConfiguration: const SubtitleViewConfiguration(visible: false),
              controls: NoVideoControls,
            );

  @override
  Future<void> seek(Duration position) async => _player?.seek(position);

  @override
  Future<void> play() async {
    await _player?.play();
    return super.play();
  }

  Future<void> open(
    Playable playable, {
    bool play = true,
  }) async {
    return _player?.open(playable, play: play);
  }

  @override
  Future<void> fastForward() async {
    if (_player != null) {
      await _player!.seek(_player!.state.position + const Duration(seconds: 30));
    }
    return super.fastForward();
  }

  @override
  Future<void> rewind() async {
    if (_player != null) {
      await _player?.seek(_player!.state.position - const Duration(seconds: 10));
    }
    return super.rewind();
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _player?.setRate(speed);
    return super.setSpeed(speed);
  }

  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));
    await _player?.pause();
    return super.pause();
  }

  @override
  Future<void> stop() {
    _player?.stop();
    return super.stop();
  }

  void dispose() => _player?.dispose();

  PlayerStream? get stream => _player?.stream;
}
