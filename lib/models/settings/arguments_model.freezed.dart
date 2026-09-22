// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arguments_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArgumentsModel {
  bool get htpcMode;
  bool get leanBackMode;
  bool get newWindow;
  bool get skipNotifications;

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ArgumentsModelCopyWith<ArgumentsModel> get copyWith =>
      _$ArgumentsModelCopyWithImpl<ArgumentsModel>(this as ArgumentsModel, _$identity);

  @override
  String toString() {
    return 'ArgumentsModel(htpcMode: $htpcMode, leanBackMode: $leanBackMode, newWindow: $newWindow, skipNotifications: $skipNotifications)';
  }
}

/// @nodoc
abstract mixin class $ArgumentsModelCopyWith<$Res> {
  factory $ArgumentsModelCopyWith(ArgumentsModel value, $Res Function(ArgumentsModel) _then) =
      _$ArgumentsModelCopyWithImpl;
  @useResult
  $Res call({bool htpcMode, bool leanBackMode, bool newWindow, bool skipNotifications});
}

/// @nodoc
class _$ArgumentsModelCopyWithImpl<$Res> implements $ArgumentsModelCopyWith<$Res> {
  _$ArgumentsModelCopyWithImpl(this._self, this._then);

  final ArgumentsModel _self;
  final $Res Function(ArgumentsModel) _then;

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? htpcMode = null,
    Object? leanBackMode = null,
    Object? newWindow = null,
    Object? skipNotifications = null,
  }) {
    return _then(_self.copyWith(
      htpcMode: null == htpcMode
          ? _self.htpcMode
          : htpcMode // ignore: cast_nullable_to_non_nullable
              as bool,
      leanBackMode: null == leanBackMode
          ? _self.leanBackMode
          : leanBackMode // ignore: cast_nullable_to_non_nullable
              as bool,
      newWindow: null == newWindow
          ? _self.newWindow
          : newWindow // ignore: cast_nullable_to_non_nullable
              as bool,
      skipNotifications: null == skipNotifications
          ? _self.skipNotifications
          : skipNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ArgumentsModel].
extension ArgumentsModelPatterns on ArgumentsModel {
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
    TResult Function(_ArgumentsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ArgumentsModel() when $default != null:
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
    TResult Function(_ArgumentsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ArgumentsModel():
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
    TResult? Function(_ArgumentsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ArgumentsModel() when $default != null:
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
    TResult Function(bool htpcMode, bool leanBackMode, bool newWindow, bool skipNotifications)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ArgumentsModel() when $default != null:
        return $default(_that.htpcMode, _that.leanBackMode, _that.newWindow, _that.skipNotifications);
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
    TResult Function(bool htpcMode, bool leanBackMode, bool newWindow, bool skipNotifications) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ArgumentsModel():
        return $default(_that.htpcMode, _that.leanBackMode, _that.newWindow, _that.skipNotifications);
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
    TResult? Function(bool htpcMode, bool leanBackMode, bool newWindow, bool skipNotifications)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ArgumentsModel() when $default != null:
        return $default(_that.htpcMode, _that.leanBackMode, _that.newWindow, _that.skipNotifications);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ArgumentsModel extends ArgumentsModel {
  _ArgumentsModel(
      {this.htpcMode = false, this.leanBackMode = false, this.newWindow = false, this.skipNotifications = false})
      : super._();

  @override
  @JsonKey()
  final bool htpcMode;
  @override
  @JsonKey()
  final bool leanBackMode;
  @override
  @JsonKey()
  final bool newWindow;
  @override
  @JsonKey()
  final bool skipNotifications;

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ArgumentsModelCopyWith<_ArgumentsModel> get copyWith =>
      __$ArgumentsModelCopyWithImpl<_ArgumentsModel>(this, _$identity);

  @override
  String toString() {
    return 'ArgumentsModel(htpcMode: $htpcMode, leanBackMode: $leanBackMode, newWindow: $newWindow, skipNotifications: $skipNotifications)';
  }
}

/// @nodoc
abstract mixin class _$ArgumentsModelCopyWith<$Res> implements $ArgumentsModelCopyWith<$Res> {
  factory _$ArgumentsModelCopyWith(_ArgumentsModel value, $Res Function(_ArgumentsModel) _then) =
      __$ArgumentsModelCopyWithImpl;
  @override
  @useResult
  $Res call({bool htpcMode, bool leanBackMode, bool newWindow, bool skipNotifications});
}

/// @nodoc
class __$ArgumentsModelCopyWithImpl<$Res> implements _$ArgumentsModelCopyWith<$Res> {
  __$ArgumentsModelCopyWithImpl(this._self, this._then);

  final _ArgumentsModel _self;
  final $Res Function(_ArgumentsModel) _then;

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? htpcMode = null,
    Object? leanBackMode = null,
    Object? newWindow = null,
    Object? skipNotifications = null,
  }) {
    return _then(_ArgumentsModel(
      htpcMode: null == htpcMode
          ? _self.htpcMode
          : htpcMode // ignore: cast_nullable_to_non_nullable
              as bool,
      leanBackMode: null == leanBackMode
          ? _self.leanBackMode
          : leanBackMode // ignore: cast_nullable_to_non_nullable
              as bool,
      newWindow: null == newWindow
          ? _self.newWindow
          : newWindow // ignore: cast_nullable_to_non_nullable
              as bool,
      skipNotifications: null == skipNotifications
          ? _self.skipNotifications
          : skipNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
