import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/util/map_bool_helper.dart';

part 'library_filter_model.freezed.dart';
part 'library_filter_model.g.dart';

@Freezed(copyWith: true)
abstract class LibraryFilterModel with _$LibraryFilterModel {
  const LibraryFilterModel._();

  const factory LibraryFilterModel({
    @Default({}) Map<String, bool> genres,
    @Default({
      ItemFilter.isplayed: false,
      ItemFilter.isunplayed: false,
      ItemFilter.isresumable: false,
    })
    @Default({})
    Map<ItemFilter, bool> itemFilters,
    @StudioEncoder() @Default({}) Map<Studio, bool> studios,
    @Default({}) Map<String, bool> tags,
    @Default({}) Map<int, bool> years,
    @Default({}) Map<String, bool> officialRatings,
    @Default({
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
    })
    Map<FladderItemType, bool> types,
    @Default(SortingOptions.sortName) SortingOptions sortingOption,
    @Default(SortingOrder.ascending) SortingOrder sortOrder,
    @Default(false) bool favourites,
    @Default(true) bool hideEmptyShows,
    @Default(true) bool recursive,
    @Default(GroupBy.none) GroupBy groupBy,
  }) = _LibraryFilterModel;

  bool get hasActiveFilters {
    return genres.hasEnabled ||
        studios.hasEnabled ||
        tags.hasEnabled ||
        years.hasEnabled ||
        officialRatings.hasEnabled ||
        hideEmptyShows ||
        itemFilters.hasEnabled ||
        favourites;
  }

  LibraryFilterModel loadModel(LibraryFilterModel model) {
    return copyWith(
      genres: genres.replaceMap(model.genres),
      itemFilters: itemFilters.replaceMap(model.itemFilters),
      studios: studios.replaceMap(model.studios),
      tags: tags.replaceMap(model.tags),
      years: years.replaceMap(model.years),
      officialRatings: officialRatings.replaceMap(model.officialRatings),
      types: types.replaceMap(model.types),
      sortingOption: model.sortingOption,
      sortOrder: model.sortOrder,
      favourites: model.favourites,
      hideEmptyShows: model.hideEmptyShows,
      recursive: model.recursive,
      groupBy: model.groupBy,
    );
  }

  factory LibraryFilterModel.fromJson(Map<String, dynamic> json) => _$LibraryFilterModelFromJson(json);

  @override
  bool operator ==(covariant LibraryFilterModel other) {
    if (identical(this, other)) return true;
    return mapEquals(other.genres, genres) &&
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
    return itemFilters.hashCode ^
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

  LibraryFilterModel setAll(bool bool) {
    return copyWith(
      genres: genres.setAll(false),
      tags: tags.setAll(false),
      officialRatings: officialRatings.setAll(false),
      years: years.setAll(false),
      favourites: false,
      recursive: false,
      studios: studios.setAll(false),
      itemFilters: itemFilters.setAll(false),
      hideEmptyShows: false,
    );
  }
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
