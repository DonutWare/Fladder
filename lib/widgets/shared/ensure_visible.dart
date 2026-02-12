import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

extension EnsureVisibleHelper on BuildContext {
  Future<void> ensureVisible({
    Duration duration = const Duration(milliseconds: 275),
    double alignment = 0.5,
    Curve curve = Curves.fastOutSlowIn,
    bool onlyNearest = false,
  }) {
    final scrollable = Scrollable.of(this);
    final renderObject = findRenderObject();
    if (onlyNearest && renderObject != null) {
      final viewport = RenderAbstractViewport.of(renderObject);
      final target = alignment;
      final offset = viewport.getOffsetToReveal(renderObject, target).offset;
      return scrollable.position.animateTo(
        offset.clamp(
          scrollable.position.minScrollExtent,
          scrollable.position.maxScrollExtent,
        ),
        duration: duration,
        curve: curve,
      );
    }
    return Scrollable.ensureVisible(
      this,
      duration: duration,
      alignment: alignment,
      curve: curve,
    );
  }
}
