import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

final mediaPlaybackProvider = StateProvider<MediaPlaybackModel>((ref) => MediaPlaybackModel());

final playBackModel = StateProvider<PlaybackModel?>((ref) => null);

final videoPlayerProvider = StateNotifierProvider<VideoPlayerNotifier, MediaControlsWrapper>((ref) {
  final videoPlayer = VideoPlayerNotifier(ref);
  videoPlayer.init();
  return videoPlayer;
});

class VideoPlayerNotifier extends StateNotifier<MediaControlsWrapper> {
  VideoPlayerNotifier(this.ref) : super(MediaControlsWrapper(ref: ref));

  final Ref ref;

  List<StreamSubscription> subscriptions = [];

  late final mediaState = ref.read(mediaPlaybackProvider.notifier);

  MediaPlaybackModel get playbackState => ref.read(mediaPlaybackProvider);

  void init() async {
    await state.dispose();
    await state.init();

    for (final s in subscriptions) {
      s.cancel();
    }

    final subscription = state.stateStream?.listen((value) {
      mediaState.update((state) => state.copyWith(buffering: value.buffering));
      mediaState.update((state) => state.copyWith(buffer: value.buffer));
      updatePlaying(value.playing);
      updatePosition(value.position);
      mediaState.update((state) => state.copyWith(duration: value.duration));
    });

    if (subscription != null) {
      subscriptions.add(subscription);
    }
  }

  Future<void> updatePlaying(bool event) async {
    if (!state.hasPlayer) return;
    mediaState.update((state) => state.copyWith(playing: event));
  }

  Future<void> updatePosition(Duration event) async {
    if (!state.hasPlayer) return;
    if (playbackState.playing == false) return;

    final position = event;
    final lastPosition = ref.read(mediaPlaybackProvider.select((value) => value.lastPosition));
    final diff = (position.inMilliseconds - lastPosition.inMilliseconds).abs();

    if (diff > const Duration(seconds: 1, milliseconds: 500).inMilliseconds) {
      mediaState.update((value) => value.copyWith(
            position: event,
            playing: playbackState.playing,
            duration: playbackState.duration,
            lastPosition: position,
          ));
      ref.read(playBackModel)?.updatePlaybackPosition(position, playbackState.playing, ref);
    } else {
      mediaState.update((value) => value.copyWith(
            position: event,
            playing: playbackState.playing,
            duration: playbackState.duration,
          ));
    }
  }

  Future<bool> loadPlaybackItem(PlaybackModel model, {Duration? startPosition}) async {
    await state.stop();
    mediaState
        .update((state) => state.copyWith(state: VideoPlayerState.fullScreen, buffering: true, errorPlaying: false));

    final media = model.media;
    PlaybackModel? newPlaybackModel = model;

    if (media != null) {
      await state.open(media.url, false);
      await state.setVolume(ref.read(videoPlayerSettingsProvider).volume);
      state.stateStream?.takeWhile((event) => event.buffering == true).listen(
        null,
        onDone: () async {
          final start = startPosition ?? await model.startDuration();
          if (start != null) {
            await state.seek(start);
          }
          await state.setAudioTrack(null, model);
          await state.setSubtitleTrack(null, model);
          state.play();
          ref.read(playBackModel.notifier).update((state) => newPlaybackModel);
        },
      );

      ref.read(playBackModel.notifier).update((state) => model);

      return true;
    }

    mediaState.update((state) => state.copyWith(errorPlaying: true));
    return false;
  }
}
