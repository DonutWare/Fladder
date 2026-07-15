import 'package:flutter/material.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';

part 'playlist_model.mapper.dart';

@MappableClass()
class PlaylistModel extends ItemBaseModel with PlaylistModelMappable {
  PlaylistModel({
    required super.name,
    required super.id,
    required super.overview,
    required super.parentId,
    required super.playlistId,
    required super.images,
    required super.childCount,
    required super.primaryRatio,
    required super.userData,
    super.canDelete,
    super.canDownload,
    super.jellyType,
  });

  factory PlaylistModel.fromBaseDto(BaseItemDto item, Ref? ref) {
    return PlaylistModel(
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      primaryRatio: item.primaryImageAspectRatio,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      jellyType: item.type,
    );
  }

  @override
  bool get syncAble => true;

  @override
  bool get playAble => true;

  Widget iconWidget(
    BuildContext context, {
    bool usePoster = false,
    Color? backgroundColor = Colors.transparent,
  }) {
    if (usePoster) {
      return SizedBox.square(
        dimension: 45,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: FladderTheme.smallShape.borderRadius,
            color: backgroundColor,
          ),
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: FladderTheme.smallShape.borderRadius,
            child: FladderImage(
              image: images?.primary,
              placeHolder: Container(
                color: backgroundColor,
                child: Icon(
                  FladderItemType.playlist.icon,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return Icon(
        FladderItemType.playlist.icon,
        color: Theme.of(context).colorScheme.onSurface,
      );
    }
  }
}
