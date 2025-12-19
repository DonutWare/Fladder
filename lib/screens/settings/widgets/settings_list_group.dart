import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';

List<Widget> settingsListGroup(BuildContext context, Widget label, List<Widget> children) {
  return [
    SettingsListGroupTitle(label: label),
    ...children.map(
      (e) {
        return SettingsListChild(
          child: e,
          isLast: e == children.last,
        );
      },
    )
  ];
}

class SettingsListGroupTitle extends StatelessWidget {
  final Widget? label;
  const SettingsListGroupTitle({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(24);
    final radiusSmall = const Radius.circular(6);
    final color = Theme.of(context).colorScheme.surfaceContainerLow.harmonizeWith(Colors.red);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius.copyWith(
          bottomLeft: radiusSmall,
          bottomRight: radiusSmall,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: label,
      ),
    );
  }
}

class SettingsListChild extends StatelessWidget {
  final Widget child;
  final bool isLast;
  const SettingsListChild({required this.child, this.isLast = false, super.key});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(24);
    final radiusSmall = const Radius.circular(6);
    final color = Theme.of(context).colorScheme.surfaceContainerLow.harmonizeWith(Colors.red);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius.copyWith(
          topLeft: radiusSmall,
          topRight: radiusSmall,
          bottomLeft: isLast ? null : radiusSmall,
          bottomRight: isLast ? null : radiusSmall,
        ),
      ),
      child: child,
    );
  }
}
