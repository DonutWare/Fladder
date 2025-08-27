// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibraryFilterModel implements DiagnosticableTreeMixin {
  Map<String, bool> get genres;
  Map<ItemFilter, bool> get itemFilters;
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

  /// Create a copy of LibraryFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LibraryFilterModelCopyWith<LibraryFilterModel> get copyWith =>
      _$LibraryFilterModelCopyWithImpl<LibraryFilterModel>(
          this as LibraryFilterModel, _$identity);

  /// Serializes this LibraryFilterModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LibraryFilterModel'))
      ..add(DiagnosticsProperty('genres', genres))
      ..add(DiagnosticsProperty('itemFilters', itemFilters))
      ..add(DiagnosticsProperty('studios', studios))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('years', years))
      ..add(DiagnosticsProperty('officialRatings', officialRatings))
      ..add(DiagnosticsProperty('types', types))
      ..add(DiagnosticsProperty('sortingOption', sortingOption))
      ..add(DiagnosticsProperty('sortOrder', sortOrder))
      ..add(DiagnosticsProperty('favourites', favourites))
      ..add(DiagnosticsProperty('hideEmptyShows', hideEmptyShows))
      ..add(DiagnosticsProperty('recursive', recursive))
      ..add(DiagnosticsProperty('groupBy', groupBy));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LibraryFilterModel(genres: $genres, itemFilters: $itemFilters, studios: $studios, tags: $tags, years: $years, officialRatings: $officialRatings, types: $types, sortingOption: $sortingOption, sortOrder: $sortOrder, favourites: $favourites, hideEmptyShows: $hideEmptyShows, recursive: $recursive, groupBy: $groupBy)';
  }
}

