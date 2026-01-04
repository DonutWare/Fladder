import 'package:flutter/widgets.dart';

enum PositionContext { first, middle, last }

class PositionProvider extends InheritedWidget {
  final PositionContext position;

  const PositionProvider({
    required this.position,
    required super.child,
    super.key,
  });

  static PositionContext of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PositionProvider>();
    return provider?.position ?? PositionContext.middle;
  }

  @override
  bool updateShouldNotify(PositionProvider oldWidget) => position != oldWidget.position;
}
