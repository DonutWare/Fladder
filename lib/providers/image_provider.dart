import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/api_provider.dart';

const _defaultHeight = 576;
const _defaultWidth = 384;
const _defaultQuality = 90;

final imageUtilityProvider = Provider<ImageNotifier>((ref) {
  return ImageNotifier(ref: ref);
});

class ImageNotifier {
  final Ref ref;
  ImageNotifier({
    required this.ref,
  });

  String get currentServerUrl {
    return ref.read(serverUrlProvider) ?? "";
  }

  String getUserImageUrl(String id) {
    final typeValue = ImageType.primary.value ?? 'Primary';
    return buildServerUrl(ref, pathSegments: ['Users', id, 'Images', typeValue]);
  }

  String getItemsImageUrl(String? itemId,
      {ImageType type = ImageType.primary,
      int maxHeight = _defaultHeight,
      int maxWidth = _defaultWidth,
      int quality = _defaultQuality}) {
    try {
      if (itemId == null) return "";
      final typeValue = type.value ?? 'Primary';

      return buildServerUrl(
        ref,
        pathSegments: ['Items', itemId, 'Images', typeValue],
        queryParameters: {
          'fillHeight': maxHeight.toString(),
          'fillWidth': maxWidth.toString(),
          'quality': quality.toString(),
        },
      );
    } catch (e) {
      return "";
    }
  }

  String getItemsOrigImageUrl(String? itemId, {ImageType type = ImageType.primary}) {
    try {
      if (itemId == null) return "";
      final typeValue = type.value ?? 'Primary';
      return buildServerUrl(ref, pathSegments: ['Items', itemId, 'Images', typeValue]);
    } catch (e) {
      return "";
    }
  }

  String getBackdropOrigImage(
    String itemId,
    int index,
    String hash,
  ) {
    try {
      return buildServerUrl(
        ref,
        pathSegments: ['Items', itemId, 'Images', 'Backdrop', index.toString()],
        queryParameters: {
          'tag': hash,
        },
      );
    } catch (e) {
      return "";
    }
  }

  String getBackdropImage(
    String itemId,
    int index,
    String hash, {
    int maxHeight = _defaultHeight,
    int maxWidth = _defaultWidth,
    int quality = _defaultQuality,
  }) {
    try {
      return buildServerUrl(
        ref,
        pathSegments: ['Items', itemId, 'Images', 'Backdrop', index.toString()],
        queryParameters: {
          'tag': hash,
          'fillHeight': maxHeight.toString(),
          'fillWidth': maxWidth.toString(),
          'quality': quality.toString(),
        },
      );
    } catch (e) {
      return "";
    }
  }

  String getChapterUrl(String itemId, int index,
      {ImageType type = ImageType.primary,
      int maxHeight = _defaultHeight,
      int maxWidth = _defaultWidth,
      int quality = _defaultQuality}) {
    try {
      return buildServerUrl(
        ref,
        pathSegments: ['Items', itemId, 'Images', 'Chapter', index.toString()],
        queryParameters: {
          'fillHeight': maxHeight.toString(),
          'fillWidth': maxWidth.toString(),
          'quality': quality.toString(),
        },
      );
    } catch (e) {
      return "";
    }
  }
}
