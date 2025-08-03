import 'package:flutter/material.dart';

class AnimatedVisibility extends StatelessWidget {
  final Widget? child;
  final bool visible;
  final double hiddenHeight;
  final Duration duration;
  const AnimatedVisibility(
      {required this.child,
      required this.visible,
      this.hiddenHeight = 16,
      this.duration = const Duration(milliseconds: 250),
      super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: duration,
      opacity: visible ? 1 : 0,
      child: IgnorePointer(
        ignoring: !visible,
        child: SizedBox(
          height: visible ? null : hiddenHeight,
          child: child,
        ),
      ),
    );
  }
}
