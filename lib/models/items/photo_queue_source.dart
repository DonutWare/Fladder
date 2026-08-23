import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/playback/playback_queue_source.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/util/map_bool_helper.dart';

class PhotoQueueSource {
  final LibrarySearchModel libraryState;
  final List<String>? parentIds;
  final bool? recursive;
  final bool shuffle;
  final int limit;

  List<int>? _libraryCountsCache;
  int? _totalCountCache;

  PhotoQueueSource({
    required this.libraryState,
    required this.parentIds,
    required this.recursive,
    required this.shuffle,
    required this.limit,
  });

  List<int> _calculateDistribution(int targetItems, List<int> librarySizes) {
    List<int> dist = List.filled(librarySizes.length, 0);
    int remaining = targetItems;

    while (remaining > 0) {
      bool hasActive = false;
      for (int i = 0; i < librarySizes.length && remaining > 0; i++) {
        if (dist[i] < librarySizes[i]) {
          dist[i]++;
          remaining--;
          hasActive = true;
        }
      }
      if (!hasActive) break;
    }
    return dist;
  }

  Future<({List<PhotoModel> items, int totalCount})> fetchPhotos(
    ProviderReader read, {
    int startIndex = 0,
  }) async {
    final filters = libraryState.filters;
    final searchTerm = filters.searchQuery.isNotEmpty ? filters.searchQuery : null;
    final parents = (parentIds?.isNotEmpty == true) ? parentIds! : [null];

    if (_libraryCountsCache == null) {
      final counts = await Future.wait(parents.map((id) async {
        final res = await _fetchFromJellyfin(read, id, searchTerm, 0, 0);
        return res.count;
      }));
      _libraryCountsCache = counts;
      _totalCountCache = counts.fold<int>(0, (sum, count) => sum + count);
    }

    final counts = _libraryCountsCache!;
    final totalCount = _totalCountCache!;

    final startDist = _calculateDistribution(startIndex, counts);
    final endDist = _calculateDistribution(startIndex + limit, counts);

    final fetchFutures = <Future<List<PhotoModel>>>[];
    for (int i = 0; i < parents.length; i++) {
      final fetchCount = endDist[i] - startDist[i];
      if (fetchCount > 0) {
        fetchFutures.add(_fetchFromJellyfin(
          read,
          parents[i],
          searchTerm,
          startDist[i],
          fetchCount,
        ).then((res) => res.items));
      } else {
        fetchFutures.add(Future.value([]));
      }
    }

    final fetchedLists = await Future.wait(fetchFutures);

    final finalItems = <PhotoModel>[];
    final maxLen = fetchedLists.fold<int>(0, (max, list) => list.length > max ? list.length : max);

    for (int i = 0; i < maxLen; i++) {
      for (final list in fetchedLists) {
        if (i < list.length) {
          finalItems.add(list[i]);
        }
      }
    }

    if (shuffle) finalItems.shuffle();

    return (items: finalItems, totalCount: totalCount);
  }

  Future<({List<PhotoModel> items, int count})> _fetchFromJellyfin(
    ProviderReader read,
    String? parentId,
    String? searchTerm,
    int startIndex,
    int localLimit,
  ) async {
    final filters = libraryState.filters;

    final response = await read(jellyApiProvider).itemsGet(
      parentId: parentId,
      searchTerm: searchTerm,
      genres: filters.genres.included,
      tags: filters.tags.included,
      recursive: recursive,
      officialRatings: filters.officialRatings.included,
      years: filters.years.included,
      isMissing: false,
      limit: localLimit,
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
    final count = response.body?.totalRecordCount ?? items.length;

    return (items: items, count: count);
  }
}
