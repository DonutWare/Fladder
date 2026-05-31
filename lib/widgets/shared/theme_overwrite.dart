import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/theme.dart';

class ThemeOverwrite extends ConsumerStatefulWidget {
  const ThemeOverwrite({
    super.key,
    this.image,
    this.color,
    required this.child,
  });

  final ImageProvider? image;
  final Color? color;
  final Widget Function(BuildContext) child;

  @override
  ConsumerState<ThemeOverwrite> createState() => _ThemeOverwriteState();
}

class _ThemeOverwriteState extends ConsumerState<ThemeOverwrite> {
  Color? _dominantColor;

  @override
  void initState() {
    super.initState();
    if (widget.image != null) _fetchColor(widget.image!);
  }

  @override
  void didUpdateWidget(ThemeOverwrite old) {
    super.didUpdateWidget(old);
    if (widget.image != old.image) {
      _dominantColor = null;
      if (widget.image != null) _fetchColor(widget.image!);
    }
  }

  Future<void> _fetchColor(ImageProvider image) async {
    final color = await getDominantColor(image);
    if (!mounted || widget.image != image) return;
    setState(() => _dominantColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final deriveColorFromItem = ref.watch(clientSettingsProvider.select((value) => value.deriveColorsFromItem));
    if (!deriveColorFromItem) return widget.child(context);

    final schemeVariant = ref.watch(clientSettingsProvider.select((value) => value.schemeVariant));
    final amoledBlack = ref.watch(clientSettingsProvider.select((value) => value.amoledBlack));
    final effectiveColor = widget.image != null ? _dominantColor : widget.color;
    final amoledOverwrite = amoledBlack ? Colors.black : null;

    final newColorScheme = effectiveColor != null
        ? ColorScheme.fromSeed(
            seedColor: effectiveColor,
            brightness: Theme.brightnessOf(context),
            dynamicSchemeVariant: schemeVariant,
          )
        : null;

    final themeData = newColorScheme != null
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
      child: Builder(builder: (context) => widget.child(context)),
    );
  }
}
