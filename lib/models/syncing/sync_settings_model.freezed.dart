// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncSettingsModel {
  List<SyncedItem> get items => throw _privateConstructorUsedError;

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncSettingsModelCopyWith<SyncSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncSettingsModelCopyWith<$Res> {
  factory $SyncSettingsModelCopyWith(
          SyncSettingsModel value, $Res Function(SyncSettingsModel) then) =
      _$SyncSettingsModelCopyWithImpl<$Res, SyncSettingsModel>;
  @useResult
  $Res call({List<SyncedItem> items});
}

/// @nodoc
class _$SyncSettingsModelCopyWithImpl<$Res, $Val extends SyncSettingsModel>
    implements $SyncSettingsModelCopyWith<$Res> {
  _$SyncSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SyncedItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncSettignsModelImplCopyWith<$Res>
    implements $SyncSettingsModelCopyWith<$Res> {
  factory _$$SyncSettignsModelImplCopyWith(_$SyncSettignsModelImpl value,
          $Res Function(_$SyncSettignsModelImpl) then) =
      __$$SyncSettignsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SyncedItem> items});
}

/// @nodoc
class __$$SyncSettignsModelImplCopyWithImpl<$Res>
    extends _$SyncSettingsModelCopyWithImpl<$Res, _$SyncSettignsModelImpl>
    implements _$$SyncSettignsModelImplCopyWith<$Res> {
  __$$SyncSettignsModelImplCopyWithImpl(_$SyncSettignsModelImpl _value,
      $Res Function(_$SyncSettignsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$SyncSettignsModelImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SyncedItem>,
    ));
  }
}

/// @nodoc

class _$SyncSettignsModelImpl extends _SyncSettignsModel {
  _$SyncSettignsModelImpl({final List<SyncedItem> items = const []})
      : _items = items,
        super._();

  final List<SyncedItem> _items;
  @override
  @JsonKey()
  List<SyncedItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SyncSettingsModel(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncSettignsModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncSettignsModelImplCopyWith<_$SyncSettignsModelImpl> get copyWith =>
      __$$SyncSettignsModelImplCopyWithImpl<_$SyncSettignsModelImpl>(
          this, _$identity);
}

abstract class _SyncSettignsModel extends SyncSettingsModel {
  factory _SyncSettignsModel({final List<SyncedItem> items}) =
      _$SyncSettignsModelImpl;
  _SyncSettignsModel._() : super._();

  @override
  List<SyncedItem> get items;

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncSettignsModelImplCopyWith<_$SyncSettignsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
