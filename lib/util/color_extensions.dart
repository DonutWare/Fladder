import 'package:flutter/material.dart';

import 'package:fladder/util/localization_helper.dart';

Color? colorFromJson(dynamic color) {
  if (color == null) return null;

  if (color is Map<String, dynamic>) {
    return Color.from(
      alpha: color['alpha'] ?? 1.0,
      red: color['red'] ?? 1.0,
      green: color['green'] ?? 1.0,
      blue: color['blue'] ?? 1.0,
    );
  }

  // Deprecated format (integer value)
  if (color is int) {
    return Color(color);
  }

  return null;
}

extension ColorExtensions on Color {
  Map<String, dynamic> get toMap {
    return {
      'alpha': a,
      'red': r,
      'green': g,
      'blue': b,
    };
  }
}

extension DynamicSchemeVariantExtension on DynamicSchemeVariant {
  String label(BuildContext context) => switch (this) {
        DynamicSchemeVariant.tonalSpot => context.localized.schemeSettingsTonalSpot,
        DynamicSchemeVariant.fidelity => context.localized.schemeSettingsFidelity,
        DynamicSchemeVariant.monochrome => context.localized.schemeSettingsMonochrome,
        DynamicSchemeVariant.neutral => context.localized.schemeSettingsNeutral,
        DynamicSchemeVariant.vibrant => context.localized.schemeSettingsVibrant,
        DynamicSchemeVariant.expressive => context.localized.schemeSettingsExpressive,
        DynamicSchemeVariant.content => context.localized.schemeSettingsContent,
        DynamicSchemeVariant.rainbow => context.localized.schemeSettingsRainbow,
        DynamicSchemeVariant.fruitSalad => context.localized.schemeSettingsFruitSalad,
      };
}
