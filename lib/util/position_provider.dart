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
  List<Widget> withPositionProvider({BuildContext? context, TextDirection? textDirection}) {
    final resolvedDirection = textDirection ?? (context != null ? Directionality.of(context) : TextDirection.ltr);
    final firstIndex = resolvedDirection == TextDirection.rtl ? length - 1 : 0;
    final lastIndex = resolvedDirection == TextDirection.rtl ? 0 : length - 1;

    return mapIndexed(
      (index, e) => PositionProvider(
          position: index == firstIndex
              ? PositionContext.first
              : (index == lastIndex ? PositionContext.last : PositionContext.middle),
          child: e),
    ).toList();
  }
}
