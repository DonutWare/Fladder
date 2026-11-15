import 'package:fladder/util/localization_helper.dart';
import 'package:material_ui/material_ui.dart';

extension ThemeModeExtension on ThemeMode {
  String label(BuildContext context) {
    return switch (this) {
      ThemeMode.light => context.localized.themeModeLight,
      ThemeMode.dark => context.localized.themeModeDark,
      ThemeMode.system => context.localized.themeModeSystem,
    };
  }
}
