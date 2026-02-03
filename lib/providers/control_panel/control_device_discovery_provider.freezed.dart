// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_device_discovery_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlDeviceDiscoveryModel {
  bool get isLoading;
  List<TunerHostInfo> get devices;

  /// Create a copy of ControlDeviceDiscoveryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ControlDeviceDiscoveryModelCopyWith<ControlDeviceDiscoveryModel>
      get copyWith => _$ControlDeviceDiscoveryModelCopyWithImpl<
              ControlDeviceDiscoveryModel>(
          this as ControlDeviceDiscoveryModel, _$identity);

  @override
  String toString() {
    return 'ControlDeviceDiscoveryModel(isLoading: $isLoading, devices: $devices)';
  }
}

/// @nodoc
abstract mixin class $ControlDeviceDiscoveryModelCopyWith<$Res> {
  factory $ControlDeviceDiscoveryModelCopyWith(
          ControlDeviceDiscoveryModel value,
          $Res Function(ControlDeviceDiscoveryModel) _then) =
      _$ControlDeviceDiscoveryModelCopyWithImpl;
  @useResult
  $Res call({bool isLoading, List<TunerHostInfo> devices});
}

/// @nodoc
class _$ControlDeviceDiscoveryModelCopyWithImpl<$Res>
    implements $ControlDeviceDiscoveryModelCopyWith<$Res> {
  _$ControlDeviceDiscoveryModelCopyWithImpl(this._self, this._then);

  final ControlDeviceDiscoveryModel _self;
  final $Res Function(ControlDeviceDiscoveryModel) _then;

  /// Create a copy of ControlDeviceDiscoveryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? devices = null,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      devices: null == devices
          ? _self.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<TunerHostInfo>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ControlDeviceDiscoveryModel].
extension ControlDeviceDiscoveryModelPatterns on ControlDeviceDiscoveryModel {
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
    TResult Function(_ControlDeviceDiscoveryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlDeviceDiscoveryModel() when $default != null:
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
    TResult Function(_ControlDeviceDiscoveryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlDeviceDiscoveryModel():
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
    TResult? Function(_ControlDeviceDiscoveryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlDeviceDiscoveryModel() when $default != null:
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
    TResult Function(bool isLoading, List<TunerHostInfo> devices)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlDeviceDiscoveryModel() when $default != null:
        return $default(_that.isLoading, _that.devices);
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
    TResult Function(bool isLoading, List<TunerHostInfo> devices) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlDeviceDiscoveryModel():
        return $default(_that.isLoading, _that.devices);
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
    TResult? Function(bool isLoading, List<TunerHostInfo> devices)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlDeviceDiscoveryModel() when $default != null:
        return $default(_that.isLoading, _that.devices);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ControlDeviceDiscoveryModel implements ControlDeviceDiscoveryModel {
  const _ControlDeviceDiscoveryModel(
      {this.isLoading = true, final List<TunerHostInfo> devices = const []})
      : _devices = devices;

  @override
  @JsonKey()
  final bool isLoading;
  final List<TunerHostInfo> _devices;
  @override
  @JsonKey()
  List<TunerHostInfo> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  /// Create a copy of ControlDeviceDiscoveryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ControlDeviceDiscoveryModelCopyWith<_ControlDeviceDiscoveryModel>
      get copyWith => __$ControlDeviceDiscoveryModelCopyWithImpl<
          _ControlDeviceDiscoveryModel>(this, _$identity);

  @override
  String toString() {
    return 'ControlDeviceDiscoveryModel(isLoading: $isLoading, devices: $devices)';
  }
}

/// @nodoc
abstract mixin class _$ControlDeviceDiscoveryModelCopyWith<$Res>
    implements $ControlDeviceDiscoveryModelCopyWith<$Res> {
  factory _$ControlDeviceDiscoveryModelCopyWith(
          _ControlDeviceDiscoveryModel value,
          $Res Function(_ControlDeviceDiscoveryModel) _then) =
      __$ControlDeviceDiscoveryModelCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoading, List<TunerHostInfo> devices});
}

/// @nodoc
class __$ControlDeviceDiscoveryModelCopyWithImpl<$Res>
    implements _$ControlDeviceDiscoveryModelCopyWith<$Res> {
  __$ControlDeviceDiscoveryModelCopyWithImpl(this._self, this._then);

  final _ControlDeviceDiscoveryModel _self;
  final $Res Function(_ControlDeviceDiscoveryModel) _then;

  /// Create a copy of ControlDeviceDiscoveryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? devices = null,
  }) {
    return _then(_ControlDeviceDiscoveryModel(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      devices: null == devices
          ? _self._devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<TunerHostInfo>,
    ));
  }
}

// dart format on
