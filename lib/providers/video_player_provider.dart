import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/playback/playback_queue_state.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/syncplay/buffering_report_debouncer.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/src/video_player_helper.g.dart' show PlaybackChangeSource, SyncPlayCommandType;
import 'package:fladder/wrappers/media_control_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

final mediaPlaybackProvider = StateProvider<MediaPlaybackModel>((ref) => MediaPlaybackModel());

final playBackModel = StateProvider<PlaybackModel?>((ref) => null);

final isVideoPlayerRouteOpenProvider = StateProvider<bool>((ref) => false);

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

  bool _syncPlayAction = false;

  /// True while [loadPlaybackItem] loads media for a SyncPlay flow; the buffering listener must not
  /// auto-report then, because the load itself owes the server exactly one Ready.
  bool _isLoadingForSyncPlay = false;

  /// Cooldown period after SyncPlay command during which we don't auto-report ready
  static const _syncPlayCooldown = Duration(milliseconds: 500);

  /// Debounces spontaneous buffering before it is reported to the group; recreated on every [init].
  BufferingReportDebouncer? _bufferingDebouncer;

  /// Kept so a re-[init] does not stack native-overlay listeners.
  ProviderSubscription<SyncPlayState>? _syncPlayStateSubscription;
  SyncPlayCommandType _lastNativeOverlayType = SyncPlayCommandType.none;

  /// Bumped by everything that pauses or stops the player so a running [_playUntilPlaying] loop gives up.
  int _playGeneration = 0;

  bool get _isSyncPlayActive => ref.read(isSyncPlayActiveProvider);

  bool get _isReloading => ref.read(syncPlayProvider.select((s) => s.correctionState.playerIsBuffering));

  bool get _inSyncPlayCooldown {
    final lastCommandTime = ref.read(syncPlayProvider.select((s) => s.lastCommandTime));
    if (lastCommandTime == null) {
      return false;
    }
    return DateTime.now().toUtc().difference(lastCommandTime) < _syncPlayCooldown;
  }

  /// The wrapper's last frame, never the throttled provider copy (1 s steps, frozen while paused):
  /// SyncPlay reports must sit inside the server's 500 ms tolerance.
  Duration get _livePosition => state.lastState?.position ?? playbackState.position;

  /// The backend's real playing state: on media-kit the wrapper's `playing` flag is only the requested one.
  bool get _livePlaying => state.isPlayerPlaying;

  ProviderSubscription<VideoPlayerSettingsModel>? settingsChanged;
  @override
  void dispose() {
    settingsChanged?.close();
    super.dispose();
  }

  /// media-kit sometimes drops the first `play()` after a paused `open()` or a reload, and in a group the
  /// server's Unpause is the only thing that starts this device, so re-issue until the backend really plays.
  Future<void> _playUntilPlaying() async {
    final generation = ++_playGeneration;
    await state.play();
    for (var attempt = 0; attempt < 12; attempt++) {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      if (generation != _playGeneration || !state.hasPlayer || _livePlaying) {
        return;
      }
      await state.play();
    }
    developer.log('SyncPlay: player still not playing after repeated play() calls');
  }

  Future<void> init() async {
    _playGeneration++;
    await state.stop();
    await state.dispose();
    await state.init();

    for (final s in subscriptions) {
      s.cancel();
    }

    _bufferingDebouncer?.dispose();
    _bufferingDebouncer = BufferingReportDebouncer(
      onBuffering: () => ref.read(syncPlayProvider.notifier).reportBuffering(),
      onReady: () => ref.read(syncPlayProvider.notifier).reportReady(isPlaying: _livePlaying),
    );

    settingsChanged = ref.listen(
      videoPlayerSettingsProvider,
      (previous, next) {
        final currentItem = ref.read(playBackModel)?.item;
        if (currentItem != null) {
          state.applyReplayGain(
            currentItem,
            settings: next,
          );
        }
      },
    );

    final subscription = state.stateStream.listen((value) {
      // The native tag says which action the frame carries, so a seek that drops ExoPlayer into buffering
      // (playing -> false on the same frame) is never mistaken for a pause.
      switch (value.changeSource) {
        case PlaybackChangeSource.userPlayPause:
          if (value.playing != playbackState.playing) {
            if (value.playing) {
              userPlay();
            } else {
              userPause();
            }
          }
          break;
        case PlaybackChangeSource.userSeek:
          userSeek(value.position);
          break;
        case PlaybackChangeSource.syncplay:
        case PlaybackChangeSource.none:
        case null:
          break;
      }
      // Playing before buffering: the Ready sent when a stall ends must carry the current playing flag.
      updatePlaying(value.playing);
      updateBuffering(value.buffering);
      updateBuffer(value.buffer);
      updatePosition(value.position);
      updateDuration(value.duration);
    });

    subscriptions.add(subscription);

    _registerSyncPlayCallbacks();

    _setupSyncPlayStateListener();
  }

  void _setupSyncPlayStateListener() {
    _syncPlayStateSubscription?.close();
    _lastNativeOverlayType = SyncPlayCommandType.none;
    _syncPlayStateSubscription = ref.listen<SyncPlayState>(
      syncPlayProvider,
      (previous, next) => _forwardNativeOverlay(next),
    );
  }

  /// Pushed right before the native activity opens so it does not wait for the next state change.
  void refreshNativeOverlay() {
    _lastNativeOverlayType = SyncPlayCommandType.none;
    _forwardNativeOverlay(ref.read(syncPlayProvider), force: true);
  }

  /// Same resolution as the Flutter overlay, so the native activity shows the group's Waiting state too.
  void _forwardNativeOverlay(SyncPlayState syncState, {bool force = false}) {
    if (!state.isNativePlayerActive) {
      _lastNativeOverlayType = SyncPlayCommandType.none;
      return;
    }
    final type = switch (resolveSyncPlayOverlay(syncState)) {
      SyncPlayOverlay.command => _toSyncPlayCommandType(syncState.processingCommandType),
      SyncPlayOverlay.waiting => SyncPlayCommandType.waiting,
      SyncPlayOverlay.switching || SyncPlayOverlay.none => SyncPlayCommandType.none,
    };
    if (!force && type == _lastNativeOverlayType) {
      return;
    }
    _lastNativeOverlayType = type;
    state.updateSyncPlayCommandState(type != SyncPlayCommandType.none, type);
  }

  SyncPlayCommandType _toSyncPlayCommandType(SyncPlayCommand? commandType) {
    return switch (commandType) {
      SyncPlayCommand.pause => SyncPlayCommandType.pause,
      SyncPlayCommand.unpause => SyncPlayCommandType.unpause,
      SyncPlayCommand.seek => SyncPlayCommandType.seek,
      SyncPlayCommand.stop => SyncPlayCommandType.stop,
      null => SyncPlayCommandType.none,
    };
  }

  void setReloading(
    bool value, {
    bool reportToSyncPlay = true,
  }) {
    ref.read(syncPlayProvider.notifier).setPlayerBufferingState(value);
    if (value && _isSyncPlayActive && reportToSyncPlay) {
      ref.read(syncPlayProvider.notifier).reportBuffering();
    }
  }

  void _registerSyncPlayCallbacks() {
    ref.read(syncPlayProvider.notifier).registerPlayer(
          onPlay: () async {
            _syncPlayAction = true;
            ref.read(syncPlayProvider.notifier).markCommandExecuted();
            try {
              await _playUntilPlaying();
            } finally {
              _syncPlayAction = false;
            }
          },
          onPause: () async {
            _syncPlayAction = true;
            _playGeneration++;
            ref.read(syncPlayProvider.notifier).markCommandExecuted();
            await state.pause();
            _syncPlayAction = false;
          },
          onSeek: (positionTicks) async {
            _syncPlayAction = true;
            ref.read(syncPlayProvider.notifier).markCommandExecuted();
            final position = Duration(microseconds: positionTicks ~/ 10);
            await state.seek(position);
            _syncPlayAction = false;
          },
          onSeekRequested: (positionTicks) async {
            // Report buffering without forcing local buffering state, or the command handler can get stuck waiting.
            ref.read(syncPlayProvider.notifier).reportBuffering();
          },
          onStop: () async {
            // Group went idle: end playback and leave the player screen.
            _syncPlayAction = true;
            ref.read(syncPlayProvider.notifier).markCommandExecuted();
            await stopAndClosePlayer();
            ref.read(syncPlayProvider.notifier).resetCorrectionState(
                  reason: 'stop_command',
                );
            _syncPlayAction = false;
          },
          onSetSpeed: (speed) async {
            await state.setSpeed(speed);
          },
          getPositionTicks: () => secondsToTicks(_livePosition.inMilliseconds / 1000),
          isPlaying: () => _livePlaying,
          isBuffering: () => _isReloading || playbackState.buffering,
          // ExoPlayer supports setPlaybackSpeed; SpeedToSync avoids SkipToSync, which triggers STATE_BUFFERING
          // and amplifies into a post-Unpause buffer cycle on Android-TV.
          hasPlaybackRate: () => true,
        );
  }

  /// The command handler owns the Buffering/Ready exchange while a command is in flight.
  bool get _isSyncPlayCommandInFlight => ref.read(syncPlayProvider.select((s) => s.isProcessingCommand));

  Future<void> updateBuffering(bool event) async {
    final oldState = playbackState;
    if (oldState.buffering == event) {
      return;
    }

    mediaState.update((state) => state.copyWith(buffering: event));

    // A stall is only fed to the debouncer when nothing else owns the Buffering/Ready exchange; the end
    // of a stall is always fed. Read the reload flag before `setPlayerBufferingState` mutates the state.
    if (!_isSyncPlayActive) {
      _bufferingDebouncer?.reset();
      return;
    }
    final ownedElsewhere = _syncPlayAction || _inSyncPlayCooldown || _isReloading || _isSyncPlayCommandInFlight;
    ref.read(syncPlayProvider.notifier).setPlayerBufferingState(event);
    if (event) {
      if (!ownedElsewhere && !_isLoadingForSyncPlay) {
        _bufferingDebouncer?.update(true);
      }
    } else {
      _bufferingDebouncer?.update(false);
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
    if (currentState.state == VideoPlayerState.disposed) return;
    mediaState.update(
      (state) => state.copyWith(playing: event),
    );
    ref.read(playBackModel)?.updatePlaybackPosition(currentState.position, event, ref);
  }

  Future<void> updatePosition(Duration event) async {
    if (!state.hasPlayer) {
      return;
    }
    if (playbackState.playing == false) {
      return;
    }
    final currentState = playbackState;
    if (currentState.state == VideoPlayerState.disposed) return;

    // Every tick feeds drift estimation; the controller throttles the actual corrections.
    if (_isSyncPlayActive) {
      ref.read(syncPlayProvider.notifier).updatePlaybackDrift(
            currentPositionTicks: secondsToTicks(event.inMilliseconds / 1000),
            at: DateTime.now().toUtc(),
          );
    }

    final currentPosition = currentState.position;

    if ((currentPosition - event).inSeconds.abs() < 1) {
      return;
    }

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

  Future<bool> loadPlaybackItem(
    PlaybackModel model,
    Duration startPosition, {
    bool waitForSyncPlayCommand = true,
  }) async {
    // A play loop started for the previous item must not start the new one ahead of the group's Unpause.
    _playGeneration++;
    final oldPlaybackModel = ref.read(playBackModel);

    if (_isSyncPlayActive) {
      // Null the model before state.stop() so its delayed Playing/Stopped report is suppressed; media-kit's
      // open() replaces the media in place, so an in-route reload needs no explicit stop.
      ref.read(playBackModel.notifier).update((_) => null);
    }
    oldPlaybackModel?.dispose();

    _bufferingDebouncer?.reset();
    ref.read(syncPlayProvider.notifier).setPlayerBufferingState(true);

    final reportingForSyncPlay = _isSyncPlayActive && waitForSyncPlayCommand;
    // The local player is at 0 here, so pass the load position to the SyncPlay reports explicitly or the
    // server finds us outside its 500 ms tolerance and answers with a corrective Seek.
    final loadPositionTicks = startPosition.inMicroseconds * 10;
    if (reportingForSyncPlay) {
      _isLoadingForSyncPlay = true;
      ref.read(syncPlayProvider.notifier).reportBuffering(positionTicks: loadPositionTicks);
    }

    final useMinimizedPlayer =
        model.item.type == FladderItemType.audio || model.mediaStreams?.videoStreams.isEmpty == true;

    try {
      await state.stop();
      ref.read(playbackRateProvider.notifier).state = 1.0;
      mediaState.update((state) => state.copyWith(
            state: useMinimizedPlayer ? VideoPlayerState.minimized : VideoPlayerState.fullScreen,
            fullScreen: !useMinimizedPlayer,
            buffering: true,
            errorPlaying: false,
            skippedSegments: {},
          ));

      final media = model.media;
      PlaybackModel? newPlaybackModel = model;
      final effectiveStartPosition = await model.resolvedStartPosition(startPosition);

      if (media == null) {
        ref.read(syncPlayProvider.notifier).setPlayerBufferingState(false);
        mediaState.update((state) => state.copyWith(errorPlaying: true));
        if (reportingForSyncPlay) {
          unawaited(ref.read(syncPlayProvider.notifier).reportReady(
                isPlaying: false,
                positionTicks: loadPositionTicks,
              ));
        }
        return false;
      }

      // No auto-play during a SyncPlay load: the server's Unpause drives playback for the group.
      await state.loadVideo(model, effectiveStartPosition, !reportingForSyncPlay);
      await state.setVolume(ref.read(videoPlayerSettingsProvider).volume);

      await state.setAudioTrack(null, model);
      await state.setSubtitleTrack(null, model);
      ref.read(playBackModel.notifier).update((state) => newPlaybackModel);

      ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(
            state: useMinimizedPlayer ? VideoPlayerState.minimized : VideoPlayerState.fullScreen,
            buffering: true,
            errorPlaying: false,
            skippedSegments: {},
          ));

      if (!reportingForSyncPlay) {
        await state.play();
      } else {
        // Report the requested position with isPlaying=false: the server only corrects a paused client whose
        // position is off by more than 500 ms, which keeps keyframe-bound media inside the window.
        await ref.read(syncPlayProvider.notifier).reportReady(
              isPlaying: false,
              positionTicks: loadPositionTicks,
            );
      }
      return true;
    } catch (e, stackTrace) {
      ref.read(syncPlayProvider.notifier).setPlayerBufferingState(false);
      mediaState.update((state) => state.copyWith(errorPlaying: true, buffering: false));
      // Tell the group we recovered so the server doesn't keep everyone paused waiting on us.
      if (reportingForSyncPlay) {
        unawaited(ref.read(syncPlayProvider.notifier).reportReady(
              isPlaying: false,
              positionTicks: loadPositionTicks,
            ));
      }
      developer.log('loadPlaybackItem failed: $e\n$stackTrace');
      return false;
    } finally {
      _isLoadingForSyncPlay = false;
    }
  }

  Future<bool> loadAudioPlaybackItem(
    PlaybackModel model,
    List<ItemBaseModel> queue,
    int currentIndex,
    Duration startPosition,
  ) async {
    final currentPlayerState = ref.read(mediaPlaybackProvider).state;
    final keepFullScreenLayout = currentPlayerState == VideoPlayerState.fullScreen;
    final playbackSettings = ref.read(mediaPlaybackProvider);

    final initializedQueueState = PlaybackQueueState.fromQueue(
      queue,
      initialItemId: queue[currentIndex.clamp(0, queue.length - 1)].id,
      shuffleEnabled: playbackSettings.shuffleEnabled,
      repeatMode: playbackSettings.repeatMode,
    );
    final queuedModel = model.updatePlaybackQueue(initializedQueueState);
    _playGeneration++;
    final effectiveStartPosition = await queuedModel.resolvedStartPosition(startPosition);

    ref.read(playBackModel.notifier).update((state) => queuedModel);
    ref.read(playbackRateProvider.notifier).state = 1.0;

    mediaState.update((state) => state.copyWith(
          state: keepFullScreenLayout ? VideoPlayerState.fullScreen : VideoPlayerState.minimized,
          fullScreen: keepFullScreenLayout,
          buffering: true,
          errorPlaying: false,
          skippedSegments: {},
          duration: queuedModel.item.overview.runTime ?? Duration.zero,
        ));

    await state.loadAudioQueue(queue, currentIndex, effectiveStartPosition, true);
    await state.setVolume(ref.read(videoPlayerSettingsProvider).volume);

    mediaState.update((state) => state.copyWith(
          buffering: false,
          playing: true,
          position: effectiveStartPosition,
          duration: queuedModel.item.overview.runTime ?? Duration.zero,
        ));
    return true;
  }

  Future<void> reorderAudioQueueSection(
    AudioQueueSection section,
    int oldIndex,
    int newIndex,
  ) async {
    await state.reorderAudioQueueSection(section, oldIndex, newIndex);
  }

  Future<void> addToTemporaryQueue(List<ItemBaseModel> items) async {
    await state.addToTemporaryQueue(items);
  }

  Future<void> clearTemporaryQueue() async {
    state.clearTemporaryQueue();
  }

  Future<void> removeAudioQueueItem(ItemBaseModel item) async {
    await state.removeAudioQueueItem(item.id);
  }

  Future<void> removeAudioQueueSectionItem(
    AudioQueueSection section,
    int sectionIndex,
  ) async {
    await state.removeAudioQueueSectionItem(section, sectionIndex);
  }

  Future<void> playAudioQueueItem(ItemBaseModel item) async {
    if (ref.read(playBackModel) == null) return;
    await state.jumpToQueueItem(item);
  }

  Future<void> openPlayer(BuildContext context) async => state.openPlayer(context);

  /// Used by SyncPlay when the group ends, stops or removes us, so no dead player screen is left behind.
  Future<void> stopAndClosePlayer({bool closeRoute = true}) async {
    _playGeneration++;
    ref.read(isVideoPlayerRouteOpenProvider.notifier).state = false;
    _bufferingDebouncer?.reset();
    // stop() reads the model synchronously before its first await; its delayed report must not block us.
    unawaited(state.stop());
    ref.read(playBackModel.notifier).update((_) => null);
    if (closeRoute) {
      state.closePlayerRoute();
    }
  }

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

  // User-initiated actions (go through SyncPlay if active)

  Future<void> userPlay() async {
    if (_isSyncPlayActive) {
      // Request only: the server answers with a scheduled Unpause for the whole group.
      await ref.read(syncPlayProvider.notifier).requestUnpause();
    } else {
      await state.play();
    }
  }

  /// Pauses locally at once for responsiveness; the Pause command that follows aligns everyone.
  Future<void> userPause() async {
    if (_isSyncPlayActive) {
      _playGeneration++;
      _syncPlayAction = true;
      try {
        await state.pause();
      } finally {
        _syncPlayAction = false;
      }
      await ref.read(syncPlayProvider.notifier).requestPause();
    } else {
      await state.pause();
    }
  }

  /// In a group the seek is applied locally so the slider does not snap back, but the player stays paused:
  /// the server's Seek and the following Unpause resume playback (resuming here gave play-pause-play).
  Future<void> userSeek(Duration position) async {
    final wasPlaying = playbackState.playing;
    if (_isSyncPlayActive) {
      _playGeneration++;
      _syncPlayAction = true;
      try {
        await state.pause();
        await state.seek(position);
      } finally {
        _syncPlayAction = false;
      }
      final positionTicks = secondsToTicks(position.inMilliseconds / 1000);
      await ref.read(syncPlayProvider.notifier).requestSeek(positionTicks);
    } else {
      await state.seek(position);
      if (wasPlaying && !playbackState.playing) {
        await state.play();
      }
    }
  }

  /// In a group this halts group playback on this device (`SetIgnoreWait`); the caller pops the route.
  /// Local flags flip and the player stops before the request, so a slow server never keeps audio playing.
  Future<void> userStop() async {
    Future<void>? halt;
    if (_isSyncPlayActive) {
      halt = ref.read(syncPlayProvider.notifier).haltPlayback(stopLocalPlayer: false);
    }
    await stopAndClosePlayer(closeRoute: false);
    await halt;
  }

  Future<void> userPlayOrPause() async {
    if (playbackState.playing) {
      await userPause();
    } else {
      await userPlay();
    }
  }
}
