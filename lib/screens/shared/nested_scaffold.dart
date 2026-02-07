import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NestedScaffold extends ConsumerWidget {
  final Widget body;
  final Widget? background;
  const NestedScaffold({
    required this.body,
    this.background,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (background != null) background!,
        body,
      ],
    );
  }
}
