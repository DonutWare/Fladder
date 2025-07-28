import 'dart:math' as math;
import 'package:fladder/models/settings/subtitle_settings_model.dart';

/// Utility class for calculating subtitle positioning based on menu overlay state
/// Provides utilities for calculating the optimal vertical position of subtitles
/// based on user settings and the visibility or size of the player menu overlay.
class SubtitlePositionCalculator {
  // Configuration constants
  static const double _fallbackMenuHeightPercentage = 0.15; // 15% fallback
  static const double _dynamicSubtitlePadding =
      -0.03; // -3% padding when we have accurate menu height so the subtitles are closer to the menu
  static const double _fallbackSubtitlePadding = 0.01; // 1% padding for conservative fallback positioning
  static const double _maxSubtitleOffset = 0.85; // Max 85% up from bottom

  /// Calculate subtitle offset using actual menu height when available
  ///
  /// Returns the optimal subtitle offset (0.0 to 1.0) where:
  /// - 0.0 = bottom of screen
  /// - 1.0 = top of screen
  ///
  /// Parameters:
  /// - [settings]: User's subtitle settings containing preferred vertical offset
  /// - [showOverlay]: Whether the player menu overlay is currently visible
  /// - [screenHeight]: Height of the screen in pixels
  /// - [menuHeight]: Optional actual height of the menu in pixels
  static double calculateOffset({
    required SubtitleSettingsModel settings,
    required bool showOverlay,
    required double screenHeight,
    double? menuHeight,
  }) {
    if (!showOverlay) {
      return settings.verticalOffset;
    }

    double menuHeightPercentage;
    double subtitlePadding;

    if (menuHeight != null && screenHeight > 0) {
      // Convert menu height from pixels to screen percentage
      menuHeightPercentage = menuHeight / screenHeight;
      // Use negative padding since we have accurate measurement - can position closer
      subtitlePadding = _dynamicSubtitlePadding;
    } else {
      // Fallback to static percentage when measurement unavailable
      menuHeightPercentage = _fallbackMenuHeightPercentage;
      // Use positive padding for safety since we're estimating
      subtitlePadding = _fallbackSubtitlePadding;
    }

    // Calculate the minimum safe position (menu height + appropriate padding)
    final minSafeOffset = menuHeightPercentage + subtitlePadding;

    // If subtitles are already positioned above the safe area, leave them alone
    // but still apply maximum bounds checking
    if (settings.verticalOffset >= minSafeOffset) {
      return math.min(settings.verticalOffset, _maxSubtitleOffset);
    }

    // Position subtitles just above the menu with bounds checking
    // Defensive: math.max(0.0, ...) ensures the offset is never negative,
    // which could happen if future changes allow negative menuHeight or padding.
    return math.max(0.0, math.min(minSafeOffset, _maxSubtitleOffset));
  }
}
