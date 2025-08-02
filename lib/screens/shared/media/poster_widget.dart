import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/screens/shared/media/components/poster_image.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class PosterWidget extends ConsumerWidget {
  final ItemBaseModel poster;
  final Widget? subTitle;
  final bool? selected;
  final bool? heroTag;
  final int maxLines;
  final double? aspectRatio;
  final bool inlineTitle;
  final bool underTitle;
  final Set<ItemActions> excludeActions;
  final List<ItemAction> otherActions;
  final Function(String id, UserData? newData)? onUserDataChanged;
  final Function(ItemBaseModel newItem)? onItemUpdated;
  final Function(ItemBaseModel oldItem)? onItemRemoved;
  final Function(VoidCallback action, ItemBaseModel item)? onPressed;
  const PosterWidget(
      {required this.poster,
      this.subTitle,
      this.maxLines = 3,
      this.selected,
      this.heroTag,
      this.aspectRatio,
      this.inlineTitle = false,
      this.underTitle = true,
      this.excludeActions = const {},
      this.otherActions = const [],
      this.onUserDataChanged,
      this.onItemUpdated,
      this.onItemRemoved,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity = 0.65;
    return AspectRatio(
      aspectRatio: aspectRatio ?? AdaptiveLayout.poster(context).ratio,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: PosterImage(
              poster: poster,
              heroTag: heroTag ?? false,
              selected: selected,
              playVideo: (value) async => await poster.play(context, ref),
              inlineTitle: inlineTitle,
              excludeActions: excludeActions,
              otherActions: otherActions,
              onUserDataChanged: (newData) => onUserDataChanged?.call(poster.id, newData),
              onItemRemoved: onItemRemoved,
              onItemUpdated: onItemUpdated,
              onPressed: onPressed,
            ),
          ),
          if (!inlineTitle && underTitle)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: ClickableText(
                    onTap: AdaptiveLayout.viewSizeOf(context) != ViewSize.phone
                        ? () => poster.parentBaseModel.navigateTo(context)
                        : null,
                    text: poster.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (subTitle != null) ...[
                      Flexible(
                        child: Opacity(
                          opacity: opacity,
                          child: subTitle!,
                        ),
                      ),
                    ],
                    if (poster.subText?.isNotEmpty ?? false)
                      Flexible(
                        child: ClickableText(
                          opacity: opacity,
                          text: poster.subText ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      Flexible(
                        child: ClickableText(
                          opacity: opacity,
                          text: poster.subTextShort(context) ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                Flexible(
                  child: ClickableText(
                    opacity: opacity,
                    text: poster.subText?.isNotEmpty ?? false ? poster.subTextShort(context) ?? "" : "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ].take(maxLines).toList(),
            ),
        ],
      ),
    );
  }
}
