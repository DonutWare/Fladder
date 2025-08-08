import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/fladder_image.dart';

class BackgroundImage extends ConsumerStatefulWidget {
  final List<ItemBaseModel> items;
  final List<ImagesData> images;
  const BackgroundImage({this.items = const [], this.images = const [], super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends ConsumerState<BackgroundImage> {
  ImageData? backgroundImage;

  @override
  void didUpdateWidget(covariant BackgroundImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length || oldWidget.images.length != widget.images.length) {
      updateItems();
    }
  }

  @override
  void initState() {
    super.initState();
    updateItems();
  }

  void updateItems() {
    final enabled = ref.read(clientSettingsProvider.select((value) => value.backgroundPosters));

    WidgetsBinding.instance.addPostFrameCallback((value) async {
      if (!enabled && mounted) return;

      if (widget.images.isNotEmpty) {
        final image = widget.images.shuffled().firstOrNull?.primary;
        if (mounted) setState(() => backgroundImage = image);
        return;
      }

      if (widget.items.isEmpty) return;

      final randomItem = widget.items.shuffled().firstOrNull;
      final itemId = switch (randomItem?.type) {
        FladderItemType.folder => randomItem?.id,
        FladderItemType.series => randomItem?.parentId ?? randomItem?.id,
        _ => randomItem?.id,
      };

      if (itemId == null) return;

      final apiResponse = await ref.read(jellyApiProvider).usersUserIdItemsItemIdGet(itemId: itemId);
      final image = apiResponse.body?.parentBaseModel.getPosters?.randomBackDrop ??
          apiResponse.body?.getPosters?.randomBackDrop ??
          apiResponse.body?.getPosters?.primary;

      if (mounted) setState(() => backgroundImage = image);
    });
  }

  @override
  Widget build(BuildContext context) {
    final enabled = ref.watch(clientSettingsProvider.select((value) => value.backgroundPosters));
    return enabled
        ? FladderImage(
            image: backgroundImage,
            fit: BoxFit.cover,
            blurOnly: false,
          )
        : const SizedBox.shrink();
  }
}
