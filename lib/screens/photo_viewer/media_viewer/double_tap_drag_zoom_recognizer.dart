import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class DoubleTapDragZoomRecognizer extends GestureRecognizer {
  DoubleTapDragZoomRecognizer({super.debugOwner, super.supportedDevices});

  VoidCallback? onSingleTap;
  ValueChanged<Offset>? onDoubleTap;
  ValueChanged<Offset>? onDragZoomStart;
  ValueChanged<double>? onDragZoomUpdate;

  _TrackedTap? _first;
  _TrackedTap? _second;
  Timer? _singleTapTimer;
  bool _dragging = false;

  GestureArenaManager get _arena => GestureBinding.instance.gestureArena;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    final first = _first;
    if (first == null) {
      _first = _track(event);
      return;
    }
    if (_second != null || !first.lifted || (event.position - first.downPosition).distance > kDoubleTapSlop) {
      _reset();
      _first = _track(event);
      return;
    }
    _singleTapTimer?.cancel();
    final second = _second = _track(event);
    second.entry.resolve(GestureDisposition.accepted);
    first.entry.resolve(GestureDisposition.accepted);
  }

  _TrackedTap _track(PointerDownEvent event) {
    GestureBinding.instance.pointerRouter.addRoute(event.pointer, _handleEvent, event.transform);
    return _TrackedTap(
      pointer: event.pointer,
      downPosition: event.position,
      localDownPosition: event.localPosition,
      entry: _arena.add(event.pointer, this),
    );
  }

  void _handleEvent(PointerEvent event) {
    if (event.pointer == _first?.pointer && _second == null) {
      _handleFirstTap(event, _first!);
    } else if (event.pointer == _second?.pointer) {
      _handleSecondTap(event, _second!);
    }
  }

  void _handleFirstTap(PointerEvent event, _TrackedTap tap) {
    switch (event) {
      case PointerMoveEvent() when (event.position - tap.downPosition).distance > kTouchSlop:
        _reset();
      case PointerUpEvent():
        tap.lifted = true;
        _stopRoute(tap);
        _arena.hold(tap.pointer);
        tap.held = true;
        _singleTapTimer = Timer(kDoubleTapTimeout, _completeSingleTap);
      case PointerCancelEvent():
        _reset();
      default:
    }
  }

  void _handleSecondTap(PointerEvent event, _TrackedTap tap) {
    switch (event) {
      case PointerMoveEvent():
        final travelled = event.position - tap.downPosition;
        if (!_dragging && travelled.distance > kTouchSlop) {
          _dragging = true;
          onDragZoomStart?.call(tap.localDownPosition);
        }
        if (_dragging) onDragZoomUpdate?.call(travelled.dy);
      case PointerUpEvent():
        if (!_dragging) onDoubleTap?.call(tap.localDownPosition);
        _reset();
      case PointerCancelEvent():
        _reset();
      default:
    }
  }

  void _completeSingleTap() {
    final first = _first;
    if (first == null) return;
    first.entry.resolve(GestureDisposition.accepted);
    onSingleTap?.call();
    _reset();
  }

  void _stopRoute(_TrackedTap tap) {
    if (!tap.routed) return;
    tap.routed = false;
    GestureBinding.instance.pointerRouter.removeRoute(tap.pointer, _handleEvent);
  }

  void _release(_TrackedTap? tap) {
    if (tap == null) return;
    _stopRoute(tap);
    tap.entry.resolve(GestureDisposition.rejected);
    if (tap.held) _arena.release(tap.pointer);
  }

  void _reset() {
    _singleTapTimer?.cancel();
    _singleTapTimer = null;
    final first = _first;
    final second = _second;
    _first = null;
    _second = null;
    _dragging = false;
    _release(first);
    _release(second);
  }

  @override
  void acceptGesture(int pointer) {}

  @override
  void rejectGesture(int pointer) {
    if (pointer == _first?.pointer || pointer == _second?.pointer) _reset();
  }

  @override
  void dispose() {
    _reset();
    super.dispose();
  }

  @override
  String get debugDescription => 'double tap drag zoom';
}

class _TrackedTap {
  _TrackedTap({
    required this.pointer,
    required this.downPosition,
    required this.localDownPosition,
    required this.entry,
  });

  final int pointer;
  final Offset downPosition;
  final Offset localDownPosition;
  final GestureArenaEntry entry;
  bool lifted = false;
  bool held = false;
  bool routed = true;
}
