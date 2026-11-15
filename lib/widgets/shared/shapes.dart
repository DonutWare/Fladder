import 'package:material_ui/material_ui.dart';

class AppBarShape extends OutlinedBorder {
  @override
  OutlinedBorder copyWith({BorderSide? side}) => this; //todo

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(rect)
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(rect.left, rect.bottom - 14, rect.width, 14),
        topLeft: const Radius.circular(14),
        topRight: const Radius.circular(14),
      ));
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return getInnerPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    /// create shader linear gradient
    canvas.drawPath(getInnerPath(rect), Paint()..color = Colors.transparent);
  }

  @override
  ShapeBorder scale(double t) => this;
}

class BottomBarShape extends OutlinedBorder {
  @override
  OutlinedBorder copyWith({BorderSide? side}) => this; //todo

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(rect)
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(rect.left, rect.top, rect.width, 14),
        bottomLeft: const Radius.circular(14),
        bottomRight: const Radius.circular(14),
      ));
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return getInnerPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    /// create shader linear gradient
    canvas.drawPath(getInnerPath(rect), Paint()..color = Colors.transparent);
  }

  @override
  ShapeBorder scale(double t) => this;
}
