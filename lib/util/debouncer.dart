import 'dart:async';
import 'package:material_ui/material_ui.dart';

class Debouncer {
  Debouncer(this.duration);
  final Duration duration;
  Timer? _timer;
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(duration, action);
  }
}
