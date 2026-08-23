enum VideoPlayerState {
  minimized,
  fullScreen,
  disposed,
}

enum AudioRepeatMode {
  off,
  all,
  one;

  const AudioRepeatMode();

  AudioRepeatMode get next => switch (this) {
        AudioRepeatMode.off => AudioRepeatMode.all,
        AudioRepeatMode.all => AudioRepeatMode.one,
        AudioRepeatMode.one => AudioRepeatMode.off,
      };
}

class MediaPlaybackModel {
  final VideoPlayerState state;
  final bool playing;
  final Duration position;
  final Duration lastPosition;
  final Duration duration;
  final Duration buffer;
  final bool completed;
  final bool errorPlaying;
  final bool buffering;
  final bool fullScreen;
  final bool queueRefilling;
  final bool shuffleEnabled;
  final AudioRepeatMode repeatMode;
  final Set<String> skippedSegments;
  MediaPlaybackModel({
    this.state = VideoPlayerState.disposed,
    this.playing = false,
    this.position = Duration.zero,
    this.lastPosition = Duration.zero,
    this.duration = Duration.zero,
    this.buffer = Duration.zero,
    this.completed = false,
    this.errorPlaying = false,
    this.buffering = false,
    this.fullScreen = false,
    this.queueRefilling = false,
    this.shuffleEnabled = false,
    this.repeatMode = AudioRepeatMode.off,
    this.skippedSegments = const {},
  });

  MediaPlaybackModel copyWith({
    VideoPlayerState? state,
    bool? playing,
    Duration? position,
    Duration? lastPosition,
    Duration? duration,
    Duration? buffer,
    bool? completed,
    bool? errorPlaying,
    bool? buffering,
    bool? fullScreen,
    bool? queueRefilling,
    bool? shuffleEnabled,
    AudioRepeatMode? repeatMode,
    Set<String>? skippedSegments,
  }) {
    return MediaPlaybackModel(
      state: state ?? this.state,
      playing: playing ?? this.playing,
      position: position ?? this.position,
      lastPosition: lastPosition ?? this.lastPosition,
      duration: duration ?? this.duration,
      buffer: buffer ?? this.buffer,
      completed: completed ?? this.completed,
      errorPlaying: errorPlaying ?? this.errorPlaying,
      buffering: buffering ?? this.buffering,
      fullScreen: fullScreen ?? this.fullScreen,
      queueRefilling: queueRefilling ?? this.queueRefilling,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
      repeatMode: repeatMode ?? this.repeatMode,
      skippedSegments: skippedSegments ?? this.skippedSegments,
    );
  }
}
