// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_properties_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ItemPropertiesModel {
  bool get canDelete;
  bool get canDownload;

  @override
  String toString() {
    return 'ItemPropertiesModel(canDelete: $canDelete, canDownload: $canDownload)';
  }
}

/// Adds pattern-matching-related methods to [ItemPropertiesModel].
extension ItemPropertiesModelPatterns on ItemPropertiesModel {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ItemPropertiesModel value)? _internal,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ItemPropertiesModel() when _internal != null:
        return _internal(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_ItemPropertiesModel value) _internal,
  }) {
    final _that = this;
    switch (_that) {
      case _ItemPropertiesModel():
        return _internal(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ItemPropertiesModel value)? _internal,
  }) {
    final _that = this;
    switch (_that) {
      case _ItemPropertiesModel() when _internal != null:
        return _internal(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool canDelete, bool canDownload)? _internal,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ItemPropertiesModel() when _internal != null:
        return _internal(_that.canDelete, _that.canDownload);
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
  TResult when<TResult extends Object?>({
    required TResult Function(bool canDelete, bool canDownload) _internal,
  }) {
    final _that = this;
    switch (_that) {
      case _ItemPropertiesModel():
        return _internal(_that.canDelete, _that.canDownload);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool canDelete, bool canDownload)? _internal,
  }) {
    final _that = this;
    switch (_that) {
      case _ItemPropertiesModel() when _internal != null:
        return _internal(_that.canDelete, _that.canDownload);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ItemPropertiesModel extends ItemPropertiesModel {
  _ItemPropertiesModel({required this.canDelete, required this.canDownload})
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

// dart format on
