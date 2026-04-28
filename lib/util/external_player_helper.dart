import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/user_provider.dart';

class ExternalPlayerHelper {
  static const String energyProtocol = 'energyplayer:launch=media';
  static const String energyStoreUrl =
      'ms-windows-store://pdp/?productid=9P9ZH5FL1BFK';

  static bool canShowEnergyPlayer(ItemBaseModel? item) {
    if (!Platform.isWindows) return false;
    if (item == null) return false;
    return item.streamModel?.hasDolbyVision ?? false;
  }

  static Future<bool> isEnergyPlayerInstalled() async {
    if (!Platform.isWindows) return false;
    final uri = Uri.parse('energyplayer:');
    return await canLaunchUrl(uri);
  }

  static Future<void> openStore() async {
    final uri = Uri.parse(energyStoreUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Fallback to web link if store protocol fails
      await launchUrl(
          Uri.parse('https://apps.microsoft.com/detail/9P9ZH5FL1BFK'));
    }
  }

  static Future<void> launchEnergyPlayer(
      WidgetRef ref, ItemBaseModel item) async {
    final user = ref.read(userProvider);
    if (user == null) return;

    var serverUrl = user.credentials.url;
    final apiKey = user.credentials.token;

    if (serverUrl.isEmpty || apiKey.isEmpty) return;

    // Normalize serverUrl to avoid double slashes
    if (serverUrl.endsWith('/')) {
      serverUrl = serverUrl.substring(0, serverUrl.length - 1);
    }

    final videoId = item.id;
    final streamUrl =
        "$serverUrl/Videos/$videoId/stream?static=true&api_key=$apiKey";

    // Subtitles
    final currentSub = item.streamModel?.currentSubStream;
    final subsPath =
        (currentSub != null && currentSub.url != null) ? currentSub.url! : "";

    // Start position (Energy Player uses seconds)
    final startTime = (item.userData.playbackPositionTicks) ~/ 10000000;

    // Use proper encoding for individual parameters (no manual quotes needed)
    final energyUrl = 'energyplayer:launch=media'
        '&path=${Uri.encodeComponent(streamUrl)}'
        '&subsPath=${Uri.encodeComponent(subsPath)}'
        '&startTime=$startTime';

    final uri = Uri.parse(energyUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await openStore();
    }
  }
}
