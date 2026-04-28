import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/theme.dart';

class ThemeOverwrite extends ConsumerWidget {
  final Color? color;
  final Widget Function(BuildContext) child;
  const ThemeOverwrite({
    super.key,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schemeVariant = ref.watch(clientSettingsProvider.select((value) => value.schemeVariant));
    final newColorScheme = color != null
        ? ColorScheme.fromSeed(
            seedColor: color!,
            brightness: Theme.brightnessOf(context),
            dynamicSchemeVariant: schemeVariant,
          )
        : null;
    final amoledBlack = ref.watch(clientSettingsProvider.select((value) => value.amoledBlack));
    final amoledOverwrite = amoledBlack ? Colors.black : null;

    final themeData =
        newColorScheme != null && ref.watch(clientSettingsProvider.select((value) => value.deriveColorsFromItem))
            ? FladderTheme.theme(newColorScheme, schemeVariant).copyWith(
                scaffoldBackgroundColor: amoledOverwrite,
                cardColor: amoledOverwrite,
                canvasColor: amoledOverwrite,
                colorScheme: newColorScheme.copyWith(
                  surface: amoledOverwrite,
                  surfaceContainerHighest: amoledOverwrite,
                  surfaceContainerLow: amoledOverwrite,
                ),
              )
            : Theme.of(context).copyWith(
                scaffoldBackgroundColor: amoledOverwrite,
                cardColor: amoledOverwrite,
                canvasColor: amoledOverwrite,
              );

    return Theme(
      data: themeData,
      child: Builder(
        builder: (context) => child(context),
      ),
    );
  }
}
