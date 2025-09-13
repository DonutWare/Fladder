import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/user_provider.dart';

const _defaultHeight = 576;
const _defaultWidth = 384;
const _defaultQuality = 96;

final imageUtilityProvider = Provider<ImageNotifier>((ref) {
  return ImageNotifier(ref: ref);
});

class ImageNotifier {
  final Ref ref;
  ImageNotifier({
    required this.ref,
  });

  String get currentServerUrl {
    return ref.read(userProvider)?.server ?? ref.read(authProvider).serverLoginModel?.tempCredentials.server ?? "";
  }

  String getUserImageUrl(String id) {
    return Uri.decodeFull("$currentServerUrl/Users/$id/Images/${ImageType.primary.value}");
  }

  String getItemsImageUrl(String? itemId,
      {ImageType type = ImageType.primary,
      int maxHeight = _defaultHeight,
      int maxWidth = _defaultWidth,
      int quality = _defaultQuality}) {
    try {
      if (itemId == null) return "";

      return Uri.decodeFull(
          "$currentServerUrl/Items/$itemId/Images/${type.value}?fillHeight=$maxHeight&fillWidth=$maxWidth&quality=$quality");
    } catch (e) {
      return "";
    }
  }

  String getItemsOrigImageUrl(String? itemId, {ImageType type = ImageType.primary}) {
    try {
      if (itemId == null) return "";
      return Uri.decodeFull("$currentServerUrl/Items/$itemId/Images/${type.value}");
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
      return Uri.decodeFull("$currentServerUrl/Items/$itemId/Images/Backdrop/$index?tag=$hash");
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
      return Uri.decodeFull(
          "$currentServerUrl/Items/$itemId/Images/Backdrop/$index?tag=$hash&fillHeight=$maxHeight&fillWidth=$maxWidth&quality=$quality");
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
      return Uri.decodeFull(
          "$currentServerUrl/Items/$itemId/Images/Chapter/$index?fillHeight=$maxHeight&fillWidth=$maxWidth&quality=$quality");
    } catch (e) {
      return "";
    }
  }
}
