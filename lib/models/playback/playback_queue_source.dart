import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/providers/api_provider.dart';

typedef ProviderReader = T Function<T>(ProviderListenable<T> provider);

abstract class PlaybackQueueSource {
  final int limit;

  const PlaybackQueueSource({required this.limit});

  bool get supportsRefill => false;

  Future<List<ItemBaseModel>> fetchQueue(ProviderReader read, {int? limit, int? startIndex});
}

class ArtistLatestTracksQueueSource extends PlaybackQueueSource {
  final String artistId;

  const ArtistLatestTracksQueueSource({
    required this.artistId,
    required super.limit,
  });

  @override
  bool get supportsRefill => true;

  @override
  Future<List<ItemBaseModel>> fetchQueue(ProviderReader read, {int? limit, int? startIndex}) async {
    final response = await read(jellyApiProvider).itemsGet(
      parentId: artistId,
      includeItemTypes: [BaseItemKind.audio],
      enableUserData: true,
      enableImages: true,
      recursive: true,
      imageTypeLimit: 1,
      startIndex: startIndex,
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

class ArtistCatalogQueueSource extends PlaybackQueueSource {
  final String artistId;

  const ArtistCatalogQueueSource({
    required this.artistId,
    required super.limit,
  });

  @override
  bool get supportsRefill => true;

  @override
  Future<List<ItemBaseModel>> fetchQueue(ProviderReader read, {int? limit, int? startIndex}) async {
    final response = await read(jellyApiProvider).itemsGet(
      artistIds: [artistId],
      includeItemTypes: [BaseItemKind.audio],
      recursive: true,
      filters: [ItemFilter.isnotfolder],
      excludeLocationTypes: [LocationType.virtual],
      sortBy: [
        ItemSortBy.album,
        ItemSortBy.parentindexnumber,
        ItemSortBy.indexnumber,
        ItemSortBy.sortname,
      ],
      sortOrder: [SortOrder.ascending],
      fields: [
        ItemFields.chapters,
        ItemFields.trickplay,
      ],
      enableTotalRecordCount: false,
      collapseBoxSetItems: false,
      startIndex: startIndex,
      limit: limit ?? this.limit,
    );

    return response.body?.items.whereType<AudioModel>().toList() ?? [];
  }
}

class AlbumInstantMixQueueSource extends PlaybackQueueSource {
  final String albumId;

  const AlbumInstantMixQueueSource({
    required this.albumId,
    required super.limit,
  });

  @override
  Future<List<ItemBaseModel>> fetchQueue(ProviderReader read, {int? limit, int? startIndex}) async {
    final response = await read(jellyApiProvider).albumInstantMixGet(
      itemId: albumId,
      limit: limit ?? this.limit,
    );

    return response.body?.items.whereType<AudioModel>().toList() ?? [];
  }
}

class ArtistInstantMixQueueSource extends PlaybackQueueSource {
  final String artistId;

  const ArtistInstantMixQueueSource({
    required this.artistId,
    required super.limit,
  });

  @override
  Future<List<ItemBaseModel>> fetchQueue(ProviderReader read, {int? limit, int? startIndex}) async {
    final response = await read(jellyApiProvider).artistInstantMixGet(
      itemId: artistId,
      limit: limit ?? this.limit,
    );

    return response.body?.items.whereType<AudioModel>().toList() ?? [];
  }
}

class AudioInstantMixQueueSource extends PlaybackQueueSource {
  final String audioId;

  const AudioInstantMixQueueSource({
    required this.audioId,
    required super.limit,
  });

  @override
  Future<List<ItemBaseModel>> fetchQueue(ProviderReader read, {int? limit, int? startIndex}) async {
    final response = await read(jellyApiProvider).audioInstantMixGet(
      itemId: audioId,
      limit: limit ?? this.limit,
    );

    return response.body?.items.whereType<AudioModel>().toList() ?? [];
  }
}
