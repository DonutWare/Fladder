// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_filters_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LibraryFiltersModel _$LibraryFiltersModelFromJson(Map<String, dynamic> json) {
  return _LibraryFiltersModel.fromJson(json);
}

/// @nodoc
mixin _$LibraryFiltersModel {
  String get id => throw _privateConstructorUsedError;
  String get name =>
      throw _privateConstructorUsedError; // ignore: unused_element
  dynamic get isFavourite => throw _privateConstructorUsedError;
  List<String> get ids => throw _privateConstructorUsedError;
  Map<String, bool> get genres => throw _privateConstructorUsedError;
  Map<ItemFilter, bool> get filters => throw _privateConstructorUsedError;
  @StudioEncoder()
  Map<Studio, bool> get studios => throw _privateConstructorUsedError;
  Map<String, bool> get tags => throw _privateConstructorUsedError;
  Map<int, bool> get years => throw _privateConstructorUsedError;
  Map<String, bool> get officialRatings => throw _privateConstructorUsedError;
  Map<FladderItemType, bool> get types => throw _privateConstructorUsedError;
  SortingOptions get sortingOption => throw _privateConstructorUsedError;
  SortingOrder get sortOrder => throw _privateConstructorUsedError;
  bool get favourites => throw _privateConstructorUsedError;
  bool get hideEmptyShows => throw _privateConstructorUsedError;
  bool get recursive => throw _privateConstructorUsedError;
  GroupBy get groupBy => throw _privateConstructorUsedError;

  /// Serializes this LibraryFiltersModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LibraryFiltersModelCopyWith<LibraryFiltersModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LibraryFiltersModelCopyWith<$Res> {
  factory $LibraryFiltersModelCopyWith(
          LibraryFiltersModel value, $Res Function(LibraryFiltersModel) then) =
      _$LibraryFiltersModelCopyWithImpl<$Res, LibraryFiltersModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      dynamic isFavourite,
      List<String> ids,
      Map<String, bool> genres,
      Map<ItemFilter, bool> filters,
      @StudioEncoder() Map<Studio, bool> studios,
      Map<String, bool> tags,
      Map<int, bool> years,
      Map<String, bool> officialRatings,
      Map<FladderItemType, bool> types,
      SortingOptions sortingOption,
      SortingOrder sortOrder,
      bool favourites,
      bool hideEmptyShows,
      bool recursive,
      GroupBy groupBy});
}

/// @nodoc
class _$LibraryFiltersModelCopyWithImpl<$Res, $Val extends LibraryFiltersModel>
    implements $LibraryFiltersModelCopyWith<$Res> {
  _$LibraryFiltersModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isFavourite = freezed,
    Object? ids = null,
    Object? genres = null,
    Object? filters = null,
    Object? studios = null,
    Object? tags = null,
    Object? years = null,
    Object? officialRatings = null,
    Object? types = null,
    Object? sortingOption = null,
    Object? sortOrder = null,
    Object? favourites = null,
    Object? hideEmptyShows = null,
    Object? recursive = null,
    Object? groupBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: freezed == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<ItemFilter, bool>,
      studios: null == studios
          ? _value.studios
          : studios // ignore: cast_nullable_to_non_nullable
              as Map<Studio, bool>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      years: null == years
          ? _value.years
          : years // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      officialRatings: null == officialRatings
          ? _value.officialRatings
          : officialRatings // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as Map<FladderItemType, bool>,
      sortingOption: null == sortingOption
          ? _value.sortingOption
          : sortingOption // ignore: cast_nullable_to_non_nullable
              as SortingOptions,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortingOrder,
      favourites: null == favourites
          ? _value.favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as bool,
      hideEmptyShows: null == hideEmptyShows
          ? _value.hideEmptyShows
          : hideEmptyShows // ignore: cast_nullable_to_non_nullable
              as bool,
      recursive: null == recursive
          ? _value.recursive
          : recursive // ignore: cast_nullable_to_non_nullable
              as bool,
      groupBy: null == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as GroupBy,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LibraryFiltersModelImplCopyWith<$Res>
    implements $LibraryFiltersModelCopyWith<$Res> {
  factory _$$LibraryFiltersModelImplCopyWith(_$LibraryFiltersModelImpl value,
          $Res Function(_$LibraryFiltersModelImpl) then) =
      __$$LibraryFiltersModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      dynamic isFavourite,
      List<String> ids,
      Map<String, bool> genres,
      Map<ItemFilter, bool> filters,
      @StudioEncoder() Map<Studio, bool> studios,
      Map<String, bool> tags,
      Map<int, bool> years,
      Map<String, bool> officialRatings,
      Map<FladderItemType, bool> types,
      SortingOptions sortingOption,
      SortingOrder sortOrder,
      bool favourites,
      bool hideEmptyShows,
      bool recursive,
      GroupBy groupBy});
}

