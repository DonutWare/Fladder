import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/playback/playback_queue_source.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/util/map_bool_helper.dart';

class PhotoQueueSource {
  final LibrarySearchModel libraryState;
  final String? parentId;
  final bool? recursive;
  final bool shuffle;
  final int limit;

  const PhotoQueueSource({
    required this.libraryState,
    required this.parentId,
    required this.recursive,
    required this.shuffle,
    required this.limit,
  });

  Future<({List<PhotoModel> items, int totalCount})> fetchPhotos(
    ProviderReader read, {
    int? startIndex,
  }) async {
    final filters = libraryState.filters;
    final searchTerm = libraryState.filters.searchQuery.isNotEmpty ? libraryState.filters.searchQuery : null;

    final response = await read(jellyApiProvider).itemsGet(
      parentId: parentId,
      searchTerm: searchTerm,
      genres: filters.genres.included,
      tags: filters.tags.included,
      recursive: recursive,
      officialRatings: filters.officialRatings.included,
      years: filters.years.included,
      isMissing: false,
      limit: limit,
      startIndex: startIndex,
      collapseBoxSetItems: false,
      studioIds: filters.studios.included.map((e) => e.id).toList(),
      sortBy: shuffle ? [ItemSortBy.random] : filters.sortingOption.toSortBy,
      sortOrder: [filters.sortOrder.sortOrder],
      fields: [
        ItemFields.genres,
        ItemFields.parentid,
        ItemFields.tags,
        ItemFields.datecreated,
        ItemFields.datelastmediaadded,
        ItemFields.overview,
        ItemFields.originaltitle,
        ItemFields.customrating,
        ItemFields.primaryimageaspectratio,
      ],
      isFavorite: filters.favourites,
      filters: filters.itemFilters.included,
      includeItemTypes: filters.types.included.map((e) => e.dtoKind).expand((e) => e).toList(),
      enableImages: true,
      enableUserData: true,
      imageTypeLimit: 1,
    );

    final items = response.body?.items.whereType<PhotoModel>().toList() ?? [];
    final totalCount = response.body?.totalRecordCount ?? items.length;
    return (items: items, totalCount: totalCount);
  }
}
