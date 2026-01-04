// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seerr_details_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeerrDetailsModel {
  int? get tmdbId;
  SeerrDashboardMediaType? get mediaType;
  SeerrDashboardPosterModel? get poster;
  List<SeerrGenre> get genres;
  double? get voteAverage;
  String? get contentRating;
  String? get releaseDate;
  List<SeerrDashboardPosterModel> get recommended;
  List<SeerrDashboardPosterModel> get similar;
  List<Person> get people;
  Map<int, SeerrMediaStatus> get seasonStatuses;
  SeerrUserModel? get currentUser;
  Map<int, bool> get expandedSeasons;
  Map<int, List<SeerrEpisode>> get episodesCache;

  /// Create a copy of SeerrDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrDetailsModelCopyWith<SeerrDetailsModel> get copyWith =>
      _$SeerrDetailsModelCopyWithImpl<SeerrDetailsModel>(
          this as SeerrDetailsModel, _$identity);

  @override
  String toString() {
    return 'SeerrDetailsModel(tmdbId: $tmdbId, mediaType: $mediaType, poster: $poster, genres: $genres, voteAverage: $voteAverage, contentRating: $contentRating, releaseDate: $releaseDate, recommended: $recommended, similar: $similar, people: $people, seasonStatuses: $seasonStatuses, currentUser: $currentUser, expandedSeasons: $expandedSeasons, episodesCache: $episodesCache)';
  }
}

