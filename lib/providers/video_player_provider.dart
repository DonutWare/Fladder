import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/util/debouncer.dart';
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

  final Debouncer debouncer = Debouncer(const Duration(milliseconds: 125));

  void init() async {
    debouncer.run(() async {
      await state.dispose();
      await state.init();

      for (final s in subscriptions) {
        s.cancel();
      }

      final subscription = state.stateStream?.listen((value) {
        updateBuffering(value.buffering);
        updateBuffer(value.buffer);
        updatePlaying(value.playing);
        updatePosition(value.position);
        updateDuration(value.duration);
      });

      if (subscription != null) {
        subscriptions.add(subscription);
      }
    });
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
    mediaState.update(
      (state) => state.copyWith(playing: event),
    );
    ref.read(playBackModel)?.updatePlaybackPosition(currentState.position, currentState.playing, ref);
  }

  Future<void> updatePosition(Duration event) async {
    if (!state.hasPlayer) return;
    if (playbackState.playing == false) return;
    final currentState = playbackState;
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
    await state.stop();
    mediaState.update((state) => state.copyWith(
          state: VideoPlayerState.fullScreen,
          buffering: true,
          errorPlaying: false,
          skippedSegments: {},
        ));

    final media = model.media;
    PlaybackModel? newPlaybackModel = model;

    if (media != null) {
      await state.loadVideo(model, startPosition, false);
      await state.setVolume(ref.read(videoPlayerSettingsProvider).volume);
      state.stateStream?.takeWhile((event) => event.buffering == true).listen(
        null,
        onDone: () async {
          final start = startPosition;
          if (start != Duration.zero) {
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
