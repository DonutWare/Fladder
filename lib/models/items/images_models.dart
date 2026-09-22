import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/util/custom_cache_manager.dart';

class ImagesData {
  final ImageData? primary;
  final ImageData? thumb;
  final List<ImageData>? backDrop;
  final ImageData? logo;
  ImagesData({
    this.primary,
    this.thumb,
    this.backDrop,
    this.logo,
  });

  bool get isEmpty {
    if (primary == null && thumb == null && backDrop == null) return true;
    return false;
  }

  ImageData? get firstOrNull {
    return primary ?? thumb ?? backDrop?.firstOrNull;
  }

  ImageData? get randomBackDrop => (backDrop?..shuffle())?.firstOrNull ?? primary;

  static ImagesData? fromBaseItem(
    dto.BaseItemDto item,
    Ref ref, {
    Size backDrop = const Size(2000, 2000),
    Size thumb = const Size(1200, 1200),
    Size logo = const Size(500, 500),
    Size primary = const Size(600, 600),
    bool getOriginalSize = false,
  }) {
    final itemid = item.id;
    if (itemid == null) return null;
    final imageProvider = ref.read(imageUtilityProvider);

    final newImgesData = ImagesData(
      primary: item.imageTags?['Primary'] != null
          ? ImageData(
              path: getOriginalSize
                  ? imageProvider.getItemsOrigImageUrl(
                      itemid,
                      type: enums.ImageType.primary,
                    )
                  : imageProvider.getItemsImageUrl(
                      itemid,
                      type: enums.ImageType.primary,
                      maxHeight: primary.height.toInt(),
                      maxWidth: primary.width.toInt(),
                    ),
              key: "${itemid}_primary_${item.imageTags?['Primary']}",
              hash: item.imageBlurHashes?.primary?[item.imageTags?['Primary']] ?? "",
            )
          : null,
      thumb: item.imageTags?['Thumb'] != null
          ? ImageData(
              path: getOriginalSize
                  ? imageProvider.getItemsOrigImageUrl(
                      itemid,
                      type: enums.ImageType.thumb,
                    )
                  : imageProvider.getItemsImageUrl(
                      itemid,
                      type: enums.ImageType.thumb,
                      maxHeight: thumb.height.toInt(),
                      maxWidth: thumb.width.toInt(),
                    ),
              key: "${itemid}_thumb_${item.imageTags?['Thumb']}",
              hash: item.imageBlurHashes?.thumb?[item.imageTags?['Thumb']] ?? "",
            )
          : null,
      logo: ImageData(
          path: getOriginalSize
              ? imageProvider.getItemsOrigImageUrl(
                  itemid,
                  type: enums.ImageType.logo,
                )
              : imageProvider.getItemsImageUrl(
                  itemid,
                  type: enums.ImageType.logo,
                  maxHeight: logo.height.toInt(),
                  maxWidth: logo.width.toInt(),
                ),
          key: "${itemid}_logo_${item.imageTags?['Logo']}",
          hash: item.imageTags?['Logo'] != null ? (item.imageBlurHashes?.logo?[item.imageTags?['Logo']] ?? "") : ""),
      backDrop: (item.backdropImageTags ?? [])
          .mapIndexed(
            (index, backdrop) {
              final image = ImageData(
                path: getOriginalSize
                    ? imageProvider.getBackdropOrigImage(
                        itemid,
                        index,
                        backdrop,
                      )
                    : imageProvider.getBackdropImage(
                        itemid,
                        index,
                        backdrop,
                        maxHeight: backDrop.height.toInt(),
                        maxWidth: backDrop.width.toInt(),
                      ),
                key: "${itemid}_backdrop_${index}_$backdrop",
                hash: item.imageBlurHashes?.backdrop?[backdrop] ?? "",
              );
              return image;
            },
          )
          .nonNulls
          .toList(),
    );
    return newImgesData;
  }

  static ImagesData? fromBaseItemParent(
    dto.BaseItemDto item,
    Ref ref, {
    Size backDrop = const Size(2000, 2000),
    Size thumb = const Size(1200, 1200),
    Size logo = const Size(500, 500),
    Size primary = const Size(600, 600),
  }) {
    if (item.seriesId == null && item.parentId == null) return null;

    final imageProvider = ref.read(imageUtilityProvider);

    final newImgesData = ImagesData(
      primary: (item.seriesPrimaryImageTag != null)
          ? ImageData(
              path: imageProvider.getItemsImageUrl(
                item.seriesId,
                type: enums.ImageType.primary,
                maxHeight: primary.height.toInt(),
                maxWidth: primary.width.toInt(),
              ),
              key: "${item.seriesId}_primary_${item.seriesPrimaryImageTag ?? ""}",
              hash: item.imageBlurHashes?.primary?[item.seriesPrimaryImageTag] ?? "")
          : null,
      thumb: ((item.seriesThumbImageTag ?? item.parentThumbImageTag) != null)
          ? ImageData(
              path: imageProvider.getItemsImageUrl(
                item.parentThumbItemId ?? item.seriesId ?? item.parentId,
                type: enums.ImageType.thumb,
                maxHeight: thumb.height.toInt(),
                maxWidth: thumb.width.toInt(),
              ),
              key:
                  "${item.parentThumbItemId ?? item.seriesId ?? item.parentId}_thumb_${item.seriesThumbImageTag ?? item.parentThumbImageTag ?? ""}",
              hash: item.imageBlurHashes?.thumb?[item.seriesThumbImageTag ?? item.parentThumbImageTag] ?? "",
            )
          : null,
      logo: ImageData(
          path: imageProvider.getItemsImageUrl(
            item.seriesId,
            type: enums.ImageType.logo,
            maxHeight: logo.height.toInt(),
            maxWidth: logo.width.toInt(),
          ),
          key: "${item.seriesId}_logo_${item.parentLogoImageTag ?? ""}",
          hash: item.parentLogoImageTag != null ? (item.imageBlurHashes?.logo?[item.parentLogoImageTag] ?? "") : ""),
      backDrop: (item.backdropImageTags ?? [])
          .mapIndexed(
            (index, backdrop) {
              final itemId = item.seriesId ?? item.parentId;
              if (itemId == null) return null;
              final image = ImageData(
                path: imageProvider.getBackdropImage(
                  itemId,
                  index,
                  backdrop,
                  maxHeight: backDrop.height.toInt(),
                  maxWidth: backDrop.width.toInt(),
                ),
                key: "${itemId}_backdrop_${index}_$backdrop",
                hash: item.imageBlurHashes?.backdrop?[backdrop] ?? "",
              );
              return image;
            },
          )
          .nonNulls
          .toList(),
    );
    return newImgesData;
  }

