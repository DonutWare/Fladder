import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/library_filter_model.dart';

extension CollectionTypeExtension on CollectionType? {
  IconData get iconOutlined {
    return getIconType(true);
  }

  IconData get icon {
    return getIconType(false);
  }

  bool get videos {
    switch (this) {
      case CollectionType.movies:
      case CollectionType.tvshows:
      case CollectionType.folders:
      case CollectionType.homevideos:
        return true;
      default:
        return false;
    }
  }

  bool get supportsExtras {
    switch (this) {
      case CollectionType.movies:
      case CollectionType.tvshows:
        return true;
      default:
        return false;
    }
  }

  bool get hasSubtitles {
    switch (this) {
      case CollectionType.movies:
      case CollectionType.tvshows:
        return true;
      default:
        return false;
    }
  }

  bool get audio {
    switch (this) {
      case CollectionType.music:
        return true;
      default:
        return false;
    }
  }

  bool get photos {
    switch (this) {
      case CollectionType.homevideos:
      case CollectionType.photos:
        return true;
      default:
        return false;
    }
  }

  Set<FladderItemType> get itemKinds {
    switch (this) {
      case CollectionType.music:
        return {FladderItemType.musicAlbum};
      case CollectionType.movies:
        return {FladderItemType.movie};
      case CollectionType.tvshows:
        return {FladderItemType.series};
      case CollectionType.homevideos:
        return {FladderItemType.photoAlbum, FladderItemType.folder, FladderItemType.photo, FladderItemType.video};
      case CollectionType.livetv:
        return {FladderItemType.tvchannel};
      default:
        return {};
    }
  }

  IconData getIconType(bool outlined) {
    switch (this) {
      case CollectionType.music:
        return outlined ? IconsaxPlusLinear.music_square : IconsaxPlusBold.music_square;
      case CollectionType.movies:
        return outlined ? IconsaxPlusLinear.video_horizontal : IconsaxPlusBold.video_horizontal;
      case CollectionType.tvshows:
        return outlined ? IconsaxPlusLinear.video_vertical : IconsaxPlusBold.video_vertical;
      case CollectionType.boxsets:
        return outlined ? IconsaxPlusLinear.box : IconsaxPlusBold.box;
      case CollectionType.folders:
        return outlined ? IconsaxPlusLinear.folder_2 : IconsaxPlusBold.folder_2;
      case CollectionType.homevideos:
        return outlined ? IconsaxPlusLinear.gallery : IconsaxPlusBold.gallery;
      case CollectionType.books:
        return outlined ? IconsaxPlusLinear.book : IconsaxPlusBold.book;
      case CollectionType.playlists:
        return outlined ? IconsaxPlusLinear.archive : IconsaxPlusBold.archive;
      case CollectionType.livetv:
        return outlined ? IconsaxPlusLinear.video_square : IconsaxPlusBold.video_square;
      default:
        return IconsaxPlusLinear.information;
    }
  }

  LibraryFilterModel get defaultFilters => switch (this) {
        CollectionType.homevideos || CollectionType.photos => const LibraryFilterModel(recursive: false),
        _ => const LibraryFilterModel(
            recursive: true,
          )
      };

  double? get aspectRatio => switch (this) {
        CollectionType.music ||
        CollectionType.homevideos ||
        CollectionType.boxsets ||
        CollectionType.photos ||
        CollectionType.livetv ||
        CollectionType.playlists =>
          0.8,
        CollectionType.folders => 1.3,
        _ => null,
      };
}
