// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_filters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LibraryFiltersModel _$LibraryFiltersModelFromJson(Map<String, dynamic> json) => _LibraryFiltersModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isFavourite: json['isFavourite'] as bool,
      sortKeys: (json['sortKeys'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$FilterSortKeyEnumMap, k), e as bool),
          ) ??
          const {},
      ids: (json['ids'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      viewNames: (json['viewNames'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      filter: json['filter'] == null
          ? const LibraryFilterModel()
          : LibraryFilterModel.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LibraryFiltersModelToJson(_LibraryFiltersModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isFavourite': instance.isFavourite,
      'sortKeys': instance.sortKeys.map((k, e) => MapEntry(_$FilterSortKeyEnumMap[k]!, e)),
      'ids': instance.ids,
      'viewNames': instance.viewNames,
      'filter': instance.filter,
    };

const _$FilterSortKeyEnumMap = {
  FilterSortKey.dashboard: 'dashboard',
  FilterSortKey.musicDashboard: 'musicDashboard',
  FilterSortKey.sideBar: 'sideBar',
  FilterSortKey.musicSideBar: 'musicSideBar',
};
