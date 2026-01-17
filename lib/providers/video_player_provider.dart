import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';
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

  /// Flag to indicate if the current action is initiated by SyncPlay
  bool _syncPlayAction = false;

  /// Timestamp of last SyncPlay command execution (for cooldown)
  DateTime? _lastSyncPlayCommandTime;

  /// Cooldown period after SyncPlay command during which we don't auto-report ready
  static const _syncPlayCooldown = Duration(milliseconds: 500);

  /// Check if SyncPlay is active
  bool get _isSyncPlayActive => ref.read(isSyncPlayActiveProvider);

  /// Check if we're in the SyncPlay cooldown period
  bool get _inSyncPlayCooldown {
    if (_lastSyncPlayCommandTime == null) return false;
    return DateTime.now().difference(_lastSyncPlayCommandTime!) < _syncPlayCooldown;
  }

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

      // Register player callbacks with SyncPlay
      _registerSyncPlayCallbacks();
    });
  }

  /// Register player callbacks with SyncPlay controller
  void _registerSyncPlayCallbacks() {
    ref.read(syncPlayProvider.notifier).registerPlayer(
      onPlay: () async {
        _syncPlayAction = true;
        _lastSyncPlayCommandTime = DateTime.now();
        await state.play();
        _syncPlayAction = false;
      },
      onPause: () async {
        _syncPlayAction = true;
        _lastSyncPlayCommandTime = DateTime.now();
        await state.pause();
        _syncPlayAction = false;
      },
      onSeek: (positionTicks) async {
        _syncPlayAction = true;
        _lastSyncPlayCommandTime = DateTime.now();
        final position = Duration(microseconds: positionTicks ~/ 10);
        await state.seek(position);
        _syncPlayAction = false;
      },
      onStop: () async {
        _syncPlayAction = true;
        _lastSyncPlayCommandTime = DateTime.now();
        await state.stop();
        _syncPlayAction = false;
      },
      getPositionTicks: () {
        final position = playbackState.position;
        return secondsToTicks(position.inMilliseconds / 1000);
      },
      isPlaying: () => playbackState.playing,
      isBuffering: () => playbackState.buffering,
    );
  }

  Future<void> updateBuffering(bool event) async {
    final oldState = playbackState;
    if (oldState.buffering == event) return;

    mediaState.update((state) => state.copyWith(buffering: event));

    // Report buffering state to SyncPlay if active
    // Skip if we're in the cooldown period after a SyncPlay command to prevent feedback loops
    if (_isSyncPlayActive && !_syncPlayAction && !_inSyncPlayCooldown) {
      if (event) {
        // Started buffering
        ref.read(syncPlayProvider.notifier).reportBuffering();
      } else {
        // Finished buffering - ready
        ref.read(syncPlayProvider.notifier).reportReady();
      }
    }
  }

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

  // ============================================
  // User-initiated actions (go through SyncPlay if active)
  // ============================================

  /// User-initiated play - routes through SyncPlay if active
  Future<void> userPlay() async {
    if (_isSyncPlayActive) {
      final syncPlay = ref.read(syncPlayProvider.notifier);
      await syncPlay.requestUnpause();
      // Must report ready after unpause for server to broadcast play command
      await syncPlay.reportReady(isPlaying: true);
    } else {
      await state.play();
    }
  }

  /// User-initiated pause - routes through SyncPlay if active
  Future<void> userPause() async {
    if (_isSyncPlayActive) {
      await ref.read(syncPlayProvider.notifier).requestPause();
    } else {
      await state.pause();
    }
  }

  /// User-initiated seek - routes through SyncPlay if active
  Future<void> userSeek(Duration position) async {
    if (_isSyncPlayActive) {
      final positionTicks = secondsToTicks(position.inMilliseconds / 1000);
      await ref.read(syncPlayProvider.notifier).requestSeek(positionTicks);
    } else {
      // Remember if we were playing before seek
      final wasPlaying = playbackState.playing;
      await state.seek(position);
      // Resume playback if we were playing before (for native player consistency)
      if (wasPlaying && !playbackState.playing) {
        await state.play();
      }
    }
  }

  /// User-initiated play/pause toggle - routes through SyncPlay if active
  Future<void> userPlayOrPause() async {
    if (playbackState.playing) {
      await userPause();
    } else {
      await userPlay();
    }
  }
}
