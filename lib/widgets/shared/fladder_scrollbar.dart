import 'package:flexible_scrollbar/flexible_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FladderScrollbar extends ConsumerWidget {
  final ScrollController controller;
  final Widget child;
  final bool visible;
  const FladderScrollbar({
    required this.controller,
    required this.child,
    this.visible = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return visible
        ? FlexibleScrollbar(
            child: child,
            controller: controller,
            alwaysVisible: false,
            scrollThumbBuilder: (ScrollbarInfo info) {
              return AnimatedContainer(
                width: info.isDragging ? 24 : 8,
                height: (info.thumbMainAxisSize / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: info.isDragging
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.75),
                ),
                duration: const Duration(milliseconds: 250),
              );
            },
          )
        : child;
  }
}
