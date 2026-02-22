import 'package:fladder/src/video_player_helper.g.dart' show PlaybackChangeSource;

class PlayerState {
  bool playing;
  bool completed;
  Duration position;
  Duration duration;
  double volume;
  double rate;
  bool buffering;
  Duration buffer;

  /// Set when state came from native player (for SyncPlay: infer user actions from stream).
  PlaybackChangeSource? changeSource;

  PlayerState({
    this.playing = false,
    this.completed = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.volume = 100,
    this.rate = 1.0,
    this.buffering = true,
    this.buffer = Duration.zero,
    this.changeSource,
  });

  PlayerState update({
    bool? playing,
    bool? completed,
    bool? buffering,
    Duration? position,
    Duration? duration,
    double? volume,
    double? rate,
    Duration? buffer,
    PlaybackChangeSource? changeSource,
    bool updateChangeSource = false,
  }) {
    if (playing != null) this.playing = playing;
    if (completed != null) this.completed = completed;
    if (buffering != null) this.buffering = buffering;
    if (position != null) this.position = position;
    if (duration != null) this.duration = duration;
    if (volume != null) this.volume = volume;
    if (rate != null) this.rate = rate;
    if (buffer != null) this.buffer = buffer;
    if (updateChangeSource) this.changeSource = changeSource;
    return this;
  }
}

class PlayerStream {
  final Stream<bool> playing;
  final Stream<bool> completed;
  final Stream<Duration> position;
  final Stream<Duration> duration;
  final Stream<double> volume;
  final Stream<double> rate;
  final Stream<bool> buffering;
  final Stream<Duration> buffer;

  const PlayerStream(
    this.playing,
    this.completed,
    this.position,
    this.duration,
    this.volume,
    this.rate,
    this.buffering,
    this.buffer,
  );

  void bindToState(PlayerState state) {
    playing.listen((value) => state.update(playing: value));
    buffering.listen((value) => state.update(buffering: value));
    position.listen((value) => state.update(position: value));
    duration.listen((value) => state.update(duration: value));
    volume.listen((value) => state.update(volume: value));
    rate.listen((value) => state.update(rate: value));
    buffer.listen((value) => state.update(buffer: value));
  }
}
