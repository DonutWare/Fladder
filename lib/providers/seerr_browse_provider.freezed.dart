// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seerr_browse_provider.dart';

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

  /// Create a copy of SeerrSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrSearchModelCopyWith<SeerrSearchModel> get copyWith =>
      _$SeerrSearchModelCopyWithImpl<SeerrSearchModel>(
          this as SeerrSearchModel, _$identity);

  @override
  String toString() {
    return 'SeerrSearchModel(query: $query, results: $results, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class $SeerrSearchModelCopyWith<$Res> {
  factory $SeerrSearchModelCopyWith(
          SeerrSearchModel value, $Res Function(SeerrSearchModel) _then) =
      _$SeerrSearchModelCopyWithImpl;
  @useResult
  $Res call(
      {String query, List<SeerrDashboardPosterModel> results, bool isLoading});
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
    ));
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
    TResult Function(String query, List<SeerrDashboardPosterModel> results,
            bool isLoading)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel() when $default != null:
        return $default(_that.query, _that.results, _that.isLoading);
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
    TResult Function(String query, List<SeerrDashboardPosterModel> results,
            bool isLoading)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel():
        return $default(_that.query, _that.results, _that.isLoading);
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
    TResult? Function(String query, List<SeerrDashboardPosterModel> results,
            bool isLoading)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSearchModel() when $default != null:
        return $default(_that.query, _that.results, _that.isLoading);
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
      this.isLoading = false})
      : _results = results;

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

  /// Create a copy of SeerrSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrSearchModelCopyWith<_SeerrSearchModel> get copyWith =>
      __$SeerrSearchModelCopyWithImpl<_SeerrSearchModel>(this, _$identity);

  @override
  String toString() {
    return 'SeerrSearchModel(query: $query, results: $results, isLoading: $isLoading)';
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
      {String query, List<SeerrDashboardPosterModel> results, bool isLoading});
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
    ));
  }
}

// dart format on
