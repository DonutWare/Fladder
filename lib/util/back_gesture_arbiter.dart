import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BackGestureArbiter with WidgetsBindingObserver {
  static final BackGestureArbiter _instance = BackGestureArbiter._();
  static final List<WidgetsBindingObserver> _handlers = [];
  static WidgetsBindingObserver? _active;
  static bool _starting = false;

  BackGestureArbiter._() {
    WidgetsBinding.instance.addObserver(this);
  }

  static void ensureInitialized() => _instance;

  static bool get starting => _starting;

  static bool get claimed => _active != null;

  static void add(WidgetsBindingObserver handler) {
    ensureInitialized();
    _handlers.add(handler);
  }

  static void remove(WidgetsBindingObserver handler) {
    _handlers.remove(handler);
    if (_active == handler) _active = null;
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    if (backEvent.isButtonEvent) return false;
    _starting = true;
    scheduleMicrotask(() => _starting = false);
    _active = _handlers.reversed.where((handler) => handler.handleStartBackGesture(backEvent)).firstOrNull;
    return _active != null;
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) =>
      _active?.handleUpdateBackGestureProgress(backEvent);

  @override
  void handleCancelBackGesture() {
    final active = _active;
    _active = null;
    active?.handleCancelBackGesture();
  }

  @override
  void handleCommitBackGesture() {
    final active = _active;
    _active = null;
    active?.handleCommitBackGesture();
  }
}

mixin BackGestureProgressState<T extends StatefulWidget> on SingleTickerProviderStateMixin<T>, WidgetsBindingObserver {
  late final AnimationController backProgress = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 160),
  );

  bool get canHandleBackGesture;

  @override
  void initState() {
    super.initState();
    BackGestureArbiter.add(this);
  }

  @override
  void dispose() {
    BackGestureArbiter.remove(this);
    backProgress.dispose();
    super.dispose();
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    if (!canHandleBackGesture) return false;
    backProgress.value = backEvent.progress;
    return true;
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) => backProgress.value = backEvent.progress;

  @override
  void handleCancelBackGesture() => unawaited(backProgress.animateBack(0));
}
