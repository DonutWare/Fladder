import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/theme.dart';

class StatusCard extends ConsumerWidget {
  final Color? color;
  final Widget child;

  const StatusCard({this.color, required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        decoration: BoxDecoration(
          color: blendColors(
            Theme.of(context).colorScheme.surfaceContainer,
            blend: color,
          ),
          borderRadius: FladderTheme.smallShape.borderRadius,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}

Color blendColors(Color base, {Color? blend, double amount = 0.25}) {
  if (blend == null) return base;

  return Color.lerp(base, blend, amount) ?? base;
}
