import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FadeEdges extends SingleChildRenderObjectWidget {
  const FadeEdges({
    super.key,
    required Widget child,
    this.topFade = 0.0,
    this.bottomFade = 0.0,
    this.leftFade = 0.0,
    this.rightFade = 0.0,
  }) : super(child: child);

  final double topFade;
  final double bottomFade;
  final double leftFade;
  final double rightFade;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderFadeEdges(
      topFade: topFade,
      bottomFade: bottomFade,
      leftFade: leftFade,
      rightFade: rightFade,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderFadeEdges renderObject) {
    renderObject
      ..topFade = topFade
      ..bottomFade = bottomFade
      ..leftFade = leftFade
      ..rightFade = rightFade;
  }
}

class RenderFadeEdges extends RenderProxyBox {
  RenderFadeEdges({
    required double topFade,
    required double bottomFade,
    required double leftFade,
    required double rightFade,
  })  : _topFade = topFade.clamp(0.0, 0.5),
        _bottomFade = bottomFade.clamp(0.0, 0.5),
        _leftFade = leftFade.clamp(0.0, 0.5),
        _rightFade = rightFade.clamp(0.0, 0.5);

  double _topFade;
  double get topFade => _topFade;
  set topFade(double value) {
    value = value.clamp(0.0, 0.5);
    if (_topFade == value) return;
    _topFade = value;
    markNeedsPaint();
  }

  double _bottomFade;
  double get bottomFade => _bottomFade;
  set bottomFade(double value) {
    value = value.clamp(0.0, 0.5);
    if (_bottomFade == value) return;
    _bottomFade = value;
    markNeedsPaint();
  }

  double _leftFade;
  double get leftFade => _leftFade;
  set leftFade(double value) {
    value = value.clamp(0.0, 0.5);
    if (_leftFade == value) return;
    _leftFade = value;
    markNeedsPaint();
  }

  double _rightFade;
  double get rightFade => _rightFade;
  set rightFade(double value) {
    value = value.clamp(0.0, 0.5);
    if (_rightFade == value) return;
    _rightFade = value;
    markNeedsPaint();
  }

  bool get _needsFade => _topFade > 0 || _bottomFade > 0 || _leftFade > 0 || _rightFade > 0;

  final LayerHandle<ShaderMaskLayer> _maskLayer = LayerHandle();
  final Paint _innerMaskPaint = Paint()..blendMode = BlendMode.dstIn;

  @override
  bool get alwaysNeedsCompositing => _needsFade;

  @override
  void dispose() {
    _maskLayer.layer = null;
    super.dispose();
  }

  LinearGradient? _gradient(double start, double end, Alignment begin, Alignment finish) {
    if (start <= 0 && end <= 0) return null;
    return LinearGradient(
      begin: begin,
      end: finish,
      colors: [
        if (start > 0) Colors.transparent,
        Colors.white,
        Colors.white,
        if (end > 0) Colors.transparent,
      ],
      stops: [
        if (start > 0) 0.0,
        start,
        1.0 - end,
        if (end > 0) 1.0,
      ],
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final vertical = _gradient(_topFade, _bottomFade, Alignment.topCenter, Alignment.bottomCenter);
    final horizontal = _gradient(_leftFade, _rightFade, Alignment.centerLeft, Alignment.centerRight);
    final outer = vertical ?? horizontal;
    if (outer == null) {
      _maskLayer.layer = null;
      super.paint(context, offset);
      return;
    }
    final inner = vertical != null ? horizontal : null;

    _maskLayer.layer = (_maskLayer.layer ?? ShaderMaskLayer())
      ..shader = outer.createShader(Offset.zero & size)
      ..maskRect = offset & size
      ..blendMode = BlendMode.dstIn;
    context.pushLayer(_maskLayer.layer!, (context, offset) {
      super.paint(context, offset);
      if (inner == null) return;
      final rect = offset & size;
      context.canvas.drawRect(rect, _innerMaskPaint..shader = inner.createShader(rect));
    }, offset);
  }
}
