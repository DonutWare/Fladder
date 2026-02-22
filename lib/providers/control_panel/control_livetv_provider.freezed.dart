// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_livetv_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlLiveTvModel {
  LiveTvOptions? get liveTvOptions;

  /// Create a copy of ControlLiveTvModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ControlLiveTvModelCopyWith<ControlLiveTvModel> get copyWith =>
      _$ControlLiveTvModelCopyWithImpl<ControlLiveTvModel>(
          this as ControlLiveTvModel, _$identity);

  @override
  String toString() {
    return 'ControlLiveTvModel(liveTvOptions: $liveTvOptions)';
  }
}

/// @nodoc
abstract mixin class $ControlLiveTvModelCopyWith<$Res> {
  factory $ControlLiveTvModelCopyWith(
          ControlLiveTvModel value, $Res Function(ControlLiveTvModel) _then) =
      _$ControlLiveTvModelCopyWithImpl;
  @useResult
  $Res call({LiveTvOptions? liveTvOptions});
}

/// @nodoc
class _$ControlLiveTvModelCopyWithImpl<$Res>
    implements $ControlLiveTvModelCopyWith<$Res> {
  _$ControlLiveTvModelCopyWithImpl(this._self, this._then);

  final ControlLiveTvModel _self;
  final $Res Function(ControlLiveTvModel) _then;

  /// Create a copy of ControlLiveTvModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? liveTvOptions = freezed,
  }) {
    return _then(_self.copyWith(
      liveTvOptions: freezed == liveTvOptions
          ? _self.liveTvOptions
          : liveTvOptions // ignore: cast_nullable_to_non_nullable
              as LiveTvOptions?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ControlLiveTvModel].
extension ControlLiveTvModelPatterns on ControlLiveTvModel {
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
    TResult Function(_ControlLiveTvModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlLiveTvModel() when $default != null:
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
    TResult Function(_ControlLiveTvModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlLiveTvModel():
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
    TResult? Function(_ControlLiveTvModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlLiveTvModel() when $default != null:
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
    TResult Function(LiveTvOptions? liveTvOptions)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlLiveTvModel() when $default != null:
        return $default(_that.liveTvOptions);
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
    TResult Function(LiveTvOptions? liveTvOptions) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlLiveTvModel():
        return $default(_that.liveTvOptions);
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
    TResult? Function(LiveTvOptions? liveTvOptions)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlLiveTvModel() when $default != null:
        return $default(_that.liveTvOptions);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ControlLiveTvModel implements ControlLiveTvModel {
  _ControlLiveTvModel({this.liveTvOptions});

  @override
  final LiveTvOptions? liveTvOptions;

  /// Create a copy of ControlLiveTvModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ControlLiveTvModelCopyWith<_ControlLiveTvModel> get copyWith =>
      __$ControlLiveTvModelCopyWithImpl<_ControlLiveTvModel>(this, _$identity);

  @override
  String toString() {
    return 'ControlLiveTvModel(liveTvOptions: $liveTvOptions)';
  }
}

/// @nodoc
abstract mixin class _$ControlLiveTvModelCopyWith<$Res>
    implements $ControlLiveTvModelCopyWith<$Res> {
  factory _$ControlLiveTvModelCopyWith(
          _ControlLiveTvModel value, $Res Function(_ControlLiveTvModel) _then) =
      __$ControlLiveTvModelCopyWithImpl;
  @override
  @useResult
  $Res call({LiveTvOptions? liveTvOptions});
}

/// @nodoc
class __$ControlLiveTvModelCopyWithImpl<$Res>
    implements _$ControlLiveTvModelCopyWith<$Res> {
  __$ControlLiveTvModelCopyWithImpl(this._self, this._then);

  final _ControlLiveTvModel _self;
  final $Res Function(_ControlLiveTvModel) _then;

  /// Create a copy of ControlLiveTvModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? liveTvOptions = freezed,
  }) {
    return _then(_ControlLiveTvModel(
      liveTvOptions: freezed == liveTvOptions
          ? _self.liveTvOptions
          : liveTvOptions // ignore: cast_nullable_to_non_nullable
              as LiveTvOptions?,
    ));
  }
}

// dart format on
