import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class NestedScaffold extends ConsumerWidget {
  final Widget body;
  final Widget? background;
  const NestedScaffold({
    required this.body,
    this.background,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        if (background != null) background!,
        Container(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.75),
          child: Padding(
            padding: EdgeInsets.only(
              left: AdaptiveLayout.of(context).sideBarWidth,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: body,
            ),
          ),
        ),
      ],
    );
  }
}
