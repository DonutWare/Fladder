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
  LogicalKeyboardKey? get modifier => throw _privateConstructorUsedError;
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey get key => throw _privateConstructorUsedError;

  /// Serializes this KeyCombination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$KeyCombinationImpl extends _KeyCombination {
  _$KeyCombinationImpl(
      {@LogicalKeyboardSerializer() this.modifier,
      @LogicalKeyboardSerializer() required this.key})
      : super._();

  factory _$KeyCombinationImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyCombinationImplFromJson(json);

  @override
  @LogicalKeyboardSerializer()
  final LogicalKeyboardKey? modifier;
  @override
  @LogicalKeyboardSerializer()
  final LogicalKeyboardKey key;

  @override
  String toString() {
    return 'KeyCombination(modifier: $modifier, key: $key)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyCombinationImplToJson(
      this,
    );
  }
}

abstract class _KeyCombination extends KeyCombination {
  factory _KeyCombination(
          {@LogicalKeyboardSerializer() final LogicalKeyboardKey? modifier,
          @LogicalKeyboardSerializer() required final LogicalKeyboardKey key}) =
      _$KeyCombinationImpl;
  _KeyCombination._() : super._();

  factory _KeyCombination.fromJson(Map<String, dynamic> json) =
      _$KeyCombinationImpl.fromJson;

  @override
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey? get modifier;
  @override
  @LogicalKeyboardSerializer()
  LogicalKeyboardKey get key;
}
