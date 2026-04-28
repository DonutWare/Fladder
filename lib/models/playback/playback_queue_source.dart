import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/providers/api_provider.dart';

abstract class PlaybackQueueSource {
  final int limit;

  const PlaybackQueueSource({required this.limit});

  Future<List<ItemBaseModel>> fetchQueue(Ref ref, {int? limit});
}

class ArtistLatestTracksQueueSource extends PlaybackQueueSource {
  final String artistId;

  const ArtistLatestTracksQueueSource({
    required this.artistId,
    required super.limit,
  });

  @override
  Future<List<ItemBaseModel>> fetchQueue(Ref ref, {int? limit}) async {
    final response = await ref.read(jellyApiProvider).itemsGet(
          parentId: artistId,
          includeItemTypes: [BaseItemKind.audio],
          enableUserData: true,
          enableImages: true,
          recursive: true,
          imageTypeLimit: 1,
          fields: [ItemFields.primaryimageaspectratio],
          sortBy: [
            ItemSortBy.playcount,
            ItemSortBy.productionyear,
            ItemSortBy.premieredate,
            ItemSortBy.datecreated,
            ItemSortBy.sortname,
          ],
          sortOrder: [SortOrder.descending],
          limit: limit ?? this.limit,
        );

    return response.body?.items.whereType<AudioModel>().toList() ?? [];
  }
}
