import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:auto_route/auto_route.dart';
import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/collection_types.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/folder_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/photo_queue_source.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/models/library_filter_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/library_filters_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';

final librarySearchProvider =
    StateNotifierProvider.family.autoDispose<LibrarySearchNotifier, LibrarySearchModel, Key>((ref, id) {
  return LibrarySearchNotifier(ref);
});

const _libraryMusicInitialQueueLimit = 5;
const _libraryMusicRefillLimit = 100;
const _libraryPhotoFetchLimit = 100;

class LibrarySearchNotifier extends StateNotifier<LibrarySearchModel> {
  LibrarySearchNotifier(this.ref) : super(const LibrarySearchModel());

  final Ref ref;

  int get pageSize => ref.read(clientSettingsProvider).libraryPageSize ?? 500;

  LibraryFiltersProvider get filterProvider => libraryFiltersProvider(state.currentIds);

  late final JellyService api = ref.read(jellyApiProvider);

  set loading(bool loading) => state = state.copyWith(loading: loading);

  bool loadedFilters = false;
  bool wasInitialized = false;

  bool get loading => state.loading;

  Future<void> initRefresh({
    required List<String> parentIds,
    LibraryFilterModel? filters,
  }) async {
    loading = true;
    state = state.resetLazyLoad();

    final views = await loadViews(parentIds);

    final isFolder = views.keys.map((e) => e.id).toList().containsAny(parentIds) == false && parentIds.isNotEmpty;

    if (!wasInitialized) {
      if (isFolder) {
        await loadFolders(folderId: parentIds);
      } else {
        state = state.copyWith(views: views);
      }
    }

    final firstView = state.views.included.firstWhereOrNull((element) => parentIds.contains(element.id) == true);

    final findFavouriteFilter = ref.read(filterProvider).firstWhereOrNull((element) => element.isFavourite);

    final defaultOrFavourite =
        filters?.isDefault == true && findFavouriteFilter != null ? findFavouriteFilter.filter : filters;
    final activeFilter = defaultOrFavourite ?? firstView?.collectionType.defaultFilters ?? const LibraryFilterModel();

    if (firstView != null && state.views.isNotEmpty) {
      await loadFilters(activeFilter);
    }

    if (!wasInitialized) {
      wasInitialized = true;
      state = state.copyWith(
        filters: state.filters.loadModel(activeFilter),
      );
    }

    await loadMore(init: true);

    loading = false;
  }

  Future<void> loadMore({bool? init}) async {
    if ((loading && init != true) || state.allDoneFetching) return;
    loading = true;

    final newLastIndices = Map<String, int>.from(state.lastIndices);
    final newLibraryItemCounts = Map<String, int>.from(state.libraryItemCounts);
    final isEmpty = newLastIndices.isEmpty;

    Future<void> handleViewLoading() async {
      final results = await Future.wait(
        state.views.included.map((viewModel) async {
          final lastIndices = newLastIndices[viewModel.id];
          final libraryTotalCount = newLibraryItemCounts[viewModel.id];
          if (libraryTotalCount != null && lastIndices != null && libraryTotalCount <= lastIndices) return null;

          final libraryItems = await _loadLibrary(
            viewModel: viewModel,
            startIndex: lastIndices,
            limit: pageSize ~/ state.views.included.length,
          );

          if (libraryItems != null) {
            newLibraryItemCounts[viewModel.id] = libraryItems.totalRecordCount ?? 0;
            newLastIndices[viewModel.id] = (lastIndices ?? 0) + libraryItems.items.length;
          }
          return libraryItems;
        }).nonNulls,
      );

      List<ItemBaseModel> newPosters = results.nonNulls.expand((element) => element.items).toList();
      if (state.views.included.length > 1) {
        if (state.filters.sortingOption == SortingOptions.random) {
          newPosters = newPosters.random();
        } else {
          newPosters = newPosters.sorted(
            (a, b) => sortItems(a, b, state.filters.sortingOption, state.filters.sortOrder),
          );
        }
      }
      state = state.copyWith(
        posters: isEmpty ? newPosters : [...state.posters, ...newPosters],
        lastIndices: newLastIndices,
        libraryItemCounts: newLibraryItemCounts,
      );
    }

    Future<void> handleFolderLoading() async {
      final results = await Future.wait(
        state.folderOverwrite.included.map((folder) async {
          final lastIndices = newLastIndices[folder.id];
          final libraryTotalCount = newLibraryItemCounts[folder.id];
          if (libraryTotalCount != null && lastIndices != null && libraryTotalCount <= lastIndices) return null;

          final libraryItems = await _loadLibrary(
            id: folder.id,
            startIndex: lastIndices,
            limit: pageSize ~/ state.folderOverwrite.length,
          );

          if (libraryItems != null) {
            newLibraryItemCounts[folder.id] = libraryItems.totalRecordCount ?? 0;
            newLastIndices[folder.id] = (lastIndices ?? 0) + libraryItems.items.length;
          }
          return libraryItems;
        }).nonNulls,
      );

      List<ItemBaseModel> newPosters = results.nonNulls.expand((element) => element.items).toList();
      if (state.folderOverwrite.length > 1) {
        if (state.filters.sortingOption == SortingOptions.random) {
          newPosters = newPosters.random();
        } else {
          newPosters = newPosters.sorted(
            (a, b) => sortItems(a, b, state.filters.sortingOption, state.filters.sortOrder),
          );
        }
      }
      state = state.copyWith(
        posters: isEmpty ? newPosters : [...state.posters, ...newPosters],
        lastIndices: newLastIndices,
        libraryItemCounts: newLibraryItemCounts,
      );
    }

    if (state.folderOverwrite.isNotEmpty) {
      await handleFolderLoading();
    } else if (!state.views.hasEnabled) {
      if (state.filters.searchQuery.isEmpty && state.filters.favourites != true) {
        state = state.copyWith(posters: []);
      } else {
        final response = await _loadLibrary(recursive: true);
        state = state.copyWith(posters: response?.items ?? []);
      }
    } else {
      await handleViewLoading();
    }

    loading = false;
  }

