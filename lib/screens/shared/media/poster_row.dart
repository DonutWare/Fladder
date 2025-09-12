import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/media/poster_widget.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';

class PosterRow extends ConsumerWidget {
  final List<ItemBaseModel> posters;
  final String label;
  final double? collectionAspectRatio;
  final Function()? onLabelClick;
  final EdgeInsets contentPadding;
  final bool autoFocus;
  final Function(ItemBaseModel focused)? onFocused;
  const PosterRow({
    required this.posters,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    required this.label,
    this.collectionAspectRatio,
    this.onLabelClick,
    this.onFocused,
    this.autoFocus = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dominantRatio = collectionAspectRatio ?? posters.getMostCommonType.aspectRatio;
    return HorizontalList(
      contentPadding: contentPadding,
      label: label,
      autoFocus: autoFocus,
      onLabelClick: onLabelClick,
      dominantRatio: dominantRatio,
      items: posters,
      onFocused: (index) => onFocused?.call(posters[index]),
      itemBuilder: (context, index, selected) {
        final poster = posters[index];
        return PosterWidget(
          key: Key(poster.id),
          poster: poster,
          aspectRatio: dominantRatio,
        );
      },
    );
  }
}
