import 'dart:async';

/// A Buffering report pauses every participant, but libmpv/ExoPlayer flip their flag on every seek and
/// cache dip: stalls shorter than [threshold] never reach the server; a reported one gets exactly one [onReady].
class BufferingReportDebouncer {
  BufferingReportDebouncer({
    required this.onBuffering,
    required this.onReady,
    this.threshold = const Duration(seconds: 3),
  });

  final void Function() onBuffering;
  final void Function() onReady;
  final Duration threshold;

  Timer? _timer;
  bool _reported = false;

  /// True between a reported Buffering and its closing Ready.
  bool get isReported => _reported;

  /// True while a stall is being timed but has not been reported yet.
  bool get isPending => _timer?.isActive == true;

  void update(bool buffering) {
    if (buffering) {
      if (_reported || isPending) {
        return;
      }
      _timer = Timer(threshold, () {
        _timer = null;
        _reported = true;
        onBuffering();
      });
      return;
    }

    _timer?.cancel();
    _timer = null;
    if (_reported) {
      _reported = false;
      onReady();
    }
  }

  /// Forgets any pending or reported stall without emitting anything (media reload, player teardown).
  void reset() {
    _timer?.cancel();
    _timer = null;
    _reported = false;
  }

  void dispose() => reset();
}
