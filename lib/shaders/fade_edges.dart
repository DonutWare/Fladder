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

  static final Paint _maskPaint = Paint();

  @override
  bool get alwaysNeedsCompositing => _needsFade;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (!_needsFade) {
      super.paint(context, offset);
      return;
    }

    final rect = offset & size;

    context.canvas.saveLayer(rect, Paint());
    super.paint(context, offset);

    _maskPaint.blendMode = BlendMode.dstIn;

    if (_topFade > 0 || _bottomFade > 0) {
      final colors = <Color>[];
      final stops = <double>[];

      if (_topFade > 0) {
        colors.addAll([Colors.transparent, Colors.white]);
        stops.addAll([0.0, _topFade]);
      } else {
        colors.add(Colors.white);
        stops.add(0.0);
      }

      if (_bottomFade > 0) {
        colors.addAll([Colors.white, Colors.transparent]);
        stops.addAll([1.0 - _bottomFade, 1.0]);
      } else {
        colors.add(Colors.white);
        stops.add(1.0);
      }

      _maskPaint.shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      context.canvas.drawRect(rect, _maskPaint);
    }

    if (_leftFade > 0 || _rightFade > 0) {
      final colors = <Color>[];
      final stops = <double>[];

      if (_leftFade > 0) {
        colors.addAll([Colors.transparent, Colors.white]);
        stops.addAll([0.0, _leftFade]);
      } else {
        colors.add(Colors.white);
        stops.add(0.0);
      }

      if (_rightFade > 0) {
        colors.addAll([Colors.white, Colors.transparent]);
        stops.addAll([1.0 - _rightFade, 1.0]);
      } else {
        colors.add(Colors.white);
        stops.add(1.0);
      }

      _maskPaint.shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      context.canvas.drawRect(rect, _maskPaint);
    }

    context.canvas.restore();
  }
}
