import 'package:audio_service/audio_service.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/wrappers/players/base_player.dart';

AudioServiceConfig get audioServiceConfig => const AudioServiceConfig(
      androidNotificationChannelId: 'nl.jknaapen.fladder.channel.playback',
      androidNotificationChannelName: 'Video playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      rewindInterval: Duration(seconds: 10),
      fastForwardInterval: Duration(seconds: 15),
      androidNotificationChannelDescription: "Playback",
      androidShowNotificationBadge: true,
    );

abstract class MediaControlBase {
  Future<void> init();
  Future<void> setup(BasePlayer player);
  Future<void> seek(Duration position);
  Future<void> open(String url, bool play);
  Future<void> play();
  Future<void> fastForward();
  Future<void> rewind();
  Future<void> setSpeed(double speed);
  Future<void> setVolume(double speed);
  Future<void> pause();
  Future<void> stop();
  Future<void> playOrPause();
  Future<void> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel);
  Future<void> setAudioTrack(AudioStreamModel? subtitleTrack, PlaybackModel playbackModel);
}
