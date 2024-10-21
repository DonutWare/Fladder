import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';

import 'package:fladder/theme/fonts.dart';
import 'package:fladder/util/custom_color_themes.dart';

ColorScheme? generateDynamicColourSchemes(ColorScheme? theme) {
  if (theme == null) return null;
  var base = ColorScheme.fromSeed(seedColor: theme.primary, brightness: theme.brightness);

  var newScheme = _insertAdditionalColours(base);

  return newScheme.harmonized();
}

ColorScheme _insertAdditionalColours(ColorScheme scheme) => scheme.copyWith(
      surface: scheme.surface,
      surfaceDim: scheme.surfaceDim,
      surfaceBright: scheme.surfaceBright,
      surfaceContainerLowest: scheme.surfaceContainerLowest,
      surfaceContainerLow: scheme.surfaceContainerLow,
      surfaceContainer: scheme.surfaceContainer,
      surfaceContainerHigh: scheme.surfaceContainerHigh,
      surfaceContainerHighest: scheme.surfaceContainerHighest,
    );

class FladderTheme {
  static RoundedRectangleBorder get smallShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
  static RoundedRectangleBorder get defaultShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
  static RoundedRectangleBorder get largeShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

  static Color get darkBackgroundColor => const Color.fromARGB(255, 10, 10, 10);
  static Color get lightBackgroundColor => const Color.fromARGB(237, 255, 255, 255);

  static ThemeData theme(ColorScheme? colorScheme) {
    final ColorScheme? scheme = generateDynamicColourSchemes(colorScheme);

    final textTheme = FladderFonts.rubikTextTheme(
      const TextTheme(),
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      sliderTheme: SliderThemeData(
        trackHeight: 8,
        thumbColor: colorScheme?.onSurface,
      ),
      cardTheme: CardTheme(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: defaultShape,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme?.secondaryContainer,
        foregroundColor: scheme?.onSecondaryContainer,
        shape: defaultShape,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme?.secondary,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        dismissDirection: DismissDirection.horizontal,
      ),
      tooltipTheme: TooltipThemeData(
        textAlign: TextAlign.center,
        waitDuration: const Duration(milliseconds: 500),
        textStyle: TextStyle(
          color: scheme?.onSurface,
        ),
        decoration: BoxDecoration(
          borderRadius: defaultShape.borderRadius,
          color: scheme?.surface,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbIcon: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(Icons.check_rounded);
          }
          return null;
        }),
        trackOutlineWidth: const WidgetStatePropertyAll(1),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(defaultShape),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(),
      dialogTheme: DialogTheme(shape: defaultShape),
      scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(16),
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return colorScheme?.primary;
            }
            return null;
          })),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme?.surface,
      ),
      buttonTheme: ButtonThemeData(shape: defaultShape),
      chipTheme: ChipThemeData(
        side: BorderSide(width: 1, color: scheme?.onSurface.withOpacity(0.05) ?? Colors.white),
        shape: defaultShape,
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: defaultShape,
        color: scheme?.secondaryContainer,
        iconColor: scheme?.onSecondaryContainer,
        surfaceTintColor: scheme?.onSecondaryContainer,
      ),
      listTileTheme: ListTileThemeData(shape: defaultShape),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(shape: WidgetStatePropertyAll(defaultShape))),
      filledButtonTheme: FilledButtonThemeData(style: ButtonStyle(shape: WidgetStatePropertyAll(defaultShape))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle(shape: WidgetStatePropertyAll(defaultShape))),
      textTheme: textTheme.copyWith(
        titleMedium: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static ColorScheme defaultScheme(Brightness brightness) {
    return ColorScheme.fromSeed(seedColor: ColorThemes.fladder.color, brightness: brightness);
  }
}
