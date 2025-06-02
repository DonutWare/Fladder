import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/flat_button.dart';

class StickyHeaderText extends ConsumerStatefulWidget {
  final String label;
  final Function()? onClick;

  const StickyHeaderText({required this.label, this.onClick, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => StickyHeaderTextState();
}

class StickyHeaderTextState extends ConsumerState<StickyHeaderText> {
  late Color color = Theme.of(context).colorScheme.onSurface;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onTap: widget.onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 6,
          children: [
            Flexible(
              child: Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            if (widget.onClick != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 4),
                child: Icon(
                  IconsaxPlusLinear.arrow_right_3,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
          ],
        ),
      ),
    );
  }
}
