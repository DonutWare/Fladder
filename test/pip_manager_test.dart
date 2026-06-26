import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/wrappers/pip_manager.dart';

class _FakePipClient implements PipClient {
  bool supported = true;
  bool autoEnterSupported = true;
  bool startResult = true;

  final List<PipOptionsSnapshot> setupCalls = [];
  int startCount = 0;
  int stopCount = 0;
  int disableAutoEnterCount = 0;
  int disposeCount = 0;
  void Function(bool isInPip)? _observer;

  void emitState(bool isInPip) => _observer?.call(isInPip);

  @override
  Future<bool> isSupported() async => supported;

  @override
  Future<bool> isAutoEnterSupported() async => autoEnterSupported;

  @override
  Future<void> setup({
    required double aspectWidth,
    required double aspectHeight,
    required bool autoEnterEnabled,
  }) async {
    setupCalls.add(PipOptionsSnapshot(aspectWidth, aspectHeight, autoEnterEnabled));
  }

  @override
  Future<bool> start() async {
    startCount++;
    return startResult;
  }

  @override
  Future<void> stop() async {
    stopCount++;
  }

  @override
  Future<void> disableAutoEnter() async {
    disableAutoEnterCount++;
  }

  @override
  void registerStateChangedObserver(void Function(bool isInPip) observer) {
    _observer = observer;
  }

  @override
  Future<void> dispose() async {
    disposeCount++;
  }
}

class PipOptionsSnapshot {
  PipOptionsSnapshot(this.width, this.height, this.autoEnter);
  final double width;
  final double height;
  final bool autoEnter;
}

void main() {
  group('PipManager', () {
    test('enable calls setup with aspect ratio and propagates autoEnter=true', () async {
      final fake = _FakePipClient();
      final manager = PipManager(client: fake);

      await manager.enable(aspectWidth: 1920, aspectHeight: 1080, autoEnter: true);

      expect(fake.setupCalls, hasLength(1));
      expect(fake.setupCalls.single.width, 1920);
      expect(fake.setupCalls.single.height, 1080);
      expect(fake.setupCalls.single.autoEnter, isTrue);
    });

    test('enable with autoEnter=false still sets up aspect but disables auto-enter', () async {
      final fake = _FakePipClient();
      final manager = PipManager(client: fake);

      await manager.enable(aspectWidth: 16, aspectHeight: 9, autoEnter: false);

      expect(fake.setupCalls, hasLength(1));
      expect(fake.setupCalls.single.autoEnter, isFalse);
    });

    test('enable forces autoEnter=false when client reports auto-enter unsupported', () async {
      final fake = _FakePipClient()..autoEnterSupported = false;
      final manager = PipManager(client: fake);

      await manager.enable(aspectWidth: 16, aspectHeight: 9, autoEnter: true);

      expect(fake.setupCalls.single.autoEnter, isFalse);
    });

    test('enable returns false when isSupported is false and skips setup', () async {
      final fake = _FakePipClient()..supported = false;
      final manager = PipManager(client: fake);

      final result = await manager.enable(aspectWidth: 16, aspectHeight: 9, autoEnter: true);

      expect(result, isFalse);
      expect(fake.setupCalls, isEmpty);
    });

    test('enter calls start and returns its result', () async {
      final fake = _FakePipClient();
      final manager = PipManager(client: fake);

      final ok = await manager.enter();

      expect(ok, isTrue);
      expect(fake.startCount, 1);
    });

    test('enter returns false when isSupported is false', () async {
      final fake = _FakePipClient()..supported = false;
      final manager = PipManager(client: fake);

      final ok = await manager.enter();

      expect(ok, isFalse);
      expect(fake.startCount, 0);
    });

    test('disable turns off auto-enter and stops any active PiP', () async {
      final fake = _FakePipClient();
      final manager = PipManager(client: fake);

      await manager.disable();

      expect(fake.disableAutoEnterCount, 1);
      expect(fake.stopCount, 1);
    });

    test('isInPip stream emits values from the observer', () async {
      final fake = _FakePipClient();
      final manager = PipManager(client: fake);
      final emitted = <bool>[];
      final sub = manager.isInPip.listen(emitted.add);

      fake.emitState(true);
      fake.emitState(false);
      await Future<void>.delayed(Duration.zero);

      expect(emitted, [true, false]);
      await sub.cancel();
      await manager.dispose();
    });

    test('dispose closes the stream and calls client.dispose', () async {
      final fake = _FakePipClient();
      final manager = PipManager(client: fake);

      await manager.dispose();

      expect(fake.disposeCount, 1);
      final emitted = <bool>[];
      final sub = manager.isInPip.listen(emitted.add);
      await Future<void>.delayed(Duration.zero);
      expect(emitted, isEmpty);
      await sub.cancel();
    });
  });
}
