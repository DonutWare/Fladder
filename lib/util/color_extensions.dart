import 'package:flutter/material.dart';

import 'package:fladder/util/localization_helper.dart';

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
