// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibrarySearchModel implements DiagnosticableTreeMixin {
  bool get loading;
  bool get selecteMode;
  List<ItemBaseModel> get folderOverwrite;
  String get searchQuery;
  Map<ViewModel, bool> get views;
  List<ItemBaseModel> get posters;
  List<ItemBaseModel> get selectedPosters;
  LibraryFilterModel get filters;
  Map<String, int> get lastIndices;
  Map<String, int> get libraryItemCounts;
  bool get fetchingItems;

  /// Create a copy of LibrarySearchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LibrarySearchModelCopyWith<LibrarySearchModel> get copyWith =>
      _$LibrarySearchModelCopyWithImpl<LibrarySearchModel>(
          this as LibrarySearchModel, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LibrarySearchModel'))
      ..add(DiagnosticsProperty('loading', loading))
      ..add(DiagnosticsProperty('selecteMode', selecteMode))
      ..add(DiagnosticsProperty('folderOverwrite', folderOverwrite))
      ..add(DiagnosticsProperty('searchQuery', searchQuery))
      ..add(DiagnosticsProperty('views', views))
      ..add(DiagnosticsProperty('posters', posters))
      ..add(DiagnosticsProperty('selectedPosters', selectedPosters))
      ..add(DiagnosticsProperty('filters', filters))
      ..add(DiagnosticsProperty('lastIndices', lastIndices))
      ..add(DiagnosticsProperty('libraryItemCounts', libraryItemCounts))
      ..add(DiagnosticsProperty('fetchingItems', fetchingItems));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LibrarySearchModel(loading: $loading, selecteMode: $selecteMode, folderOverwrite: $folderOverwrite, searchQuery: $searchQuery, views: $views, posters: $posters, selectedPosters: $selectedPosters, filters: $filters, lastIndices: $lastIndices, libraryItemCounts: $libraryItemCounts, fetchingItems: $fetchingItems)';
  }
}

/// @nodoc
abstract mixin class $LibrarySearchModelCopyWith<$Res> {
  factory $LibrarySearchModelCopyWith(
          LibrarySearchModel value, $Res Function(LibrarySearchModel) _then) =
      _$LibrarySearchModelCopyWithImpl;
  @useResult
  $Res call(
      {bool loading,
      bool selecteMode,
      List<ItemBaseModel> folderOverwrite,
      String searchQuery,
      Map<ViewModel, bool> views,
      List<ItemBaseModel> posters,
      List<ItemBaseModel> selectedPosters,
      LibraryFilterModel filters,
      Map<String, int> lastIndices,
      Map<String, int> libraryItemCounts,
      bool fetchingItems});

  $LibraryFilterModelCopyWith<$Res> get filters;
}

