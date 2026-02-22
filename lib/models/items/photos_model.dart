import 'package:flutter/material.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';

part 'photos_model.mapper.dart';

@MappableClass()
class PhotoAlbumModel extends ItemBaseModel with PhotoAlbumModelMappable {
  final List<ItemBaseModel> photos;

  const PhotoAlbumModel({
    required this.photos,
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
  @override
  bool get unWatched => userData.unPlayedItemCount != 0;

  @override
  bool get playAble => true;

  @override
  ItemBaseModel get parentBaseModel => copyWith(id: parentId);

  factory PhotoAlbumModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    return PhotoAlbumModel(
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
      photos: [],
    );
  }
}

@MappableClass()
class PhotoModel extends ItemBaseModel with PhotoModelMappable {
  final String? albumId;
  final DateTime? dateTaken;
  final ImagesData? thumbnail;
  final FladderItemType internalType;

  const PhotoModel({
    required this.albumId,
    required this.dateTaken,
    required this.thumbnail,
    required this.internalType,
    required super.name,
    required super.id,
    required super.overview,
    required super.parentId,
    required super.playlistId,
    required super.images,
    required super.childCount,
    required super.primaryRatio,
    required super.userData,
    required super.canDownload,
    required super.canDelete,
    super.jellyType,
  });

  @override
  PhotoAlbumModel get parentBaseModel => PhotoAlbumModel(
        photos: [],
        name: "",
        id: parentId ?? "",
        overview: overview,
        parentId: parentId,
        playlistId: playlistId,
        images: images,
        childCount: childCount,
        primaryRatio: primaryRatio,
        userData: userData,
      );

  @override
  ImagesData? get getPosters => thumbnail;

  @override
  bool get galleryItem => switch (internalType) {
        FladderItemType.photo => albumId?.isNotEmpty == true,
        FladderItemType.video => parentId?.isNotEmpty == true,
        _ => false,
      };

  @override
  bool get unWatched => false;

  factory PhotoModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    return PhotoModel(
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      primaryRatio: double.tryParse(item.aspectRatio ?? "") ?? item.primaryImageAspectRatio ?? 1.0,
      dateTaken: item.dateCreated,
      albumId: item.albumId,
      thumbnail: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      images: ref != null ? ImagesData.fromBaseItem(item, ref, getOriginalSize: true) : null,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      internalType: switch (item.type) {
        BaseItemKind.video => FladderItemType.video,
        _ => FladderItemType.photo,
      },
    );
  }

  String downloadPath(WidgetRef ref) {
    final baseUrl = ref.read(serverUrlProvider);
    if (baseUrl == null || baseUrl.isEmpty) return '';
    return buildServerUriFromBase(
          baseUrl,
          pathSegments: ['Items', id, 'Download'],
          queryParameters: {'api_key': ref.read(userProvider)?.credentials.token},
        )?.toString() ??
        '';
  }

  Future<void> navigateToAlbum(BuildContext context) async {
    if ((albumId ?? parentId) == null) {
      FladderSnack.show(context.localized.notPartOfAlbum, context: context);
      return;
    }
    await parentBaseModel.navigateTo(context);
    if (context.mounted) context.refreshData();
  }
}
