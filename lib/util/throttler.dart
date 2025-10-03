import 'package:flutter/material.dart';

class Throttler {
  final Duration duration;
  int? _lastActionTime;

  Throttler({required this.duration});

  bool canRun() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_lastActionTime == null || now - _lastActionTime! >= duration.inMilliseconds) {
      _lastActionTime = now;
      return true;
    }
    return false;
  }

  void run(VoidCallback action) {
    if (canRun()) {
      action();
    }
  }
}
