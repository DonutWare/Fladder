import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/wrappers/media_control_base.dart';
import 'package:fladder/wrappers/players/base_player.dart';

class MediaControlsWrapper extends BaseAudioHandler implements MediaControlBase {
  MediaControlsWrapper({required this.ref});

  final Ref ref;

  List<StreamSubscription> subscriptions = [];

  @override
  Future<void> init() async {
    await AudioService.init(
      builder: () => this,
      config: audioServiceConfig,
    );
  }

  @override
  Future<void> setup(BasePlayer player) {
    throw UnimplementedError();
  }

  Player _initPlayer() {
    for (var element in subscriptions) {
      element.cancel();
    }

    stop();

    final newPlayer = Player(
      configuration: PlayerConfiguration(
        title: "nl.jknaapen.fladder",
        bufferSize: 64 * 1024 * 1024,
        libassAndroidFont: 'assets/fonts/mp-font.ttf',
        libass: ref.read(
          videoPlayerSettingsProvider.select((value) => value.useLibass),
        ),
      ),
    );
    _subscribePlayer();
    return newPlayer;
  }

  @override
  Future<void> open(
    String url,
    bool play,
  ) async {}

  Future<void> _subscribePlayer() async {
    // subscriptions.addAll([
    //   player?.stream.buffer.listen((buffer) {
    //     playbackState.add(playbackState.value.copyWith(
    //       bufferedPosition: buffer,
    //     ));
    //   }),
    //   player?.stream.buffering.listen((buffering) {
    //     playbackState.add(playbackState.value.copyWith(
    //       processingState: buffering ? AudioProcessingState.buffering : AudioProcessingState.ready,
    //     ));
    //   }),
    //   player?.stream.position.listen((position) {
    //     playbackState.add(playbackState.value.copyWith(
    //       updatePosition: position,
    //     ));
    //   }),
    //   player?.stream.playing.listen((playing) {
    //     playbackState.add(playbackState.value.copyWith(
    //       playing: playing,
    //     ));
    //   }),
    // ].whereNotNull());
  }

  @override
  Future<void> seek(Duration position);

  @override
  Future<void> play() async {
    if (!ref.read(clientSettingsProvider).enableMediaKeys) {
      // await player?.play();
      return super.play();
    }

    final playBackItem = ref.read(playBackModel.select((value) => value?.item));
    if (playBackItem == null) return;

    final poster = playBackItem.images?.firstOrNull;

    //Everything else setup
    mediaItem.add(MediaItem(
      id: playBackItem.id,
      title: playBackItem.title,
      artist: playBackItem.subText,
      rating: Rating.newHeartRating(playBackItem.userData.isFavourite),
      duration: playBackItem.overview.runTime ?? const Duration(seconds: 0),
      artUri: poster != null ? Uri.parse(poster.path) : null,
    ));
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [
        MediaControl.pause,
        MediaControl.stop,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.fastForward,
        MediaAction.setSpeed,
        MediaAction.rewind,
      },
      processingState: AudioProcessingState.ready,
    ));

    // await player?.play();
    return super.play();
  }

  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));
    // await player?.pause();
    return super.pause();
  }

  @override
  Future<void> stop() async {
    WakelockPlus.disable();
    // final position = player?.state.position;
    // final totalDuration = player?.state.duration;
    // await player?.stop();
    // ref.read(playBackModel)?.playbackStopped(position ?? Duration.zero, totalDuration, ref);
    // ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(position: Duration.zero));

    playbackState.add(
      playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.completed,
        controls: [],
      ),
    );
    return super.stop();
  }

  @override
  Future<void> playOrPause() async {
    // player?.playOrPause();
    // playbackState.add(playbackState.value.copyWith(
    //   playing: player?.state.playing ?? false,
    //   controls: [MediaControl.play],
    // ));
  }

  @override
  Future<void> setAudioTrack(AudioStreamModel? subtitleTrack, PlaybackModel playbackModel) {
    // TODO: implement setAudioTrack
    throw UnimplementedError();
  }

  @override
  Future<void> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) {
    // TODO: implement setSubtitleTrack
    throw UnimplementedError();
  }

  @override
  Future<void> setVolume(double speed) {
    // TODO: implement setVolume
    throw UnimplementedError();
  }
}
