import 'package:ficonsax/ficonsax.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:flutter/material.dart';

extension CollectionTypeExtension on CollectionType {
  IconData get iconOutlined {
    return getIconType(true);
  }

  IconData get icon {
    return getIconType(false);
  }

  Set<FladderItemType> get itemKinds {
    switch (this) {
      case CollectionType.movies:
        return {FladderItemType.movie};
      case CollectionType.tvshows:
        return {FladderItemType.series};
      case CollectionType.homevideos:
        return {FladderItemType.photoAlbum, FladderItemType.folder, FladderItemType.photo, FladderItemType.video};
      case CollectionType.boxsets:
      case CollectionType.folders:
      case CollectionType.books:
      default:
        return {};
    }
  }

  IconData getIconType(bool outlined) {
    switch (this) {
      case CollectionType.movies:
        return outlined ? IconsaxOutline.video_horizontal : IconsaxBold.video_horizontal;
      case CollectionType.tvshows:
        return outlined ? IconsaxOutline.video_vertical : IconsaxBold.video_vertical;
      case CollectionType.boxsets:
      case CollectionType.folders:
        return outlined ? IconsaxOutline.folder : IconsaxBold.folder;
      case CollectionType.homevideos:
        return outlined ? IconsaxOutline.gallery : IconsaxBold.gallery;
      case CollectionType.books:
        return outlined ? IconsaxOutline.book : Icons.book_rounded;
      default:
        return IconsaxOutline.info_circle;
    }
  }
}
