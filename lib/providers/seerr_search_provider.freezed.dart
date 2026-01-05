// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seerr_search_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeerrSearchModel {
  String get query;
  List<SeerrDashboardPosterModel> get results;
  bool get isLoading;
  bool get isLoadingMore;
  bool get initialized;
  SeerrSearchMode get searchMode;
  SeerrFilterModel get filters;
  int get currentPage;
  List<SeerrWatchProviderRegion> get watchProviderRegions;
  Map<SeerrGenre, bool> get genres;
  Map<SeerrWatchProvider, bool> get watchProviders;
  Map<SeerrCertification, bool> get certifications;
  int? get totalPages;

  /// Create a copy of SeerrSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrSearchModelCopyWith<SeerrSearchModel> get copyWith =>
      _$SeerrSearchModelCopyWithImpl<SeerrSearchModel>(
          this as SeerrSearchModel, _$identity);

  @override
  String toString() {
    return 'SeerrSearchModel(query: $query, results: $results, isLoading: $isLoading, isLoadingMore: $isLoadingMore, initialized: $initialized, searchMode: $searchMode, filters: $filters, currentPage: $currentPage, watchProviderRegions: $watchProviderRegions, genres: $genres, watchProviders: $watchProviders, certifications: $certifications, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class $SeerrSearchModelCopyWith<$Res> {
  factory $SeerrSearchModelCopyWith(
          SeerrSearchModel value, $Res Function(SeerrSearchModel) _then) =
      _$SeerrSearchModelCopyWithImpl;
  @useResult
  $Res call(
      {String query,
      List<SeerrDashboardPosterModel> results,
      bool isLoading,
      bool isLoadingMore,
      bool initialized,
      SeerrSearchMode searchMode,
      SeerrFilterModel filters,
      int currentPage,
      List<SeerrWatchProviderRegion> watchProviderRegions,
      Map<SeerrGenre, bool> genres,
      Map<SeerrWatchProvider, bool> watchProviders,
      Map<SeerrCertification, bool> certifications,
      int? totalPages});

  $SeerrFilterModelCopyWith<$Res> get filters;
}

