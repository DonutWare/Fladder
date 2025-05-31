import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.98),
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: body,
          ),
        ),
      ],
    );
  }
}
