import 'dart:math' as math;

import 'package:fladder/models/settings/subtitle_settings_model.dart';

class SubtitlePositionCalculator {
  static const double _fallbackMenuHeightPercentage = 0.15;
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

    if (menuHeight != null && screenHeight > 0) {
      menuHeightPercentage = menuHeight / screenHeight;
    } else {
      menuHeightPercentage = _fallbackMenuHeightPercentage;
    }

    final minSafeOffset = menuHeightPercentage;

    if (settings.verticalOffset >= minSafeOffset) {
      return math.min(settings.verticalOffset, _maxSubtitleOffset);
    }

    return math.max(0.0, math.min(minSafeOffset, _maxSubtitleOffset));
  }
}
