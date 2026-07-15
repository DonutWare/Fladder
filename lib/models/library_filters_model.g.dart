// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_filters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LibraryFiltersModel _$LibraryFiltersModelFromJson(Map<String, dynamic> json) => _LibraryFiltersModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isFavourite: json['isFavourite'] as bool,
      showInSideBar: json['showInSideBar'] as bool? ?? false,
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
      'showInSideBar': instance.showInSideBar,
      'ids': instance.ids,
      'viewNames': instance.viewNames,
      'filter': instance.filter,
    };
