import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/fladder_image.dart';

final _backgroundImageProvider = StateProvider<ImageData?>((ref) => null);

class BackgroundImage extends ConsumerStatefulWidget {
  final List<ItemBaseModel> items;
  final List<ImagesData> images;
  const BackgroundImage({this.items = const [], this.images = const [], super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends ConsumerState<BackgroundImage> {
  @override
  void initState() {
    super.initState();
    updateItems();
  }

  @override
  void didUpdateWidget(covariant BackgroundImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.items.equals(widget.items)) {
      updateItems();
    }
  }

  void updateItems() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final enabled = ref.read(
        clientSettingsProvider.select((value) => value.backgroundImage != BackgroundType.disabled),
      );
      if (!enabled || !mounted) return;

      ImageData? newImage;

      if (widget.images.isNotEmpty) {
        newImage = widget.images.shuffled().firstOrNull?.primary;
      } else if (widget.items.isNotEmpty) {
        final randomItem = widget.items.shuffled().firstOrNull;
        final itemId = switch (randomItem?.type) {
          FladderItemType.folder => randomItem?.id,
          FladderItemType.series => randomItem?.parentId ?? randomItem?.id,
          _ => randomItem?.id,
        };

        if (itemId != null) {
          final apiResponse = await ref.read(jellyApiProvider).usersUserIdItemsItemIdGet(itemId: itemId);

          newImage = apiResponse.body?.parentBaseModel.getPosters?.randomBackDrop ??
              apiResponse.body?.getPosters?.randomBackDrop ??
              apiResponse.body?.getPosters?.primary;
        }
      }

      if (newImage != null && mounted) {
        ref.read(_backgroundImageProvider.notifier).state = newImage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(clientSettingsProvider.select((value) => value.backgroundImage));
    final enabled = settings != BackgroundType.disabled;
    final image = ref.watch(_backgroundImageProvider);

    if (!enabled || image == null) return const SizedBox.shrink();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: FladderImage(
        key: ValueKey(image.key),
        image: image,
        fit: BoxFit.cover,
        blurOnly: settings == BackgroundType.blurred,
      ),
    );
  }
}
