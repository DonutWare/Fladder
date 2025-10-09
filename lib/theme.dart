import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';

import 'package:fladder/theme/fonts.dart';
import 'package:fladder/util/custom_color_themes.dart';

ColorScheme? generateDynamicColourSchemes(ColorScheme? theme, DynamicSchemeVariant dynamicSchemeVariant) {
  if (theme == null) return null;
  var base = ColorScheme.fromSeed(
    seedColor: theme.primary,
    dynamicSchemeVariant: dynamicSchemeVariant,
    brightness: theme.brightness,
  );

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
  static RoundedRectangleBorder get smallShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  static RoundedRectangleBorder get defaultShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
  static RoundedRectangleBorder get largeShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(32));

  static ThemeData theme(ColorScheme? colorScheme, DynamicSchemeVariant dynamicSchemeVariant) {
    final ColorScheme? scheme = generateDynamicColourSchemes(colorScheme, dynamicSchemeVariant);

    final buttonSides = WidgetStateProperty.resolveWith(
      (states) {
        return BorderSide(
          width: 3,
          color: scheme?.onPrimaryContainer.withValues(alpha: states.contains(WidgetState.focused) ? 1.0 : 0.0) ??
              Colors.transparent,
        );
      },
    );

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
      cardTheme: CardThemeData(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: smallShape,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: FladderTheme.defaultShape.borderRadius),
        collapsedShape: RoundedRectangleBorder(borderRadius: FladderTheme.defaultShape.borderRadius),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme?.secondaryContainer,
        foregroundColor: scheme?.onSecondaryContainer,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme?.secondary,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(borderRadius: FladderTheme.defaultShape.borderRadius),
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
      navigationBarTheme: const NavigationBarThemeData(),
      dialogTheme: DialogThemeData(shape: defaultShape),
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
        side: BorderSide(width: 1, color: scheme?.onSurface.withValues(alpha: 0.05) ?? Colors.white),
        shape: defaultShape,
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: defaultShape,
        color: scheme?.secondaryContainer,
        iconColor: scheme?.onSecondaryContainer,
        surfaceTintColor: scheme?.onSecondaryContainer,
      ),
      listTileTheme: ListTileThemeData(
        shape: defaultShape,
      ),
      dividerTheme: DividerThemeData(
        indent: 6,
        endIndent: 6,
        color: scheme?.onSurface.withAlpha(30),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.selected)) {
              return scheme?.primaryContainer;
            }
            return scheme?.surfaceContainer;
          }),
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8, horizontal: 12)),
          elevation: const WidgetStatePropertyAll(5),
          side: const WidgetStatePropertyAll(BorderSide.none),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(smallShape),
          side: buttonSides,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(smallShape),
          side: buttonSides,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(smallShape),
          side: buttonSides,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(smallShape),
          side: buttonSides,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(smallShape),
          side: buttonSides,
        ),
      ),
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
