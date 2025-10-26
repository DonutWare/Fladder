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
class SimpleItemModel {
  final String id;
  final String title;
  final String? subTitle;
  final String? overview;
  final String? logoUrl;
  final String primaryPoster;

  const SimpleItemModel({
    required this.id,
    required this.title,
    this.subTitle,
    this.overview,
    this.logoUrl,
    required this.primaryPoster,
  });
}

enum PlaybackType {
  direct,
  transcoded,
  offline,
}

class MediaInfo {
  final PlaybackType playbackType;
  final String videoInformation;

  const MediaInfo({
    required this.playbackType,
    required this.videoInformation,
  });
}

class PlayableData {
  final SimpleItemModel currentItem;
  final String description;
  final int startPosition;
  final int defaultAudioTrack;
  final List<AudioTrack> audioTracks;
  final int defaultSubtrack;
  final List<SubtitleTrack> subtitleTracks;
  final TrickPlayModel? trickPlayModel;
  final List<Chapter> chapters;
  final List<MediaSegment> segments;
  final SimpleItemModel? previousVideo;
  final SimpleItemModel? nextVideo;
  final MediaInfo mediaInfo;
  final String url;

  PlayableData({
    required this.currentItem,
    required this.description,
    required this.startPosition,
    required this.defaultAudioTrack,
    this.audioTracks = const [],
    required this.defaultSubtrack,
    this.subtitleTracks = const [],
    this.trickPlayModel,
    this.chapters = const [],
    this.segments = const [],
    this.previousVideo,
    this.nextVideo,
    required this.mediaInfo,
    required this.url,
  });
}

enum MediaSegmentType {
  commercial,
  preview,
  recap,
  intro,
  outro,
}

class MediaSegment {
  final MediaSegmentType type;
  final String name;
  final int start;
  final int end;

  const MediaSegment({
    required this.type,
    required this.name,
    required this.start,
    required this.end,
  });
}

class AudioTrack {
  final String name;
  final String languageCode;
  final String codec;
  final int index;
  final bool external;
  final String? url;

  const AudioTrack({
    required this.name,
    required this.languageCode,
    required this.codec,
    required this.index,
    required this.external,
    required this.url,
  });
}

class SubtitleTrack {
  final String name;
  final String languageCode;
  final String codec;
  final int index;
  final bool external;
  final String? url;

  const SubtitleTrack({
    required this.name,
    required this.languageCode,
    required this.codec,
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
  @async
  StartResult launchActivity();
  void disposeActivity();

  bool isLeanBackEnabled();
}

@HostApi()
abstract class VideoPlayerApi {
  @async
  bool sendPlayableModel(PlayableData playableData);

  @async
  bool open(String url, bool play);

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
  //Milliseconds
  final int duration;
  final bool playing;
  final bool buffering;
  final bool completed;
  final bool failed;

  const PlaybackState({
    required this.position,
    required this.buffered,
    required this.duration,
    required this.playing,
    required this.buffering,
    required this.completed,
    required this.failed,
  });
}

@FlutterApi()
abstract class VideoPlayerListenerCallback {
  void onPlaybackStateChanged(PlaybackState state);
}

@FlutterApi()
abstract class VideoPlayerControlsCallback {
  void loadNextVideo();
  void loadPreviousVideo();
  void onStop();
  void swapSubtitleTrack(int value);
  void swapAudioTrack(int value);
}
