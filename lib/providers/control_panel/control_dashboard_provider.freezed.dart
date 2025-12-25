// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_dashboard_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlDashboardModel {
  String? get serverName;
  String? get serverVersion;
  String? get webVersion;
  bool get isShuttingDown;
  jelly.ItemCounts? get itemCounts;
  jelly.SystemStorageDto? get storagePaths;

  /// Create a copy of ControlDashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ControlDashboardModelCopyWith<ControlDashboardModel> get copyWith =>
      _$ControlDashboardModelCopyWithImpl<ControlDashboardModel>(
          this as ControlDashboardModel, _$identity);

  @override
  String toString() {
    return 'ControlDashboardModel(serverName: $serverName, serverVersion: $serverVersion, webVersion: $webVersion, isShuttingDown: $isShuttingDown, itemCounts: $itemCounts, storagePaths: $storagePaths)';
  }
}

/// @nodoc
abstract mixin class $ControlDashboardModelCopyWith<$Res> {
  factory $ControlDashboardModelCopyWith(ControlDashboardModel value,
          $Res Function(ControlDashboardModel) _then) =
      _$ControlDashboardModelCopyWithImpl;
  @useResult
  $Res call(
      {String? serverName,
      String? serverVersion,
      String? webVersion,
      bool isShuttingDown,
      jelly.ItemCounts? itemCounts,
      jelly.SystemStorageDto? storagePaths});
}

/// @nodoc
class _$ControlDashboardModelCopyWithImpl<$Res>
    implements $ControlDashboardModelCopyWith<$Res> {
  _$ControlDashboardModelCopyWithImpl(this._self, this._then);

  final ControlDashboardModel _self;
  final $Res Function(ControlDashboardModel) _then;

  /// Create a copy of ControlDashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverName = freezed,
    Object? serverVersion = freezed,
    Object? webVersion = freezed,
    Object? isShuttingDown = null,
    Object? itemCounts = freezed,
    Object? storagePaths = freezed,
  }) {
    return _then(_self.copyWith(
      serverName: freezed == serverName
          ? _self.serverName
          : serverName // ignore: cast_nullable_to_non_nullable
              as String?,
      serverVersion: freezed == serverVersion
          ? _self.serverVersion
          : serverVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      webVersion: freezed == webVersion
          ? _self.webVersion
          : webVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      isShuttingDown: null == isShuttingDown
          ? _self.isShuttingDown
          : isShuttingDown // ignore: cast_nullable_to_non_nullable
              as bool,
      itemCounts: freezed == itemCounts
          ? _self.itemCounts
          : itemCounts // ignore: cast_nullable_to_non_nullable
              as jelly.ItemCounts?,
      storagePaths: freezed == storagePaths
          ? _self.storagePaths
          : storagePaths // ignore: cast_nullable_to_non_nullable
              as jelly.SystemStorageDto?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ControlDashboardModel].
extension ControlDashboardModelPatterns on ControlDashboardModel {
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
    TResult Function(_ControlDashboardModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlDashboardModel() when $default != null:
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
    TResult Function(_ControlDashboardModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlDashboardModel():
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
    TResult? Function(_ControlDashboardModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlDashboardModel() when $default != null:
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
    TResult Function(
            String? serverName,
            String? serverVersion,
            String? webVersion,
            bool isShuttingDown,
            jelly.ItemCounts? itemCounts,
            jelly.SystemStorageDto? storagePaths)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlDashboardModel() when $default != null:
        return $default(_that.serverName, _that.serverVersion, _that.webVersion,
            _that.isShuttingDown, _that.itemCounts, _that.storagePaths);
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
    TResult Function(
            String? serverName,
            String? serverVersion,
            String? webVersion,
            bool isShuttingDown,
            jelly.ItemCounts? itemCounts,
            jelly.SystemStorageDto? storagePaths)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlDashboardModel():
        return $default(_that.serverName, _that.serverVersion, _that.webVersion,
            _that.isShuttingDown, _that.itemCounts, _that.storagePaths);
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
    TResult? Function(
            String? serverName,
            String? serverVersion,
            String? webVersion,
            bool isShuttingDown,
            jelly.ItemCounts? itemCounts,
            jelly.SystemStorageDto? storagePaths)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlDashboardModel() when $default != null:
        return $default(_that.serverName, _that.serverVersion, _that.webVersion,
            _that.isShuttingDown, _that.itemCounts, _that.storagePaths);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ControlDashboardModel implements ControlDashboardModel {
  _ControlDashboardModel(
      {this.serverName,
      this.serverVersion,
      this.webVersion,
      this.isShuttingDown = false,
      this.itemCounts,
      this.storagePaths});

  @override
  final String? serverName;
  @override
  final String? serverVersion;
  @override
  final String? webVersion;
  @override
  @JsonKey()
  final bool isShuttingDown;
  @override
  final jelly.ItemCounts? itemCounts;
  @override
  final jelly.SystemStorageDto? storagePaths;

  /// Create a copy of ControlDashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ControlDashboardModelCopyWith<_ControlDashboardModel> get copyWith =>
      __$ControlDashboardModelCopyWithImpl<_ControlDashboardModel>(
          this, _$identity);

  @override
  String toString() {
    return 'ControlDashboardModel(serverName: $serverName, serverVersion: $serverVersion, webVersion: $webVersion, isShuttingDown: $isShuttingDown, itemCounts: $itemCounts, storagePaths: $storagePaths)';
  }
}

/// @nodoc
abstract mixin class _$ControlDashboardModelCopyWith<$Res>
    implements $ControlDashboardModelCopyWith<$Res> {
  factory _$ControlDashboardModelCopyWith(_ControlDashboardModel value,
          $Res Function(_ControlDashboardModel) _then) =
      __$ControlDashboardModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? serverName,
      String? serverVersion,
      String? webVersion,
      bool isShuttingDown,
      jelly.ItemCounts? itemCounts,
      jelly.SystemStorageDto? storagePaths});
}

/// @nodoc
class __$ControlDashboardModelCopyWithImpl<$Res>
    implements _$ControlDashboardModelCopyWith<$Res> {
  __$ControlDashboardModelCopyWithImpl(this._self, this._then);

  final _ControlDashboardModel _self;
  final $Res Function(_ControlDashboardModel) _then;

  /// Create a copy of ControlDashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serverName = freezed,
    Object? serverVersion = freezed,
    Object? webVersion = freezed,
    Object? isShuttingDown = null,
    Object? itemCounts = freezed,
    Object? storagePaths = freezed,
  }) {
    return _then(_ControlDashboardModel(
      serverName: freezed == serverName
          ? _self.serverName
          : serverName // ignore: cast_nullable_to_non_nullable
              as String?,
      serverVersion: freezed == serverVersion
          ? _self.serverVersion
          : serverVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      webVersion: freezed == webVersion
          ? _self.webVersion
          : webVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      isShuttingDown: null == isShuttingDown
          ? _self.isShuttingDown
          : isShuttingDown // ignore: cast_nullable_to_non_nullable
              as bool,
      itemCounts: freezed == itemCounts
          ? _self.itemCounts
          : itemCounts // ignore: cast_nullable_to_non_nullable
              as jelly.ItemCounts?,
      storagePaths: freezed == storagePaths
          ? _self.storagePaths
          : storagePaths // ignore: cast_nullable_to_non_nullable
              as jelly.SystemStorageDto?,
    ));
  }
}

// dart format on
