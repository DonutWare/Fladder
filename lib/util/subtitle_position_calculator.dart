import 'dart:math' as math;
import 'package:fladder/models/settings/subtitle_settings_model.dart';

class SubtitlePositionCalculator {
  static const double _fallbackMenuHeightPercentage = 0.15;
  static const double _dynamicSubtitlePadding =
      0.00; // Currently unused (0%). Reserved for future implementation of a user-adjustable slider to control subtitle positioning
  // relative to the player menu
  static const double _fallbackSubtitlePadding = 0.01; // 1% padding for conservative fallback positioning
  static const double _maxSubtitleOffset = 0.85;

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
      menuHeightPercentage = menuHeight / screenHeight;
      subtitlePadding = _dynamicSubtitlePadding;
    } else {
      menuHeightPercentage = _fallbackMenuHeightPercentage;
      subtitlePadding = _fallbackSubtitlePadding;
    }

    final minSafeOffset = menuHeightPercentage + subtitlePadding;

    if (settings.verticalOffset >= minSafeOffset) {
      return math.min(settings.verticalOffset, _maxSubtitleOffset);
    }

    return math.max(0.0, math.min(minSafeOffset, _maxSubtitleOffset));
  }
}
