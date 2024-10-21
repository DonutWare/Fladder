import 'package:flutter/material.dart';

class FladderFonts {
  static TextTheme rubikTextTheme([TextTheme? textTheme]) {
    textTheme ??= ThemeData.light().textTheme;

    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.displayLarge?.fontSize,
        fontVariations: [
          const FontVariation('wght', 300),
        ],
      ),
      displayMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.displayMedium?.fontSize,
        fontVariations: [
          const FontVariation('wght', 400),
        ],
      ),
      displaySmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.displaySmall?.fontSize,
        fontVariations: [
          const FontVariation('wght', 500),
        ],
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.headlineLarge?.fontSize,
        fontVariations: [
          const FontVariation('wght', 600),
        ],
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.headlineMedium?.fontSize,
        fontVariations: [
          const FontVariation('wght', 700),
        ],
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.headlineSmall?.fontSize,
        fontVariations: [
          const FontVariation('wght', 800),
        ],
      ),
      titleLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.titleLarge?.fontSize,
        fontVariations: [
          const FontVariation('wght', 400),
        ],
      ),
      titleMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.titleMedium?.fontSize,
        fontVariations: [
          const FontVariation('wght', 500),
        ],
      ),
      titleSmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.titleSmall?.fontSize,
        fontVariations: [
          const FontVariation('wght', 600),
        ],
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.bodyLarge?.fontSize,
        fontVariations: [
          const FontVariation('wght', 400),
        ],
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.bodyMedium?.fontSize,
        fontVariations: [
          const FontVariation('wght', 500),
        ],
      ),
      bodySmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.bodySmall?.fontSize,
        fontVariations: [
          const FontVariation('wght', 400),
        ],
      ),
      labelLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.labelLarge?.fontSize,
        fontVariations: [
          const FontVariation('wght', 600),
        ],
      ),
      labelMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.labelMedium?.fontSize,
        fontVariations: [
          const FontVariation('wght', 500),
        ],
      ),
      labelSmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: textTheme.labelSmall?.fontSize,
        fontVariations: [
          const FontVariation('wght', 400),
        ],
      ),
    );
  }
}
