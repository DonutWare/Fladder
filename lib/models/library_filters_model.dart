import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xid/xid.dart';

import 'package:fladder/models/library_filter_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/util/map_bool_helper.dart';

part 'library_filters_model.freezed.dart';
part 'library_filters_model.g.dart';

@Freezed(copyWith: true)
abstract class LibraryFiltersModel with _$LibraryFiltersModel {
  const LibraryFiltersModel._();

  factory LibraryFiltersModel({
    required String id,
    required String name,
    required bool isFavourite,
    @Default([]) List<String> ids,
    @Default(LibraryFilterModel()) LibraryFilterModel filter,
  }) = _LibraryFiltersModel;

  factory LibraryFiltersModel.fromJson(Map<String, dynamic> json) => _$LibraryFiltersModelFromJson(json);

  factory LibraryFiltersModel.fromLibrarySearch(
    String name,
    LibrarySearchModel searchModel, {
    bool? isFavourite,
    String? id,
  }) {
    return LibraryFiltersModel(
      id: id ?? Xid().toString(),
      name: name,
      isFavourite: isFavourite ?? false,
      ids: searchModel.views.included.map((e) => e.id).toList(),
      filter: searchModel.filters,
    );
  }

  bool containsSameIds(List<String> otherIds) => ids.length == otherIds.length && Set.from(ids).containsAll(otherIds);
}
