import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/theme.dart';

class ThemeOverwrite extends ConsumerWidget {
  final ImageProvider? image;
  final Color? color;
  final Widget Function(BuildContext) child;
  const ThemeOverwrite({
    super.key,
    this.image,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deriveColorFromItem = ref.watch(clientSettingsProvider.select((value) => value.deriveColorsFromItem));
    if (!deriveColorFromItem) {
      return child(context);
    }

    ThemeData themeData(Color? color) {
      final schemeVariant = ref.watch(clientSettingsProvider.select((value) => value.schemeVariant));
      final newColorScheme = color != null
          ? ColorScheme.fromSeed(
              seedColor: color,
              brightness: Theme.brightnessOf(context),
              dynamicSchemeVariant: schemeVariant,
            )
          : null;
      final amoledBlack = ref.watch(clientSettingsProvider.select((value) => value.amoledBlack));
      final amoledOverwrite = amoledBlack ? Colors.black : null;

      return newColorScheme != null
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
    }

    if (image != null) {
      return FutureBuilder<Color?>(
        future: getDominantColor(image!),
        builder: (context, snapshot) {
          return Theme(
            data: themeData(snapshot.data),
            child: Builder(
              builder: (context) => child(context),
            ),
          );
        },
      );
    }

    return Theme(
      data: themeData(color),
      child: Builder(
        builder: (context) => child(context),
      ),
    );
  }
}
