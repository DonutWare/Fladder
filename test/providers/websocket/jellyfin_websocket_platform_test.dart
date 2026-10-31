import 'dart:math';

import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:fladder/providers/websocket/jellyfin_websocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('reconnectDelay', () {
    test('first attempt is the base delay within jitter', () {
      final delay = reconnectDelay(0, random: Random(1));
      expect(delay.inMilliseconds, inInclusiveRange(1600, 2400));
    });

    test('doubles per attempt until the cap', () {
      final second = reconnectDelay(1, random: _NoJitter());
      final third = reconnectDelay(2, random: _NoJitter());
      expect(second, const Duration(seconds: 4));
      expect(third, const Duration(seconds: 8));
    });

    test('is capped and never gives up', () {
      for (final attempt in [4, 10, 100, 1 << 20]) {
        final delay = reconnectDelay(attempt, random: Random(attempt));
        expect(delay.inMilliseconds, lessThanOrEqualTo(36000), reason: 'attempt $attempt');
        expect(delay.inMilliseconds, greaterThanOrEqualTo(24000), reason: 'attempt $attempt');
      }
    });
  });

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

/// Random that always yields 0.5 so the jitter term is exactly zero.
class _NoJitter implements Random {
  @override
  bool nextBool() => false;

  @override
  double nextDouble() => 0.5;

  @override
  int nextInt(int max) => 0;
}
