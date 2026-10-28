import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DrawerPeek extends StatefulWidget {
  static const double edgeWidth = 20.0;

  final Widget drawer;
  final bool Function() canPeek;
  final Widget child;
  const DrawerPeek({
    required this.drawer,
    required this.canPeek,
    required this.child,
    super.key,
  });

  @override
  State<DrawerPeek> createState() => _DrawerPeekState();
}

class _DrawerPeekState extends State<DrawerPeek> with SingleTickerProviderStateMixin {
  static const double _peekWidth = 24.0;

  late final AnimationController _peek = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  Timer? _holdTimer;
  int? _pointer;
  Offset _downPosition = Offset.zero;

  bool get _isRtl => Directionality.of(context) == TextDirection.rtl;

  @override
  void dispose() {
    _holdTimer?.cancel();
    _peek.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    if (_pointer != null || event.kind != PointerDeviceKind.touch || !widget.canPeek()) return;
    final padding = MediaQuery.paddingOf(context);
    final edgeDistance = _isRtl ? context.size!.width - event.localPosition.dx : event.localPosition.dx;
    if (edgeDistance > DrawerPeek.edgeWidth + (_isRtl ? padding.right : padding.left)) return;
    _pointer = event.pointer;
    _downPosition = event.localPosition;
    _holdTimer = Timer(const Duration(milliseconds: 160), _peek.forward);
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (event.pointer != _pointer) return;
    final distance = (event.localPosition - _downPosition).distance;
    if (_holdTimer?.isActive == true && distance > kTouchSlop) {
      _onPointerEnd(event);
    } else if (distance > _peekWidth + kTouchSlop) {
      _peek.value = 0;
      _onPointerEnd(event);
    }
  }

  void _onPointerEnd(PointerEvent event) {
    if (event.pointer != _pointer) return;
    _holdTimer?.cancel();
    _pointer = null;
    _peek.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerEnd,
      onPointerCancel: _onPointerEnd,
      child: Stack(
        children: [
          widget.child,
          AnimatedBuilder(
            animation: _peek,
            builder: (context, child) => _peek.isDismissed
                ? const SizedBox.shrink()
                : CustomSingleChildLayout(
                    delegate: _PeekLayout(_peekWidth * Curves.easeOut.transform(_peek.value), _isRtl),
                    child: child,
                  ),
            child: IgnorePointer(child: widget.drawer),
          ),
        ],
      ),
    );
  }
}

class _PeekLayout extends SingleChildLayoutDelegate {
  final double visibleWidth;
  final bool rtl;
  const _PeekLayout(this.visibleWidth, this.rtl);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) =>
      Offset(rtl ? size.width - visibleWidth : visibleWidth - childSize.width, 0);

  @override
  bool shouldRelayout(_PeekLayout oldDelegate) => visibleWidth != oldDelegate.visibleWidth || rtl != oldDelegate.rtl;
}

class DrawerEdgeBlocker extends StatelessWidget {
  const DrawerEdgeBlocker({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return PositionedDirectional(
      start: 0,
      top: 0,
      bottom: 0,
      width: DrawerPeek.edgeWidth + (isRtl ? padding.right : padding.left),
      child: const Listener(behavior: HitTestBehavior.opaque),
    );
  }
}
