import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Adds browser-style middle mouse autoscroll to every [Scrollable] in the app.
///
/// Holding the middle button marks an origin. While it is held, the nearest horizontal and
/// the nearest vertical scrollable under the pointer scroll towards wherever the pointer is
/// relative to that origin, faster the further away it is. Releasing the button stops it.
class FladderScrollBehavior extends MaterialScrollBehavior {
  const FladderScrollBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    final scrollbar = super.buildScrollbar(context, child, details);
    final controller = details.controller;
    if (kIsWeb || controller == null) return scrollbar;
    return MiddleMouseAutoscroll(
      controller: controller,
      axisDirection: details.direction,
      child: scrollbar,
    );
  }
}

class MiddleMouseAutoscroll extends StatelessWidget {
  final ScrollController controller;
  final AxisDirection axisDirection;
  final Widget child;

  const MiddleMouseAutoscroll({
    required this.controller,
    required this.axisDirection,
    required this.child,
    super.key,
  });

  /// Pointer distance from the origin, in logical pixels, before anything starts moving.
  static const double deadZone = 8;

  /// Scroll speed gained per logical pixel the pointer sits past the dead zone, in pixels per second.
  static const double speedPerPixel = 6;

  /// Upper bound on the scroll speed, in logical pixels per second.
  static const double maxSpeed = 3000;

  // Pointer events reach listeners innermost first, so the first scrollable to claim an axis
  // for the current pointer is the nearest one. One session is shared by every listener.
  static _AutoscrollSession? _session;

  Axis get _axis => axisDirectionToAxis(axisDirection);

  ScrollPosition? get _position => controller.positions.length == 1 ? controller.position : null;

  static bool _isMiddleButton(PointerEvent event) =>
      event.kind == PointerDeviceKind.mouse && event.buttons & kMiddleMouseButton != 0;

  void _onPointerDown(BuildContext context, PointerDownEvent event) {
    if (!_isMiddleButton(event)) return;
    var session = _session;
    if (session == null || session.pointer != event.pointer) {
      session?.dispose();
      session = _session = _AutoscrollSession(pointer: event.pointer, origin: event.position);
    }
    final position = _position;
    if (position == null || session.claimed.containsKey(_axis)) return;
    final canScroll = position.hasContentDimensions &&
        position.maxScrollExtent > position.minScrollExtent &&
        position.physics.shouldAcceptUserOffset(position);
    if (!canScroll) return;
    session.claimed[_axis] = _ClaimedAxis(position, reversed: axisDirectionIsReversed(axisDirection));
    session.ensureStarted(context);
  }

  void _onPointerMove(PointerMoveEvent event) {
    final session = _session;
    if (session == null || event.pointer != session.pointer) return;
    if (!_isMiddleButton(event)) {
      _endSession();
      return;
    }
    session.current = event.position;
  }

  void _onPointerEnd(PointerEvent event) {
    if (_session?.pointer != event.pointer) return;
    _endSession();
  }

  static void _endSession() {
    _session?.dispose();
    _session = null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => _onPointerDown(context, event),
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerEnd,
      onPointerCancel: _onPointerEnd,
      child: child,
    );
  }
}

class _ClaimedAxis {
  final ScrollPosition position;
  final bool reversed;

  const _ClaimedAxis(this.position, {required this.reversed});
}

class _AutoscrollSession {
  final int pointer;
  final Offset origin;
  final Map<Axis, _ClaimedAxis> claimed = {};
  Offset current;

  Ticker? _ticker;
  Duration _lastTick = Duration.zero;
  OverlayEntry? _marker;

  _AutoscrollSession({required this.pointer, required this.origin}) : current = origin;

  void ensureStarted(BuildContext context) {
    if (_ticker != null) return;
    _ticker = Ticker(_onTick, debugLabel: 'MiddleMouseAutoscroll')..start();
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay != null) {
      _marker = OverlayEntry(builder: (context) => AutoscrollMarker(origin: origin));
      overlay.insert(_marker!);
    }
  }

  void _onTick(Duration elapsed) {
    final seconds = (elapsed - _lastTick).inMicroseconds / Duration.microsecondsPerSecond;
    _lastTick = elapsed;
    if (seconds <= 0) return;
    final offset = current - origin;
    for (final entry in claimed.entries) {
      final distance = entry.key == Axis.horizontal ? offset.dx : offset.dy;
      final speed = _speedFor(distance);
      if (speed == 0) continue;
      final delta = speed * seconds;
      entry.value.position.pointerScroll(entry.value.reversed ? -delta : delta);
    }
  }

  static double _speedFor(double distance) {
    final magnitude = distance.abs() - MiddleMouseAutoscroll.deadZone;
    if (magnitude <= 0) return 0;
    final speed = (magnitude * MiddleMouseAutoscroll.speedPerPixel).clamp(0.0, MiddleMouseAutoscroll.maxSpeed);
    return distance.isNegative ? -speed : speed;
  }

  void dispose() {
    _ticker?.dispose();
    _ticker = null;
    _marker?.remove();
    _marker?.dispose();
    _marker = null;
  }
}

/// The small badge drawn where the middle button was pressed, so the dead zone has a visible centre.
class AutoscrollMarker extends StatelessWidget {
  final Offset origin;

  const AutoscrollMarker({required this.origin, super.key});

  static const double size = 28;

  @override
  Widget build(BuildContext context) {
    final overlayBox = context.findAncestorRenderObjectOfType<RenderBox>();
    final local = overlayBox?.globalToLocal(origin) ?? origin;
    final colors = Theme.of(context).colorScheme;
    return Positioned(
      left: local.dx - size / 2,
      top: local.dy - size / 2,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.surface.withValues(alpha: 0.85),
            border: Border.all(color: colors.onSurface.withValues(alpha: 0.6)),
          ),
          child: Icon(Icons.open_with, size: 16, color: colors.onSurface),
        ),
      ),
    );
  }
}
