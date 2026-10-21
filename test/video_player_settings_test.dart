import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('older settings default refresh rate switching and ambient blur to off', () {
    final settings = VideoPlayerSettingsModel.fromJson({});

    expect(settings.refreshRateSwitching, isFalse);
    expect(settings.ambientBlur, isFalse);
  });

  test('refresh rate switching and ambient blur persist independently', () {
    for (final refreshRateSwitching in [false, true]) {
      for (final ambientBlur in [false, true]) {
        final settings = VideoPlayerSettingsModel(
          refreshRateSwitching: refreshRateSwitching,
          ambientBlur: ambientBlur,
        );
        final restored = VideoPlayerSettingsModel.fromJson(settings.toJson());

        expect(restored.refreshRateSwitching, refreshRateSwitching);
        expect(restored.ambientBlur, ambientBlur);
        expect(restored.copyWith(refreshRateSwitching: !refreshRateSwitching).ambientBlur, ambientBlur);
        expect(restored.copyWith(ambientBlur: !ambientBlur).refreshRateSwitching, refreshRateSwitching);
        expect(
            restored.copyWith(refreshRateSwitching: !refreshRateSwitching).refreshRateSwitching, !refreshRateSwitching);
        expect(restored.copyWith(ambientBlur: !ambientBlur).ambientBlur, !ambientBlur);
      }
    }
  });
}