/// @nodoc
class _$LibrarySearchModelCopyWithImpl<$Res>
    implements $LibrarySearchModelCopyWith<$Res> {
  _$LibrarySearchModelCopyWithImpl(this._self, this._then);

  final LibrarySearchModel _self;
  final $Res Function(LibrarySearchModel) _then;

  /// Create a copy of LibrarySearchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? selecteMode = null,
    Object? folderOverwrite = null,
    Object? searchQuery = null,
    Object? views = null,
    Object? posters = null,
    Object? selectedPosters = null,
    Object? filters = null,
    Object? lastIndices = null,
    Object? libraryItemCounts = null,
    Object? fetchingItems = null,
  }) {
    return _then(_self.copyWith(
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selecteMode: null == selecteMode
          ? _self.selecteMode
          : selecteMode // ignore: cast_nullable_to_non_nullable
              as bool,
      folderOverwrite: null == folderOverwrite
          ? _self.folderOverwrite
          : folderOverwrite // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
      searchQuery: null == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      views: null == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as Map<ViewModel, bool>,
      posters: null == posters
          ? _self.posters
          : posters // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
      selectedPosters: null == selectedPosters
          ? _self.selectedPosters
          : selectedPosters // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
      filters: null == filters
          ? _self.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as LibraryFilterModel,
      lastIndices: null == lastIndices
          ? _self.lastIndices
          : lastIndices // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      libraryItemCounts: null == libraryItemCounts
          ? _self.libraryItemCounts
          : libraryItemCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      fetchingItems: null == fetchingItems
          ? _self.fetchingItems
          : fetchingItems // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of LibrarySearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LibraryFilterModelCopyWith<$Res> get filters {
    return $LibraryFilterModelCopyWith<$Res>(_self.filters, (value) {
      return _then(_self.copyWith(filters: value));
    });
  }
}

/// Adds pattern-matching-related methods to [LibrarySearchModel].
extension LibrarySearchModelPatterns on LibrarySearchModel {
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
    TResult Function(_LibrarySearchModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibrarySearchModel() when $default != null:
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
    TResult Function(_LibrarySearchModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibrarySearchModel():
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
    TResult? Function(_LibrarySearchModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibrarySearchModel() when $default != null:
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
            bool loading,
            bool selecteMode,
            List<ItemBaseModel> folderOverwrite,
            String searchQuery,
            Map<ViewModel, bool> views,
            List<ItemBaseModel> posters,
            List<ItemBaseModel> selectedPosters,
            LibraryFilterModel filters,
            Map<String, int> lastIndices,
            Map<String, int> libraryItemCounts,
            bool fetchingItems)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibrarySearchModel() when $default != null:
        return $default(
            _that.loading,
            _that.selecteMode,
            _that.folderOverwrite,
            _that.searchQuery,
            _that.views,
            _that.posters,
            _that.selectedPosters,
            _that.filters,
            _that.lastIndices,
            _that.libraryItemCounts,
            _that.fetchingItems);
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
            bool loading,
            bool selecteMode,
            List<ItemBaseModel> folderOverwrite,
            String searchQuery,
            Map<ViewModel, bool> views,
            List<ItemBaseModel> posters,
            List<ItemBaseModel> selectedPosters,
            LibraryFilterModel filters,
            Map<String, int> lastIndices,
            Map<String, int> libraryItemCounts,
            bool fetchingItems)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibrarySearchModel():
        return $default(
            _that.loading,
            _that.selecteMode,
            _that.folderOverwrite,
            _that.searchQuery,
            _that.views,
            _that.posters,
            _that.selectedPosters,
            _that.filters,
            _that.lastIndices,
            _that.libraryItemCounts,
            _that.fetchingItems);
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
            bool loading,
            bool selecteMode,
            List<ItemBaseModel> folderOverwrite,
            String searchQuery,
            Map<ViewModel, bool> views,
            List<ItemBaseModel> posters,
            List<ItemBaseModel> selectedPosters,
            LibraryFilterModel filters,
            Map<String, int> lastIndices,
            Map<String, int> libraryItemCounts,
            bool fetchingItems)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibrarySearchModel() when $default != null:
        return $default(
            _that.loading,
            _that.selecteMode,
            _that.folderOverwrite,
            _that.searchQuery,
            _that.views,
            _that.posters,
            _that.selectedPosters,
            _that.filters,
            _that.lastIndices,
            _that.libraryItemCounts,
            _that.fetchingItems);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LibrarySearchModel
    with DiagnosticableTreeMixin
    implements LibrarySearchModel {
  const _LibrarySearchModel(
      {this.loading = false,
      this.selecteMode = false,
      final List<ItemBaseModel> folderOverwrite = const <ItemBaseModel>[],
      this.searchQuery = "",
      final Map<ViewModel, bool> views = const <ViewModel, bool>{},
      final List<ItemBaseModel> posters = const <ItemBaseModel>[],
      final List<ItemBaseModel> selectedPosters = const <ItemBaseModel>[],
      this.filters = const LibraryFilterModel(),
      final Map<String, int> lastIndices = const <String, int>{},
      final Map<String, int> libraryItemCounts = const <String, int>{},
      this.fetchingItems = false})
      : _folderOverwrite = folderOverwrite,
        _views = views,
        _posters = posters,
        _selectedPosters = selectedPosters,
        _lastIndices = lastIndices,
        _libraryItemCounts = libraryItemCounts;

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool selecteMode;
  final List<ItemBaseModel> _folderOverwrite;
  @override
  @JsonKey()
  List<ItemBaseModel> get folderOverwrite {
    if (_folderOverwrite is EqualUnmodifiableListView) return _folderOverwrite;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_folderOverwrite);
  }

  @override
  @JsonKey()
  final String searchQuery;
  final Map<ViewModel, bool> _views;
  @override
  @JsonKey()
  Map<ViewModel, bool> get views {
    if (_views is EqualUnmodifiableMapView) return _views;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_views);
  }

  final List<ItemBaseModel> _posters;
  @override
  @JsonKey()
  List<ItemBaseModel> get posters {
    if (_posters is EqualUnmodifiableListView) return _posters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posters);
  }

  final List<ItemBaseModel> _selectedPosters;
  @override
  @JsonKey()
  List<ItemBaseModel> get selectedPosters {
    if (_selectedPosters is EqualUnmodifiableListView) return _selectedPosters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedPosters);
  }

  @override
  @JsonKey()
  final LibraryFilterModel filters;
  final Map<String, int> _lastIndices;
  @override
  @JsonKey()
  Map<String, int> get lastIndices {
    if (_lastIndices is EqualUnmodifiableMapView) return _lastIndices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastIndices);
  }

  final Map<String, int> _libraryItemCounts;
  @override
  @JsonKey()
  Map<String, int> get libraryItemCounts {
    if (_libraryItemCounts is EqualUnmodifiableMapView)
      return _libraryItemCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_libraryItemCounts);
  }

  @override
  @JsonKey()
  final bool fetchingItems;

  /// Create a copy of LibrarySearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LibrarySearchModelCopyWith<_LibrarySearchModel> get copyWith =>
      __$LibrarySearchModelCopyWithImpl<_LibrarySearchModel>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LibrarySearchModel'))
      ..add(DiagnosticsProperty('loading', loading))
      ..add(DiagnosticsProperty('selecteMode', selecteMode))
      ..add(DiagnosticsProperty('folderOverwrite', folderOverwrite))
      ..add(DiagnosticsProperty('searchQuery', searchQuery))
      ..add(DiagnosticsProperty('views', views))
      ..add(DiagnosticsProperty('posters', posters))
      ..add(DiagnosticsProperty('selectedPosters', selectedPosters))
      ..add(DiagnosticsProperty('filters', filters))
      ..add(DiagnosticsProperty('lastIndices', lastIndices))
      ..add(DiagnosticsProperty('libraryItemCounts', libraryItemCounts))
      ..add(DiagnosticsProperty('fetchingItems', fetchingItems));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LibrarySearchModel(loading: $loading, selecteMode: $selecteMode, folderOverwrite: $folderOverwrite, searchQuery: $searchQuery, views: $views, posters: $posters, selectedPosters: $selectedPosters, filters: $filters, lastIndices: $lastIndices, libraryItemCounts: $libraryItemCounts, fetchingItems: $fetchingItems)';
  }
}

