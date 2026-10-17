import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/video_part_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';

/// Fetches the additional parts (Part 2..N) of a multi-part movie or episode.
///
/// Parts are only fetched online. Offline playback support is added in a
/// later phase, so this returns an empty list while offline or when the
/// request fails.
final videoPartsProvider = FutureProvider.autoDispose.family<List<VideoPartModel>, String>((ref, itemId) async {
  final isOffline = ref.watch(offlineStateProvider);
  if (isOffline) return const [];

  try {
    final response = await ref.read(jellyApiProvider).getAdditionalParts(itemId: itemId);
    final items = response.body?.items ?? const [];
    if (items.isEmpty) return const [];

    return VideoPartModel.fromDtos(
      items,
      ref,
      parentItemId: itemId,
      totalParts: items.length + 1,
    );
  } catch (e) {
    return const [];
  }
});
