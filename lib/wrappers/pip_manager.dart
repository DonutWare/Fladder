import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pip/pip.dart';

bool get pipPlatformSupported {
  if (kIsWeb) return false;
  return Platform.isAndroid || Platform.isIOS;
}

abstract class PipClient {
  Future<bool> isSupported();
  Future<bool> isAutoEnterSupported();
  Future<void> setup({
    required double aspectWidth,
    required double aspectHeight,
    required bool autoEnterEnabled,
  });

  // stop() only exits an active session; this re-runs setup with auto-enter off.
  Future<void> disableAutoEnter();
  Future<bool> start();
  Future<void> stop();
  void registerStateChangedObserver(void Function(bool isInPip) observer);
  Future<void> dispose();
}

class _RealPipClient implements PipClient {
  _RealPipClient() : _pip = Pip();

  final Pip _pip;
  bool _observerRegistered = false;

  @override
  Future<bool> isSupported() async {
    if (!pipPlatformSupported) return false;
    return _pip.isSupported();
  }

  @override
  Future<bool> isAutoEnterSupported() => _pip.isAutoEnterSupported();

  @override
  Future<void> setup({
    required double aspectWidth,
    required double aspectHeight,
    required bool autoEnterEnabled,
  }) async {
    await _pip.setup(PipOptions(
      autoEnterEnabled: autoEnterEnabled,
      aspectRatioX: aspectWidth.toInt(),
      aspectRatioY: aspectHeight.toInt(),
    ));
  }

  @override
  Future<void> disableAutoEnter() async {
    await _pip.setup(const PipOptions(autoEnterEnabled: false));
  }

  @override
  Future<bool> start() => _pip.start();

  @override
  Future<void> stop() => _pip.stop();

  @override
  void registerStateChangedObserver(void Function(bool isInPip) observer) {
    final wrapped = PipStateChangedObserver(
      onPipStateChanged: (state, error) {
        observer(state == PipState.pipStateStarted);
      },
    );
    _pip.registerStateChangedObserver(wrapped);
    _observerRegistered = true;
  }

  @override
  Future<void> dispose() async {
    if (_observerRegistered) {
      await _pip.unregisterStateChangedObserver();
      _observerRegistered = false;
    }
    await _pip.dispose();
  }
}

// Only file that imports `package:pip` — everything else depends on PipManager.
class PipManager {
  PipManager({PipClient? client}) : _client = client ?? _RealPipClient() {
    _client.registerStateChangedObserver(_onStateChanged);
  }

  final PipClient _client;
  final StreamController<bool> _stateController = StreamController<bool>.broadcast();

  bool _supportCached = false;
  bool _supportChecked = false;

  Stream<bool> get isInPip => _stateController.stream;

  // Always sets up aspect so manual enter() works; autoEnter gates the
  // OS auto-enter-on-background behavior independently.
  Future<bool> enable({
    required double aspectWidth,
    required double aspectHeight,
    required bool autoEnter,
  }) async {
    if (!await _ensureSupported()) return false;
    final autoEnterAllowed = autoEnter && await _client.isAutoEnterSupported();
    await _client.setup(
      aspectWidth: aspectWidth,
      aspectHeight: aspectHeight,
      autoEnterEnabled: autoEnterAllowed,
    );
    return true;
  }

  Future<void> disable() async {
    if (!await _ensureSupported()) return;
    await _client.disableAutoEnter();
    await _client.stop();
  }

  Future<bool> enter() async {
    if (!await _ensureSupported()) return false;
    return _client.start();
  }

  Future<void> dispose() async {
    await _client.dispose();
    await _stateController.close();
  }

  Future<bool> _ensureSupported() async {
    if (_supportChecked) return _supportCached;
    _supportCached = await _client.isSupported();
    _supportChecked = true;
    return _supportCached;
  }

  void _onStateChanged(bool isInPip) {
    if (!_stateController.isClosed) {
      _stateController.add(isInPip);
    }
  }
}
