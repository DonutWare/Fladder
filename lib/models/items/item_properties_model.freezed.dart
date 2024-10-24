// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_properties_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ItemPropertiesModel {
  bool get canDelete => throw _privateConstructorUsedError;
  bool get canDownload => throw _privateConstructorUsedError;

  /// Create a copy of ItemPropertiesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemPropertiesModelCopyWith<ItemPropertiesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemPropertiesModelCopyWith<$Res> {
  factory $ItemPropertiesModelCopyWith(
          ItemPropertiesModel value, $Res Function(ItemPropertiesModel) then) =
      _$ItemPropertiesModelCopyWithImpl<$Res, ItemPropertiesModel>;
  @useResult
  $Res call({bool canDelete, bool canDownload});
}

/// @nodoc
class _$ItemPropertiesModelCopyWithImpl<$Res, $Val extends ItemPropertiesModel>
    implements $ItemPropertiesModelCopyWith<$Res> {
  _$ItemPropertiesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemPropertiesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canDelete = null,
    Object? canDownload = null,
  }) {
    return _then(_value.copyWith(
      canDelete: null == canDelete
          ? _value.canDelete
          : canDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      canDownload: null == canDownload
          ? _value.canDownload
          : canDownload // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemPropertiesModelImplCopyWith<$Res>
    implements $ItemPropertiesModelCopyWith<$Res> {
  factory _$$ItemPropertiesModelImplCopyWith(_$ItemPropertiesModelImpl value,
          $Res Function(_$ItemPropertiesModelImpl) then) =
      __$$ItemPropertiesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool canDelete, bool canDownload});
}

/// @nodoc
class __$$ItemPropertiesModelImplCopyWithImpl<$Res>
    extends _$ItemPropertiesModelCopyWithImpl<$Res, _$ItemPropertiesModelImpl>
    implements _$$ItemPropertiesModelImplCopyWith<$Res> {
  __$$ItemPropertiesModelImplCopyWithImpl(_$ItemPropertiesModelImpl _value,
      $Res Function(_$ItemPropertiesModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemPropertiesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canDelete = null,
    Object? canDownload = null,
  }) {
    return _then(_$ItemPropertiesModelImpl(
      canDelete: null == canDelete
          ? _value.canDelete
          : canDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      canDownload: null == canDownload
          ? _value.canDownload
          : canDownload // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ItemPropertiesModelImpl extends _ItemPropertiesModel {
  _$ItemPropertiesModelImpl(
      {required this.canDelete, required this.canDownload})
      : super._();

  @override
  final bool canDelete;
  @override
  final bool canDownload;

  @override
  String toString() {
    return 'ItemPropertiesModel._internal(canDelete: $canDelete, canDownload: $canDownload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemPropertiesModelImpl &&
            (identical(other.canDelete, canDelete) ||
                other.canDelete == canDelete) &&
            (identical(other.canDownload, canDownload) ||
                other.canDownload == canDownload));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canDelete, canDownload);

  /// Create a copy of ItemPropertiesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemPropertiesModelImplCopyWith<_$ItemPropertiesModelImpl> get copyWith =>
      __$$ItemPropertiesModelImplCopyWithImpl<_$ItemPropertiesModelImpl>(
          this, _$identity);
}

abstract class _ItemPropertiesModel extends ItemPropertiesModel {
  factory _ItemPropertiesModel(
      {required final bool canDelete,
      required final bool canDownload}) = _$ItemPropertiesModelImpl;
  _ItemPropertiesModel._() : super._();

  @override
  bool get canDelete;
  @override
  bool get canDownload;

  /// Create a copy of ItemPropertiesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemPropertiesModelImplCopyWith<_$ItemPropertiesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
