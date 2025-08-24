// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_combinations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyCombination {
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get key;
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get modifier;
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get altKey;
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get altModifier;

  /// Create a copy of KeyCombination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeyCombinationCopyWith<KeyCombination> get copyWith =>
      _$KeyCombinationCopyWithImpl<KeyCombination>(
          this as KeyCombination, _$identity);

  /// Serializes this KeyCombination to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'KeyCombination(key: $key, modifier: $modifier, altKey: $altKey, altModifier: $altModifier)';
  }
}

/// @nodoc
abstract mixin class $KeyCombinationCopyWith<$Res> {
  factory $KeyCombinationCopyWith(
          KeyCombination value, $Res Function(KeyCombination) _then) =
      _$KeyCombinationCopyWithImpl;
  @useResult
  $Res call(
      {@LogicalKeyboardSerializer() LogicalKeyboardKey? key,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? altKey,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? altModifier});
}

/// @nodoc
class _$KeyCombinationCopyWithImpl<$Res>
    implements $KeyCombinationCopyWith<$Res> {
  _$KeyCombinationCopyWithImpl(this._self, this._then);

  final KeyCombination _self;
  final $Res Function(KeyCombination) _then;

  /// Create a copy of KeyCombination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? modifier = freezed,
    Object? altKey = freezed,
    Object? altModifier = freezed,
  }) {
    return _then(_self.copyWith(
      key: freezed == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      modifier: freezed == modifier
          ? _self.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      altKey: freezed == altKey
          ? _self.altKey
          : altKey // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      altModifier: freezed == altModifier
          ? _self.altModifier
          : altModifier // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
    ));
  }
}

/// Adds pattern-matching-related methods to [KeyCombination].
extension KeyCombinationPatterns on KeyCombination {
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
    TResult Function(_KeyCombination value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KeyCombination() when $default != null:
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
    TResult Function(_KeyCombination value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeyCombination():
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
    TResult? Function(_KeyCombination value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeyCombination() when $default != null:
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
            @LogicalKeyboardSerializer() LogicalKeyboardKey? key,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? altKey,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? altModifier)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KeyCombination() when $default != null:
        return $default(
            _that.key, _that.modifier, _that.altKey, _that.altModifier);
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
            @LogicalKeyboardSerializer() LogicalKeyboardKey? key,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? altKey,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? altModifier)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeyCombination():
        return $default(
            _that.key, _that.modifier, _that.altKey, _that.altModifier);
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
            @LogicalKeyboardSerializer() LogicalKeyboardKey? key,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? altKey,
            @LogicalKeyboardSerializer() LogicalKeyboardKey? altModifier)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeyCombination() when $default != null:
        return $default(
            _that.key, _that.modifier, _that.altKey, _that.altModifier);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _KeyCombination extends KeyCombination {
  _KeyCombination(
      {@LogicalKeyboardSerializer() this.key,
      @LogicalKeyboardSerializer() this.modifier,
      @LogicalKeyboardSerializer() this.altKey,
      @LogicalKeyboardSerializer() this.altModifier})
      : super._();
  factory _KeyCombination.fromJson(Map<String, dynamic> json) =>
      _$KeyCombinationFromJson(json);

  @override
  @LogicalKeyboardSerializer()
  final LogicalKeyboardKey? key;
  @override
  @LogicalKeyboardSerializer()
  final LogicalKeyboardKey? modifier;
  @override
  @LogicalKeyboardSerializer()
  final LogicalKeyboardKey? altKey;
  @override
  @LogicalKeyboardSerializer()
  final LogicalKeyboardKey? altModifier;

  /// Create a copy of KeyCombination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeyCombinationCopyWith<_KeyCombination> get copyWith =>
      __$KeyCombinationCopyWithImpl<_KeyCombination>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KeyCombinationToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'KeyCombination(key: $key, modifier: $modifier, altKey: $altKey, altModifier: $altModifier)';
  }
}

/// @nodoc
abstract mixin class _$KeyCombinationCopyWith<$Res>
    implements $KeyCombinationCopyWith<$Res> {
  factory _$KeyCombinationCopyWith(
          _KeyCombination value, $Res Function(_KeyCombination) _then) =
      __$KeyCombinationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@LogicalKeyboardSerializer() LogicalKeyboardKey? key,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? altKey,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? altModifier});
}

/// @nodoc
class __$KeyCombinationCopyWithImpl<$Res>
    implements _$KeyCombinationCopyWith<$Res> {
  __$KeyCombinationCopyWithImpl(this._self, this._then);

  final _KeyCombination _self;
  final $Res Function(_KeyCombination) _then;

  /// Create a copy of KeyCombination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = freezed,
    Object? modifier = freezed,
    Object? altKey = freezed,
    Object? altModifier = freezed,
  }) {
    return _then(_KeyCombination(
      key: freezed == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      modifier: freezed == modifier
          ? _self.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      altKey: freezed == altKey
          ? _self.altKey
          : altKey // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      altModifier: freezed == altModifier
          ? _self.altModifier
          : altModifier // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
    ));
  }
}

// dart format on