/// @nodoc
abstract mixin class _$LibrarySearchModelCopyWith<$Res>
    implements $LibrarySearchModelCopyWith<$Res> {
  factory _$LibrarySearchModelCopyWith(
          _LibrarySearchModel value, $Res Function(_LibrarySearchModel) _then) =
      __$LibrarySearchModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool loading,
      bool selecteMode,
      List<ItemBaseModel> folderOverwrite,
      String searchQuery,
      Map<ViewModel, bool> views,
      List<ItemBaseModel> posters,
      List<ItemBaseModel> selectedPosters,
      LibraryFilterModel filters,
      Map<String, int> lastIndices,
      Map<String, int> libraryItemCounts,
      bool fetchingItems});

  @override
  $LibraryFilterModelCopyWith<$Res> get filters;
}

/// @nodoc
class __$LibrarySearchModelCopyWithImpl<$Res>
    implements _$LibrarySearchModelCopyWith<$Res> {
  __$LibrarySearchModelCopyWithImpl(this._self, this._then);

  final _LibrarySearchModel _self;
  final $Res Function(_LibrarySearchModel) _then;

  /// Create a copy of LibrarySearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? loading = null,
    Object? selecteMode = null,
    Object? folderOverwrite = null,
    Object? searchQuery = null,
    Object? views = null,
    Object? posters = null,
    Object? selectedPosters = null,
    Object? filters = null,
    Object? lastIndices = null,
    Object? libraryItemCounts = null,
    Object? fetchingItems = null,
  }) {
    return _then(_LibrarySearchModel(
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      selecteMode: null == selecteMode
          ? _self.selecteMode
          : selecteMode // ignore: cast_nullable_to_non_nullable
              as bool,
      folderOverwrite: null == folderOverwrite
          ? _self._folderOverwrite
          : folderOverwrite // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
      searchQuery: null == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      views: null == views
          ? _self._views
          : views // ignore: cast_nullable_to_non_nullable
              as Map<ViewModel, bool>,
      posters: null == posters
          ? _self._posters
          : posters // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
      selectedPosters: null == selectedPosters
          ? _self._selectedPosters
          : selectedPosters // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
      filters: null == filters
          ? _self.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as LibraryFilterModel,
      lastIndices: null == lastIndices
          ? _self._lastIndices
          : lastIndices // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      libraryItemCounts: null == libraryItemCounts
          ? _self._libraryItemCounts
          : libraryItemCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      fetchingItems: null == fetchingItems
          ? _self.fetchingItems
          : fetchingItems // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of LibrarySearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LibraryFilterModelCopyWith<$Res> get filters {
    return $LibraryFilterModelCopyWith<$Res>(_self.filters, (value) {
      return _then(_self.copyWith(filters: value));
    });
  }
}

// dart format on
