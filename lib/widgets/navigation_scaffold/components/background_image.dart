import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/providers/api_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      if (widget.images.isNotEmpty) {
        setState(() {
          backgroundImage = widget.images.shuffled().firstOrNull?.primary;
        });
        return;
      }
      final randomItem = widget.items.shuffled().firstOrNull;
      if (widget.items.isEmpty) return;
      final itemId = switch (randomItem?.type) {
            FladderItemType.folder => randomItem?.id,
            FladderItemType.series => randomItem?.parentId ?? randomItem?.id,
            _ => randomItem?.id,
          } ??
          randomItem?.id;
      if (itemId == null) return;
      final apiProvider = await ref.read(jellyApiProvider).usersUserIdItemsItemIdGet(
            itemId: itemId,
          );
      setState(() {
        backgroundImage = apiProvider.body?.parentBaseModel.getPosters?.randomBackDrop ??
            apiProvider.body?.getPosters?.randomBackDrop;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FladderImage(
      image: backgroundImage,
      fit: BoxFit.cover,
      blurOnly: false,
    );
  }
}