/// @nodoc
abstract mixin class $LibraryFilterModelCopyWith<$Res> {
  factory $LibraryFilterModelCopyWith(
          LibraryFilterModel value, $Res Function(LibraryFilterModel) _then) =
      _$LibraryFilterModelCopyWithImpl;
  @useResult
  $Res call(
      {Map<String, bool> genres,
      Map<ItemFilter, bool> itemFilters,
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
class _$LibraryFilterModelCopyWithImpl<$Res>
    implements $LibraryFilterModelCopyWith<$Res> {
  _$LibraryFilterModelCopyWithImpl(this._self, this._then);

  final LibraryFilterModel _self;
  final $Res Function(LibraryFilterModel) _then;

  /// Create a copy of LibraryFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genres = null,
    Object? itemFilters = null,
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
      genres: null == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      itemFilters: null == itemFilters
          ? _self.itemFilters
          : itemFilters // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [LibraryFilterModel].
extension LibraryFilterModelPatterns on LibraryFilterModel {
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
    TResult Function(_LibraryFilterModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibraryFilterModel() when $default != null:
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
    TResult Function(_LibraryFilterModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFilterModel():
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
    TResult? Function(_LibraryFilterModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFilterModel() when $default != null:
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
            Map<String, bool> genres,
            Map<ItemFilter, bool> itemFilters,
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
      case _LibraryFilterModel() when $default != null:
        return $default(
            _that.genres,
            _that.itemFilters,
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
            Map<String, bool> genres,
            Map<ItemFilter, bool> itemFilters,
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
      case _LibraryFilterModel():
        return $default(
            _that.genres,
            _that.itemFilters,
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
            Map<String, bool> genres,
            Map<ItemFilter, bool> itemFilters,
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
      case _LibraryFilterModel() when $default != null:
        return $default(
            _that.genres,
            _that.itemFilters,
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
class _LibraryFilterModel extends LibraryFilterModel
    with DiagnosticableTreeMixin {
  const _LibraryFilterModel(
      {final Map<String, bool> genres = const {},
      final Map<ItemFilter, bool> itemFilters = const {
        ItemFilter.isplayed: false,
        ItemFilter.isunplayed: false,
        ItemFilter.isresumable: false
      },
      @StudioEncoder() final Map<Studio, bool> studios = const {},
      final Map<String, bool> tags = const {},
      final Map<int, bool> years = const {},
      final Map<String, bool> officialRatings = const {},
      final Map<FladderItemType, bool> types = const {
        FladderItemType.audio: false,
        FladderItemType.boxset: false,
        FladderItemType.book: false,
        FladderItemType.collectionFolder: false,
        FladderItemType.episode: false,
        FladderItemType.folder: false,
        FladderItemType.movie: false,
        FladderItemType.musicAlbum: false,
        FladderItemType.musicVideo: false,
        FladderItemType.photo: false,
        FladderItemType.person: false,
        FladderItemType.photoAlbum: false,
        FladderItemType.series: false,
        FladderItemType.video: false
      },
      this.sortingOption = SortingOptions.sortName,
      this.sortOrder = SortingOrder.ascending,
      this.favourites = false,
      this.hideEmptyShows = true,
      this.recursive = true,
      this.groupBy = GroupBy.none})
      : _genres = genres,
        _itemFilters = itemFilters,
        _studios = studios,
        _tags = tags,
        _years = years,
        _officialRatings = officialRatings,
        _types = types,
        super._();
  factory _LibraryFilterModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryFilterModelFromJson(json);

  final Map<String, bool> _genres;
  @override
  @JsonKey()
  Map<String, bool> get genres {
    if (_genres is EqualUnmodifiableMapView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_genres);
  }

  final Map<ItemFilter, bool> _itemFilters;
  @override
  @JsonKey()
  Map<ItemFilter, bool> get itemFilters {
    if (_itemFilters is EqualUnmodifiableMapView) return _itemFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_itemFilters);
  }

  final Map<Studio, bool> _studios;
  @override
  @JsonKey()
  @StudioEncoder()
  Map<Studio, bool> get studios {
    if (_studios is EqualUnmodifiableMapView) return _studios;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_studios);
  }

  final Map<String, bool> _tags;
  @override
  @JsonKey()
  Map<String, bool> get tags {
    if (_tags is EqualUnmodifiableMapView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tags);
  }

  final Map<int, bool> _years;
  @override
  @JsonKey()
  Map<int, bool> get years {
    if (_years is EqualUnmodifiableMapView) return _years;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_years);
  }

  final Map<String, bool> _officialRatings;
  @override
  @JsonKey()
  Map<String, bool> get officialRatings {
    if (_officialRatings is EqualUnmodifiableMapView) return _officialRatings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_officialRatings);
  }

  final Map<FladderItemType, bool> _types;
  @override
  @JsonKey()
  Map<FladderItemType, bool> get types {
    if (_types is EqualUnmodifiableMapView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_types);
  }

  @override
  @JsonKey()
  final SortingOptions sortingOption;
  @override
  @JsonKey()
  final SortingOrder sortOrder;
  @override
  @JsonKey()
  final bool favourites;
  @override
  @JsonKey()
  final bool hideEmptyShows;
  @override
  @JsonKey()
  final bool recursive;
  @override
  @JsonKey()
  final GroupBy groupBy;

  /// Create a copy of LibraryFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LibraryFilterModelCopyWith<_LibraryFilterModel> get copyWith =>
      __$LibraryFilterModelCopyWithImpl<_LibraryFilterModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LibraryFilterModelToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LibraryFilterModel'))
      ..add(DiagnosticsProperty('genres', genres))
      ..add(DiagnosticsProperty('itemFilters', itemFilters))
      ..add(DiagnosticsProperty('studios', studios))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('years', years))
      ..add(DiagnosticsProperty('officialRatings', officialRatings))
      ..add(DiagnosticsProperty('types', types))
      ..add(DiagnosticsProperty('sortingOption', sortingOption))
      ..add(DiagnosticsProperty('sortOrder', sortOrder))
      ..add(DiagnosticsProperty('favourites', favourites))
      ..add(DiagnosticsProperty('hideEmptyShows', hideEmptyShows))
      ..add(DiagnosticsProperty('recursive', recursive))
      ..add(DiagnosticsProperty('groupBy', groupBy));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LibraryFilterModel(genres: $genres, itemFilters: $itemFilters, studios: $studios, tags: $tags, years: $years, officialRatings: $officialRatings, types: $types, sortingOption: $sortingOption, sortOrder: $sortOrder, favourites: $favourites, hideEmptyShows: $hideEmptyShows, recursive: $recursive, groupBy: $groupBy)';
  }
}

/// @nodoc
abstract mixin class _$LibraryFilterModelCopyWith<$Res>
    implements $LibraryFilterModelCopyWith<$Res> {
  factory _$LibraryFilterModelCopyWith(
          _LibraryFilterModel value, $Res Function(_LibraryFilterModel) _then) =
      __$LibraryFilterModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Map<String, bool> genres,
      Map<ItemFilter, bool> itemFilters,
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
class __$LibraryFilterModelCopyWithImpl<$Res>
    implements _$LibraryFilterModelCopyWith<$Res> {
  __$LibraryFilterModelCopyWithImpl(this._self, this._then);

  final _LibraryFilterModel _self;
  final $Res Function(_LibraryFilterModel) _then;

  /// Create a copy of LibraryFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? genres = null,
    Object? itemFilters = null,
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
    return _then(_LibraryFilterModel(
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      itemFilters: null == itemFilters
          ? _self._itemFilters
          : itemFilters // ignore: cast_nullable_to_non_nullable
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
