import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NestedBottomAppBar extends ConsumerWidget {
  final Widget child;
  const NestedBottomAppBar({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(bottom: MediaQuery.paddingOf(context).bottom),
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: child,
        ),
      ),
    );
  }
}
