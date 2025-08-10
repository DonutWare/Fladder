// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_info_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionInfoModel {
  String? get playbackModel;
  TranscodingInfo? get transCodeInfo;

  /// Serializes this SessionInfoModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SessionInfoModel(playbackModel: $playbackModel, transCodeInfo: $transCodeInfo)';
  }
}

/// Adds pattern-matching-related methods to [SessionInfoModel].
extension SessionInfoModelPatterns on SessionInfoModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SessionInfoModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SessionInfoModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SessionInfoModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionInfoModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SessionInfoModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionInfoModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? playbackModel, TranscodingInfo? transCodeInfo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SessionInfoModel() when $default != null:
        return $default(_that.playbackModel, _that.transCodeInfo);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? playbackModel, TranscodingInfo? transCodeInfo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionInfoModel():
        return $default(_that.playbackModel, _that.transCodeInfo);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? playbackModel, TranscodingInfo? transCodeInfo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionInfoModel() when $default != null:
        return $default(_that.playbackModel, _that.transCodeInfo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SessionInfoModel extends SessionInfoModel {
  _SessionInfoModel({this.playbackModel, this.transCodeInfo}) : super._();
  factory _SessionInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SessionInfoModelFromJson(json);

  @override
  final String? playbackModel;
  @override
  final TranscodingInfo? transCodeInfo;

  @override
  Map<String, dynamic> toJson() {
    return _$SessionInfoModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SessionInfoModel(playbackModel: $playbackModel, transCodeInfo: $transCodeInfo)';
  }
}

// dart format on
