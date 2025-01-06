import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AbsorbEvents extends ConsumerWidget {
  final bool absorb;
  final Widget child;
  const AbsorbEvents({super.key, required this.child, this.absorb = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (absorb) {
      return GestureDetector(
        onDoubleTap: () {},
        onTap: () {},
        onLongPress: () {},
        child: Container(color: Colors.black.withValues(alpha: 0), child: child),
      );
    } else {
      return child;
    }
  }
}
