// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_screen_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibraryScreenModel {
  List<ViewModel> get views;
  ViewModel? get selectedViewModel;
  Set<LibraryViewType> get viewType;
  List<RecommendedModel> get recommendations;
  List<RecommendedModel> get genres;
  List<ItemBaseModel> get favourites;

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LibraryScreenModelCopyWith<LibraryScreenModel> get copyWith =>
      _$LibraryScreenModelCopyWithImpl<LibraryScreenModel>(
          this as LibraryScreenModel, _$identity);

  @override
  String toString() {
    return 'LibraryScreenModel(views: $views, selectedViewModel: $selectedViewModel, viewType: $viewType, recommendations: $recommendations, genres: $genres, favourites: $favourites)';
  }
}

/// @nodoc
abstract mixin class $LibraryScreenModelCopyWith<$Res> {
  factory $LibraryScreenModelCopyWith(
          LibraryScreenModel value, $Res Function(LibraryScreenModel) _then) =
      _$LibraryScreenModelCopyWithImpl;
  @useResult
  $Res call(
      {List<ViewModel> views,
      ViewModel? selectedViewModel,
      Set<LibraryViewType> viewType,
      List<RecommendedModel> recommendations,
      List<RecommendedModel> genres,
      List<ItemBaseModel> favourites});
}

/// @nodoc
class _$LibraryScreenModelCopyWithImpl<$Res>
    implements $LibraryScreenModelCopyWith<$Res> {
  _$LibraryScreenModelCopyWithImpl(this._self, this._then);

  final LibraryScreenModel _self;
  final $Res Function(LibraryScreenModel) _then;

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? views = null,
    Object? selectedViewModel = freezed,
    Object? viewType = null,
    Object? recommendations = null,
    Object? genres = null,
    Object? favourites = null,
  }) {
    return _then(_self.copyWith(
      views: null == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as List<ViewModel>,
      selectedViewModel: freezed == selectedViewModel
          ? _self.selectedViewModel
          : selectedViewModel // ignore: cast_nullable_to_non_nullable
              as ViewModel?,
      viewType: null == viewType
          ? _self.viewType
          : viewType // ignore: cast_nullable_to_non_nullable
              as Set<LibraryViewType>,
      recommendations: null == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<RecommendedModel>,
      genres: null == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<RecommendedModel>,
      favourites: null == favourites
          ? _self.favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LibraryScreenModel].
extension LibraryScreenModelPatterns on LibraryScreenModel {
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
    TResult Function(_LibraryScreenModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibraryScreenModel() when $default != null:
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
    TResult Function(_LibraryScreenModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryScreenModel():
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
    TResult? Function(_LibraryScreenModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryScreenModel() when $default != null:
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
            List<ViewModel> views,
            ViewModel? selectedViewModel,
            Set<LibraryViewType> viewType,
            List<RecommendedModel> recommendations,
            List<RecommendedModel> genres,
            List<ItemBaseModel> favourites)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibraryScreenModel() when $default != null:
        return $default(_that.views, _that.selectedViewModel, _that.viewType,
            _that.recommendations, _that.genres, _that.favourites);
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
            List<ViewModel> views,
            ViewModel? selectedViewModel,
            Set<LibraryViewType> viewType,
            List<RecommendedModel> recommendations,
            List<RecommendedModel> genres,
            List<ItemBaseModel> favourites)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryScreenModel():
        return $default(_that.views, _that.selectedViewModel, _that.viewType,
            _that.recommendations, _that.genres, _that.favourites);
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
            List<ViewModel> views,
            ViewModel? selectedViewModel,
            Set<LibraryViewType> viewType,
            List<RecommendedModel> recommendations,
            List<RecommendedModel> genres,
            List<ItemBaseModel> favourites)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryScreenModel() when $default != null:
        return $default(_that.views, _that.selectedViewModel, _that.viewType,
            _that.recommendations, _that.genres, _that.favourites);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LibraryScreenModel implements LibraryScreenModel {
  _LibraryScreenModel(
      {final List<ViewModel> views = const [],
      this.selectedViewModel,
      final Set<LibraryViewType> viewType = const {
        LibraryViewType.recommended,
        LibraryViewType.favourites
      },
      final List<RecommendedModel> recommendations = const [],
      final List<RecommendedModel> genres = const [],
      final List<ItemBaseModel> favourites = const []})
      : _views = views,
        _viewType = viewType,
        _recommendations = recommendations,
        _genres = genres,
        _favourites = favourites;

  final List<ViewModel> _views;
  @override
  @JsonKey()
  List<ViewModel> get views {
    if (_views is EqualUnmodifiableListView) return _views;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_views);
  }

  @override
  final ViewModel? selectedViewModel;
  final Set<LibraryViewType> _viewType;
  @override
  @JsonKey()
  Set<LibraryViewType> get viewType {
    if (_viewType is EqualUnmodifiableSetView) return _viewType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_viewType);
  }

  final List<RecommendedModel> _recommendations;
  @override
  @JsonKey()
  List<RecommendedModel> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final List<RecommendedModel> _genres;
  @override
  @JsonKey()
  List<RecommendedModel> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  final List<ItemBaseModel> _favourites;
  @override
  @JsonKey()
  List<ItemBaseModel> get favourites {
    if (_favourites is EqualUnmodifiableListView) return _favourites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favourites);
  }

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LibraryScreenModelCopyWith<_LibraryScreenModel> get copyWith =>
      __$LibraryScreenModelCopyWithImpl<_LibraryScreenModel>(this, _$identity);

  @override
  String toString() {
    return 'LibraryScreenModel(views: $views, selectedViewModel: $selectedViewModel, viewType: $viewType, recommendations: $recommendations, genres: $genres, favourites: $favourites)';
  }
}

/// @nodoc
abstract mixin class _$LibraryScreenModelCopyWith<$Res>
    implements $LibraryScreenModelCopyWith<$Res> {
  factory _$LibraryScreenModelCopyWith(
          _LibraryScreenModel value, $Res Function(_LibraryScreenModel) _then) =
      __$LibraryScreenModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<ViewModel> views,
      ViewModel? selectedViewModel,
      Set<LibraryViewType> viewType,
      List<RecommendedModel> recommendations,
      List<RecommendedModel> genres,
      List<ItemBaseModel> favourites});
}

/// @nodoc
class __$LibraryScreenModelCopyWithImpl<$Res>
    implements _$LibraryScreenModelCopyWith<$Res> {
  __$LibraryScreenModelCopyWithImpl(this._self, this._then);

  final _LibraryScreenModel _self;
  final $Res Function(_LibraryScreenModel) _then;

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? views = null,
    Object? selectedViewModel = freezed,
    Object? viewType = null,
    Object? recommendations = null,
    Object? genres = null,
    Object? favourites = null,
  }) {
    return _then(_LibraryScreenModel(
      views: null == views
          ? _self._views
          : views // ignore: cast_nullable_to_non_nullable
              as List<ViewModel>,
      selectedViewModel: freezed == selectedViewModel
          ? _self.selectedViewModel
          : selectedViewModel // ignore: cast_nullable_to_non_nullable
              as ViewModel?,
      viewType: null == viewType
          ? _self._viewType
          : viewType // ignore: cast_nullable_to_non_nullable
              as Set<LibraryViewType>,
      recommendations: null == recommendations
          ? _self._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<RecommendedModel>,
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<RecommendedModel>,
      favourites: null == favourites
          ? _self._favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
    ));
  }
}

// dart format on