/// @nodoc
class _$SeerrSearchModelCopyWithImpl<$Res>
    implements $SeerrSearchModelCopyWith<$Res> {
  _$SeerrSearchModelCopyWithImpl(this._self, this._then);

  final SeerrSearchModel _self;
  final $Res Function(SeerrSearchModel) _then;

  /// Create a copy of SeerrSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? results = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? initialized = null,
    Object? searchMode = null,
    Object? filters = null,
    Object? currentPage = null,
    Object? watchProviderRegions = null,
    Object? genres = null,
    Object? watchProviders = null,
    Object? certifications = null,
    Object? totalPages = freezed,
  }) {
    return _then(_self.copyWith(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<SeerrDashboardPosterModel>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      initialized: null == initialized
          ? _self.initialized
          : initialized // ignore: cast_nullable_to_non_nullable
              as bool,
      searchMode: null == searchMode
          ? _self.searchMode
          : searchMode // ignore: cast_nullable_to_non_nullable
              as SeerrSearchMode,
      filters: null == filters
          ? _self.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as SeerrFilterModel,
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      watchProviderRegions: null == watchProviderRegions
          ? _self.watchProviderRegions
          : watchProviderRegions // ignore: cast_nullable_to_non_nullable
              as List<SeerrWatchProviderRegion>,
      genres: null == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<SeerrGenre, bool>,
      watchProviders: null == watchProviders
          ? _self.watchProviders
          : watchProviders // ignore: cast_nullable_to_non_nullable
              as Map<SeerrWatchProvider, bool>,
      certifications: null == certifications
          ? _self.certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as Map<SeerrCertification, bool>,
      totalPages: freezed == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of SeerrSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrFilterModelCopyWith<$Res> get filters {
    return $SeerrFilterModelCopyWith<$Res>(_self.filters, (value) {
      return _then(_self.copyWith(filters: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SeerrSearchModel].
extension SeerrSearchModelPatterns on SeerrSearchModel {
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
    TResult Function(_SeerrSearchModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel() when $default != null:
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
    TResult Function(_SeerrSearchModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel():
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
    TResult? Function(_SeerrSearchModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel() when $default != null:
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
            String query,
            List<SeerrDashboardPosterModel> results,
            bool isLoading,
            bool isLoadingMore,
            bool initialized,
            SeerrSearchMode searchMode,
            SeerrFilterModel filters,
            int currentPage,
            List<SeerrWatchProviderRegion> watchProviderRegions,
            Map<SeerrGenre, bool> genres,
            Map<SeerrWatchProvider, bool> watchProviders,
            Map<SeerrCertification, bool> certifications,
            int? totalPages)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel() when $default != null:
        return $default(
            _that.query,
            _that.results,
            _that.isLoading,
            _that.isLoadingMore,
            _that.initialized,
            _that.searchMode,
            _that.filters,
            _that.currentPage,
            _that.watchProviderRegions,
            _that.genres,
            _that.watchProviders,
            _that.certifications,
            _that.totalPages);
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
            String query,
            List<SeerrDashboardPosterModel> results,
            bool isLoading,
            bool isLoadingMore,
            bool initialized,
            SeerrSearchMode searchMode,
            SeerrFilterModel filters,
            int currentPage,
            List<SeerrWatchProviderRegion> watchProviderRegions,
            Map<SeerrGenre, bool> genres,
            Map<SeerrWatchProvider, bool> watchProviders,
            Map<SeerrCertification, bool> certifications,
            int? totalPages)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel():
        return $default(
            _that.query,
            _that.results,
            _that.isLoading,
            _that.isLoadingMore,
            _that.initialized,
            _that.searchMode,
            _that.filters,
            _that.currentPage,
            _that.watchProviderRegions,
            _that.genres,
            _that.watchProviders,
            _that.certifications,
            _that.totalPages);
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
            String query,
            List<SeerrDashboardPosterModel> results,
            bool isLoading,
            bool isLoadingMore,
            bool initialized,
            SeerrSearchMode searchMode,
            SeerrFilterModel filters,
            int currentPage,
            List<SeerrWatchProviderRegion> watchProviderRegions,
            Map<SeerrGenre, bool> genres,
            Map<SeerrWatchProvider, bool> watchProviders,
            Map<SeerrCertification, bool> certifications,
            int? totalPages)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel() when $default != null:
        return $default(
            _that.query,
            _that.results,
            _that.isLoading,
            _that.isLoadingMore,
            _that.initialized,
            _that.searchMode,
            _that.filters,
            _that.currentPage,
            _that.watchProviderRegions,
            _that.genres,
            _that.watchProviders,
            _that.certifications,
            _that.totalPages);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SeerrSearchModel implements SeerrSearchModel {
  _SeerrSearchModel(
      {this.query = "",
      final List<SeerrDashboardPosterModel> results = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.initialized = false,
      this.searchMode = SeerrSearchMode.search,
      this.filters = const SeerrFilterModel(),
      this.currentPage = 1,
      final List<SeerrWatchProviderRegion> watchProviderRegions = const [],
      final Map<SeerrGenre, bool> genres = const {},
      final Map<SeerrWatchProvider, bool> watchProviders = const {},
      final Map<SeerrCertification, bool> certifications = const {},
      this.totalPages})
      : _results = results,
        _watchProviderRegions = watchProviderRegions,
        _genres = genres,
        _watchProviders = watchProviders,
        _certifications = certifications;

  @override
  @JsonKey()
  final String query;
  final List<SeerrDashboardPosterModel> _results;
  @override
  @JsonKey()
  List<SeerrDashboardPosterModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool initialized;
  @override
  @JsonKey()
  final SeerrSearchMode searchMode;
  @override
  @JsonKey()
  final SeerrFilterModel filters;
  @override
  @JsonKey()
  final int currentPage;
  final List<SeerrWatchProviderRegion> _watchProviderRegions;
  @override
  @JsonKey()
  List<SeerrWatchProviderRegion> get watchProviderRegions {
    if (_watchProviderRegions is EqualUnmodifiableListView)
      return _watchProviderRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_watchProviderRegions);
  }

  final Map<SeerrGenre, bool> _genres;
  @override
  @JsonKey()
  Map<SeerrGenre, bool> get genres {
    if (_genres is EqualUnmodifiableMapView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_genres);
  }

  final Map<SeerrWatchProvider, bool> _watchProviders;
  @override
  @JsonKey()
  Map<SeerrWatchProvider, bool> get watchProviders {
    if (_watchProviders is EqualUnmodifiableMapView) return _watchProviders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_watchProviders);
  }

  final Map<SeerrCertification, bool> _certifications;
  @override
  @JsonKey()
  Map<SeerrCertification, bool> get certifications {
    if (_certifications is EqualUnmodifiableMapView) return _certifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_certifications);
  }

  @override
  final int? totalPages;

  /// Create a copy of SeerrSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrSearchModelCopyWith<_SeerrSearchModel> get copyWith =>
      __$SeerrSearchModelCopyWithImpl<_SeerrSearchModel>(this, _$identity);

  @override
  String toString() {
    return 'SeerrSearchModel(query: $query, results: $results, isLoading: $isLoading, isLoadingMore: $isLoadingMore, initialized: $initialized, searchMode: $searchMode, filters: $filters, currentPage: $currentPage, watchProviderRegions: $watchProviderRegions, genres: $genres, watchProviders: $watchProviders, certifications: $certifications, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class _$SeerrSearchModelCopyWith<$Res>
    implements $SeerrSearchModelCopyWith<$Res> {
  factory _$SeerrSearchModelCopyWith(
          _SeerrSearchModel value, $Res Function(_SeerrSearchModel) _then) =
      __$SeerrSearchModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String query,
      List<SeerrDashboardPosterModel> results,
      bool isLoading,
      bool isLoadingMore,
      bool initialized,
      SeerrSearchMode searchMode,
      SeerrFilterModel filters,
      int currentPage,
      List<SeerrWatchProviderRegion> watchProviderRegions,
      Map<SeerrGenre, bool> genres,
      Map<SeerrWatchProvider, bool> watchProviders,
      Map<SeerrCertification, bool> certifications,
      int? totalPages});

  @override
  $SeerrFilterModelCopyWith<$Res> get filters;
}

/// @nodoc
class __$SeerrSearchModelCopyWithImpl<$Res>
    implements _$SeerrSearchModelCopyWith<$Res> {
  __$SeerrSearchModelCopyWithImpl(this._self, this._then);

  final _SeerrSearchModel _self;
  final $Res Function(_SeerrSearchModel) _then;

  /// Create a copy of SeerrSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
    Object? results = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? initialized = null,
    Object? searchMode = null,
    Object? filters = null,
    Object? currentPage = null,
    Object? watchProviderRegions = null,
    Object? genres = null,
    Object? watchProviders = null,
    Object? certifications = null,
    Object? totalPages = freezed,
  }) {
    return _then(_SeerrSearchModel(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<SeerrDashboardPosterModel>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      initialized: null == initialized
          ? _self.initialized
          : initialized // ignore: cast_nullable_to_non_nullable
              as bool,
      searchMode: null == searchMode
          ? _self.searchMode
          : searchMode // ignore: cast_nullable_to_non_nullable
              as SeerrSearchMode,
      filters: null == filters
          ? _self.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as SeerrFilterModel,
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      watchProviderRegions: null == watchProviderRegions
          ? _self._watchProviderRegions
          : watchProviderRegions // ignore: cast_nullable_to_non_nullable
              as List<SeerrWatchProviderRegion>,
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<SeerrGenre, bool>,
      watchProviders: null == watchProviders
          ? _self._watchProviders
          : watchProviders // ignore: cast_nullable_to_non_nullable
              as Map<SeerrWatchProvider, bool>,
      certifications: null == certifications
          ? _self._certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as Map<SeerrCertification, bool>,
      totalPages: freezed == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of SeerrSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrFilterModelCopyWith<$Res> get filters {
    return $SeerrFilterModelCopyWith<$Res>(_self.filters, (value) {
      return _then(_self.copyWith(filters: value));
    });
  }
}

// dart format on
