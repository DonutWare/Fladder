// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';

import 'package:dart_mappable/dart_mappable.dart';

part 'folder_model.mapper.dart';

@MappableClass()
class FolderModel extends ItemBaseModel with FolderModelMappable {
  final List<ItemBaseModel> items;

  const FolderModel({
    required this.items,
    required super.overview,
    required super.parentId,
    required super.playlistId,
    required super.images,
    required super.childCount,
    required super.primaryRatio,
    required super.userData,
    required super.name,
    required super.id,
    super.canDownload,
    super.canDelete,
    super.jellyType,
  });

  factory FolderModel.fromBaseDto(BaseItemDto item, Ref? ref) {
    return FolderModel(
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      primaryRatio: item.primaryImageAspectRatio,
      items: [],
      canDelete: item.canDelete,
      canDownload: item.canDownload,
    );
  }
}