  static ImagesData? fromPersonDto(
    dto.BaseItemPerson item,
    Ref ref, {
    Size backDrop = const Size(2000, 2000),
    Size logo = const Size(1000, 1000),
    Size primary = const Size(500, 500),
  }) {
    return ImagesData(
      primary: (item.primaryImageTag != null && item.imageBlurHashes != null)
          ? ImageData(
              path: ref.read(imageUtilityProvider).getItemsImageUrl(
                    item.id ?? "",
                    type: enums.ImageType.primary,
                    maxHeight: primary.height.toInt(),
                    maxWidth: primary.width.toInt(),
                  ),
              key: "${item.id ?? ""}_primary_${item.primaryImageTag ?? ''}",
              hash: item.imageBlurHashes?.primary?[item.primaryImageTag] ?? '')
          : null,
      thumb: null,
      logo: null,
      backDrop: null,
    );
  }

  @override
  String toString() => 'ImagesData(primary: $primary, thumb: $thumb, backDrop: $backDrop, logo: $logo)';

  ImagesData copyWith({
    ValueGetter<ImageData?>? primary,
    ValueGetter<ImageData?>? thumb,
    ValueGetter<List<ImageData>?>? backDrop,
    ValueGetter<ImageData?>? logo,
  }) {
    return ImagesData(
      primary: primary != null ? primary() : this.primary,
      thumb: thumb != null ? thumb() : this.thumb,
      backDrop: backDrop != null ? backDrop() : this.backDrop,
      logo: logo != null ? logo() : this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'primary': primary?.toMap(),
      'thumb': thumb?.toMap(),
      'backDrop': backDrop?.map((x) => x.toMap()).toList(),
      'logo': logo?.toMap(),
    };
  }

  factory ImagesData.fromMap(Map<String, dynamic> map) {
    return ImagesData(
      primary: map['primary'] != null ? ImageData.fromMap(map['primary']) : null,
      thumb: map['thumb'] != null ? ImageData.fromMap(map['thumb']) : null,
      backDrop:
          map['backDrop'] != null ? List<ImageData>.from(map['backDrop']?.map((x) => ImageData.fromMap(x))) : null,
      logo: map['logo'] != null ? ImageData.fromMap(map['logo']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagesData.fromJson(String source) => ImagesData.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImagesData &&
        other.primary?.hash == primary?.hash &&
        other.backDrop?.length == backDrop?.length &&
        other.logo?.hash == logo?.hash;
  }

  @override
  int get hashCode => Object.hash(primary?.hash, Object.hashAll(backDrop?.map((e) => e.hash) ?? []), logo?.hash);
}

class ImageData {
  final String path;
  final String hash;
  final String key;
  ImageData({
    this.path = '',
    this.hash = '',
    this.key = '',
  });

  ImageProvider get imageProvider {
    if (path.startsWith("http")) {
      return CachedNetworkImageProvider(
        cacheKey: key,
        cacheManager: CustomCacheManager.instance,
        path,
      );
    } else {
      return Image.file(
        key: Key(key),
        File(path),
      ).image;
    }
  }

  ImageProvider get nonCachedImageProvider {
    if (path.startsWith("http")) {
      return CachedNetworkImageProvider(
        cacheKey: UniqueKey().toString(),
        cacheManager: CustomCacheManager.instance,
        path,
      );
    } else {
      return Image.file(
        key: Key(key),
        File(path),
      ).image;
    }
  }

  @override
  String toString() => 'ImageData(path: $path, hash: $hash, key: $key)';

  ImageData copyWith({
    String? path,
    String? hash,
    String? key,
  }) {
    return ImageData(
      path: path ?? this.path,
      hash: hash ?? this.hash,
      key: key ?? this.key,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'hash': hash,
      'key': key,
    };
  }

  factory ImageData.fromMap(Map<String, dynamic> map) {
    return ImageData(
      path: map['path'] ?? '',
      hash: map['hash'] ?? '',
      key: map['key'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageData.fromJson(String source) => ImageData.fromMap(json.decode(source));
}
