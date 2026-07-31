import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/shared_provider.dart';

void main() {
  group('playback-rate settings model', () {
    test('older persisted settings retain the existing behavior', () {
      final settings = VideoPlayerSettingsModel.fromJson(const {});

      expect(settings.rememberPlaybackRate, isFalse);
      expect(settings.defaultPlaybackRate, 1.0);
      expect(settings.lastPlaybackRate, isNull);
      expect(settings.effectivePlaybackRate, 1.0);
    });

    test('effective rate uses the default and then the last selected rate', () {
      final settings = VideoPlayerSettingsModel(
        rememberPlaybackRate: true,
        defaultPlaybackRate: 1.25,
      );

      expect(settings.effectivePlaybackRate, 1.25);
      expect(settings.copyWith(lastPlaybackRate: 1.75).effectivePlaybackRate, 1.75);
    });

    test('disabled persistence always resolves to the existing 1.0x default', () {
      final settings = VideoPlayerSettingsModel(
        defaultPlaybackRate: 1.5,
        lastPlaybackRate: 2.0,
      );

      expect(settings.effectivePlaybackRate, 1.0);
    });

    test('playback rates are clamped to the supported range', () {
      expect(clampPlaybackRate(0.1), 0.25);
      expect(clampPlaybackRate(1.5), 1.5);
      expect(clampPlaybackRate(4.0), 3.0);
    });
  });

  group('playback-rate settings notifier', () {
    late ProviderContainer container;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('default changes and disabling clear the remembered rate', () async {
      final notifier = container.read(videoPlayerSettingsProvider.notifier);

      notifier.setRememberPlaybackRate(true);
      await notifier.setPlaybackRate(2.0, applyToPlayer: false);
      expect(container.read(videoPlayerSettingsProvider).lastPlaybackRate, 2.0);

      notifier.setDefaultPlaybackRate(1.5);
      final changedDefault = container.read(videoPlayerSettingsProvider);
      expect(changedDefault.defaultPlaybackRate, 1.5);
      expect(changedDefault.lastPlaybackRate, isNull);

      await notifier.setPlaybackRate(2.5, applyToPlayer: false);
      notifier.setRememberPlaybackRate(false);
      final disabled = container.read(videoPlayerSettingsProvider);
      expect(disabled.rememberPlaybackRate, isFalse);
      expect(disabled.lastPlaybackRate, isNull);
    });

    test('ordinary changes persist only while the feature is enabled', () async {
      final notifier = container.read(videoPlayerSettingsProvider.notifier);

      await notifier.setPlaybackRate(2.0, applyToPlayer: false);
      expect(container.read(playbackRateProvider), 2.0);
      expect(container.read(videoPlayerSettingsProvider).lastPlaybackRate, isNull);

      notifier.setRememberPlaybackRate(true);
      await notifier.setPlaybackRate(4.0, applyToPlayer: false);
      expect(container.read(playbackRateProvider), 3.0);
      expect(container.read(videoPlayerSettingsProvider).lastPlaybackRate, 3.0);

      await notifier.setPlaybackRate(
        2.5,
        persistLastUsed: false,
        applyToPlayer: false,
      );
      expect(container.read(playbackRateProvider), 2.5);
      expect(container.read(videoPlayerSettingsProvider).lastPlaybackRate, 3.0);
    });
  });
}
