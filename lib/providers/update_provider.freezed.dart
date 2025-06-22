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
}

abstract class _UpdatesModel extends UpdatesModel {
  factory _UpdatesModel({final List<ReleaseInfo> lastRelease}) =
      _$UpdatesModelImpl;
  _UpdatesModel._() : super._();

  @override
  List<ReleaseInfo> get lastRelease;
}
