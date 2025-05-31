import 'package:flutter/material.dart';

List<Widget> settingsListGroup(BuildContext context, Widget label, List<Widget> children) {
  final radius = BorderRadius.circular(24);
  final radiusSmall = const Radius.circular(6);
  final color = Theme.of(context).colorScheme.surfaceContainer;
  return [
    Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: radius.copyWith(
          bottomLeft: radiusSmall,
          bottomRight: radiusSmall,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: label,
      ),
    ),
    ...children.map(
      (e) {
        return Card(
          elevation: 0,
          color: color,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          shape: RoundedRectangleBorder(
              borderRadius: radius.copyWith(
            topLeft: radiusSmall,
            topRight: radiusSmall,
            bottomLeft: e != children.last ? radiusSmall : null,
            bottomRight: e != children.last ? radiusSmall : null,
          )),
          child: e,
        );
      },
    )
  ];
}
