import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/theme.dart';

class FlatButton extends ConsumerWidget {
  final Widget? child;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function()? onDoubleTap;
  final Function(TapDownDetails details)? onSecondaryTapDown;
  final BorderRadius? borderRadiusGeometry;
  final Color? splashColor;
  final double elevation;
  final Clip clipBehavior;
  const FlatButton({
    this.child,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onSecondaryTapDown,
    this.borderRadiusGeometry,
    this.splashColor,
    this.elevation = 0,
    this.clipBehavior = Clip.none,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child ?? Container(),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            clipBehavior: clipBehavior,
            borderRadius: borderRadiusGeometry ?? FladderTheme.defaultShape.borderRadius,
            elevation: 0,
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              onDoubleTap: onDoubleTap,
              onSecondaryTapDown: onSecondaryTapDown,
              borderRadius: borderRadiusGeometry ?? BorderRadius.circular(10),
              splashColor: splashColor ?? Theme.of(context).colorScheme.primary.withOpacity(0.5),
              splashFactory: InkSparkle.splashFactory,
            ),
          ),
        ),
      ],
    );
  }
}
