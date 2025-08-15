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
}
