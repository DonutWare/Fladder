import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:fladder/providers/websocket/jellyfin_websocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isPhonePlatform', () {
    test('Android handheld (not leanback) is a phone', () {
      expect(
        isPhonePlatform(isWeb: false, platform: TargetPlatform.android, leanBackMode: false),
        isTrue,
      );
    });

    test('iOS handheld is a phone', () {
      expect(
        isPhonePlatform(isWeb: false, platform: TargetPlatform.iOS, leanBackMode: false),
        isTrue,
      );
    });

    test('Android-TV / leanback is NOT a phone (always-alive)', () {
      expect(
        isPhonePlatform(isWeb: false, platform: TargetPlatform.android, leanBackMode: true),
        isFalse,
      );
    });

    test('Web is never a phone', () {
      expect(
        isPhonePlatform(isWeb: true, platform: TargetPlatform.android, leanBackMode: false),
        isFalse,
      );
    });

    test('Desktop platforms are not phones', () {
      for (final p in [TargetPlatform.windows, TargetPlatform.macOS, TargetPlatform.linux]) {
        expect(
          isPhonePlatform(isWeb: false, platform: p, leanBackMode: false),
          isFalse,
          reason: '$p should not be a phone',
        );
      }
    });
  });
}
