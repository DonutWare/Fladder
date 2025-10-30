// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncSettingsModel {
  List<SyncedItem> get items;

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyncSettingsModelCopyWith<SyncSettingsModel> get copyWith =>
      _$SyncSettingsModelCopyWithImpl<SyncSettingsModel>(
          this as SyncSettingsModel, _$identity);

  @override
  String toString() {
    return 'SyncSettingsModel(items: $items)';
  }
}

/// @nodoc
abstract mixin class $SyncSettingsModelCopyWith<$Res> {
  factory $SyncSettingsModelCopyWith(
          SyncSettingsModel value, $Res Function(SyncSettingsModel) _then) =
      _$SyncSettingsModelCopyWithImpl;
  @useResult
  $Res call({List<SyncedItem> items});
}

/// @nodoc
class _$SyncSettingsModelCopyWithImpl<$Res>
    implements $SyncSettingsModelCopyWith<$Res> {
  _$SyncSettingsModelCopyWithImpl(this._self, this._then);

  final SyncSettingsModel _self;
  final $Res Function(SyncSettingsModel) _then;

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SyncedItem>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SyncSettingsModel].
extension SyncSettingsModelPatterns on SyncSettingsModel {
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
    TResult Function(_SyncSettignsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncSettignsModel() when $default != null:
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
    TResult Function(_SyncSettignsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncSettignsModel():
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
    TResult? Function(_SyncSettignsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncSettignsModel() when $default != null:
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
    TResult Function(List<SyncedItem> items)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncSettignsModel() when $default != null:
        return $default(_that.items);
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
    TResult Function(List<SyncedItem> items) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncSettignsModel():
        return $default(_that.items);
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
    TResult? Function(List<SyncedItem> items)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncSettignsModel() when $default != null:
        return $default(_that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SyncSettignsModel extends SyncSettingsModel {
  _SyncSettignsModel({final List<SyncedItem> items = const []})
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

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyncSettignsModelCopyWith<_SyncSettignsModel> get copyWith =>
      __$SyncSettignsModelCopyWithImpl<_SyncSettignsModel>(this, _$identity);

  @override
  String toString() {
    return 'SyncSettingsModel(items: $items)';
  }
}

/// @nodoc
abstract mixin class _$SyncSettignsModelCopyWith<$Res>
    implements $SyncSettingsModelCopyWith<$Res> {
  factory _$SyncSettignsModelCopyWith(
          _SyncSettignsModel value, $Res Function(_SyncSettignsModel) _then) =
      __$SyncSettignsModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<SyncedItem> items});
}

/// @nodoc
class __$SyncSettignsModelCopyWithImpl<$Res>
    implements _$SyncSettignsModelCopyWith<$Res> {
  __$SyncSettignsModelCopyWithImpl(this._self, this._then);

  final _SyncSettignsModel _self;
  final $Res Function(_SyncSettignsModel) _then;

  /// Create a copy of SyncSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
  }) {
    return _then(_SyncSettignsModel(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SyncedItem>,
    ));
  }
}

// dart format on
