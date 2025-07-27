import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusCard extends ConsumerWidget {
  final Color? color;
  final bool useFittedBox;
  final Widget child;

  const StatusCard({this.color, this.useFittedBox = false, required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SizedBox.square(
        dimension: 33,
        child: Card(
          elevation: 10,
          surfaceTintColor: color,
          shadowColor: color != null ? Colors.transparent : null,
          child: IconTheme(
            data: IconThemeData(
              color: color,
            ),
            child: Center(
              child: useFittedBox
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: child,
                    )
                  : child,
            ),
          ),
        ),
      ),
    );
  }
}
