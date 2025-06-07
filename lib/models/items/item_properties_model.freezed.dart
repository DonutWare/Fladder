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
}
