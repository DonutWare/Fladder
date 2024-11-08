import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/media/components/poster_placeholder.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/util/string_extensions.dart';

class EmptyItem extends ConsumerWidget {
  final ItemBaseModel item;
  const EmptyItem({required this.item, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DetailScaffold(
      label: "Empty",
      item: item,
      backDrops: item.images,
      actions: (context) => item.generateActions(
        context,
        ref,
        exclude: {
          ItemActions.play,
          ItemActions.playFromStart,
          ItemActions.details,
        },
        onDeleteSuccesFully: (item) {
          if (context.mounted) {
            context.router.popBack();
          }
        },
      ),
      content: (padding) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 350),
            child: AspectRatio(
              aspectRatio: 0.67,
              child: Card(
                elevation: 6,
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.0,
                    color: Colors.white.withOpacity(0.10),
                  ),
                  borderRadius: FladderTheme.defaultShape.borderRadius,
                ),
                child: FladderImage(
                  image: item.getPosters?.primary ?? item.getPosters?.backDrop?.lastOrNull,
                  placeHolder: PosterPlaceholder(item: item),
                ),
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Type of (Jelly.${item.jellyType?.name.capitalize()}) has not been implemented yet."),
        ].addInBetween(const SizedBox(height: 32)),
      ),
    );
  }
}
