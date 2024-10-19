import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsLabelDivider extends ConsumerWidget {
  final String label;
  const SettingsLabelDivider({required this.label, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
