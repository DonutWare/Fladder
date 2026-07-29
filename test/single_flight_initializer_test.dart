import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/util/single_flight_initializer.dart';

void main() {
  test('concurrent initialization creates one native instance', () async {
    final initializer = SingleFlightInitializer<Object>();
    final gate = Completer<void>();
    var initializationCount = 0;
    var instanceCount = 0;

    Future<Object> initialize() async {
      initializationCount++;
      await gate.future;
      instanceCount++;
      return Object();
    }

    final first = initializer.run(initialize);
    final second = initializer.run(initialize);

    expect(identical(first, second), isTrue);
    expect(initializationCount, 1);
    expect(initializer.isRunning, isTrue);

    gate.complete();
    final instances = await Future.wait([first, second]);

    expect(instanceCount, 1);
    expect(identical(instances.first, instances.last), isTrue);
    expect(initializer.hasValue, isTrue);
  });

  test('failed initialization remains retryable', () async {
    final initializer = SingleFlightInitializer<Object>();
    var initializationCount = 0;

    Future<Object> initialize() async {
      initializationCount++;
      if (initializationCount == 1) {
        throw StateError('first attempt failed');
      }
      return Object();
    }

    await expectLater(initializer.run(initialize), throwsStateError);
    await initializer.run(initialize);

    expect(initializationCount, 2);
    expect(initializer.hasValue, isTrue);
  });
}
