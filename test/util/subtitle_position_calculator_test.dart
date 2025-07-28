import 'package:flutter_test/flutter_test.dart';
import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/util/subtitle_position_calculator.dart';

void main() {
  group('SubtitlePositionCalculator', () {
    test('returns original offset when overlay is hidden', () {
      const settings = SubtitleSettingsModel(verticalOffset: 0.2);

      final result = SubtitlePositionCalculator.calculateOffset(
        settings: settings,
        showOverlay: false,
        screenHeight: 800,
        menuHeight: 120,
      );

      expect(result, equals(0.2));
    });

    test('uses dynamic menu height when available', () {
      const settings = SubtitleSettingsModel(verticalOffset: 0.1);

      final result = SubtitlePositionCalculator.calculateOffset(
        settings: settings,
        showOverlay: true,
        screenHeight: 800,
        menuHeight: 120, // 120/800 = 0.15 (15%)
      );

      // Should position at menu height + dynamic padding = (120/800) + (-0.03) = 0.12
      expect(result, closeTo(0.12, 0.001));
    });

    test('uses fallback when menu height unavailable', () {
      const settings = SubtitleSettingsModel(verticalOffset: 0.1);

      final result = SubtitlePositionCalculator.calculateOffset(
        settings: settings,
        showOverlay: true,
        screenHeight: 800,
        menuHeight: null,
      );

      // Should use fallback: 0.15 + 0.01 = 0.16
      expect(result, equals(0.16));
    });

    test('preserves user offset when already above menu', () {
      const settings = SubtitleSettingsModel(verticalOffset: 0.3);

      final result = SubtitlePositionCalculator.calculateOffset(
        settings: settings,
        showOverlay: true,
        screenHeight: 800,
        menuHeight: 120,
      );

      // Should keep original 0.3 since it's above menu area (0.12)
      expect(result, equals(0.3));
    });

    test('clamps to maximum offset', () {
      const settings = SubtitleSettingsModel(verticalOffset: 0.95);

      final result = SubtitlePositionCalculator.calculateOffset(
        settings: settings,
        showOverlay: true,
        screenHeight: 800,
        menuHeight: 600, // Large menu that would push subtitles too high
      );

      // Should clamp to max 0.85
      expect(result, equals(0.85));
    });

    test('handles zero screen height gracefully', () {
      const settings = SubtitleSettingsModel(verticalOffset: 0.1);

      final result = SubtitlePositionCalculator.calculateOffset(
        settings: settings,
        showOverlay: true,
        screenHeight: 0,
        menuHeight: 120,
      );

      // Should use fallback when screen height is invalid
      expect(result, equals(0.16));
    });

    test('clamps to minimum offset', () {
      const settings = SubtitleSettingsModel(verticalOffset: 0.05);

      final result = SubtitlePositionCalculator.calculateOffset(
        settings: settings,
        showOverlay: true,
        screenHeight: 800,
        menuHeight: 120,
      );

      // Should not go below 0.0
      expect(result, greaterThanOrEqualTo(0.0));
    });
  });
}
