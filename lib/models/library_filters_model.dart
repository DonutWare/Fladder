import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xid/xid.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/util/map_bool_helper.dart';

part 'library_filters_model.freezed.dart';
part 'library_filters_model.g.dart';

@freezed
class LibraryFiltersModel with _$LibraryFiltersModel {
  const LibraryFiltersModel._();

  factory LibraryFiltersModel._internal({
    required String id,
    required String name,
    required bool isFavourite,
    required List<String> ids,
    required Map<String, bool> genres,
    required Map<ItemFilter, bool> filters,
    @StudioEncoder() required Map<Studio, bool> studios,
    required Map<String, bool> tags,
    required Map<int, bool> years,
    required Map<String, bool> officialRatings,
    required Map<FladderItemType, bool> types,
    required SortingOptions sortingOption,
    required SortingOrder sortOrder,
    required bool favourites,
    required bool hideEmptyShows,
    required bool recursive,
    required GroupBy groupBy,
  }) = _LibraryFiltersModel;

  factory LibraryFiltersModel.fromJson(Map<String, dynamic> json) => _$LibraryFiltersModelFromJson(json);

  factory LibraryFiltersModel.fromLibrarySearch(String name, LibrarySearchModel searchModel) {
    return LibraryFiltersModel._internal(
      id: Xid().toString(),
      name: name,
      isFavourite: false,
      ids: searchModel.views.included.map((e) => e.id).toList(),
      genres: searchModel.genres,
      filters: searchModel.filters,
      studios: searchModel.studios,
      tags: searchModel.tags,
      years: searchModel.years,
      officialRatings: searchModel.officialRatings,
      types: searchModel.types,
      sortingOption: searchModel.sortingOption,
      sortOrder: searchModel.sortOrder,
      favourites: searchModel.favourites,
      hideEmptyShows: searchModel.hideEmptyShows,
      recursive: searchModel.recursive,
      groupBy: searchModel.groupBy,
    );
  }

  bool containsSameIds(List<String> otherIds) => ids.length == otherIds.length && Set.from(ids).containsAll(otherIds);
}

class StudioEncoder implements JsonConverter<Map<Studio, bool>, String> {
  const StudioEncoder();

  @override
  Map<Studio, bool> fromJson(String json) {
    final decodedMap = jsonDecode(json) as Map<dynamic, dynamic>;
    final studios = decodedMap.map((key, value) => MapEntry(Studio.fromJson(key), value as bool));
    return studios;
  }

  @override
  String toJson(Map<Studio, bool> studios) => jsonEncode(studios.map((key, value) => MapEntry(key.toJson(), value)));
}
