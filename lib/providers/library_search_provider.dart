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
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/library_filter_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/playlist_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/library_filters_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';

final librarySearchProvider =
    StateNotifierProvider.family.autoDispose<LibrarySearchNotifier, LibrarySearchModel, Key>((ref, id) {
  return LibrarySearchNotifier(ref);
});

class LibrarySearchNotifier extends StateNotifier<LibrarySearchModel> {
  LibrarySearchNotifier(this.ref) : super(const LibrarySearchModel());

  final Ref ref;

  int get pageSize => ref.read(clientSettingsProvider).libraryPageSize ?? 500;

  LibraryFiltersProvider get filterProvider => libraryFiltersProvider(state.views.included.map((e) => e.id).toList());

  late final JellyService api = ref.read(jellyApiProvider);

  set loading(bool loading) => state = state.copyWith(loading: loading);

  bool loadedFilters = false;
  bool wasInitialized = false;

  bool get loading => state.loading;

  Future<void> initRefresh(
    List<String>? folderId,
    String? viewModelId,
    LibraryFilterModel filters,
  ) async {
    loading = true;
    state = state.resetLazyLoad();
    if (state.views.isEmpty && state.folderOverwrite.isEmpty) {
      if (folderId != null) {
        await loadFolders(folderId: folderId);
      } else {
        await loadViews(viewModelId, filters);
      }
    }

    await loadFilters();

    if (!wasInitialized) {
      wasInitialized = true;
      final findFavouriteFilter = ref
          .read(libraryFiltersProvider(state.views.included.map((e) => e.id).toList()))
          .firstWhereOrNull((element) => element.isFavourite);
      if (findFavouriteFilter != null) {
        state = state.copyWith(
          filters: findFavouriteFilter.filter,
        );
      }
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

    Future<void> handleItemLoading(String itemId, ItemBaseModel currentModel) async {
      final lastIndices = newLastIndices[itemId];
      final libraryTotalCount = newLibraryItemCounts[itemId];
      if (libraryTotalCount != null && lastIndices != null && libraryTotalCount <= lastIndices) return;

      final result = currentModel is PlaylistModel
          ? await _loadPlaylistItems(id: itemId, startIndex: lastIndices, limit: pageSize)
          : await _loadLibrary(id: itemId, startIndex: lastIndices, limit: pageSize);

      if (result != null) {
        newLibraryItemCounts[itemId] = result.totalRecordCount ?? 0;
        newLastIndices[itemId] = (lastIndices ?? 0) + result.items.length;
        state = state.copyWith(
          posters: isEmpty ? result.items : [...state.posters, ...result.items],
          lastIndices: newLastIndices,
          libraryItemCounts: newLibraryItemCounts,
        );
      }
    }

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

    if (state.folderOverwrite.isNotEmpty) {
      await handleItemLoading(state.folderOverwrite.last.id, state.folderOverwrite.last);
    } else if (state.views.hasEnabled) {
      await handleViewLoading();
    } else {
      if (state.searchQuery.isEmpty && state.filters.favourites == false) {
        state = state.copyWith(posters: []);
      } else {
        final response = await _loadLibrary(recursive: true);
        state = state.copyWith(posters: response?.items ?? []);
      }
    }

    loading = false;
  }

  Future<void> loadViews(
    String? viewModelId,
    LibraryFilterModel filters,
  ) async {
    final response = await api.usersUserIdViewsGet(includeHidden: false);
    final createdViews = response.body?.items?.map((e) => ViewModel.fromBodyDto(e, ref));
    Map<ViewModel, bool> mappedModels =
        createdViews?.isNotEmpty ?? false ? {for (var element in createdViews!) element: false} : {};

    final selectedModel = mappedModels.keys.firstWhereOrNull((element) => element.id == viewModelId);

    final views = selectedModel != null
        ? mappedModels.setKey(mappedModels.keys.firstWhere((element) => element.id == viewModelId), true)
        : mappedModels;

    state = state.copyWith(
      views: views,
    );

    final findFavouriteFilter = ref
        .read(libraryFiltersProvider(views.included.map((e) => e.id).toList()))
        .firstWhereOrNull((element) => element.isFavourite);
    if (findFavouriteFilter != null) {
      loadModel(findFavouriteFilter.filter);
    } else {
      loadModel(filters);
    }
  }

  Future<void> loadFolders({List<String>? folderId}) async {
    final response = await api.itemsGet(
      ids: folderId ?? state.folderOverwrite.map((e) => e.id).toList(),
      sortBy: state.filters.sortingOption.toSortBy,
      sortOrder: [state.filters.sortOrder.sortOrder],
      fields: [
        ItemFields.parentid,
        ItemFields.primaryimageaspectratio,
      ],
    );

    state = state.copyWith(folderOverwrite: response.body?.items.toList() ?? []);
  }

  Future<void> loadFilters() async {
    if (loadedFilters == true) return;
    loadedFilters = true;
    final enabledCollections = state.views.included.map((e) => e.collectionType.itemKinds).expand((element) => element);
    final mappedList = await Future.wait(state.views.included.map((viewModel) => _loadFilters(viewModel)));
    final studios = (await Future.wait(state.views.included.map((viewModel) => _loadStudios(viewModel))))
        .expand((element) => element)
        .toSet()
        .toList();
    var tempState = state.copyWith();
    final genres = (await Future.wait(state.views.included.map((viewModel) => _loadGenres(viewModel))))
        .expand((element) => element)
        .toSet()
        .toList();
    final tags = mappedList
        .expand((element) => element?.tags ?? <String>[])
        .sorted((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    var tempFilters = tempState.filters;
    tempState = tempState.copyWith(
      filters: tempFilters.copyWith(
        types: tempFilters.types.setAll(false).setKeys(enabledCollections, true),
        genres: {for (var element in genres) element.name: false}.replaceMap(tempFilters.genres),
        studios: {for (var element in studios) element: false}.replaceMap(tempFilters.studios),
        tags: {for (var element in tags) element: false}.replaceMap(tempFilters.tags),
      ),
    );
    state = tempState;
  }

  Future<QueryFilters?> _loadFilters(ViewModel viewModel) async {
    final response = await api.itemsFilters2Get(parentId: viewModel.id);
    return response.body;
  }

  Future<List<Studio>> _loadStudios(ViewModel viewModel) async {
    final response = await api.studiosGet(parentId: viewModel.id);
    return response.body?.items?.map((e) => Studio(id: e.id ?? "", name: e.name ?? "")).toList() ?? [];
  }

  Future<List<GenreItems>> _loadGenres(ViewModel viewModel) async {
    final response = await api.genresGet(parentId: viewModel.id);
    return response.body?.items?.map((e) => GenreItems(id: e.id ?? "", name: e.name ?? "")).toList() ?? [];
  }

  Future<ServerQueryResult?> _loadLibrary(
      {ViewModel? viewModel,
      bool? recursive,
      bool? shuffle,
      String? id,
      int? limit,
      int? startIndex,
      String? searchTerm}) async {
    final searchString = searchTerm ?? (state.searchQuery.isNotEmpty ? state.searchQuery : null);
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
      filters: [
        ...state.filters.itemFilters.included,
        if (state.filters.favourites == true) ItemFilter.isfavorite,
      ],
      includeItemTypes: state.filters.types.included.map((e) => e.dtoKind).toList(),
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
      final response = await _loadLibrary(id: state.nestedCurrentItem?.id ?? "", searchTerm: searchTerm, limit: limit);
      return response?.items ?? [];
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
    state = state.copyWith(searchQuery: query);
    ref.read(userProvider.notifier).addSearchQuery(query);
  }

  void toggleFavourite() =>
      state = state.copyWith(filters: state.filters.copyWith(favourites: state.filters.favourites == false));
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
    state = state.copyWith(views: views).setFiltersToDefault();
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
      searchQuery: '',
      filters: state.filters.clear(),
    );
  }

  void setFolderId(ItemBaseModel item) {
    if (state.folderOverwrite.contains(item)) return;
    state = state.copyWith(folderOverwrite: [...state.folderOverwrite, item]);
  }

  void backToFolder(ItemBaseModel item) => state = state.copyWith(
      folderOverwrite: state.folderOverwrite.getRange(0, state.folderOverwrite.indexOf(item) + 1).toList());

  void clearFolderOverWrite() => state = state.copyWith(folderOverwrite: []);

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
        collectionId: state.nestedCurrentItem?.id, ids: state.selectedPosters.map((e) => e.id).toList());
    if (response.isSuccessful) {
      removeFromPosters([state.nestedCurrentItem?.id].nonNulls.toList());
    }
    return response;
  }

  Future<Response> removeSelectedFromPlaylist() async {
    final response = await api.playlistsPlaylistIdItemsDelete(
        playlistId: state.nestedCurrentItem?.id,
        entryIds: state.selectedPosters.map((e) => e.playlistId).nonNulls.toList());
    if (response.isSuccessful) {
      removeFromPosters([state.nestedCurrentItem?.id].nonNulls.toList());
    }
    return response;
  }

  Future<Response> removeFromCollection({required List<ItemBaseModel> items}) async {
    final response = await api.collectionsCollectionIdItemsDelete(
        collectionId: state.nestedCurrentItem?.id, ids: items.map((e) => e.id).toList());
    if (response.isSuccessful) {
      removeFromPosters(items.map((e) => e.id).toList());
    }
    return response;
  }

  Future<Response> removeFromPlaylist({required List<ItemBaseModel> items}) async {
    final response = await api.playlistsPlaylistIdItemsDelete(
        playlistId: state.nestedCurrentItem?.id, entryIds: items.map((e) => e.playlistId).nonNulls.toList());
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
      folderOverwrite: [state.folderOverwrite.lastOrNull?.copyWith(userData: userData)].nonNulls.toList(),
    );
  }

  void updateParentItem(ItemBaseModel item) {
    state = state.copyWith(
      folderOverwrite: [item],
    );
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
      await handleItemLoading(state.folderOverwrite.last.id, state.folderOverwrite.last);
    } else if (state.views.hasEnabled) {
      await handleViewLoading();
    } else {
      if (state.searchQuery.isEmpty && state.filters.favourites == false) {
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
      fladderSnackbar(context, title: context.localized.libraryFetchNoItemsFound);
    }
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
              includeItemTypes: [BaseItemKind.video, BaseItemKind.photo],
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
              filters: [
                ...state.filters.itemFilters.included,
                if (state.filters.favourites == true) ItemFilter.isfavorite,
              ],
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

  Future<void> viewGallery(BuildContext context, {PhotoModel? selected, bool shuffle = false}) async {
    List<PhotoModel> allItems = [];
    allItems = await showLoadingOverlay(context, callBack: fetchGallery(shuffle: shuffle));
    if (allItems.isNotEmpty) {
      final newItemList = shuffle ? allItems.shuffled() : allItems;
      await context.pushRoute(PhotoViewerRoute(
        items: newItemList,
        selected: selected?.id,
      ));
    } else {
      fladderSnackbar(context, title: context.localized.libraryFetchNoItemsFound);
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
                  const CircularProgressIndicator.adaptive(),
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

  void loadModel(LibraryFilterModel model) => state = state.copyWith(filters: state.filters.loadModel(model));

  void saveFiltersNew(String newName) =>
      ref.read(filterProvider.notifier).saveFilter(LibraryFiltersModel.fromLibrarySearch(newName, state));

  void updateFilter(LibraryFiltersModel model) {
    ref.read(filterProvider.notifier).saveFilter(
          LibraryFiltersModel.fromLibrarySearch(
            model.name,
            state,
            isFavourite: model.isFavourite,
            id: model.id,
          ),
        );
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
