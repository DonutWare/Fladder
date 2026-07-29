import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/providers/video_player_provider.dart';

void main() {
  test('concurrent initialization requests share one operation', () async {
    final gate = Completer<void>();
    var initializationCount = 0;
    final testProvider = Provider<VideoPlayerNotifier>((ref) {
      return VideoPlayerNotifier(
        ref,
        initializeOverride: () async {
          initializationCount++;
          await gate.future;
        },
      );
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(testProvider);

    final first = notifier.init();
    final second = notifier.init();

    expect(identical(first, second), isTrue);
    expect(initializationCount, 1);
    expect(notifier.initializationInProgress, isTrue);

    gate.complete();
    await Future.wait([first, second]);

    expect(notifier.initializationInProgress, isFalse);
    expect(notifier.hasCompletedInitialization, isTrue);
  });

  test('a completed initialization can be intentionally run again', () async {
    var initializationCount = 0;
    final testProvider = Provider<VideoPlayerNotifier>((ref) {
      return VideoPlayerNotifier(
        ref,
        initializeOverride: () async {
          initializationCount++;
        },
      );
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(testProvider);

    await notifier.init();
    await notifier.init();

    expect(initializationCount, 2);
  });

  test('failed initialization is retryable', () async {
    var initializationCount = 0;
    final testProvider = Provider<VideoPlayerNotifier>((ref) {
      return VideoPlayerNotifier(
        ref,
        initializeOverride: () async {
          initializationCount++;
          if (initializationCount == 1) {
            throw StateError('first attempt failed');
          }
        },
      );
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(testProvider);

    await expectLater(notifier.init(), throwsStateError);
    await notifier.init();

    expect(initializationCount, 2);
    expect(notifier.hasCompletedInitialization, isTrue);
  });
}
