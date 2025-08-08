// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hotkeys_model.dart';

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

HotKeysModel _$HotKeysModelFromJson(Map<String, dynamic> json) {
  return _HotKeysModel.fromJson(json);
}

/// @nodoc
mixin _$HotKeysModel {
  Map<HotKeys, KeyCombination?> get shortCuts =>
      throw _privateConstructorUsedError;

  /// Serializes this HotKeysModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HotKeysModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HotKeysModelCopyWith<HotKeysModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotKeysModelCopyWith<$Res> {
  factory $HotKeysModelCopyWith(
          HotKeysModel value, $Res Function(HotKeysModel) then) =
      _$HotKeysModelCopyWithImpl<$Res, HotKeysModel>;
  @useResult
  $Res call({Map<HotKeys, KeyCombination?> shortCuts});
}

/// @nodoc
class _$HotKeysModelCopyWithImpl<$Res, $Val extends HotKeysModel>
    implements $HotKeysModelCopyWith<$Res> {
  _$HotKeysModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HotKeysModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortCuts = null,
  }) {
    return _then(_value.copyWith(
      shortCuts: null == shortCuts
          ? _value.shortCuts
          : shortCuts // ignore: cast_nullable_to_non_nullable
              as Map<HotKeys, KeyCombination?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HotKeysModelImplCopyWith<$Res>
    implements $HotKeysModelCopyWith<$Res> {
  factory _$$HotKeysModelImplCopyWith(
          _$HotKeysModelImpl value, $Res Function(_$HotKeysModelImpl) then) =
      __$$HotKeysModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<HotKeys, KeyCombination?> shortCuts});
}

/// @nodoc
class __$$HotKeysModelImplCopyWithImpl<$Res>
    extends _$HotKeysModelCopyWithImpl<$Res, _$HotKeysModelImpl>
    implements _$$HotKeysModelImplCopyWith<$Res> {
  __$$HotKeysModelImplCopyWithImpl(
      _$HotKeysModelImpl _value, $Res Function(_$HotKeysModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HotKeysModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortCuts = null,
  }) {
    return _then(_$HotKeysModelImpl(
      shortCuts: null == shortCuts
          ? _value._shortCuts
          : shortCuts // ignore: cast_nullable_to_non_nullable
              as Map<HotKeys, KeyCombination?>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HotKeysModelImpl extends _HotKeysModel {
  _$HotKeysModelImpl({final Map<HotKeys, KeyCombination?> shortCuts = const {}})
      : _shortCuts = shortCuts,
        super._();

  factory _$HotKeysModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HotKeysModelImplFromJson(json);

  final Map<HotKeys, KeyCombination?> _shortCuts;
  @override
  @JsonKey()
  Map<HotKeys, KeyCombination?> get shortCuts {
    if (_shortCuts is EqualUnmodifiableMapView) return _shortCuts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_shortCuts);
  }

  @override
  String toString() {
    return 'HotKeysModel(shortCuts: $shortCuts)';
  }

  /// Create a copy of HotKeysModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotKeysModelImplCopyWith<_$HotKeysModelImpl> get copyWith =>
      __$$HotKeysModelImplCopyWithImpl<_$HotKeysModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HotKeysModelImplToJson(
      this,
    );
  }
}

abstract class _HotKeysModel extends HotKeysModel {
  factory _HotKeysModel({final Map<HotKeys, KeyCombination?> shortCuts}) =
      _$HotKeysModelImpl;
  _HotKeysModel._() : super._();

  factory _HotKeysModel.fromJson(Map<String, dynamic> json) =
      _$HotKeysModelImpl.fromJson;

  @override
  Map<HotKeys, KeyCombination?> get shortCuts;

  /// Create a copy of HotKeysModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotKeysModelImplCopyWith<_$HotKeysModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
