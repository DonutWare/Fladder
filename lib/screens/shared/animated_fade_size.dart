import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedFadeSize extends ConsumerWidget {
  final Duration duration;
  final Widget child;
  final Alignment alignment;
  const AnimatedFadeSize({
    this.duration = const Duration(milliseconds: 125),
    required this.child,
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSize(
      duration: duration,
      alignment: alignment,
      curve: Curves.easeInOutCubic,
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        child: child,
      ),
    );
  }
}
