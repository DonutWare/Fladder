import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/library_filter_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';

part 'library_search_model.freezed.dart';

@Freezed(copyWith: true)
abstract class LibrarySearchModel with _$LibrarySearchModel {
  const factory LibrarySearchModel({
    @Default(false) bool loading,
    @Default(false) bool selecteMode,
    @Default(<ItemBaseModel>[]) List<ItemBaseModel> folderOverwrite,
    @Default("") String searchQuery,
    @Default(<ViewModel, bool>{}) Map<ViewModel, bool> views,
    @Default(<ItemBaseModel>[]) List<ItemBaseModel> posters,
    @Default(<ItemBaseModel>[]) List<ItemBaseModel> selectedPosters,
    @Default(LibraryFilterModel()) LibraryFilterModel filters,
    @Default(<String, int>{}) Map<String, int> lastIndices,
    @Default(<String, int>{}) Map<String, int> libraryItemCounts,
    @Default(false) bool fetchingItems,
  }) = _LibrarySearchModel;
}

extension LibrarySearchModelX on LibrarySearchModel {
  bool get hasActiveFilters => filters.hasActiveFilters || searchQuery.isNotEmpty;

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
    return filters.types.included.isEmpty ||
        filters.types.included.containsAny(
          {...FladderItemType.playable, FladderItemType.folder},
        );
  }

  bool get showGalleryButtons {
    if (totalItemCount == 0) return false;
    return filters.types.included.isEmpty ||
        filters.types.included.containsAny(
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
      searchQuery: '',
      filters: const LibraryFilterModel(),
    );
  }
}
