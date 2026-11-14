import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fladder/screens/photo_viewer/media_viewer/double_tap_drag_zoom_recognizer.dart';

class ZoomableMedia extends StatefulWidget {
  const ZoomableMedia({
    required this.child,
    required this.active,
    this.contentSize,
    this.onTap,
    this.onZoomChanged,
    super.key,
  });

  final Widget child;
  final bool active;
  final Size? contentSize;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onZoomChanged;

  @override
  State<ZoomableMedia> createState() => _ZoomableMediaState();
}

class _ZoomableMediaState extends State<ZoomableMedia> with SingleTickerProviderStateMixin {
  static const _maxScale = 6.0;
  static const _doubleTapScale = 2.5;
  static const _dragZoomSensitivity = 200.0;
  static const _wheelZoomSensitivity = 300.0;
  static const _zoomDuration = Duration(milliseconds: 250);
  static const _flingDuration = Duration(milliseconds: 600);
  static const _minFlingVelocity = 1000.0;

  late final _animation = AnimationController(vsync: this, duration: _zoomDuration)..addListener(_onAnimationTick);
  _ZoomView _view = _ZoomView.identity;
  _ZoomView _animationStart = _ZoomView.identity;
  _ZoomView _animationEnd = _ZoomView.identity;
  _ZoomView _gestureStart = _ZoomView.identity;
  Offset _gestureContentPoint = Offset.zero;
  Offset _dragZoomAnchor = Offset.zero;
  Size _viewport = Size.zero;
  bool _zoomed = false;

  @override
  void didUpdateWidget(ZoomableMedia oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active && !widget.active) {
      _animation.stop();
      _view = _ZoomView.identity;
      _zoomed = false;
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  Rect get _contentRect {
    final viewportRect = Offset.zero & _viewport;
    final content = widget.contentSize;
    if (content == null || content.isEmpty) return viewportRect;
    final fitted = applyBoxFit(BoxFit.contain, content, _viewport).destination;
    return Alignment.center.inscribe(fitted, viewportRect);
  }

  _ZoomView _clamp(double scale, Offset offset) {
    final clampedScale = scale.clamp(1.0, _maxScale);
    final content = _contentRect;
    double axis(double offset, double start, double extent, double viewport) {
      final scaledStart = start * clampedScale;
      final scaledExtent = extent * clampedScale;
      if (scaledExtent <= viewport) return (viewport - scaledExtent) / 2 - scaledStart;
      return offset.clamp(viewport - scaledStart - scaledExtent, -scaledStart);
    }

    return _ZoomView(
      clampedScale,
      Offset(
        axis(offset.dx, content.left, content.width, _viewport.width),
        axis(offset.dy, content.top, content.height, _viewport.height),
      ),
    );
  }

  _ZoomView _zoomedAround(Offset focal, double scale, _ZoomView from) {
    final contentPoint = from.toContent(focal);
    return _clamp(scale, focal - contentPoint * scale.clamp(1.0, _maxScale));
  }

  void _show(_ZoomView view) {
    _animation.stop();
    setState(() => _view = view);
    _reportZoom();
  }

  void _animateTo(_ZoomView view, {Duration duration = _zoomDuration}) {
    _animation.duration = duration;
    _animationStart = _view;
    _animationEnd = view;
    _animation.forward(from: 0);
  }

  void _onAnimationTick() {
    final t = Curves.easeOutCubic.transform(_animation.value);
    setState(() => _view = _ZoomView.lerp(_animationStart, _animationEnd, t));
    _reportZoom();
  }

  void _reportZoom() {
    final zoomed = _view.scale > 1.01;
    if (zoomed == _zoomed) return;
    _zoomed = zoomed;
    widget.onZoomChanged?.call(zoomed);
  }

  void _onDoubleTap(Offset position) {
    _animateTo(_zoomed ? _clamp(1, Offset.zero) : _zoomedAround(position, _doubleTapScale, _view));
  }

  void _onDragZoomStart(Offset anchor) {
    _animation.stop();
    _gestureStart = _view;
    _dragZoomAnchor = anchor;
  }

  void _onDragZoomUpdate(double dy) {
    final scale = _gestureStart.scale * math.exp(dy / _dragZoomSensitivity);
    _show(_zoomedAround(_dragZoomAnchor, scale, _gestureStart));
  }

  void _onScaleStart(ScaleStartDetails details) {
    _animation.stop();
    _gestureStart = _view;
    _gestureContentPoint = _view.toContent(details.localFocalPoint);
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scale = (_gestureStart.scale * details.scale).clamp(1.0, _maxScale);
    _show(_clamp(scale, details.localFocalPoint - _gestureContentPoint * scale));
  }

  void _onScaleEnd(ScaleEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond;
    final speed = velocity.distance;
    if (!_zoomed || details.pointerCount > 0 || speed < _minFlingVelocity) return;
    final travel = velocity / speed * (speed - _minFlingVelocity) * (_flingDuration.inMilliseconds / 3000);
    _animateTo(_clamp(_view.scale, _view.offset + travel), duration: _flingDuration);
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    GestureBinding.instance.pointerSignalResolver.register(event, (resolved) {
      final scroll = resolved as PointerScrollEvent;
      final scale = _view.scale * math.exp(-scroll.scrollDelta.dy / _wheelZoomSensitivity);
      _show(_zoomedAround(scroll.localPosition, scale, _view));
    });
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final viewport = constraints.biggest;
          if (viewport != _viewport) {
            _viewport = viewport;
            _view = _ZoomView.identity;
            if (_zoomed) WidgetsBinding.instance.addPostFrameCallback((_) => _reportZoom());
          }
          return Listener(
            onPointerSignal: _onPointerSignal,
            child: RawGestureDetector(
              behavior: HitTestBehavior.opaque,
              gestures: {
                DoubleTapDragZoomRecognizer: GestureRecognizerFactoryWithHandlers<DoubleTapDragZoomRecognizer>(
                  () => DoubleTapDragZoomRecognizer(debugOwner: this),
                  (recognizer) => recognizer
                    ..onSingleTap = widget.onTap
                    ..onDoubleTap = _onDoubleTap
                    ..onDragZoomStart = _onDragZoomStart
                    ..onDragZoomUpdate = _onDragZoomUpdate,
                ),
                ScaleGestureRecognizer: GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
                  () => ScaleGestureRecognizer(debugOwner: this),
                  (recognizer) => recognizer
                    ..onStart = _onScaleStart
                    ..onUpdate = _onScaleUpdate
                    ..onEnd = _onScaleEnd,
                ),
              },
              child: ClipRect(
                child: Transform(
                  transform: _view.matrix,
                  child: SizedBox.fromSize(size: viewport, child: widget.child),
                ),
              ),
            ),
          );
        },
      );
}

@immutable
class _ZoomView {
  const _ZoomView(this.scale, this.offset);

  static const identity = _ZoomView(1, Offset.zero);

  final double scale;
  final Offset offset;

  Offset toContent(Offset viewportPoint) => (viewportPoint - offset) / scale;

  Matrix4 get matrix => Matrix4.identity()
    ..translateByDouble(offset.dx, offset.dy, 0, 1)
    ..scaleByDouble(scale, scale, 1, 1);

  static _ZoomView lerp(_ZoomView a, _ZoomView b, double t) =>
      _ZoomView(a.scale + (b.scale - a.scale) * t, Offset.lerp(a.offset, b.offset, t)!);
}
