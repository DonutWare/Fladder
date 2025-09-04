import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/video_player_helper.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/app/src/main/kotlin/nl/jknaapen/fladder/api/VideoPlayerHelper.g.kt',
    kotlinOptions: KotlinOptions(),
    dartPackageName: 'nl_jknaapen_fladder.video',
  ),
)
class PlayableData {
  final String id;
  final String title;
  final String description;
  final int startPosition;
  final List<AudioTrack> audioTracks;
  final List<SubtitleTrack> subtitleTracks;
  final TrickPlayModel? trickPlayModel;
  final List<Chapter> chapters;
  final String url;

  PlayableData({
    required this.id,
    required this.title,
    required this.description,
    required this.startPosition,
    this.audioTracks = const [],
    this.subtitleTracks = const [],
    this.trickPlayModel,
    this.chapters = const [],
    required this.url,
  });
}

class AudioTrack {
  final String name;
  final int index;
  final bool external;
  final String? url;

  const AudioTrack({
    required this.name,
    required this.index,
    required this.external,
    required this.url,
  });
}

class SubtitleTrack {
  final String name;
  final int index;
  final bool external;
  final String? url;

  const SubtitleTrack({
    required this.name,
    required this.index,
    required this.external,
    required this.url,
  });
}

class Chapter {
  final String name;
  final String url;
  // Duration in milliseconds
  final int time;

  const Chapter({
    required this.name,
    required this.url,
    required this.time,
  });
}

class TrickPlayModel {
  final int width;
  final int height;
  final int tileWidth;
  final int tileHeight;
  final int thumbnailCount;
  //Duration in milliseconds
  final int interval;
  final List<String> images;

  const TrickPlayModel({
    required this.width,
    required this.height,
    required this.tileWidth,
    required this.tileHeight,
    required this.thumbnailCount,
    required this.interval,
    this.images = const [],
  });
}

class StartResult {
  String? resultValue;
}

@HostApi()
abstract class NativeVideoActivity {
  StartResult launchActivity() ;
  void disposeActivity();
}

@HostApi()
abstract class VideoPlayerApi {
  bool sendPlayableModel(PlayableData playableData);

  void setLooping(bool looping);

  /// Sets the volume, with 0.0 being muted and 1.0 being full volume.
  void setVolume(double volume);

  /// Sets the playback speed as a multiple of normal speed.
  void setPlaybackSpeed(double speed);

  void play();

  /// Pauses playback if the video is currently playing.
  void pause();

  /// Seeks to the given playback position, in milliseconds.
  void seekTo(int position);

  void stop();
}

class PlaybackState {
  //Milliseconds
  final int position;
  //Milliseconds
  final int buffered;
  final bool playing;
  final bool completed;
  final bool failed;

  const PlaybackState({
    required this.position,
    required this.buffered,
    required this.playing,
    required this.completed,
    required this.failed,
  });
}

@FlutterApi()
abstract class VideoPlayerListener {
  void onPlaybackStateChanged(PlaybackState state);
  void loadNextVideo();
  void loadPreviousVideo();

  void onStop();
}
