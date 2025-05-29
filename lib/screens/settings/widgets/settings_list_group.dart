import 'package:flutter/material.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

List<Widget> settingsListGroup(BuildContext context, Widget label, List<Widget> children) {
  final radius = BorderRadius.circular(24);
  final color = Theme.of(context).colorScheme.surfaceContainerLow;
  return AdaptiveLayout.layoutModeOf(context) != LayoutMode.single
      ? [
          label,
          ...children,
        ]
      : [
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: radius.copyWith(
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
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
                margin: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: radius.copyWith(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: e != children.last ? Radius.zero : null,
                  bottomRight: e != children.last ? Radius.zero : null,
                )),
                child: e,
              );
            },
          )
        ];
}