/// @nodoc
class __$$LibraryFiltersModelImplCopyWithImpl<$Res>
    extends _$LibraryFiltersModelCopyWithImpl<$Res, _$LibraryFiltersModelImpl>
    implements _$$LibraryFiltersModelImplCopyWith<$Res> {
  __$$LibraryFiltersModelImplCopyWithImpl(_$LibraryFiltersModelImpl _value,
      $Res Function(_$LibraryFiltersModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isFavourite = freezed,
    Object? ids = null,
    Object? genres = null,
    Object? filters = null,
    Object? studios = null,
    Object? tags = null,
    Object? years = null,
    Object? officialRatings = null,
    Object? types = null,
    Object? sortingOption = null,
    Object? sortOrder = null,
    Object? favourites = null,
    Object? hideEmptyShows = null,
    Object? recursive = null,
    Object? groupBy = null,
  }) {
    return _then(_$LibraryFiltersModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: freezed == isFavourite ? _value.isFavourite! : isFavourite,
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<ItemFilter, bool>,
      studios: null == studios
          ? _value._studios
          : studios // ignore: cast_nullable_to_non_nullable
              as Map<Studio, bool>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      years: null == years
          ? _value._years
          : years // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      officialRatings: null == officialRatings
          ? _value._officialRatings
          : officialRatings // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      types: null == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as Map<FladderItemType, bool>,
      sortingOption: null == sortingOption
          ? _value.sortingOption
          : sortingOption // ignore: cast_nullable_to_non_nullable
              as SortingOptions,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortingOrder,
      favourites: null == favourites
          ? _value.favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as bool,
      hideEmptyShows: null == hideEmptyShows
          ? _value.hideEmptyShows
          : hideEmptyShows // ignore: cast_nullable_to_non_nullable
              as bool,
      recursive: null == recursive
          ? _value.recursive
          : recursive // ignore: cast_nullable_to_non_nullable
              as bool,
      groupBy: null == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as GroupBy,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LibraryFiltersModelImpl extends _LibraryFiltersModel {
  _$LibraryFiltersModelImpl(
      {required this.id,
      required this.name,
      this.isFavourite = false,
      required final List<String> ids,
      required final Map<String, bool> genres,
      required final Map<ItemFilter, bool> filters,
      @StudioEncoder() required final Map<Studio, bool> studios,
      required final Map<String, bool> tags,
      required final Map<int, bool> years,
      required final Map<String, bool> officialRatings,
      required final Map<FladderItemType, bool> types,
      required this.sortingOption,
      required this.sortOrder,
      required this.favourites,
      required this.hideEmptyShows,
      required this.recursive,
      required this.groupBy})
      : _ids = ids,
        _genres = genres,
        _filters = filters,
        _studios = studios,
        _tags = tags,
        _years = years,
        _officialRatings = officialRatings,
        _types = types,
        super._();

  factory _$LibraryFiltersModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LibraryFiltersModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
// ignore: unused_element
  @override
  @JsonKey()
  final dynamic isFavourite;
  final List<String> _ids;
  @override
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  final Map<String, bool> _genres;
  @override
  Map<String, bool> get genres {
    if (_genres is EqualUnmodifiableMapView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_genres);
  }

  final Map<ItemFilter, bool> _filters;
  @override
  Map<ItemFilter, bool> get filters {
    if (_filters is EqualUnmodifiableMapView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_filters);
  }

  final Map<Studio, bool> _studios;
  @override
  @StudioEncoder()
  Map<Studio, bool> get studios {
    if (_studios is EqualUnmodifiableMapView) return _studios;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_studios);
  }

  final Map<String, bool> _tags;
  @override
  Map<String, bool> get tags {
    if (_tags is EqualUnmodifiableMapView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tags);
  }

  final Map<int, bool> _years;
  @override
  Map<int, bool> get years {
    if (_years is EqualUnmodifiableMapView) return _years;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_years);
  }

  final Map<String, bool> _officialRatings;
  @override
  Map<String, bool> get officialRatings {
    if (_officialRatings is EqualUnmodifiableMapView) return _officialRatings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_officialRatings);
  }

  final Map<FladderItemType, bool> _types;
  @override
  Map<FladderItemType, bool> get types {
    if (_types is EqualUnmodifiableMapView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_types);
  }

  @override
  final SortingOptions sortingOption;
  @override
  final SortingOrder sortOrder;
  @override
  final bool favourites;
  @override
  final bool hideEmptyShows;
  @override
  final bool recursive;
  @override
  final GroupBy groupBy;

  @override
  String toString() {
    return 'LibraryFiltersModel._internal(id: $id, name: $name, isFavourite: $isFavourite, ids: $ids, genres: $genres, filters: $filters, studios: $studios, tags: $tags, years: $years, officialRatings: $officialRatings, types: $types, sortingOption: $sortingOption, sortOrder: $sortOrder, favourites: $favourites, hideEmptyShows: $hideEmptyShows, recursive: $recursive, groupBy: $groupBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LibraryFiltersModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.isFavourite, isFavourite) &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality().equals(other._studios, _studios) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._years, _years) &&
            const DeepCollectionEquality()
                .equals(other._officialRatings, _officialRatings) &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            (identical(other.sortingOption, sortingOption) ||
                other.sortingOption == sortingOption) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.favourites, favourites) ||
                other.favourites == favourites) &&
            (identical(other.hideEmptyShows, hideEmptyShows) ||
                other.hideEmptyShows == hideEmptyShows) &&
            (identical(other.recursive, recursive) ||
                other.recursive == recursive) &&
            (identical(other.groupBy, groupBy) || other.groupBy == groupBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(isFavourite),
      const DeepCollectionEquality().hash(_ids),
      const DeepCollectionEquality().hash(_genres),
      const DeepCollectionEquality().hash(_filters),
      const DeepCollectionEquality().hash(_studios),
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_years),
      const DeepCollectionEquality().hash(_officialRatings),
      const DeepCollectionEquality().hash(_types),
      sortingOption,
      sortOrder,
      favourites,
      hideEmptyShows,
      recursive,
      groupBy);

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LibraryFiltersModelImplCopyWith<_$LibraryFiltersModelImpl> get copyWith =>
      __$$LibraryFiltersModelImplCopyWithImpl<_$LibraryFiltersModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LibraryFiltersModelImplToJson(
      this,
    );
  }
}

