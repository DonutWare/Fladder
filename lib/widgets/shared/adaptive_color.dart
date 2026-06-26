import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:material_color_utilities/material_color_utilities.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/themes_data.dart';

class AdaptiveColor extends ConsumerStatefulWidget {
  final Widget Function(ThemeData dark, ThemeData light) child;
  const AdaptiveColor({required this.child, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AdaptiveColorState();
}

class AdaptiveColorState extends ConsumerState<AdaptiveColor> with WidgetsBindingObserver {
  ColorScheme? _light;
  ColorScheme? _dark;

  CorePalette? _corePalette;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchColors();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchColors();
    }
  }

  Future<void> _fetchColors() async {
    try {
      final corePalette = await DynamicColorPlugin.getCorePalette();
      if (corePalette == _corePalette) {
        return;
      }
      _corePalette = corePalette;
      if (corePalette != null && mounted) {
        setState(() {
          _light = corePalette.toColorScheme(brightness: Brightness.light);
          _dark = corePalette.toColorScheme(brightness: Brightness.dark);
        });
        return;
      }
    } on PlatformException {
      if (kDebugMode) debugPrint('dynamic_color: Failed to obtain core palette.');
    }

    try {
      final accentColor = await DynamicColorPlugin.getAccentColor();
      if (accentColor != null && mounted) {
        setState(() {
          _light = ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.light);
          _dark = ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.dark);
        });
        return;
      }
    } on PlatformException {
      if (kDebugMode) debugPrint('dynamic_color: Failed to obtain accent color.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    final themeColor = ref.watch(clientSettingsProvider.select((value) => value.themeColor));
    final schemeVariant = ref.watch(clientSettingsProvider.select((value) => value.schemeVariant));

    final fallbackLight = FladderTheme.defaultScheme(Brightness.light);
    final fallbackDark = FladderTheme.defaultScheme(Brightness.dark);

    final baseLightTheme = themeColor == null
        ? FladderTheme.theme(_light ?? fallbackLight, schemeVariant)
        : FladderTheme.theme(themeColor.schemeLight, schemeVariant);

    final baseDarkTheme = themeColor == null
        ? FladderTheme.theme(_dark ?? fallbackDark, schemeVariant)
        : FladderTheme.theme(themeColor.schemeDark, schemeVariant);

    // Apply fonts
    final lightTheme = isLinux
        ? baseLightTheme
        : FladderTheme.applyChineseFontToTheme(lightTheme: baseLightTheme, darkTheme: baseDarkTheme);

    final darkTheme = isLinux ? baseDarkTheme : FladderTheme.applyChineseFontToDarkTheme(darkTheme: baseDarkTheme);

    return ThemesData(
      light: lightTheme,
      dark: darkTheme,
      child: widget.child(darkTheme, lightTheme),
    );
  }
}
