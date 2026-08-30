import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/providers/video_player_provider.dart';

void main() {
  test('concurrent player initialization requests share one operation', () async {
    final completer = Completer<void>();
    var calls = 0;
    final provider = Provider<VideoPlayerNotifier>((ref) {
      return VideoPlayerNotifier(ref, initializer: () {
        calls++;
        return completer.future;
      });
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(provider);

    final first = notifier.init();
    final second = notifier.init();

    expect(identical(first, second), isTrue);
    expect(calls, 1);

    completer.complete();
    await Future.wait([first, second]);
  });

  test('failed player initialization can be retried', () async {
    var calls = 0;
    final provider = Provider<VideoPlayerNotifier>((ref) {
      return VideoPlayerNotifier(ref, initializer: () async {
        calls++;
        if (calls == 1) throw StateError('first attempt failed');
      });
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(provider);

    await expectLater(notifier.init(), throwsStateError);
    await notifier.init();

    expect(calls, 2);
  });

  test('completed player initialization can be run again for backend changes', () async {
    var calls = 0;
    final provider = Provider<VideoPlayerNotifier>((ref) {
      return VideoPlayerNotifier(ref, initializer: () async {
        calls++;
      });
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(provider);

    await notifier.init();
    await notifier.init();

    expect(calls, 2);
  });
}
