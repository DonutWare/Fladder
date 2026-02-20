import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

enum PositionContext { first, middle, last }

class PositionProvider extends InheritedWidget {
  final PositionContext position;

  const PositionProvider({
    required this.position,
    required super.child,
    super.key,
  });

  static PositionContext? of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PositionProvider>();
    return provider?.position;
  }

  @override
  bool updateShouldNotify(PositionProvider oldWidget) => position != oldWidget.position;
}

extension PositionProviderExtension on List<Widget> {
  List<Widget> withPositionProvider() {
    return mapIndexed(
      (index, e) => PositionProvider(
          position: index == 0
              ? PositionContext.first
              : (index == length - 1 ? PositionContext.last : PositionContext.middle),
          child: e),
    ).toList();
  }
}
