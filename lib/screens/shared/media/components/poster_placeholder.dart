import 'package:flutter/material.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/util/localization_helper.dart';

class PosterPlaceholder extends StatelessWidget {
  final ItemBaseModel item;
  const PosterPlaceholder({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                    ),
                softWrap: true,
              ),
              if (item.label(context.localized) != null) ...[
                Text(
                  item.label(context.localized)!,
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
        )
      ],
    );
  }
}