/// @nodoc
abstract mixin class $SeerrDetailsModelCopyWith<$Res> {
  factory $SeerrDetailsModelCopyWith(
          SeerrDetailsModel value, $Res Function(SeerrDetailsModel) _then) =
      _$SeerrDetailsModelCopyWithImpl;
  @useResult
  $Res call(
      {int? tmdbId,
      SeerrDashboardMediaType? mediaType,
      SeerrDashboardPosterModel? poster,
      List<SeerrGenre> genres,
      double? voteAverage,
      String? contentRating,
      String? releaseDate,
      List<SeerrDashboardPosterModel> recommended,
      List<SeerrDashboardPosterModel> similar,
      List<Person> people,
      Map<int, SeerrMediaStatus> seasonStatuses,
      SeerrUserModel? currentUser,
      Map<int, bool> expandedSeasons,
      Map<int, List<SeerrEpisode>> episodesCache});

  $SeerrUserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$SeerrDetailsModelCopyWithImpl<$Res>
    implements $SeerrDetailsModelCopyWith<$Res> {
  _$SeerrDetailsModelCopyWithImpl(this._self, this._then);

  final SeerrDetailsModel _self;
  final $Res Function(SeerrDetailsModel) _then;

  /// Create a copy of SeerrDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tmdbId = freezed,
    Object? mediaType = freezed,
    Object? poster = freezed,
    Object? genres = null,
    Object? voteAverage = freezed,
    Object? contentRating = freezed,
    Object? releaseDate = freezed,
    Object? recommended = null,
    Object? similar = null,
    Object? people = null,
    Object? seasonStatuses = null,
    Object? currentUser = freezed,
    Object? expandedSeasons = null,
    Object? episodesCache = null,
  }) {
    return _then(_self.copyWith(
      tmdbId: freezed == tmdbId
          ? _self.tmdbId
          : tmdbId // ignore: cast_nullable_to_non_nullable
              as int?,
      mediaType: freezed == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as SeerrDashboardMediaType?,
      poster: freezed == poster
          ? _self.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as SeerrDashboardPosterModel?,
      genres: null == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<SeerrGenre>,
      voteAverage: freezed == voteAverage
          ? _self.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double?,
      contentRating: freezed == contentRating
          ? _self.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      recommended: null == recommended
          ? _self.recommended
          : recommended // ignore: cast_nullable_to_non_nullable
              as List<SeerrDashboardPosterModel>,
      similar: null == similar
          ? _self.similar
          : similar // ignore: cast_nullable_to_non_nullable
              as List<SeerrDashboardPosterModel>,
      people: null == people
          ? _self.people
          : people // ignore: cast_nullable_to_non_nullable
              as List<Person>,
      seasonStatuses: null == seasonStatuses
          ? _self.seasonStatuses
          : seasonStatuses // ignore: cast_nullable_to_non_nullable
              as Map<int, SeerrMediaStatus>,
      currentUser: freezed == currentUser
          ? _self.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as SeerrUserModel?,
      expandedSeasons: null == expandedSeasons
          ? _self.expandedSeasons
          : expandedSeasons // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      episodesCache: null == episodesCache
          ? _self.episodesCache
          : episodesCache // ignore: cast_nullable_to_non_nullable
              as Map<int, List<SeerrEpisode>>,
    ));
  }

  /// Create a copy of SeerrDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrUserModelCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
      return null;
    }

    return $SeerrUserModelCopyWith<$Res>(_self.currentUser!, (value) {
      return _then(_self.copyWith(currentUser: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SeerrDetailsModel].
extension SeerrDetailsModelPatterns on SeerrDetailsModel {
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
    TResult Function(_SeerrDetailsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrDetailsModel() when $default != null:
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
    TResult Function(_SeerrDetailsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrDetailsModel():
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
    TResult? Function(_SeerrDetailsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrDetailsModel() when $default != null:
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
            int? tmdbId,
            SeerrDashboardMediaType? mediaType,
            SeerrDashboardPosterModel? poster,
            List<SeerrGenre> genres,
            double? voteAverage,
            String? contentRating,
            String? releaseDate,
            List<SeerrDashboardPosterModel> recommended,
            List<SeerrDashboardPosterModel> similar,
            List<Person> people,
            Map<int, SeerrMediaStatus> seasonStatuses,
            SeerrUserModel? currentUser,
            Map<int, bool> expandedSeasons,
            Map<int, List<SeerrEpisode>> episodesCache)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrDetailsModel() when $default != null:
        return $default(
            _that.tmdbId,
            _that.mediaType,
            _that.poster,
            _that.genres,
            _that.voteAverage,
            _that.contentRating,
            _that.releaseDate,
            _that.recommended,
            _that.similar,
            _that.people,
            _that.seasonStatuses,
            _that.currentUser,
            _that.expandedSeasons,
            _that.episodesCache);
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
            int? tmdbId,
            SeerrDashboardMediaType? mediaType,
            SeerrDashboardPosterModel? poster,
            List<SeerrGenre> genres,
            double? voteAverage,
            String? contentRating,
            String? releaseDate,
            List<SeerrDashboardPosterModel> recommended,
            List<SeerrDashboardPosterModel> similar,
            List<Person> people,
            Map<int, SeerrMediaStatus> seasonStatuses,
            SeerrUserModel? currentUser,
            Map<int, bool> expandedSeasons,
            Map<int, List<SeerrEpisode>> episodesCache)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrDetailsModel():
        return $default(
            _that.tmdbId,
            _that.mediaType,
            _that.poster,
            _that.genres,
            _that.voteAverage,
            _that.contentRating,
            _that.releaseDate,
            _that.recommended,
            _that.similar,
            _that.people,
            _that.seasonStatuses,
            _that.currentUser,
            _that.expandedSeasons,
            _that.episodesCache);
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
            int? tmdbId,
            SeerrDashboardMediaType? mediaType,
            SeerrDashboardPosterModel? poster,
            List<SeerrGenre> genres,
            double? voteAverage,
            String? contentRating,
            String? releaseDate,
            List<SeerrDashboardPosterModel> recommended,
            List<SeerrDashboardPosterModel> similar,
            List<Person> people,
            Map<int, SeerrMediaStatus> seasonStatuses,
            SeerrUserModel? currentUser,
            Map<int, bool> expandedSeasons,
            Map<int, List<SeerrEpisode>> episodesCache)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrDetailsModel() when $default != null:
        return $default(
            _that.tmdbId,
            _that.mediaType,
            _that.poster,
            _that.genres,
            _that.voteAverage,
            _that.contentRating,
            _that.releaseDate,
            _that.recommended,
            _that.similar,
            _that.people,
            _that.seasonStatuses,
            _that.currentUser,
            _that.expandedSeasons,
            _that.episodesCache);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SeerrDetailsModel extends SeerrDetailsModel {
  const _SeerrDetailsModel(
      {this.tmdbId,
      this.mediaType,
      this.poster,
      final List<SeerrGenre> genres = const [],
      this.voteAverage,
      this.contentRating,
      this.releaseDate,
      final List<SeerrDashboardPosterModel> recommended = const [],
      final List<SeerrDashboardPosterModel> similar = const [],
      final List<Person> people = const [],
      final Map<int, SeerrMediaStatus> seasonStatuses = const {},
      this.currentUser,
      final Map<int, bool> expandedSeasons = const {},
      final Map<int, List<SeerrEpisode>> episodesCache = const {}})
      : _genres = genres,
        _recommended = recommended,
        _similar = similar,
        _people = people,
        _seasonStatuses = seasonStatuses,
        _expandedSeasons = expandedSeasons,
        _episodesCache = episodesCache,
        super._();

  @override
  final int? tmdbId;
  @override
  final SeerrDashboardMediaType? mediaType;
  @override
  final SeerrDashboardPosterModel? poster;
  final List<SeerrGenre> _genres;
  @override
  @JsonKey()
  List<SeerrGenre> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  final double? voteAverage;
  @override
  final String? contentRating;
  @override
  final String? releaseDate;
  final List<SeerrDashboardPosterModel> _recommended;
  @override
  @JsonKey()
  List<SeerrDashboardPosterModel> get recommended {
    if (_recommended is EqualUnmodifiableListView) return _recommended;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommended);
  }

  final List<SeerrDashboardPosterModel> _similar;
  @override
  @JsonKey()
  List<SeerrDashboardPosterModel> get similar {
    if (_similar is EqualUnmodifiableListView) return _similar;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_similar);
  }

  final List<Person> _people;
  @override
  @JsonKey()
  List<Person> get people {
    if (_people is EqualUnmodifiableListView) return _people;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_people);
  }

  final Map<int, SeerrMediaStatus> _seasonStatuses;
  @override
  @JsonKey()
  Map<int, SeerrMediaStatus> get seasonStatuses {
    if (_seasonStatuses is EqualUnmodifiableMapView) return _seasonStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_seasonStatuses);
  }

  @override
  final SeerrUserModel? currentUser;
  final Map<int, bool> _expandedSeasons;
  @override
  @JsonKey()
  Map<int, bool> get expandedSeasons {
    if (_expandedSeasons is EqualUnmodifiableMapView) return _expandedSeasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expandedSeasons);
  }

  final Map<int, List<SeerrEpisode>> _episodesCache;
  @override
  @JsonKey()
  Map<int, List<SeerrEpisode>> get episodesCache {
    if (_episodesCache is EqualUnmodifiableMapView) return _episodesCache;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_episodesCache);
  }

  /// Create a copy of SeerrDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrDetailsModelCopyWith<_SeerrDetailsModel> get copyWith =>
      __$SeerrDetailsModelCopyWithImpl<_SeerrDetailsModel>(this, _$identity);

  @override
  String toString() {
    return 'SeerrDetailsModel(tmdbId: $tmdbId, mediaType: $mediaType, poster: $poster, genres: $genres, voteAverage: $voteAverage, contentRating: $contentRating, releaseDate: $releaseDate, recommended: $recommended, similar: $similar, people: $people, seasonStatuses: $seasonStatuses, currentUser: $currentUser, expandedSeasons: $expandedSeasons, episodesCache: $episodesCache)';
  }
}

