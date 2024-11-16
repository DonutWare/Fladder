import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart'
    if (dart.library.html) 'package:fladder/wrappers/media_control_wrapper_web.dart';

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

  void init() async {
    // state.dispose();
    state.init();
    for (final s in subscriptions) {
      s.cancel();
    }

    subscriptions.addAll(
      [
        state.player?.stream?.buffering
            .listen((event) => mediaState.update((state) => state.copyWith(buffering: event))),
        state.player?.stream?.buffer.listen((event) => mediaState.update((state) => state.copyWith(buffer: event))),
        state.player?.stream?.playing.listen((event) => updatePlaying(event)),
        state.player?.stream?.position.listen((event) => updatePosition(event)),
        state.player?.stream?.duration.listen((event) => mediaState.update((state) => state.copyWith(duration: event))),
      ].whereNotNull(),
    );
  }

  Future<void> updatePlaying(bool event) async {
    final player = state.player;
    if (player == null) return;
    mediaState.update((state) => state.copyWith(playing: event));
  }

  Future<void> updatePosition(Duration event) async {
    final player = state.player;
    if (player == null) return;
    if (state.player?.state.playing == false) return;

    final position = event;
    final lastPosition = ref.read(mediaPlaybackProvider.select((value) => value.lastPosition));
    final diff = (position.inMilliseconds - lastPosition.inMilliseconds).abs();

    if (diff > const Duration(seconds: 1, milliseconds: 500).inMilliseconds) {
      mediaState.update((value) => value.copyWith(
            position: event,
            playing: player.state.playing,
            duration: player.state.duration,
            lastPosition: position,
          ));
      ref.read(playBackModel)?.updatePlaybackPosition(position, player.state.playing, ref);
    } else {
      mediaState.update((value) => value.copyWith(
            position: event,
            playing: player.state.playing,
            duration: player.state.duration,
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
      await state.setVolume(ref.read(videoPlayerSettingsProvider).volume);
      await state.open(media.uri, false);
      await Future.delayed(const Duration(milliseconds: 125));
      state.player?.stream?.buffering.takeWhile((event) => event == true).listen(
        null,
        onDone: () async {
          final start = startPosition ?? await model.startDuration();
          if (start != null) {
            await state.seek(start);
          }
          newPlaybackModel = await newPlaybackModel?.setAudio(null, state);
          newPlaybackModel = await newPlaybackModel?.setSubtitle(null, state);
          ref.read(playBackModel.notifier).update((state) => newPlaybackModel);
          state.play();
        },
      );
      ref.read(playBackModel.notifier).update((state) => model);
      return true;
    }

    mediaState.update((state) => state.copyWith(errorPlaying: true));
    return false;
  }
}
