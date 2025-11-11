import 'package:flutter/material.dart';

class AdaptiveFab {
  final BuildContext context;
  final String title;
  final String? heroTag;
  final Widget child;
  final Function() onPressed;
  final Color? backgroundColor;
  final Key? key;
  AdaptiveFab({
    required this.context,
    this.title = '',
    this.heroTag,
    required this.child,
    required this.onPressed,
    this.key,
    this.backgroundColor,
  });

  Widget get normal {
    return Hero(
      tag: heroTag ?? UniqueKey(),
      child: IconButton.filledTonal(
        iconSize: 26,
        key: key,
        tooltip: title,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }

  Widget get extended {
    return AnimatedContainer(
      key: key,
      duration: const Duration(milliseconds: 250),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(16),
            backgroundColor: backgroundColor,
          ),
          child: Row(
            spacing: 16,
            children: [
              child,
              Flexible(child: Text(title)),
            ],
          ),
        ),
      ),
    );
  }
}