/// @nodoc
abstract mixin class _$SeerrDetailsModelCopyWith<$Res>
    implements $SeerrDetailsModelCopyWith<$Res> {
  factory _$SeerrDetailsModelCopyWith(
          _SeerrDetailsModel value, $Res Function(_SeerrDetailsModel) _then) =
      __$SeerrDetailsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? tmdbId,
      SeerrDashboardMediaType? mediaType,
      SeerrDashboardPosterModel? poster,
      List<SeerrGenre> genres,
      double? voteAverage,
      String? contentRating,
      String? releaseDate,
      List<SeerrDashboardPosterModel> recommended,
      List<SeerrDashboardPosterModel> similar,
      List<Person> people,
      Map<int, SeerrMediaStatus> seasonStatuses,
      SeerrUserModel? currentUser,
      Map<int, bool> expandedSeasons,
      Map<int, List<SeerrEpisode>> episodesCache});

  @override
  $SeerrUserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$SeerrDetailsModelCopyWithImpl<$Res>
    implements _$SeerrDetailsModelCopyWith<$Res> {
  __$SeerrDetailsModelCopyWithImpl(this._self, this._then);

  final _SeerrDetailsModel _self;
  final $Res Function(_SeerrDetailsModel) _then;

  /// Create a copy of SeerrDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tmdbId = freezed,
    Object? mediaType = freezed,
    Object? poster = freezed,
    Object? genres = null,
    Object? voteAverage = freezed,
    Object? contentRating = freezed,
    Object? releaseDate = freezed,
    Object? recommended = null,
    Object? similar = null,
    Object? people = null,
    Object? seasonStatuses = null,
    Object? currentUser = freezed,
    Object? expandedSeasons = null,
    Object? episodesCache = null,
  }) {
    return _then(_SeerrDetailsModel(
      tmdbId: freezed == tmdbId
          ? _self.tmdbId
          : tmdbId // ignore: cast_nullable_to_non_nullable
              as int?,
      mediaType: freezed == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as SeerrDashboardMediaType?,
      poster: freezed == poster
          ? _self.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as SeerrDashboardPosterModel?,
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<SeerrGenre>,
      voteAverage: freezed == voteAverage
          ? _self.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double?,
      contentRating: freezed == contentRating
          ? _self.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      recommended: null == recommended
          ? _self._recommended
          : recommended // ignore: cast_nullable_to_non_nullable
              as List<SeerrDashboardPosterModel>,
      similar: null == similar
          ? _self._similar
          : similar // ignore: cast_nullable_to_non_nullable
              as List<SeerrDashboardPosterModel>,
      people: null == people
          ? _self._people
          : people // ignore: cast_nullable_to_non_nullable
              as List<Person>,
      seasonStatuses: null == seasonStatuses
          ? _self._seasonStatuses
          : seasonStatuses // ignore: cast_nullable_to_non_nullable
              as Map<int, SeerrMediaStatus>,
      currentUser: freezed == currentUser
          ? _self.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as SeerrUserModel?,
      expandedSeasons: null == expandedSeasons
          ? _self._expandedSeasons
          : expandedSeasons // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      episodesCache: null == episodesCache
          ? _self._episodesCache
          : episodesCache // ignore: cast_nullable_to_non_nullable
              as Map<int, List<SeerrEpisode>>,
    ));
  }

  /// Create a copy of SeerrDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrUserModelCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
      return null;
    }

    return $SeerrUserModelCopyWith<$Res>(_self.currentUser!, (value) {
      return _then(_self.copyWith(currentUser: value));
    });
  }
}

// dart format on
