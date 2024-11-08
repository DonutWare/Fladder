import 'package:flutter/material.dart';

import 'package:fladder/models/item_base_model.dart';

class PosterPlaceholder extends StatelessWidget {
  final ItemBaseModel item;
  const PosterPlaceholder({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Opacity(opacity: 0.5, child: Icon(item.type.icon)),
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
                  Opacity(
                    opacity: 0.75,
                    child: Text(
                      item.label(context)!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                      softWrap: true,
                    ),
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
