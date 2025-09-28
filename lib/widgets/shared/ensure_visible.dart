import 'package:flutter/material.dart';

extension EnsureVisibleHelper on BuildContext {
  Future<void> ensureVisible({
    Duration duration = const Duration(milliseconds: 300),
    double? alignment,
    Curve curve = Curves.fastOutSlowIn,
  }) {
    return Scrollable.ensureVisible(
      this,
      duration: duration,
      alignment: alignment ?? 0.5,
      curve: curve,
    );
  }
}
