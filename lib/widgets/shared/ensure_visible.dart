import 'package:flutter/material.dart';

import 'package:fladder/util/focus_provider.dart';

extension EnsureVisibleHelper on BuildContext {
  Future<void> ensureVisible({
    Duration duration = const Duration(milliseconds: 300),
    double? alignment,
    Curve curve = Curves.fastOutSlowIn,
  }) {
    return Scrollable.ensureVisible(
      this,
      duration: duration,
      alignment: alignment ?? FocusProvider.focusPositionOf(this),
      curve: curve,
    );
  }
}
