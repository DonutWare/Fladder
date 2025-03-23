// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arguments_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ArgumentsModel {
  bool get htpcMode => throw _privateConstructorUsedError;

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArgumentsModelCopyWith<ArgumentsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArgumentsModelCopyWith<$Res> {
  factory $ArgumentsModelCopyWith(
          ArgumentsModel value, $Res Function(ArgumentsModel) then) =
      _$ArgumentsModelCopyWithImpl<$Res, ArgumentsModel>;
  @useResult
  $Res call({bool htpcMode});
}

/// @nodoc
class _$ArgumentsModelCopyWithImpl<$Res, $Val extends ArgumentsModel>
    implements $ArgumentsModelCopyWith<$Res> {
  _$ArgumentsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? htpcMode = null,
  }) {
    return _then(_value.copyWith(
      htpcMode: null == htpcMode
          ? _value.htpcMode
          : htpcMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArgumentsModelImplCopyWith<$Res>
    implements $ArgumentsModelCopyWith<$Res> {
  factory _$$ArgumentsModelImplCopyWith(_$ArgumentsModelImpl value,
          $Res Function(_$ArgumentsModelImpl) then) =
      __$$ArgumentsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool htpcMode});
}

/// @nodoc
class __$$ArgumentsModelImplCopyWithImpl<$Res>
    extends _$ArgumentsModelCopyWithImpl<$Res, _$ArgumentsModelImpl>
    implements _$$ArgumentsModelImplCopyWith<$Res> {
  __$$ArgumentsModelImplCopyWithImpl(
      _$ArgumentsModelImpl _value, $Res Function(_$ArgumentsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? htpcMode = null,
  }) {
    return _then(_$ArgumentsModelImpl(
      htpcMode: null == htpcMode
          ? _value.htpcMode
          : htpcMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ArgumentsModelImpl extends _ArgumentsModel {
  _$ArgumentsModelImpl({this.htpcMode = false}) : super._();

  @override
  @JsonKey()
  final bool htpcMode;

  @override
  String toString() {
    return 'ArgumentsModel(htpcMode: $htpcMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArgumentsModelImpl &&
            (identical(other.htpcMode, htpcMode) ||
                other.htpcMode == htpcMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, htpcMode);

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArgumentsModelImplCopyWith<_$ArgumentsModelImpl> get copyWith =>
      __$$ArgumentsModelImplCopyWithImpl<_$ArgumentsModelImpl>(
          this, _$identity);
}

abstract class _ArgumentsModel extends ArgumentsModel {
  factory _ArgumentsModel({final bool htpcMode}) = _$ArgumentsModelImpl;
  _ArgumentsModel._() : super._();

  @override
  bool get htpcMode;

  /// Create a copy of ArgumentsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArgumentsModelImplCopyWith<_$ArgumentsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
