// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syncplay_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncPlayGroupsState implements DiagnosticableTreeMixin {
  List<GroupInfoDto>? get groups;
  bool get isLoading;
  String? get error;

  /// Create a copy of SyncPlayGroupsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyncPlayGroupsStateCopyWith<SyncPlayGroupsState> get copyWith =>
      _$SyncPlayGroupsStateCopyWithImpl<SyncPlayGroupsState>(this as SyncPlayGroupsState, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SyncPlayGroupsState'))
      ..add(DiagnosticsProperty('groups', groups))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SyncPlayGroupsState(groups: $groups, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class $SyncPlayGroupsStateCopyWith<$Res> {
  factory $SyncPlayGroupsStateCopyWith(SyncPlayGroupsState value, $Res Function(SyncPlayGroupsState) _then) =
      _$SyncPlayGroupsStateCopyWithImpl;
  @useResult
  $Res call({List<GroupInfoDto>? groups, bool isLoading, String? error});
}

/// @nodoc
class _$SyncPlayGroupsStateCopyWithImpl<$Res> implements $SyncPlayGroupsStateCopyWith<$Res> {
  _$SyncPlayGroupsStateCopyWithImpl(this._self, this._then);

  final SyncPlayGroupsState _self;
  final $Res Function(SyncPlayGroupsState) _then;

  /// Create a copy of SyncPlayGroupsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groups = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      groups: freezed == groups
          ? _self.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<GroupInfoDto>?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SyncPlayGroupsState].
extension SyncPlayGroupsStatePatterns on SyncPlayGroupsState {
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
    TResult Function(_SyncPlayGroupsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncPlayGroupsState() when $default != null:
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
    TResult Function(_SyncPlayGroupsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncPlayGroupsState():
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
    TResult? Function(_SyncPlayGroupsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncPlayGroupsState() when $default != null:
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
    TResult Function(List<GroupInfoDto>? groups, bool isLoading, String? error)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncPlayGroupsState() when $default != null:
        return $default(_that.groups, _that.isLoading, _that.error);
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
    TResult Function(List<GroupInfoDto>? groups, bool isLoading, String? error) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncPlayGroupsState():
        return $default(_that.groups, _that.isLoading, _that.error);
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
    TResult? Function(List<GroupInfoDto>? groups, bool isLoading, String? error)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncPlayGroupsState() when $default != null:
        return $default(_that.groups, _that.isLoading, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SyncPlayGroupsState with DiagnosticableTreeMixin implements SyncPlayGroupsState {
  const _SyncPlayGroupsState({final List<GroupInfoDto>? groups, this.isLoading = false, this.error}) : _groups = groups;

  final List<GroupInfoDto>? _groups;
  @override
  List<GroupInfoDto>? get groups {
    final value = _groups;
    if (value == null) return null;
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  /// Create a copy of SyncPlayGroupsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyncPlayGroupsStateCopyWith<_SyncPlayGroupsState> get copyWith =>
      __$SyncPlayGroupsStateCopyWithImpl<_SyncPlayGroupsState>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SyncPlayGroupsState'))
      ..add(DiagnosticsProperty('groups', groups))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SyncPlayGroupsState(groups: $groups, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$SyncPlayGroupsStateCopyWith<$Res> implements $SyncPlayGroupsStateCopyWith<$Res> {
  factory _$SyncPlayGroupsStateCopyWith(_SyncPlayGroupsState value, $Res Function(_SyncPlayGroupsState) _then) =
      __$SyncPlayGroupsStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<GroupInfoDto>? groups, bool isLoading, String? error});
}

/// @nodoc
class __$SyncPlayGroupsStateCopyWithImpl<$Res> implements _$SyncPlayGroupsStateCopyWith<$Res> {
  __$SyncPlayGroupsStateCopyWithImpl(this._self, this._then);

  final _SyncPlayGroupsState _self;
  final $Res Function(_SyncPlayGroupsState) _then;

  /// Create a copy of SyncPlayGroupsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? groups = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_SyncPlayGroupsState(
      groups: freezed == groups
          ? _self._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<GroupInfoDto>?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
