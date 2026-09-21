import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/util/custom_cache_manager.dart';

const _defaultBackDrop = Size(2000, 2000);
const _defaultThumb = Size(1200, 1200);
const _defaultLogo = Size(500, 500);
const _defaultPrimary = Size(600, 600);
const _defaultPersonPrimary = Size(500, 500);

/// Distinguishes cache entries for the same image at different sizes, leaving
/// keys for the default size unchanged.
String _sizeSuffix(Size size, Size defaultSize, {bool original = false}) {
  if (original) return '_orig';
  if (size == defaultSize) return '';
  return '_${size.width.toInt()}x${size.height.toInt()}';
}

/// For entries persisted before [ImageData.largeArt] existed.
bool _looksLikeLargeArt(String key) => key.contains('_backdrop_') || key.contains('_thumb_');

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

  /// A backdrop that varies between items but is stable for any given one, so
  /// rebuilds do not trigger new downloads.
  ImageData? get randomBackDrop {
    final backDrops = backDrop;
    if (backDrops == null || backDrops.isEmpty) return primary;
    final seed = backDrops.first.key.hashCode.abs();
    return backDrops[seed % backDrops.length];
  }

  /// The backdrop following [current], for callers that deliberately cycle art.
  ImageData? backDropAfter(ImageData? current) {
    final backDrops = backDrop;
    if (backDrops == null || backDrops.isEmpty) return primary;
    final index = current == null ? -1 : backDrops.indexWhere((image) => image.key == current.key);
    return backDrops[(index + 1) % backDrops.length];
  }

  static ImagesData? fromBaseItem(
    dto.BaseItemDto item,
    Ref ref, {
    Size backDrop = _defaultBackDrop,
    Size thumb = _defaultThumb,
    Size logo = _defaultLogo,
    Size primary = _defaultPrimary,
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
              key:
                  "${itemid}_primary_${item.imageTags?['Primary']}${_sizeSuffix(primary, _defaultPrimary, original: getOriginalSize)}",
              largeArt: getOriginalSize,
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
              key:
                  "${itemid}_thumb_${item.imageTags?['Thumb']}${_sizeSuffix(thumb, _defaultThumb, original: getOriginalSize)}",
              largeArt: true,
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
          key: "${itemid}_logo_${item.imageTags?['Logo']}${_sizeSuffix(logo, _defaultLogo, original: getOriginalSize)}",
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
                key:
                    "${itemid}_backdrop_${index}_$backdrop${_sizeSuffix(backDrop, _defaultBackDrop, original: getOriginalSize)}",
                largeArt: true,
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
    Size backDrop = _defaultBackDrop,
    Size thumb = _defaultThumb,
    Size logo = _defaultLogo,
    Size primary = _defaultPrimary,
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
              key:
                  "${item.seriesId}_primary_${item.seriesPrimaryImageTag ?? ""}${_sizeSuffix(primary, _defaultPrimary)}",
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
                  "${item.parentThumbItemId ?? item.seriesId ?? item.parentId}_thumb_${item.seriesThumbImageTag ?? item.parentThumbImageTag ?? ""}${_sizeSuffix(thumb, _defaultThumb)}",
              largeArt: true,
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
          key: "${item.seriesId}_logo_${item.parentLogoImageTag ?? ""}${_sizeSuffix(logo, _defaultLogo)}",
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
                key: "${itemId}_backdrop_${index}_$backdrop${_sizeSuffix(backDrop, _defaultBackDrop)}",
                largeArt: true,
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
    Size primary = _defaultPersonPrimary,
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
              key:
                  "${item.id ?? ""}_primary_${item.primaryImageTag ?? ''}${_sizeSuffix(primary, _defaultPersonPrimary)}",
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

  /// Large art (backdrops, thumbs, original-size images) is cached in a separate
  /// store so a few multi-megabyte files cannot evict thousands of posters.
  final bool largeArt;
  ImageData({
    this.path = '',
    this.hash = '',
    this.key = '',
    this.largeArt = false,
  });

  CacheManager get _cacheManager => largeArt ? CustomCacheManager.largeArt : CustomCacheManager.instance;

  ImageProvider get imageProvider {
    if (path.startsWith("http")) {
      return CachedNetworkImageProvider(
        cacheKey: key,
        cacheManager: _cacheManager,
        path,
      );
    } else {
      return Image.file(
        key: Key(key),
        File(path),
      ).image;
    }
  }

  /// Always re-fetches, for images that may have just changed on the server
  /// (a library thumbnail the user edited). The cache-buster keeps Flutter's
  /// in-memory [ImageCache] from serving a stale copy, and nothing is written to
  /// the disk stores.
  ImageProvider get nonCachedImageProvider {
    if (path.startsWith("http")) {
      final separator = path.contains('?') ? '&' : '?';
      return NetworkImage('$path${separator}nocache=${DateTime.now().microsecondsSinceEpoch}');
    } else {
      return Image.file(
        key: Key(key),
        File(path),
      ).image;
    }
  }

  @override
  String toString() => 'ImageData(path: $path, hash: $hash, key: $key, largeArt: $largeArt)';

  ImageData copyWith({
    String? path,
    String? hash,
    String? key,
    bool? largeArt,
  }) {
    return ImageData(
      path: path ?? this.path,
      hash: hash ?? this.hash,
      key: key ?? this.key,
      largeArt: largeArt ?? this.largeArt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'hash': hash,
      'key': key,
      'largeArt': largeArt,
    };
  }

  factory ImageData.fromMap(Map<String, dynamic> map) {
    return ImageData(
      path: map['path'] ?? '',
      hash: map['hash'] ?? '',
      key: map['key'] ?? '',
      largeArt: map['largeArt'] ?? _looksLikeLargeArt(map['key'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageData.fromJson(String source) => ImageData.fromMap(json.decode(source));
}
