// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApplicationInfo {
  String get name => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get buildNumber => throw _privateConstructorUsedError;
  String get os => throw _privateConstructorUsedError;

  /// Create a copy of ApplicationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationInfoCopyWith<ApplicationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationInfoCopyWith<$Res> {
  factory $ApplicationInfoCopyWith(
          ApplicationInfo value, $Res Function(ApplicationInfo) then) =
      _$ApplicationInfoCopyWithImpl<$Res, ApplicationInfo>;
  @useResult
  $Res call({String name, String version, String buildNumber, String os});
}

/// @nodoc
class _$ApplicationInfoCopyWithImpl<$Res, $Val extends ApplicationInfo>
    implements $ApplicationInfoCopyWith<$Res> {
  _$ApplicationInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplicationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? version = null,
    Object? buildNumber = null,
    Object? os = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      buildNumber: null == buildNumber
          ? _value.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as String,
      os: null == os
          ? _value.os
          : os // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicationInfoImplCopyWith<$Res>
    implements $ApplicationInfoCopyWith<$Res> {
  factory _$$ApplicationInfoImplCopyWith(_$ApplicationInfoImpl value,
          $Res Function(_$ApplicationInfoImpl) then) =
      __$$ApplicationInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String version, String buildNumber, String os});
}

/// @nodoc
class __$$ApplicationInfoImplCopyWithImpl<$Res>
    extends _$ApplicationInfoCopyWithImpl<$Res, _$ApplicationInfoImpl>
    implements _$$ApplicationInfoImplCopyWith<$Res> {
  __$$ApplicationInfoImplCopyWithImpl(
      _$ApplicationInfoImpl _value, $Res Function(_$ApplicationInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplicationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? version = null,
    Object? buildNumber = null,
    Object? os = null,
  }) {
    return _then(_$ApplicationInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      buildNumber: null == buildNumber
          ? _value.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as String,
      os: null == os
          ? _value.os
          : os // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ApplicationInfoImpl extends _ApplicationInfo {
  _$ApplicationInfoImpl(
      {required this.name,
      required this.version,
      required this.buildNumber,
      required this.os})
      : super._();

  @override
  final String name;
  @override
  final String version;
  @override
  final String buildNumber;
  @override
  final String os;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.buildNumber, buildNumber) ||
                other.buildNumber == buildNumber) &&
            (identical(other.os, os) || other.os == os));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, version, buildNumber, os);

  /// Create a copy of ApplicationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationInfoImplCopyWith<_$ApplicationInfoImpl> get copyWith =>
      __$$ApplicationInfoImplCopyWithImpl<_$ApplicationInfoImpl>(
          this, _$identity);
}

abstract class _ApplicationInfo extends ApplicationInfo {
  factory _ApplicationInfo(
      {required final String name,
      required final String version,
      required final String buildNumber,
      required final String os}) = _$ApplicationInfoImpl;
  _ApplicationInfo._() : super._();

  @override
  String get name;
  @override
  String get version;
  @override
  String get buildNumber;
  @override
  String get os;

  /// Create a copy of ApplicationInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationInfoImplCopyWith<_$ApplicationInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
