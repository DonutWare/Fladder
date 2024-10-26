enum VideoPlayerState {
  minimized,
  fullScreen,
  disposed,
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
    );
  }
}
