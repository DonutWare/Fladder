// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdatesModel {
  List<ReleaseInfo> get lastRelease => throw _privateConstructorUsedError;

  /// Create a copy of UpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatesModelCopyWith<UpdatesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatesModelCopyWith<$Res> {
  factory $UpdatesModelCopyWith(
          UpdatesModel value, $Res Function(UpdatesModel) then) =
      _$UpdatesModelCopyWithImpl<$Res, UpdatesModel>;
  @useResult
  $Res call({List<ReleaseInfo> lastRelease});
}

/// @nodoc
class _$UpdatesModelCopyWithImpl<$Res, $Val extends UpdatesModel>
    implements $UpdatesModelCopyWith<$Res> {
  _$UpdatesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastRelease = null,
  }) {
    return _then(_value.copyWith(
      lastRelease: null == lastRelease
          ? _value.lastRelease
          : lastRelease // ignore: cast_nullable_to_non_nullable
              as List<ReleaseInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatesModelImplCopyWith<$Res>
    implements $UpdatesModelCopyWith<$Res> {
  factory _$$UpdatesModelImplCopyWith(
          _$UpdatesModelImpl value, $Res Function(_$UpdatesModelImpl) then) =
      __$$UpdatesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ReleaseInfo> lastRelease});
}

/// @nodoc
class __$$UpdatesModelImplCopyWithImpl<$Res>
    extends _$UpdatesModelCopyWithImpl<$Res, _$UpdatesModelImpl>
    implements _$$UpdatesModelImplCopyWith<$Res> {
  __$$UpdatesModelImplCopyWithImpl(
      _$UpdatesModelImpl _value, $Res Function(_$UpdatesModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastRelease = null,
  }) {
    return _then(_$UpdatesModelImpl(
      lastRelease: null == lastRelease
          ? _value._lastRelease
          : lastRelease // ignore: cast_nullable_to_non_nullable
              as List<ReleaseInfo>,
    ));
  }
}

/// @nodoc

class _$UpdatesModelImpl extends _UpdatesModel with DiagnosticableTreeMixin {
  _$UpdatesModelImpl({final List<ReleaseInfo> lastRelease = const []})
      : _lastRelease = lastRelease,
        super._();

  final List<ReleaseInfo> _lastRelease;
  @override
  @JsonKey()
  List<ReleaseInfo> get lastRelease {
    if (_lastRelease is EqualUnmodifiableListView) return _lastRelease;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lastRelease);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdatesModel(lastRelease: $lastRelease)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UpdatesModel'))
      ..add(DiagnosticsProperty('lastRelease', lastRelease));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatesModelImpl &&
            const DeepCollectionEquality()
                .equals(other._lastRelease, _lastRelease));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_lastRelease));

  /// Create a copy of UpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatesModelImplCopyWith<_$UpdatesModelImpl> get copyWith =>
      __$$UpdatesModelImplCopyWithImpl<_$UpdatesModelImpl>(this, _$identity);
}

abstract class _UpdatesModel extends UpdatesModel {
  factory _UpdatesModel({final List<ReleaseInfo> lastRelease}) =
      _$UpdatesModelImpl;
  _UpdatesModel._() : super._();

  @override
  List<ReleaseInfo> get lastRelease;

  /// Create a copy of UpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatesModelImplCopyWith<_$UpdatesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
