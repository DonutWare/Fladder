import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:audio_service/audio_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smtc_windows/smtc_windows.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/wrappers/media_control_base.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/libmpv.dart';

class MediaControlsWrapper extends BaseAudioHandler implements MediaControlBase {
  MediaControlsWrapper({required this.ref});

  BasePlayer? player;

  final Ref ref;

  List<StreamSubscription> subscriptions = [];
  SMTCWindows? smtc;

  bool initMediaControls = false;

  @override
  Future<void> init() async {
    if (!initMediaControls && !kDebugMode) {
      await AudioService.init(
        builder: () => this,
        config: audioServiceConfig,
      );
      initMediaControls = true;
    }

    setup(Libmpv());
  }

  @override
  Future<void> setup(BasePlayer newPlayer) async {
    player = newPlayer;
    await newPlayer.init(ref);
    _initPlayer();
  }

  void _initPlayer() {
    for (var element in subscriptions) {
      element.cancel();
    }
    stop();
    _subscribePlayer();
  }

  @override
  Future<void> open(String url, bool play) async => player?.open(url, play);

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
      player?.stream?.buffer.listen((buffer) {
        playbackState.add(playbackState.value.copyWith(
          bufferedPosition: buffer,
        ));
      }),
      player?.stream?.buffering.listen((buffering) {
        playbackState.add(playbackState.value.copyWith(
          processingState: buffering ? AudioProcessingState.buffering : AudioProcessingState.ready,
        ));
      }),
      player?.stream?.position.listen((position) {
        playbackState.add(playbackState.value.copyWith(
          updatePosition: position,
        ));
        smtc?.setPosition(position);
      }),
      player?.stream?.playing.listen((playing) {
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
    super.stop();
    player?.stop();

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
  Future<void> playOrPause() async {
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

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async =>
      await player?.setAudioTrack(model, playbackModel) ?? -1;

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async =>
      await player?.setSubtitleTrack(model, playbackModel) ?? -1;

  @override
  Future<void> setVolume(double speed) async => player?.setVolume(speed);

  @override
  Future<void> seek(Duration position) {
    player?.seek(position);
    return super.seek(position);
  }

  @override
  Future<void> setSpeed(double speed) {
    player?.setSpeed(speed);
    return super.setSpeed(speed);
  }
}
