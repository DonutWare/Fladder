// ignore_for_file: implementation_imports, constant_identifier_names
import 'dart:async';

// This is a stub class that provides the same method signatures as the original
// implementation, ensuring web builds compile without requiring changes elsewhere.
class SMTCWindows {
  SMTCWindows({
    SMTCConfig? config,
    PlaybackTimeline? timeline,
    MusicMetadata? metadata,
    PlaybackStatus? status,
    bool? shuffleEnabled,
    RepeatMode? repeatMode,
    bool? enabled,
  });

  late final Stream<PressedButton> buttonPressStream;

  Future<void> updateConfig(SMTCConfig config) async {}

  Future<void> updateTimeline(PlaybackTimeline timeline) async {}

  Future<void> updateMetadata(MusicMetadata metadata) async {}

  Future<void> clearMetadata() async {}

  Future<void> dispose() async {}

  Future<void> disableSmtc() async {}

  Future<void> enableSmtc() async {}

  Future<void> setPlaybackStatus(PlaybackStatus status) async {}

  Future<void> setIsPlayEnabled(bool enabled) async {}

  Future<void> setIsPauseEnabled(bool enabled) async {}

  Future<void> setIsStopEnabled(bool enabled) async {}

  Future<void> setIsNextEnabled(bool enabled) async {}

  Future<void> setIsPrevEnabled(bool enabled) async {}

  Future<void> setIsFastForwardEnabled(bool enabled) async {}

  Future<void> setIsRewindEnabled(bool enabled) async {}

  Future<void> setTimeline(PlaybackTimeline timeline) async {}

  Future<void> setTitle(String title) async {}

  Future<void> setArtist(String artist) async {}

  Future<void> setAlbum(String album) async {}

  Future<void> setAlbumArtist(String albumArtist) async {}

  Future<void> setThumbnail(String thumbnail) async {}

  Future<void> setPosition(Duration position) async {}

  Future<void> setStartTime(Duration startTime) async {}

  Future<void> setEndTime(Duration endTime) async {}

  Future<void> setMaxSeekTime(Duration maxSeekTime) async {}

  Future<void> setMinSeekTime(Duration minSeekTime) async {}

  Future<void> setShuffleEnabled(bool enabled) async {}

  Future<void> setRepeatMode(RepeatMode repeatMode) async {}
}

class MusicMetadata {
  final String? title;
  final String? artist;
  final String? album;
  final String? albumArtist;
  final String? thumbnail;

  const MusicMetadata({
    this.title,
    this.artist,
    this.album,
    this.albumArtist,
    this.thumbnail,
  });
}

enum PlaybackStatus {
  Closed,
  Changing,
  Stopped,
  Playing,
  Paused,
}

enum PressedButton {
  play,
  pause,
  next,
  previous,
  fastForward,
  rewind,
  stop,
  record,
  channelUp,
  channelDown;

  static PressedButton fromString(String button) {
    switch (button) {
      case 'play':
        return PressedButton.play;
      case 'pause':
        return PressedButton.pause;
      case 'next':
        return PressedButton.next;
      case 'previous':
        return PressedButton.previous;
      case 'fast_forward':
        return PressedButton.fastForward;
      case 'rewind':
        return PressedButton.rewind;
      case 'stop':
        return PressedButton.stop;
      case 'record':
        return PressedButton.record;
      case 'channel_up':
        return PressedButton.channelUp;
      case 'channel_down':
        return PressedButton.channelDown;
      default:
        throw Exception('Unknown button: $button');
    }
  }
}

class PlaybackTimeline {
  final int startTimeMs;
  final int endTimeMs;
  final int positionMs;
  final int? minSeekTimeMs;
  final int? maxSeekTimeMs;

  const PlaybackTimeline({
    required this.startTimeMs,
    required this.endTimeMs,
    required this.positionMs,
    this.minSeekTimeMs,
    this.maxSeekTimeMs,
  });
}

class SMTCConfig {
  final bool playEnabled;
  final bool pauseEnabled;
  final bool stopEnabled;
  final bool nextEnabled;
  final bool prevEnabled;
  final bool fastForwardEnabled;
  final bool rewindEnabled;

  const SMTCConfig({
    required this.playEnabled,
    required this.pauseEnabled,
    required this.stopEnabled,
    required this.nextEnabled,
    required this.prevEnabled,
    required this.fastForwardEnabled,
    required this.rewindEnabled,
  });
}

enum RepeatMode {
  none,
  track,
  list;

  static RepeatMode fromString(String value) {
    switch (value) {
      case 'none':
        return none;
      case 'track':
        return track;
      case 'list':
        return list;
      default:
        throw Exception('Unknown repeat mode: $value');
    }
  }

  String get asString => toString().split('.').last;
}
