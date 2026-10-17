import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/video_part_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/sync_provider.dart';

/// Fetches the additional parts (Part 2..N) of a multi-part movie or episode.
///
/// Offline, the parts are loaded from the sync database and the stream updates
/// as downloads are added. Online, the server response is fetched once.
final videoPartsProvider = StreamProvider.autoDispose.family<List<VideoPartModel>, String>((ref, itemId) {
  final isOffline = ref.watch(offlineStateProvider);
  if (isOffline) {
    return ref.read(syncProvider.notifier).watchChildren(itemId).map((children) {
      return children
          .where((child) => child.partOfId == itemId)
          .map((child) => child.itemModel)
          .whereType<VideoPartModel>()
          .toList()
        ..sort((a, b) => a.partNumber.compareTo(b.partNumber));
    });
  }

  return Stream.fromFuture(() async {
    try {
      final response = await ref.read(jellyApiProvider).getAdditionalParts(itemId: itemId);
      final items = response.body?.items ?? const [];
      if (items.isEmpty) return const <VideoPartModel>[];

      return VideoPartModel.fromDtos(
        items,
        ref,
        parentItemId: itemId,
        totalParts: items.length + 1,
      );
    } catch (e) {
      return const <VideoPartModel>[];
    }
  }());
});
