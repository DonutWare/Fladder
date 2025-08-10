// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_filters_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibraryFiltersModel {
  String get id;
  String get name;
  bool get isFavourite;
  List<String> get ids;
  Map<String, bool> get genres;
  Map<ItemFilter, bool> get filters;
  @StudioEncoder()
  Map<Studio, bool> get studios;
  Map<String, bool> get tags;
  Map<int, bool> get years;
  Map<String, bool> get officialRatings;
  Map<FladderItemType, bool> get types;
  SortingOptions get sortingOption;
  SortingOrder get sortOrder;
  bool get favourites;
  bool get hideEmptyShows;
  bool get recursive;
  GroupBy get groupBy;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LibraryFiltersModelCopyWith<LibraryFiltersModel> get copyWith =>
      _$LibraryFiltersModelCopyWithImpl<LibraryFiltersModel>(
          this as LibraryFiltersModel, _$identity);

  /// Serializes this LibraryFiltersModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'LibraryFiltersModel(id: $id, name: $name, isFavourite: $isFavourite, ids: $ids, genres: $genres, filters: $filters, studios: $studios, tags: $tags, years: $years, officialRatings: $officialRatings, types: $types, sortingOption: $sortingOption, sortOrder: $sortOrder, favourites: $favourites, hideEmptyShows: $hideEmptyShows, recursive: $recursive, groupBy: $groupBy)';
  }
}

/// @nodoc
abstract mixin class $LibraryFiltersModelCopyWith<$Res> {
  factory $LibraryFiltersModelCopyWith(
          LibraryFiltersModel value, $Res Function(LibraryFiltersModel) _then) =
      _$LibraryFiltersModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      bool isFavourite,
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
class _$LibraryFiltersModelCopyWithImpl<$Res>
    implements $LibraryFiltersModelCopyWith<$Res> {
  _$LibraryFiltersModelCopyWithImpl(this._self, this._then);

  final LibraryFiltersModel _self;
  final $Res Function(LibraryFiltersModel) _then;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isFavourite = null,
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: null == isFavourite
          ? _self.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      ids: null == ids
          ? _self.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      genres: null == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      filters: null == filters
          ? _self.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<ItemFilter, bool>,
      studios: null == studios
          ? _self.studios
          : studios // ignore: cast_nullable_to_non_nullable
              as Map<Studio, bool>,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      years: null == years
          ? _self.years
          : years // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      officialRatings: null == officialRatings
          ? _self.officialRatings
          : officialRatings // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      types: null == types
          ? _self.types
          : types // ignore: cast_nullable_to_non_nullable
              as Map<FladderItemType, bool>,
      sortingOption: null == sortingOption
          ? _self.sortingOption
          : sortingOption // ignore: cast_nullable_to_non_nullable
              as SortingOptions,
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortingOrder,
      favourites: null == favourites
          ? _self.favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as bool,
      hideEmptyShows: null == hideEmptyShows
          ? _self.hideEmptyShows
          : hideEmptyShows // ignore: cast_nullable_to_non_nullable
              as bool,
      recursive: null == recursive
          ? _self.recursive
          : recursive // ignore: cast_nullable_to_non_nullable
              as bool,
      groupBy: null == groupBy
          ? _self.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as GroupBy,
    ));
  }
}

/// Adds pattern-matching-related methods to [LibraryFiltersModel].
extension LibraryFiltersModelPatterns on LibraryFiltersModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LibraryFiltersModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LibraryFiltersModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LibraryFiltersModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            bool isFavourite,
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
            GroupBy groupBy)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.isFavourite,
            _that.ids,
            _that.genres,
            _that.filters,
            _that.studios,
            _that.tags,
            _that.years,
            _that.officialRatings,
            _that.types,
            _that.sortingOption,
            _that.sortOrder,
            _that.favourites,
            _that.hideEmptyShows,
            _that.recursive,
            _that.groupBy);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            bool isFavourite,
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
            GroupBy groupBy)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel():
        return $default(
            _that.id,
            _that.name,
            _that.isFavourite,
            _that.ids,
            _that.genres,
            _that.filters,
            _that.studios,
            _that.tags,
            _that.years,
            _that.officialRatings,
            _that.types,
            _that.sortingOption,
            _that.sortOrder,
            _that.favourites,
            _that.hideEmptyShows,
            _that.recursive,
            _that.groupBy);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            bool isFavourite,
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
            GroupBy groupBy)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.isFavourite,
            _that.ids,
            _that.genres,
            _that.filters,
            _that.studios,
            _that.tags,
            _that.years,
            _that.officialRatings,
            _that.types,
            _that.sortingOption,
            _that.sortOrder,
            _that.favourites,
            _that.hideEmptyShows,
            _that.recursive,
            _that.groupBy);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LibraryFiltersModel extends LibraryFiltersModel {
  _LibraryFiltersModel(
      {required this.id,
      required this.name,
      required this.isFavourite,
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
  factory _LibraryFiltersModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryFiltersModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool isFavourite;
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

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LibraryFiltersModelCopyWith<_LibraryFiltersModel> get copyWith =>
      __$LibraryFiltersModelCopyWithImpl<_LibraryFiltersModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LibraryFiltersModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'LibraryFiltersModel(id: $id, name: $name, isFavourite: $isFavourite, ids: $ids, genres: $genres, filters: $filters, studios: $studios, tags: $tags, years: $years, officialRatings: $officialRatings, types: $types, sortingOption: $sortingOption, sortOrder: $sortOrder, favourites: $favourites, hideEmptyShows: $hideEmptyShows, recursive: $recursive, groupBy: $groupBy)';
  }
}

/// @nodoc
abstract mixin class _$LibraryFiltersModelCopyWith<$Res>
    implements $LibraryFiltersModelCopyWith<$Res> {
  factory _$LibraryFiltersModelCopyWith(_LibraryFiltersModel value,
          $Res Function(_LibraryFiltersModel) _then) =
      __$LibraryFiltersModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      bool isFavourite,
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
class __$LibraryFiltersModelCopyWithImpl<$Res>
    implements _$LibraryFiltersModelCopyWith<$Res> {
  __$LibraryFiltersModelCopyWithImpl(this._self, this._then);

  final _LibraryFiltersModel _self;
  final $Res Function(_LibraryFiltersModel) _then;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isFavourite = null,
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
    return _then(_LibraryFiltersModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: null == isFavourite
          ? _self.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      ids: null == ids
          ? _self._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      filters: null == filters
          ? _self._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<ItemFilter, bool>,
      studios: null == studios
          ? _self._studios
          : studios // ignore: cast_nullable_to_non_nullable
              as Map<Studio, bool>,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      years: null == years
          ? _self._years
          : years // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      officialRatings: null == officialRatings
          ? _self._officialRatings
          : officialRatings // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      types: null == types
          ? _self._types
          : types // ignore: cast_nullable_to_non_nullable
              as Map<FladderItemType, bool>,
      sortingOption: null == sortingOption
          ? _self.sortingOption
          : sortingOption // ignore: cast_nullable_to_non_nullable
              as SortingOptions,
      sortOrder: null == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortingOrder,
      favourites: null == favourites
          ? _self.favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as bool,
      hideEmptyShows: null == hideEmptyShows
          ? _self.hideEmptyShows
          : hideEmptyShows // ignore: cast_nullable_to_non_nullable
              as bool,
      recursive: null == recursive
          ? _self.recursive
          : recursive // ignore: cast_nullable_to_non_nullable
              as bool,
      groupBy: null == groupBy
          ? _self.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as GroupBy,
    ));
  }
}

// dart format on
