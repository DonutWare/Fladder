import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/util/single_flight_initializer.dart';

void main() {
  test('concurrent calls share one initialization', () async {
    final initializer = SingleFlightInitializer<int>();
    final completer = Completer<int>();
    var calls = 0;

    Future<int> initialize() {
      calls++;
      return completer.future;
    }

    final first = initializer.run(initialize);
    final second = initializer.run(initialize);

    expect(identical(first, second), isTrue);
    expect(calls, 1);
    expect(initializer.isRunning, isTrue);

    completer.complete(42);

    await expectLater(first, completion(42));
    expect(initializer.isRunning, isFalse);
    expect(initializer.hasValue, isTrue);
    await expectLater(initializer.run(initialize), completion(42));
    expect(calls, 1);
  });

  test('failed initialization can be retried', () async {
    final initializer = SingleFlightInitializer<int>();
    var calls = 0;

    Future<int> initialize() async {
      calls++;
      if (calls == 1) throw StateError('first attempt failed');
      return 7;
    }

    await expectLater(initializer.run(initialize), throwsStateError);
    expect(initializer.isRunning, isFalse);
    expect(initializer.hasValue, isFalse);

    await expectLater(initializer.run(initialize), completion(7));
    expect(calls, 2);
    expect(initializer.hasValue, isTrue);
  });
}