abstract class _LibraryFiltersModel extends LibraryFiltersModel {
  factory _LibraryFiltersModel(
      {required final String id,
      required final String name,
      final dynamic isFavourite,
      required final List<String> ids,
      required final Map<String, bool> genres,
      required final Map<ItemFilter, bool> filters,
      @StudioEncoder() required final Map<Studio, bool> studios,
      required final Map<String, bool> tags,
      required final Map<int, bool> years,
      required final Map<String, bool> officialRatings,
      required final Map<FladderItemType, bool> types,
      required final SortingOptions sortingOption,
      required final SortingOrder sortOrder,
      required final bool favourites,
      required final bool hideEmptyShows,
      required final bool recursive,
      required final GroupBy groupBy}) = _$LibraryFiltersModelImpl;
  _LibraryFiltersModel._() : super._();

  factory _LibraryFiltersModel.fromJson(Map<String, dynamic> json) =
      _$LibraryFiltersModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name; // ignore: unused_element
  @override
  dynamic get isFavourite;
  @override
  List<String> get ids;
  @override
  Map<String, bool> get genres;
  @override
  Map<ItemFilter, bool> get filters;
  @override
  @StudioEncoder()
  Map<Studio, bool> get studios;
  @override
  Map<String, bool> get tags;
  @override
  Map<int, bool> get years;
  @override
  Map<String, bool> get officialRatings;
  @override
  Map<FladderItemType, bool> get types;
  @override
  SortingOptions get sortingOption;
  @override
  SortingOrder get sortOrder;
  @override
  bool get favourites;
  @override
  bool get hideEmptyShows;
  @override
  bool get recursive;
  @override
  GroupBy get groupBy;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LibraryFiltersModelImplCopyWith<_$LibraryFiltersModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
