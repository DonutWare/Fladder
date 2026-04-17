import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fladder/models/items/trick_play_model.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/util/custom_cache_manager.dart';

class Chapter {
  final String name;
  final String imageUrl;
  final Uint8List? imageData;
  final Duration startPosition;
  final TrickPlayModel? trickplayFallback;
  Chapter({
    required this.name,
    required this.imageUrl,
    this.imageData,
    required this.startPosition,
    this.trickplayFallback,
  });

  ImageProvider get imageProvider {
    if (imageData != null) {
      return Image.memory(imageData!).image;
    }
    if (imageUrl.startsWith("http")) {
      return CachedNetworkImageProvider(
        cacheKey: name + imageUrl,
        cacheManager: CustomCacheManager.instance,
        imageUrl,
      );
    } else {
      return Image.file(
        key: Key(name + imageUrl),
        File(imageUrl),
      ).image;
    }
  }

  static List<Chapter> chaptersFromInfo(
      String itemId, List<dto.ChapterInfo> chapters, TrickPlayModel? trickplay, Ref ref) {
    return chapters.mapIndexed((index, element) {
      final startPosition = Duration(milliseconds: (element.startPositionTicks ?? 0) ~/ 10000);
      return Chapter(
          name: element.name ?? "",
          imageUrl: ref.read(imageUtilityProvider).getChapterUrl(itemId, index),
          startPosition: startPosition,
          trickplayFallback: trickplay);
    }).toList();
  }

  Chapter copyWith({
    String? name,
    String? imageUrl,
    Duration? startPosition,
    TrickPlayModel? trickplayFallback,
  }) {
    return Chapter(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      startPosition: startPosition ?? this.startPosition,
      trickplayFallback: trickplayFallback ?? this.trickplayFallback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'startPosition': startPosition.inMilliseconds,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      startPosition: Duration(milliseconds: map['startPosition'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) => Chapter.fromMap(json.decode(source));

  Future<bool> isImageValidWithCache({CacheManager? preferredCacheManager}) async {
    try {
      var cacheManager = preferredCacheManager ?? CustomCacheManager.instance;
      FileInfo? fileInfo = await cacheManager.getFileFromCache(imageUrl);

      fileInfo ??= await cacheManager.downloadFile(imageUrl);

      return fileInfo.file.existsSync();
    } catch (e) {
      return false;
    }
  }
}

extension ChapterExtension on List<Chapter> {
  Chapter? getChapterFromDuration(Duration duration) {
    return lastWhereOrNull((element) => element.startPosition < duration);
  }
}
