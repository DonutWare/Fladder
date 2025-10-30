import 'package:flutter/material.dart';

import 'package:fladder/models/item_base_model.dart';

class PosterPlaceholder extends StatelessWidget {
  final ItemBaseModel item;
  const PosterPlaceholder({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75);
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              item.type.icon,
              color: color.withValues(alpha: 0.5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                ),
                if (item.label(context) != null) ...[
                  Text(
                    item.label(context)!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: color.withValues(alpha: 0.75),
                        ),
                    softWrap: true,
                  ),
                ],
              ],
            ),
          ),
        )
      ],
    );
  }
}
