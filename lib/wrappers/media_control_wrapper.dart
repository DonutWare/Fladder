import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:audio_service/audio_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:smtc_windows/smtc_windows.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/wrappers/media_control_base.dart';
import 'package:fladder/wrappers/media_wrapper_interface.dart';

class MediaControlsWrapper extends MediaPlayback implements MediaControlBase {
  MediaControlsWrapper({required this.ref});

  final Ref ref;

  List<StreamSubscription> subscriptions = [];
  SMTCWindows? smtc;

  @override
  Future<void> init() async {
    await AudioService.init(
      builder: () => this,
      config: audioServiceConfig,
    );
  }

  @override
  Player setup() => setPlayer(_initPlayer());

  Player _initPlayer() {
    for (var element in subscriptions) {
      element.cancel();
    }

    stop();

    player?.dispose();

    final newPlayer = Player(
      configuration: PlayerConfiguration(
        title: "nl.jknaapen.fladder",
        bufferSize: 64 * 1024 * 1024,
        libassAndroidFont: 'assets/fonts/mp-font.ttf',
        libass: !kIsWeb &&
            ref.read(
              videoPlayerSettingsProvider.select((value) => value.useLibass),
            ),
      ),
    );
    setPlayer(newPlayer);
    setController(VideoController(
      newPlayer,
      configuration: VideoControllerConfiguration(
        enableHardwareAcceleration: ref.read(
          videoPlayerSettingsProvider.select((value) => value.hardwareAccel),
        ),
      ),
    ));
    _subscribePlayer();
    return newPlayer;
  }

  void _subscribePlayer() {
    if (Platform.isWindows) {
      smtc = SMTCWindows(
        config: const SMTCConfig(
          fastForwardEnabled: true,
          nextEnabled: false,
          pauseEnabled: true,
          playEnabled: true,
          rewindEnabled: true,
          prevEnabled: false,
          stopEnabled: true,
        ),
      );

      if (smtc != null) {
        subscriptions.add(
          smtc!.buttonPressStream.listen((event) {
            switch (event) {
              case PressedButton.play:
                play();
                break;
              case PressedButton.pause:
                pause();
                break;
              case PressedButton.fastForward:
                fastForward();
                break;
              case PressedButton.rewind:
                rewind();
                break;
              case PressedButton.previous:
                break;
              case PressedButton.stop:
                stop();
                break;
              default:
                break;
            }
          }),
        );
      }
    }

    subscriptions.addAll([
      player?.stream.buffer.listen((buffer) {
        playbackState.add(playbackState.value.copyWith(
          bufferedPosition: buffer,
        ));
      }),
      player?.stream.buffering.listen((buffering) {
        playbackState.add(playbackState.value.copyWith(
          processingState: buffering ? AudioProcessingState.buffering : AudioProcessingState.ready,
        ));
      }),
      player?.stream.position.listen((position) {
        playbackState.add(playbackState.value.copyWith(
          updatePosition: position,
        ));
        smtc?.setPosition(position);
      }),
      player?.stream.playing.listen((playing) {
        if (playing) {
          WakelockPlus.enable();
        } else {
          WakelockPlus.disable();
        }
        playbackState.add(playbackState.value.copyWith(
          playing: playing,
        ));
        smtc?.setPlaybackStatus(playing ? PlaybackStatus.Playing : PlaybackStatus.Paused);
      }),
    ].whereNotNull());
  }

  @override
  Future<void> play() async {
    if (!ref.read(clientSettingsProvider).enableMediaKeys) {
      await player?.play();
      return super.play();
    }

    final playBackItem = ref.read(playBackModel.select((value) => value?.item));
    final currentPosition = await ref.read(playBackModel.select((value) => value?.startDuration()));
    final poster = playBackItem?.images?.firstOrNull;

    if (playBackItem == null) return;

    windowSMTCSetup(playBackItem, currentPosition ?? Duration.zero);

    //Everything else setup
    mediaItem.add(MediaItem(
      id: playBackItem.id,
      title: playBackItem.title,
      rating: Rating.newHeartRating(playBackItem.userData.isFavourite),
      duration: playBackItem.overview.runTime ?? const Duration(seconds: 0),
      artUri: poster != null ? Uri.parse(poster.path) : null,
    ));
    playbackState.add(PlaybackState(
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

    await player?.play();
    return super.play();
  }

  Future<void> windowSMTCSetup(ItemBaseModel playBackItem, Duration currentPosition) async {
    final poster = playBackItem.images?.firstOrNull;

    //Windows setup
    smtc?.updateMetadata(MusicMetadata(
      title: playBackItem.title,
      thumbnail: poster?.path,
    ));
    smtc?.updateTimeline(
      PlaybackTimeline(
        startTimeMs: currentPosition.inMilliseconds,
        endTimeMs: (playBackItem.overview.runTime ?? const Duration(seconds: 0)).inMilliseconds,
        positionMs: 0,
        minSeekTimeMs: 0,
        maxSeekTimeMs: (playBackItem.overview.runTime ?? const Duration(seconds: 0)).inMilliseconds,
      ),
    );

    smtc?.enableSmtc();
    smtc?.setPlaybackStatus(PlaybackStatus.Playing);
  }

  @override
  Future<void> stop() async {
    WakelockPlus.disable();
    final position = player?.state.position;
    final totalDuration = player?.state.duration;
    await player?.stop();
    ref.read(playBackModel)?.playbackStopped(position ?? Duration.zero, totalDuration, ref);
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(position: Duration.zero));
    smtc?.setPlaybackStatus(PlaybackStatus.Stopped);
    smtc?.clearMetadata();
    smtc?.disableSmtc();
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
  void playOrPause() async {
    await player?.playOrPause();
    playbackState.add(playbackState.value.copyWith(
      playing: player?.state.playing ?? false,
      controls: [MediaControl.play],
    ));
    final playerState = player;
    if (playerState != null) {
      ref.read(playBackModel)?.updatePlaybackPosition(playerState.state.position, playerState.state.playing, ref);
    }
  }
}
