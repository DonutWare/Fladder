import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';

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
    final backgroundOpacity = ref.watch(clientSettingsProvider.select((value) => value.backgroundImage.opacityValues));
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (background != null) background!,
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.surface.withValues(alpha: backgroundOpacity),
                Theme.of(context).colorScheme.surface.withValues(alpha: backgroundOpacity / 1.5),
              ],
            ),
          ),
          child: body,
        ),
      ],
    );
  }
}
