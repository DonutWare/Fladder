// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_combinations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KeyCombination _$KeyCombinationFromJson(Map<String, dynamic> json) {
  return _KeyCombination.fromJson(json);
}

/// @nodoc
mixin _$KeyCombination {
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get key => throw _privateConstructorUsedError;
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get modifier => throw _privateConstructorUsedError;
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get altKey => throw _privateConstructorUsedError;
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get altModifier => throw _privateConstructorUsedError;

  /// Serializes this KeyCombination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeyCombination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyCombinationCopyWith<KeyCombination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyCombinationCopyWith<$Res> {
  factory $KeyCombinationCopyWith(
          KeyCombination value, $Res Function(KeyCombination) then) =
      _$KeyCombinationCopyWithImpl<$Res, KeyCombination>;
  @useResult
  $Res call(
      {@LogicalKeyboardSerializer() LogicalKeyboardKey? key,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? altKey,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? altModifier});
}

/// @nodoc
class _$KeyCombinationCopyWithImpl<$Res, $Val extends KeyCombination>
    implements $KeyCombinationCopyWith<$Res> {
  _$KeyCombinationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      modifier: freezed == modifier
          ? _value.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      altKey: freezed == altKey
          ? _value.altKey
          : altKey // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      altModifier: freezed == altModifier
          ? _value.altModifier
          : altModifier // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeyCombinationImplCopyWith<$Res>
    implements $KeyCombinationCopyWith<$Res> {
  factory _$$KeyCombinationImplCopyWith(_$KeyCombinationImpl value,
          $Res Function(_$KeyCombinationImpl) then) =
      __$$KeyCombinationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@LogicalKeyboardSerializer() LogicalKeyboardKey? key,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? modifier,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? altKey,
      @LogicalKeyboardSerializer() LogicalKeyboardKey? altModifier});
}

/// @nodoc
class __$$KeyCombinationImplCopyWithImpl<$Res>
    extends _$KeyCombinationCopyWithImpl<$Res, _$KeyCombinationImpl>
    implements _$$KeyCombinationImplCopyWith<$Res> {
  __$$KeyCombinationImplCopyWithImpl(
      _$KeyCombinationImpl _value, $Res Function(_$KeyCombinationImpl) _then)
      : super(_value, _then);

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
    return _then(_$KeyCombinationImpl(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      modifier: freezed == modifier
          ? _value.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      altKey: freezed == altKey
          ? _value.altKey
          : altKey // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
      altModifier: freezed == altModifier
          ? _value.altModifier
          : altModifier // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyCombinationImpl extends _KeyCombination {
  _$KeyCombinationImpl(
      {@LogicalKeyboardSerializer() this.key,
      @LogicalKeyboardSerializer() this.modifier,
      @LogicalKeyboardSerializer() this.altKey,
      @LogicalKeyboardSerializer() this.altModifier})
      : super._();

  factory _$KeyCombinationImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyCombinationImplFromJson(json);

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

  @override
  String toString() {
    return 'KeyCombination(key: $key, modifier: $modifier, altKey: $altKey, altModifier: $altModifier)';
  }

  /// Create a copy of KeyCombination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyCombinationImplCopyWith<_$KeyCombinationImpl> get copyWith =>
      __$$KeyCombinationImplCopyWithImpl<_$KeyCombinationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyCombinationImplToJson(
      this,
    );
  }
}

abstract class _KeyCombination extends KeyCombination {
  factory _KeyCombination(
          {@LogicalKeyboardSerializer() final LogicalKeyboardKey? key,
          @LogicalKeyboardSerializer() final LogicalKeyboardKey? modifier,
          @LogicalKeyboardSerializer() final LogicalKeyboardKey? altKey,
          @LogicalKeyboardSerializer() final LogicalKeyboardKey? altModifier}) =
      _$KeyCombinationImpl;
  _KeyCombination._() : super._();

  factory _KeyCombination.fromJson(Map<String, dynamic> json) =
      _$KeyCombinationImpl.fromJson;

  @override
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get key;
  @override
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get modifier;
  @override
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get altKey;
  @override
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get altModifier;

  /// Create a copy of KeyCombination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyCombinationImplCopyWith<_$KeyCombinationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