  Future<Map<ViewModel, bool>> loadViews(
    List<String>? viewModelId,
  ) async {
    final response = await api.usersUserIdViewsGet(includeHidden: false);
    final createdViews = response.body?.items?.map((e) => ViewModel.fromBodyDto(e, ref));

    Map<ViewModel, bool> mappedModels =
        createdViews?.isNotEmpty ?? false ? {for (var element in createdViews!) element: false} : {};

    final selectedModels = mappedModels.keys.where((element) => viewModelId?.contains(element.id) ?? false).toList();

    final views = mappedModels.setKeys(selectedModels, true);

    return views;
  }

  Future<void> loadFolders({List<String>? folderId}) async {
    final response = await api.itemsGet(
      ids: folderId ?? state.folderOverwrite.keys.map((e) => e.id).toList(),
      sortBy: state.filters.sortingOption.toSortBy,
      sortOrder: [state.filters.sortOrder.sortOrder],
      fields: [
        ItemFields.parentid,
        ItemFields.primaryimageaspectratio,
      ],
    );

    state = state.copyWith(
      folderOverwrite: response.body?.items.toList().asMap().map((key, value) => MapEntry(value, true)) ?? {},
    );
  }

  Future<void> loadFilters(LibraryFilterModel filters) async {
    if (loadedFilters == true) return;
    loadedFilters = true;

    final disabledYearTypes = {
      FladderItemType.photo,
      FladderItemType.photoAlbum,
      FladderItemType.video,
    };

    final itemIds = state.currentIds;

    final enabledCollections = state.views.included.map((e) => e.collectionType.itemKinds).expand((element) => element);
    final disableYearFetching =
        state.folderOverwrite.isNotEmpty || enabledCollections.any((e) => disabledYearTypes.contains(e));

    final mappedListFuture = Future.wait(itemIds.map((id) => _loadFilters(id)));
    final studiosFuture = Future.wait(itemIds.map((id) => _loadStudios(id)));
    final genresFuture = Future.wait(itemIds.map((id) => _loadGenres(id)));
    final yearsFuture =
        disableYearFetching ? Future.value(<List<int>>[]) : Future.wait(itemIds.map((id) => _loadYears(id)));

    final mappedList = await mappedListFuture;
    final studiosRaw = await studiosFuture;
    final genresRaw = await genresFuture;
    final yearsRaw = await yearsFuture;

    final studios = studiosRaw.expand((element) => element).toSet().toList();
    final genres = genresRaw.expand((element) => element).toSet().toList();
    final years = yearsRaw.expand((element) => element).toSet().toList();

    final tags = mappedList
        .expand((element) => element?.tags ?? <String>[])
        .sorted((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    var tempState = state.copyWith();
    var tempFilters = tempState.filters;

    tempState = tempState.copyWith(
      filters: tempFilters.copyWith(
        searchQuery: filters.searchQuery,
        types: filters.types.isEmpty
            ? tempFilters.types.setAll(false).setKeys(enabledCollections, true)
            : tempFilters.types.replaceMap(filters.types),
        genres: {for (var element in genres) element.name: false}.replaceMap(filters.genres),
        studios: {for (var element in studios) element: false}.replaceMap(filters.studios),
        itemFilters: {
          for (var element in {
            ItemFilter.isplayed,
            ItemFilter.isunplayed,
            ItemFilter.isresumable,
          })
            element: false
        }.replaceMap(filters.itemFilters),
        years: {for (var element in years) element: false}.replaceMap(filters.years),
        tags: {for (var element in tags) element: false}.replaceMap(filters.tags),
      ),
    );

    state = tempState;
  }

  Future<QueryFilters?> _loadFilters(String id) async {
    final response = await api.itemsFilters2Get(parentId: id);
    return response.body;
  }

  Future<List<Studio>> _loadStudios(String id) async {
    final response = await api.studiosGet(parentId: id);
    return response.body?.items?.map((e) => Studio(id: e.id ?? "", name: e.name ?? "")).toList() ?? [];
  }

  Future<List<GenreItems>> _loadGenres(String id) async {
    final response = await api.genresGet(parentId: id);
    return response.body?.items?.map((e) => GenreItems(id: e.id ?? "", name: e.name ?? "")).toList() ?? [];
  }

  Future<List<int>> _loadYears(String id) async {
    final response = await api.yearsGet(
      parentId: id,
    );
    return response.body?.items?.map((e) => int.tryParse(e.name.toString())).whereType<int>().toList() ?? [];
  }

  Future<ServerQueryResult?> _loadLibrary(
      {ViewModel? viewModel,
      bool? recursive,
      bool? shuffle,
      String? id,
      int? limit,
      int? startIndex,
      String? searchTerm}) async {
    final searchString = searchTerm ?? (state.filters.searchQuery.isNotEmpty ? state.filters.searchQuery : null);
    final response = await api.itemsGet(
      parentId: viewModel?.id ?? id,
      searchTerm: searchString,
      genres: state.filters.genres.included,
      tags: state.filters.tags.included,
      recursive: searchString?.isNotEmpty == true ? true : recursive ?? state.filters.recursive,
      officialRatings: state.filters.officialRatings.included,
      years: state.filters.years.included,
      isMissing: false,
      limit: (limit ?? 0) > 0 ? limit : null,
      startIndex: (limit ?? 0) > 0 ? startIndex : null,
      collapseBoxSetItems: false,
      studioIds: state.filters.studios.included.map((e) => e.id).toList(),
      sortBy: shuffle == true ? [ItemSortBy.random] : state.filters.sortingOption.toSortBy,
      sortOrder: [state.filters.sortOrder.sortOrder],
      fields: {
        ItemFields.genres,
        ItemFields.parentid,
        ItemFields.tags,
        ItemFields.datecreated,
        ItemFields.datelastmediaadded,
        ItemFields.overview,
        ItemFields.originaltitle,
        ItemFields.customrating,
        ItemFields.primaryimageaspectratio,
        if (viewModel?.collectionType == CollectionType.tvshows) ItemFields.childcount,
      }.toList(),
      isFavorite: state.filters.favourites,
      filters: state.filters.itemFilters.included,
      includeItemTypes: state.filters.types.included.map((e) => e.dtoKind).expand((e) => e).toList(),
    );
    return response.body;
  }

  Future<ServerQueryResult?> _loadPlaylistItems({ViewModel? viewModel, String? id, int? startIndex, int? limit}) async {
    final response = await api.playlistsPlaylistIdItemsGet(
      playlistId: viewModel?.id ?? id,
      limit: (limit ?? 0) > 0 ? limit : null,
      startIndex: (limit ?? 0) > 0 ? startIndex : null,
      fields: {
        ItemFields.genres,
        ItemFields.parentid,
        ItemFields.tags,
        ItemFields.datecreated,
        ItemFields.datelastmediaadded,
        ItemFields.overview,
        ItemFields.originaltitle,
        ItemFields.customrating,
        ItemFields.primaryimageaspectratio,
        if (viewModel?.collectionType == CollectionType.tvshows) ItemFields.childcount,
      }.toList(),
    );
    return response.body;
  }

  Future<List<ItemBaseModel>> fetchSuggestions(String searchTerm, {int limit = 25}) async {
    if (state.folderOverwrite.isNotEmpty) {
      final mappedList = await Future.wait(state.folderOverwrite.included
          .map((folder) => _loadLibrary(id: folder.id, limit: limit, searchTerm: searchTerm)));
      return mappedList
          .expand((innerList) => innerList?.items ?? [])
          .where((item) => item != null)
          .cast<ItemBaseModel>()
          .toList();
    } else {
      if (state.views.hasEnabled) {
        final mappedList = await Future.wait(state.views.included
            .map((viewModel) => _loadLibrary(viewModel: viewModel, limit: limit, searchTerm: searchTerm)));
        return mappedList
            .expand((innerList) => innerList?.items ?? [])
            .where((item) => item != null)
            .cast<ItemBaseModel>()
            .toList();
      } else {
        if (searchTerm.isEmpty) {
          return [];
        } else {
          final response = await _loadLibrary(limit: limit, recursive: true, searchTerm: searchTerm);
          return response?.items ?? [];
        }
      }
    }
  }

  void setSearch(String query) {
    state = state.copyWith(filters: state.filters.copyWith(searchQuery: query));
    ref.read(userProvider.notifier).addSearchQuery(query);
  }

  void setFavourites(bool? value) => state = state.copyWith(filters: state.filters.copyWith(favourites: value));
  void toggleRecursive() =>
      state = state.copyWith(filters: state.filters.copyWith(recursive: state.filters.recursive == false));
  void toggleType(FladderItemType type) =>
      state = state.copyWith(filters: state.filters.copyWith(types: state.filters.types.toggleKey(type)));
  void toggleView(ViewModel view) => state = state.copyWith(views: state.views.toggleKey(view));
  void toggleGenre(String genre) =>
      state = state.copyWith(filters: state.filters.copyWith(genres: state.filters.genres.toggleKey(genre)));
  void toggleStudio(Studio studio) =>
      state = state.copyWith(filters: state.filters.copyWith(studios: state.filters.studios.toggleKey(studio)));
  void toggleTag(String tag) =>
      state = state.copyWith(filters: state.filters.copyWith(tags: state.filters.tags.toggleKey(tag)));
  void toggleRatings(String officialRatings) => state = state.copyWith(
      filters: state.filters.copyWith(officialRatings: state.filters.officialRatings.toggleKey(officialRatings)));
  void toggleYears(int year) =>
      state = state.copyWith(filters: state.filters.copyWith(years: state.filters.years.toggleKey(year)));
  void toggleFilters(ItemFilter filter) =>
      state = state.copyWith(filters: state.filters.copyWith(itemFilters: state.filters.itemFilters.toggleKey(filter)));

  void setViews(Map<ViewModel, bool> views) {
    loadedFilters = false;
    state = state.copyWith(views: views);
  }

  void setGenres(Map<String, bool> genres) => state = state.copyWith(filters: state.filters.copyWith(genres: genres));
  void setStudios(Map<Studio, bool> studios) =>
      state = state.copyWith(filters: state.filters.copyWith(studios: studios));
  void setTags(Map<String, bool> tags) => state = state.copyWith(filters: state.filters.copyWith(tags: tags));
  void setTypes(Map<FladderItemType, bool> types) =>
      state = state.copyWith(filters: state.filters.copyWith(types: types));
  void setRatings(Map<String, bool> officialRatings) =>
      state = state.copyWith(filters: state.filters.copyWith(officialRatings: officialRatings));
  void setYears(Map<int, bool> years) => state = state.copyWith(filters: state.filters.copyWith(years: years));
  void setFilters(Map<ItemFilter, bool> filters) =>
      state = state.copyWith(filters: state.filters.copyWith(itemFilters: filters));

  void setSortBy(SortingOptions e) => state = state.copyWith(filters: state.filters.copyWith(sortingOption: e));

  void setSortOrder(SortingOrder e) => state = state.copyWith(filters: state.filters.copyWith(sortOrder: e));

  void toggleEmptyShows() =>
      state = state.copyWith(filters: state.filters.copyWith(hideEmptyShows: !state.filters.hideEmptyShows));
  void setGroupBy(GroupBy groupBy) => state = state.copyWith(filters: state.filters.copyWith(groupBy: groupBy));

  void clearAllFilters() {
    state = state.copyWith(
      filters: state.filters.clear(),
    );
  }

  void toggleSelectMode() =>
      state = state.copyWith(selecteMode: !state.selecteMode, selectedPosters: !state.selecteMode == false ? [] : []);

  void toggleSelection(ItemBaseModel item) {
    if (state.selectedPosters.contains(item)) {
      state = state.copyWith(selectedPosters: state.selectedPosters.where((element) => element != item).toList());
    } else {
      state = state.copyWith(selectedPosters: [...state.selectedPosters, item]);
    }
  }

  LibrarySearchModel selectAll(bool select) => state = state.copyWith(selectedPosters: select ? state.posters : []);

  Future<void> setSelectedAsFavorite(bool bool) async {
    final Map<String, UserData> updateInfo = {};
    for (var i = 0; i < state.selectedPosters.length; i++) {
      final response = await ref.read(userProvider.notifier).setAsFavorite(bool, state.selectedPosters[i].id);
      final userData = response?.bodyOrThrow;
      if (userData != null) {
        updateInfo.putIfAbsent(state.selectedPosters[i].id, () => userData);
      }
    }
    updateMultiUserData(updateInfo);
  }

  Future<void> setSelectedAsWatched(bool bool) async {
    final Map<String, UserData> updateInfo = {};
    for (var i = 0; i < state.selectedPosters.length; i++) {
      final response = await ref.read(userProvider.notifier).markAsPlayed(bool, state.selectedPosters[i].id);
      final userData = response?.bodyOrThrow;
      if (userData != null) {
        updateInfo.putIfAbsent(state.selectedPosters[i].id, () => userData);
      }
    }
    updateMultiUserData(updateInfo);
  }

  Future<Response> removeSelectedFromCollection() async {
    final response = await api.collectionsCollectionIdItemsDelete(
        collectionId: state.folderOverwrite.included.firstOrNull?.id,
        ids: state.selectedPosters.map((e) => e.id).toList());
    if (response.isSuccessful) {
      removeFromPosters([state.folderOverwrite.included.firstOrNull?.id].nonNulls.toList());
    }
    return response;
  }

  Future<Response> removeSelectedFromPlaylist() async {
    final response = await api.playlistsPlaylistIdItemsDelete(
        playlistId: state.folderOverwrite.included.firstOrNull?.id,
        entryIds: state.selectedPosters.map((e) => e.playlistId).nonNulls.toList());
    if (response.isSuccessful) {
      removeFromPosters([state.folderOverwrite.included.firstOrNull?.id].nonNulls.toList());
    }
    return response;
  }

  Future<Response> removeFromCollection({required List<ItemBaseModel> items}) async {
    final response = await api.collectionsCollectionIdItemsDelete(
        collectionId: state.folderOverwrite.included.firstOrNull?.id, ids: items.map((e) => e.id).toList());
    if (response.isSuccessful) {
      removeFromPosters(items.map((e) => e.id).toList());
    }
    return response;
  }

  Future<Response> removeFromPlaylist({required List<ItemBaseModel> items}) async {
    final response = await api.playlistsPlaylistIdItemsDelete(
        playlistId: state.folderOverwrite.included.firstOrNull?.id,
        entryIds: items.map((e) => e.playlistId).nonNulls.toList());
    if (response.isSuccessful) {
      removeFromPosters(items.map((e) => e.id).toList());
    }
    return response;
  }

  Future<void> updateMultiUserData(Map<String, UserData?> newData) async {
    for (var element in newData.entries) {
      updateUserData(element.key, element.value);
    }
  }

  Future<void> updateUserData(String id, UserData? newData) async {
    final currentItems = state.posters.toList();
    final item = currentItems.firstWhereOrNull((element) => element.id == id);
    if (item == null) return;
    final indexOf = currentItems.indexOf(item);
    if (indexOf == -1) return;
    currentItems.removeAt(indexOf);
    currentItems.insert(indexOf, item.copyWith(userData: newData));
    state = state.copyWith(posters: currentItems);
  }

  void updateUserDataMain(UserData? userData) {
    state = state.copyWith(
      folderOverwrite: state.folderOverwrite.map((key, value) {
        if (value == true) {
          return MapEntry(key.copyWith(userData: userData), value);
        }
        return MapEntry(key, value);
      }),
    );
  }

  void updateParentItem(ItemBaseModel item) {
    state = state.copyWith(folderOverwrite: state.folderOverwrite.map((key, value) {
      if (value == true) {
        return MapEntry(item, value);
      }
      return MapEntry(key, value);
    }));
  }

  void removeFromPosters(List<String> ids) {
    final newPosters = state.posters;
    state = state.copyWith(posters: newPosters..removeWhere((element) => ids.contains(element.id)));
  }

  void updateItems(List<ItemBaseModel> items) {}

  void updateItem(ItemBaseModel item) {
    state = state.copyWith(posters: state.posters.replace(item));
  }

  Future<List<ItemBaseModel>> _loadAllItems({bool shuffle = false, int? limit}) async {
    List<ItemBaseModel> itemsToPlay = [];

    Future<void> handleItemLoading(String itemId, ItemBaseModel currentModel) async {
      final result =
          currentModel is PlaylistModel ? await _loadPlaylistItems(id: itemId) : await _loadLibrary(id: itemId);

      itemsToPlay = result?.items ?? [];
    }

    Future<void> handleViewLoading() async {
      final results = await Future.wait(
        state.views.included.map((viewModel) async {
          final libraryItems = await _loadLibrary(
            shuffle: shuffle,
            viewModel: viewModel,
            limit: limit,
          );
          return libraryItems;
        }).nonNulls,
      );

      List<ItemBaseModel> newPosters = results.nonNulls.expand((element) => element.items).toList();
      if (state.views.included.length > 1) {
        if (shuffle || state.filters.sortingOption == SortingOptions.random) {
          newPosters = newPosters.random();
        } else {
          newPosters = newPosters.sorted(
            (a, b) => sortItems(a, b, state.filters.sortingOption, state.filters.sortOrder),
          );
        }
      }

      itemsToPlay = newPosters;
    }

    if (state.folderOverwrite.isNotEmpty) {
      await handleItemLoading(state.folderOverwrite.included.last.id, state.folderOverwrite.included.last);
    } else if (state.views.hasEnabled) {
      await handleViewLoading();
    } else {
      if (state.filters.searchQuery.isEmpty && state.filters.favourites == false) {
        itemsToPlay = [];
      } else {
        final response = await _loadLibrary(recursive: true, shuffle: shuffle);
        itemsToPlay = response?.items ?? [];
      }
    }

    return itemsToPlay;
  }

  Future<void> playLibraryItems(BuildContext context, WidgetRef ref, {bool shuffle = false}) async {
    List<ItemBaseModel> itemsToPlay = [];

    if (state.selectedPosters.isNotEmpty) {
      itemsToPlay = shuffle ? state.selectedPosters.random() : state.selectedPosters;
    } else {
      itemsToPlay = await showLoadingOverlay(context, callBack: _loadAllItems(shuffle: shuffle));
    }

    //Only try to load video items
    itemsToPlay = itemsToPlay.where((element) => FladderItemType.playable.contains(element.type)).toList();

    if (itemsToPlay.isNotEmpty) {
      await itemsToPlay.playLibraryItems(context, ref, shuffle: shuffle);
    } else {
      FladderSnack.show(context.localized.libraryFetchNoItemsFound, context: context);
    }
  }

  Future<void> playMusicItems(BuildContext context, WidgetRef ref, {bool shuffle = false}) async {
    if (state.selectedPosters.isEmpty) {
      final queueSource = _createMusicQueueSource(shuffle: shuffle);
      if (queueSource != null) {
        final started = await _playMusicFromQueueSource(context, ref, queueSource);
        if (started) {
          return;
        } else {
          FladderSnack.show(context.localized.libraryFetchNoItemsFound, context: context);
        }
      }
    } else {
      List<ItemBaseModel> itemsToPlay = [];

      if (state.selectedPosters.isNotEmpty) {
        itemsToPlay = shuffle ? state.selectedPosters.random() : state.selectedPosters;
      } else {
        itemsToPlay = await showLoadingOverlay(context, callBack: _loadAllItems(shuffle: shuffle));
      }

      itemsToPlay = itemsToPlay.where((element) => FladderItemType.musicPlayable.contains(element.type)).toList();

      if (itemsToPlay.isNotEmpty) {
        await itemsToPlay.playMusicItems(context, ref, shuffle: shuffle);
      } else {
        FladderSnack.show(context.localized.libraryFetchNoItemsFound, context: context);
      }
    }
  }

  PlaybackQueueSource? _createMusicQueueSource({required bool shuffle}) {
    if (state.folderOverwrite.isNotEmpty) {
      final currentItem = state.folderOverwrite.keys.last;
      if (currentItem is PlaylistModel) {
        return PlaylistAudioQueueSource(
          playlistId: currentItem.id,
          limit: _libraryMusicRefillLimit,
        );
      }

      return _buildLibraryMusicQueueSource(
        parentId: state.folderOverwrite.keys.map((e) => e.id).toList(),
        recursive: true,
        shuffle: shuffle,
      );
    }

    if (state.views.hasEnabled) {
      return _buildLibraryMusicQueueSource(
        parentId: state.views.included.map((e) => e.id).toList(),
        recursive: true,
        shuffle: shuffle,
      );
    }

    return _buildLibraryMusicQueueSource(
      parentId: [],
      recursive: true,
      shuffle: shuffle,
    );
  }

  LibraryMusicQueueSource _buildLibraryMusicQueueSource({
    required List<String> parentId,
    required bool? recursive,
    required bool shuffle,
  }) {
    return LibraryMusicQueueSource(
      libraryState: state,
      parentId: parentId,
      recursive: recursive,
      shuffle: shuffle,
      limit: _libraryMusicRefillLimit,
    );
  }

  PhotoQueueSource? createPhotoQueueSource({required bool shuffle}) {
    final recursive = state.filters.searchQuery.isNotEmpty ? true : state.filters.recursive;

    if (state.folderOverwrite.isNotEmpty) {
      return _buildPhotoQueueSource(
        parentId: state.folderOverwrite.included.map((e) => e.id).toList(),
        recursive: recursive,
        shuffle: shuffle,
      );
    }

    if (state.views.hasEnabled) {
      return _buildPhotoQueueSource(
        parentId: state.views.included.map((e) => e.id).toList(),
        recursive: recursive,
        shuffle: shuffle,
      );
    }

    if (state.filters.searchQuery.isEmpty && state.filters.favourites == false) {
      return null;
    }

    return _buildPhotoQueueSource(
      parentId: null,
      recursive: true,
      shuffle: shuffle,
    );
  }

  PhotoQueueSource _buildPhotoQueueSource({
    required List<String>? parentId,
    required bool? recursive,
    required bool shuffle,
  }) {
    return PhotoQueueSource(
      libraryState: state,
      parentIds: parentId,
      recursive: recursive,
      shuffle: shuffle,
      limit: _libraryPhotoFetchLimit,
    );
  }

  Future<bool> _playMusicFromQueueSource(
    BuildContext context,
    WidgetRef ref,
    PlaybackQueueSource queueSource,
  ) async {
    await ref.read(videoPlayerProvider.notifier).init();

    final result = await showLoadingOverlay(
      context,
      callBack: Future(() async {
        final initialQueue = await queueSource.fetchQueue(
          ref.read,
          limit: _libraryMusicInitialQueueLimit,
          startIndex: 0,
        );
        if (initialQueue.isEmpty) return null;

        final model = await ref.read(playbackModelHelper).createPlaybackModel(
              context,
              initialQueue.firstOrNull,
              libraryQueue: initialQueue,
              queueSource: queueSource,
            );
        if (model == null) return null;

        return (model, initialQueue);
      }),
    );

    if (result == null) {
      return false;
    }

    final model = result.$1;
    final queue = result.$2;
    final currentIndex = queue.indexWhere((element) => element.id == model.item.id).clamp(0, queue.length - 1);
    final actualStartPosition = await model.startDuration() ?? Duration.zero;

    await ref.read(videoPlayerProvider.notifier).loadAudioPlaybackItem(
          model,
          queue,
          currentIndex,
          actualStartPosition,
        );
    return true;
  }

  Future<List<PhotoModel>> fetchGallery({bool shuffle = false}) async {
    try {
      List<ItemBaseModel> itemsToPlay = [];

      if (state.selectedPosters.isNotEmpty) {
        itemsToPlay = shuffle ? state.selectedPosters.random() : state.selectedPosters;
      } else {
        itemsToPlay = await _loadAllItems(shuffle: shuffle);
      }

      List<PhotoModel> albumItems = [];

      if (!state.filters.types.included.containsAny([FladderItemType.video, FladderItemType.photo]) &&
          state.filters.recursive == true) {
        for (var album in itemsToPlay.where(
          (element) => element is PhotoAlbumModel || element is FolderModel,
        )) {
          try {
            final fetchedAlbumContent = await api.itemsGet(
              parentId: album.id,
              includeItemTypes: state.filters.types.included.map((e) => e.dtoKind).expand((e) => e).toList(),
              recursive: true,
              fields: {
                ItemFields.genres,
                ItemFields.parentid,
                ItemFields.tags,
                ItemFields.datecreated,
                ItemFields.datelastmediaadded,
                ItemFields.overview,
                ItemFields.originaltitle,
                ItemFields.customrating,
                ItemFields.primaryimageaspectratio,
              }.toList(),
              isFavorite: state.filters.favourites,
              filters: state.filters.itemFilters.included,
              sortBy: shuffle ? [ItemSortBy.random] : null,
            );
            albumItems.addAll(fetchedAlbumContent.body?.items.whereType<PhotoModel>() ?? []);
          } catch (e) {
            log("Error fetching ${e.toString()}");
          }
        }
      }

      final galleryItems = itemsToPlay.whereType<PhotoModel>().toList();

      if (shuffle) {
        albumItems = albumItems.random();
      }

      final allItems = {...albumItems.whereType<PhotoModel>(), ...galleryItems}.toList();

      return allItems;
    } catch (e) {
      log(e.toString());
    } finally {}
    return [];
  }

  Future<void> viewGallery(BuildContext context, WidgetRef ref, {PhotoModel? selected, bool shuffle = false}) async {
    List<PhotoModel> allItems = state.activePosters.whereType<PhotoModel>().toList();
    if (allItems.isNotEmpty) {
      final newItemList = shuffle ? allItems.shuffled() : allItems;
      final photoSource = state.selectedPosters.isEmpty ? createPhotoQueueSource(shuffle: shuffle) : null;
      final loadPhotos = shuffle ? (await photoSource?.fetchPhotos(ref.read))?.items : newItemList;
      await context.pushRoute(
        PhotoViewerRoute(
          items: loadPhotos,
          selected: selected?.id,
          photoQueueSource: photoSource,
        ),
      );
    } else {
      FladderSnack.show(context.localized.libraryFetchNoItemsFound, context: context);
    }
  }

  Future<T> showLoadingOverlay<T>(
    BuildContext context, {
    required Future<T> callBack,
  }) async {
    state = state.copyWith(fetchingItems: true);
    BuildContext? dialogContext;
    var cancelAble = CancelableOperation<T>.fromFuture(callBack);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        dialogContext = context;
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  const CircularProgressIndicator(),
                  Text(context.localized.fetchingLibrary, style: Theme.of(context).textTheme.titleMedium),
                  IconButton(
                    onPressed: () {
                      cancelAble.cancel();
                      context.pop();
                    },
                    icon: const Icon(IconsaxPlusLinear.close_square),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

    try {
      return await cancelAble.value;
    } finally {
      state = state.copyWith(fetchingItems: false);
      if (dialogContext != null && Navigator.of(dialogContext!).canPop()) {
        Navigator.of(dialogContext!).pop();
      }
    }
  }

  Future<void> openRandom(BuildContext context) async {
    final items = await _loadAllItems(shuffle: true, limit: 1);
    if (items.isNotEmpty) {
      items.firstOrNull?.navigateTo(context);
    }
  }

  void updateEverything() {
    state = state.copyWith();
  }

  void loadModel(LibraryFiltersModel model) {
    state = state.copyWith(
      filters: state.filters.loadModel(model.filter),
    );
  }

  void saveFilter(LibraryFiltersModel model) => ref.read(filterProvider.notifier).saveFilter(
        model.copyWith(
          viewNames: state.folderOverwrite.isNotEmpty
              ? state.folderOverwrite.included.map((e) => e.name).toList()
              : state.views.included.map((e) => e.name).toList(),
        ),
      );

  void saveFiltersNew(String newName) => ref.read(filterProvider.notifier).saveFilter(
        LibraryFiltersModel.fromLibrarySearch(
          newName,
          state,
        ),
      );

  void updateFilterName(LibraryFiltersModel model) {
    ref.read(filterProvider.notifier).saveFilter(model);
  }

  void updateFilter(LibraryFiltersModel model) {
    ref.read(filterProvider.notifier).saveFilter(
          LibraryFiltersModel.fromLibrarySearch(
            model.name,
            state,
            isFavourite: model.isFavourite,
            id: model.id,
            showInSideBar: model.showInSideBar,
            viewNames: state.folderOverwrite.isNotEmpty
                ? state.folderOverwrite.included.map((e) => e.name).toList()
                : state.views.included.map((e) => e.name).toList(),
          ),
        );
  }

  void setYearsRange(int? first, int? last) {
    state = state.copyWith(
      filters: state.filters.copyWith(
        years: state.filters.years.replaceMap(
          {for (var i = first ?? 0; i <= (last ?? 0); i++) i: true},
        ),
      ),
    );
  }

  void setFolderOverwrite(Map<ItemBaseModel, bool> value) async {
    loadedFilters = false;
    state = state.copyWith(folderOverwrite: value);
  }
}

extension SimpleSorter on List<ItemBaseModel> {
  List<ItemBaseModel> hideEmptyChildren(bool hide) {
    if (hide) {
      return where((element) {
        if (element.childCount == null) {
          return true;
        }
        return (element.childCount ?? 0) > 0;
      }).toList();
    } else {
      return this;
    }
  }
}
