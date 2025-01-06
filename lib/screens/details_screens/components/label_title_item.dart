import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LabelTitleItem extends ConsumerWidget {
  final Text? title;
  final String? label;
  final Widget? content;
  const LabelTitleItem({
    this.title,
    this.label,
    this.content,
    super.key,
  }) : assert(label != null || content != null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
              opacity: 0.6,
              child: Material(
                  color: Colors.transparent, textStyle: Theme.of(context).textTheme.titleMedium, child: title)),
          const SizedBox(width: 12),
          label != null
              ? SelectableText(
                  label!,
                )
              : content!,
        ].nonNulls.toList(),
      ),
    );
  }
}
