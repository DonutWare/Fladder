import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatingActionButtonAnimated extends ConsumerWidget {
  final Widget label;
  final Widget icon;
  final String tooltip;
  final bool alternate;
  final bool isExtended;
  final void Function()? onPressed;
  const FloatingActionButtonAnimated({
    required this.label,
    required this.icon,
    required this.tooltip,
    this.alternate = false,
    this.isExtended = false,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      key: key,
      tooltip: tooltip,
      onPressed: onPressed,
      foregroundColor: alternate ? Theme.of(context).colorScheme.onSecondary : null,
      backgroundColor: alternate ? Theme.of(context).colorScheme.secondary : null,
      extendedPadding: const EdgeInsets.all(14),
      label: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        child: isExtended
            ? Row(
                children: [
                  icon,
                  const SizedBox(width: 6),
                  label,
                ],
              )
            : icon,
      ),
    );
  }
}
