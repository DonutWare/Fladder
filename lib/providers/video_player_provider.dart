import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
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

  Future<void> init() async {
    await state.dispose();
    await state.init();

    for (final s in subscriptions) {
      s.cancel();
    }

    final subscription = state.stateStream.listen((value) {
      updateBuffering(value.buffering);
      updateBuffer(value.buffer);
      updatePlaying(value.playing);
      updatePosition(value.position);
      updateDuration(value.duration);
    });

    subscriptions.add(subscription);
  }

  Future<void> updateBuffering(bool event) async =>
      mediaState.update((state) => state.buffering == event ? state : state.copyWith(buffering: event));

  Future<void> updateBuffer(Duration buffer) async {
    mediaState.update(
      (state) => (state.buffer - buffer).inSeconds.abs() < 1
          ? state
          : state.copyWith(
              buffer: buffer,
            ),
    );
  }

  Future<void> updateDuration(Duration duration) async {
    mediaState.update((state) {
      return (state.duration - duration).inSeconds.abs() < 1
          ? state
          : state.copyWith(
              duration: duration,
            );
    });
  }

  Future<void> updatePlaying(bool event) async {
    final currentState = playbackState;
    if (!state.hasPlayer || currentState.playing == event) return;
    if (currentState.state == VideoPlayerState.disposed) return;
    mediaState.update(
      (state) => state.copyWith(playing: event),
    );
    ref.read(playBackModel)?.updatePlaybackPosition(currentState.position, currentState.playing, ref);
  }

  Future<void> updatePosition(Duration event) async {
    if (!state.hasPlayer) return;
    if (playbackState.playing == false) return;
    final currentState = playbackState;
    if (currentState.state == VideoPlayerState.disposed) return;
    final currentPosition = currentState.position;

    if ((currentPosition - event).inSeconds.abs() < 1) return;

    final position = event;

    final lastPosition = currentState.lastPosition;
    final diff = (position.inMilliseconds - lastPosition.inMilliseconds).abs();

    if (diff > const Duration(seconds: 10).inMilliseconds) {
      mediaState.update((value) => value.copyWith(
            position: event,
            lastPosition: position,
          ));
      ref.read(playBackModel)?.updatePlaybackPosition(position, playbackState.playing, ref);
    } else {
      mediaState.update((value) => value.copyWith(
            position: event,
          ));
    }
  }

  Future<bool> loadPlaybackItem(PlaybackModel model, Duration startPosition) async {
    ref.read(playBackModel)?.dispose();
    await state.stop();
    ref.read(playbackRateProvider.notifier).state = 1.0;

    final useMinimizedPlayer =
        model.item.type == FladderItemType.audio || model.mediaStreams?.videoStreams.isEmpty == true;

    mediaState.update((state) => state.copyWith(
          state: useMinimizedPlayer ? VideoPlayerState.minimized : VideoPlayerState.fullScreen,
          fullScreen: !useMinimizedPlayer,
          buffering: true,
          errorPlaying: false,
          skippedSegments: {},
        ));

    final media = model.media;
    PlaybackModel? newPlaybackModel = model;

    if (media != null) {
      ref.read(playBackModel.notifier).update((state) => newPlaybackModel);
      await state.loadVideo(model, startPosition, true);
      await state.setVolume(ref.read(videoPlayerSettingsProvider).volume);

      await state.setAudioTrack(null, model);
      await state.setSubtitleTrack(null, model);

      ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(
            state: useMinimizedPlayer ? VideoPlayerState.minimized : VideoPlayerState.fullScreen,
            buffering: true,
            errorPlaying: false,
            skippedSegments: {},
          ));

      await state.play();
      return true;
    }

    mediaState.update((state) => state.copyWith(errorPlaying: true));
    return false;
  }

  Future<bool> loadAudioPlaybackItem(
    PlaybackModel model,
    List<ItemBaseModel> queue,
    int currentIndex,
    Duration startPosition,
  ) async {
    ref.read(playBackModel.notifier).update((state) => model);
    ref.read(playbackRateProvider.notifier).state = 1.0;

    mediaState.update((state) => state.copyWith(
          state: VideoPlayerState.minimized,
          fullScreen: false,
          buffering: true,
          errorPlaying: false,
          skippedSegments: {},
          duration: model.item.overview.runTime ?? Duration.zero,
        ));

    await state.loadAudioQueue(
      queue,
      currentIndex,
      startPosition,
      true,
      (item) => state.buildAudioUrl(item),
    );
    await state.setVolume(ref.read(videoPlayerSettingsProvider).volume);

    mediaState.update((state) => state.copyWith(
          buffering: false,
          playing: true,
          position: startPosition,
          duration: model.item.overview.runTime ?? Duration.zero,
        ));
    return true;
  }

  PlaybackModel _updateQueueOnModel(PlaybackModel playbackModel, List<ItemBaseModel> queue) =>
      playbackModel.updateQueueModel(queue);

  Future<void> reorderAudioQueue(List<ItemBaseModel> queue) async {
    final playbackModel = ref.read(playBackModel);
    if (playbackModel == null) return;

    final currentIndex = queue.indexWhere((element) => element.id == playbackModel.item.id).clamp(0, queue.length - 1);
    final updatedModel = _updateQueueOnModel(playbackModel, queue);
    ref.read(playBackModel.notifier).update((state) => updatedModel);

    await loadAudioPlaybackItem(updatedModel, queue, currentIndex, ref.read(mediaPlaybackProvider).position);
  }

  Future<void> playAudioQueueItem(ItemBaseModel item) async {
    final playbackModel = ref.read(playBackModel);
    if (playbackModel == null) return;

    final queue = playbackModel.queue;
    final index = queue.indexWhere((element) => element.id == item.id).clamp(0, queue.length - 1);
    final updatedPlaybackModel = await ref.read(playbackModelHelper).createPlaybackModel(
          null,
          item,
          oldModel: playbackModel,
          libraryQueue: queue,
          showPlaybackOptions: false,
        );
    if (updatedPlaybackModel == null) return;

    ref.read(playBackModel.notifier).update((state) => updatedPlaybackModel);
    await loadAudioPlaybackItem(updatedPlaybackModel, queue, index, Duration.zero);
  }

  Future<void> openPlayer(BuildContext context) async => state.openPlayer(context);

  Future<bool> takeScreenshot() async {
    final syncPath = ref.read(clientSettingsProvider).syncPath;
    // Early return here if we don't have a set/valid path. Skips actually taking the screenshot
    // which would be discarded.
    if (syncPath == null) {
      return false;
    }

    final screenshotsPath = p.join(syncPath, "Screenshots");
    final screenshotBuf = await state.takeScreenshot();

    if (screenshotBuf != null) {
      final savePathDirectory = Directory(screenshotsPath);

      // Should we try to create the directory instead?
      if (!await savePathDirectory.exists()) {
        return false;
      }

      final fileExtension = "png";
      final paddingAmount = 3;

      int maxNumber = 0;

      await for (var file in savePathDirectory.list()) {
        final finalSegment = file.uri.pathSegments.last;

        if (file is File && p.extension(finalSegment) == ".$fileExtension") {
          final match = RegExp(r'(\d+)').firstMatch(finalSegment);

          if (match != null) {
            final fileNumber = int.parse(match.group(0)!);

            if (fileNumber > maxNumber) {
              maxNumber = fileNumber;
            }
          }
        }
      }

      maxNumber += 1;

      final maxNumberStr = maxNumber.toString().padLeft(paddingAmount, '0');
      final screenshotName = '$maxNumberStr.$fileExtension';
      final screenshotPath = p.join(screenshotsPath, screenshotName);

      final screenshotFile = File(screenshotPath);
      await screenshotFile.writeAsBytes(screenshotBuf);

      return true;
    }

    return false;
  }
}
