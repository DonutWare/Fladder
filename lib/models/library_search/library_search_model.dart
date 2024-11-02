import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';

part 'library_search_model.mapper.dart';

@MappableClass()
class LibrarySearchModel with LibrarySearchModelMappable {
  final bool loading;
  final bool selecteMode;
  final String searchQuery;
  final List<ItemBaseModel> folderOverwrite;
  final Map<ViewModel, bool> views;
  final List<ItemBaseModel> posters;
  final List<ItemBaseModel> selectedPosters;
  final Map<ItemFilter, bool> filters;
  final Map<String, bool> genres;
  final Map<Studio, bool> studios;
  final Map<String, bool> tags;
  final Map<int, bool> years;
  final Map<String, bool> officialRatings;
  final Map<FladderItemType, bool> types;
  final SortingOptions sortingOption;
  final SortingOrder sortOrder;
  final bool favourites;
  final bool hideEmptyShows;
  final bool recursive;
  final GroupBy groupBy;
  final Map<String, int> lastIndices;
  final Map<String, int> libraryItemCounts;
  final bool fetchingItems;

  const LibrarySearchModel({
    this.loading = false,
    this.selecteMode = false,
    this.folderOverwrite = const [],
    this.searchQuery = "",
    this.views = const {},
    this.posters = const [],
    this.selectedPosters = const [],
    this.filters = const {
      ItemFilter.isplayed: false,
      ItemFilter.isunplayed: false,
      ItemFilter.isresumable: false,
    },
    this.genres = const {},
    this.studios = const {},
    this.tags = const {},
    this.years = const {},
    this.officialRatings = const {},
    this.types = const {
      FladderItemType.audio: false,
      FladderItemType.boxset: false,
      FladderItemType.book: false,
      FladderItemType.collectionFolder: false,
      FladderItemType.episode: false,
      FladderItemType.folder: false,
      FladderItemType.movie: true,
      FladderItemType.musicAlbum: false,
      FladderItemType.musicVideo: false,
      FladderItemType.photo: false,
      FladderItemType.person: false,
      FladderItemType.photoAlbum: false,
      FladderItemType.series: true,
      FladderItemType.video: true,
    },
    this.favourites = false,
    this.sortingOption = SortingOptions.name,
    this.sortOrder = SortingOrder.ascending,
    this.hideEmptyShows = true,
    this.recursive = false,
    this.groupBy = GroupBy.none,
    this.lastIndices = const {},
    this.libraryItemCounts = const {},
    this.fetchingItems = false,
  });

  bool get hasActiveFilters {
    return genres.hasEnabled ||
        studios.hasEnabled ||
        tags.hasEnabled ||
        years.hasEnabled ||
        officialRatings.hasEnabled ||
        hideEmptyShows ||
        filters.hasEnabled ||
        favourites ||
        searchQuery.isNotEmpty;
  }

  int get totalItemCount {
    if (libraryItemCounts.isEmpty) return posters.length;
    int totalCount = 0;
    for (var item in libraryItemCounts.values) {
      totalCount += item;
    }
    return totalCount;
  }

  bool get allDoneFetching {
    if (libraryItemCounts.isEmpty) return false;
    if (libraryItemCounts.length != lastIndices.length) {
      return false;
    } else {
      for (var item in libraryItemCounts.entries) {
        if (lastIndices[item.key] != item.value) {
          return false;
        }
      }
    }
    return true;
  }

  String searchBarTitle(BuildContext context) {
    if (folderOverwrite.isNotEmpty) {
      return "${context.localized.search} ${folderOverwrite.last.name}...";
    }
    return views.included.length == 1
        ? "${context.localized.search} ${views.included.first.name}..."
        : "${context.localized.search} ${context.localized.library(2)}...";
  }

  ItemBaseModel? get nestedCurrentItem => folderOverwrite.lastOrNull;

  List<ItemBaseModel> get activePosters => selectedPosters.isNotEmpty ? selectedPosters : posters;

  bool get showPlayButtons {
    if (totalItemCount == 0) return false;
    return types.included.isEmpty ||
        types.included.containsAny(
          {...FladderItemType.playable, FladderItemType.folder},
        );
  }

  bool get showGalleryButtons {
    if (totalItemCount == 0) return false;
    return types.included.isEmpty ||
        types.included.containsAny(
          {...FladderItemType.galleryItem, FladderItemType.photoAlbum, FladderItemType.folder},
        );
  }

  LibrarySearchModel resetLazyLoad() {
    return copyWith(
      selectedPosters: [],
      lastIndices: const {},
      libraryItemCounts: const {},
    );
  }

  LibrarySearchModel fullReset() {
    return copyWith(
      posters: [],
      selectedPosters: [],
      lastIndices: const {},
      libraryItemCounts: const {},
    );
  }

  LibrarySearchModel setFiltersToDefault() {
    return copyWith(
      genres: const {},
      tags: const {},
      officialRatings: const {},
      years: const {},
      searchQuery: '',
      favourites: false,
      recursive: false,
      studios: const {},
      hideEmptyShows: true,
    );
  }

  @override
  bool operator ==(covariant LibrarySearchModel other) {
    if (identical(this, other)) return true;

    return other.searchQuery == searchQuery &&
        listEquals(other.folderOverwrite, folderOverwrite) &&
        mapEquals(other.views, views) &&
        mapEquals(other.filters, filters) &&
        mapEquals(other.genres, genres) &&
        mapEquals(other.studios, studios) &&
        mapEquals(other.tags, tags) &&
        mapEquals(other.years, years) &&
        mapEquals(other.officialRatings, officialRatings) &&
        mapEquals(other.types, types) &&
        other.sortingOption == sortingOption &&
        other.sortOrder == sortOrder &&
        other.favourites == favourites &&
        other.recursive == recursive;
  }

  @override
  int get hashCode {
    return searchQuery.hashCode ^
        folderOverwrite.hashCode ^
        views.hashCode ^
        posters.hashCode ^
        selectedPosters.hashCode ^
        filters.hashCode ^
        genres.hashCode ^
        studios.hashCode ^
        tags.hashCode ^
        years.hashCode ^
        officialRatings.hashCode ^
        types.hashCode ^
        sortingOption.hashCode ^
        sortOrder.hashCode ^
        favourites.hashCode ^
        recursive.hashCode;
  }
}
