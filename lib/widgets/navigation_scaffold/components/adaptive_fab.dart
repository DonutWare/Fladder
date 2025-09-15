import 'package:flutter/material.dart';

class AdaptiveFab {
  final BuildContext context;
  final String title;
  final Widget child;
  final Function() onPressed;
  final Key? key;
  AdaptiveFab({
    required this.context,
    this.title = '',
    required this.child,
    required this.onPressed,
    this.key,
  });

  FloatingActionButton get normal {
    return FloatingActionButton(
      key: key,
      onPressed: onPressed,
      tooltip: title,
      child: child,
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
