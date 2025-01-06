import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/screens/shared/flat_button.dart';

class ChipButton extends ConsumerWidget {
  final String label;
  final Function()? onPressed;
  const ChipButton({required this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.15),
      shadowColor: Colors.transparent,
      child: FlatButton(
        onTap: onPressed,
        // ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
