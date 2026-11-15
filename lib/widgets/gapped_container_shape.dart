import 'package:material_ui/material_ui.dart';
import 'dart:math' as math;

class GappedContainerShape extends StatelessWidget {
  final Color? activeColor;
  final Color? inActiveColor;
  final double? trackGapWidth;
  final double thumbPosition;

  const GappedContainerShape({
    this.activeColor,
    this.inActiveColor,
    this.trackGapWidth,
    required this.thumbPosition,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GappedContainerPainter(
        activeColor:
            activeColor ?? Theme.of(context).sliderTheme.activeTrackColor ?? Theme.of(context).colorScheme.primary,
        inActiveColor: inActiveColor ??
            Theme.of(context).sliderTheme.inactiveTrackColor ??
            Theme.of(context).colorScheme.secondaryContainer,
        trackGapWidth: trackGapWidth ?? 18,
        thumbCenterDxFraction: thumbPosition,
      ),
      child: Container(),
    );
  }
}

class _GappedContainerPainter extends CustomPainter {
  final Color activeColor;
  final Color inActiveColor;
  final double trackGapWidth;
  final double thumbCenterDxFraction;

  _GappedContainerPainter({
    required this.activeColor,
    required this.inActiveColor,
    required this.trackGapWidth,
    required this.thumbCenterDxFraction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = activeColor // Change this to the desired color
      ..style = PaintingStyle.fill;
    final Paint inActive = Paint()
      ..color = inActiveColor // Change this to the desired color
      ..style = PaintingStyle.fill;

    final Rect trackRect = Offset.zero & size;

    // Ensure thumbCenterDxFraction is not NaN or Infinity
    final double thumbCenterDx =
        thumbCenterDxFraction.isFinite ? thumbCenterDxFraction * size.width : 0.0; // Default to 0 if invalid fraction

    final Radius trackCornerRadius = Radius.circular(trackRect.shortestSide / 2);
    final Radius trackInsideCornerRadius = const Radius.circular(2.0);

    final RRect trackRRect = RRect.fromRectAndCorners(
      trackRect,
      topLeft: trackCornerRadius,
      bottomLeft: trackCornerRadius,
      topRight: trackCornerRadius,
      bottomRight: trackCornerRadius,
    );

    final RRect leftRRect = RRect.fromLTRBAndCorners(
      trackRect.left,
      trackRect.top,
      math.max(trackRect.left, thumbCenterDx - trackGapWidth / 2),
      trackRect.bottom,
      topLeft: trackCornerRadius,
      bottomLeft: trackCornerRadius,
      topRight: trackInsideCornerRadius,
      bottomRight: trackInsideCornerRadius,
    );

    final RRect rightRRect = RRect.fromLTRBAndCorners(
      thumbCenterDx + trackGapWidth / 2,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
      topRight: trackCornerRadius,
      bottomRight: trackCornerRadius,
      topLeft: trackInsideCornerRadius,
      bottomLeft: trackInsideCornerRadius,
    );

    canvas
      ..save()
      ..clipRRect(trackRRect);
    canvas.drawRRect(leftRRect, paint);
    canvas.drawRRect(rightRRect, inActive);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
