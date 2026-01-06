// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_activity_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlActivityModel {
  AccountModel? get user;
  String? get deviceName;
  String? get client;
  String? get applicationVersion;
  String? get activityType;
  ItemBaseModel? get nowPlayingItem;
  TrickPlayModel? get trickPlay;
  ActivityPlayState? get playState;
  DateTime? get lastActivityDate;

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ControlActivityModelCopyWith<ControlActivityModel> get copyWith =>
      _$ControlActivityModelCopyWithImpl<ControlActivityModel>(
          this as ControlActivityModel, _$identity);

  @override
  String toString() {
    return 'ControlActivityModel(user: $user, deviceName: $deviceName, client: $client, applicationVersion: $applicationVersion, activityType: $activityType, nowPlayingItem: $nowPlayingItem, trickPlay: $trickPlay, playState: $playState, lastActivityDate: $lastActivityDate)';
  }
}

/// @nodoc
abstract mixin class $ControlActivityModelCopyWith<$Res> {
  factory $ControlActivityModelCopyWith(ControlActivityModel value,
          $Res Function(ControlActivityModel) _then) =
      _$ControlActivityModelCopyWithImpl;
  @useResult
  $Res call(
      {AccountModel? user,
      String? deviceName,
      String? client,
      String? applicationVersion,
      String? activityType,
      ItemBaseModel? nowPlayingItem,
      TrickPlayModel? trickPlay,
      ActivityPlayState? playState,
      DateTime? lastActivityDate});

  $AccountModelCopyWith<$Res>? get user;
  $TrickPlayModelCopyWith<$Res>? get trickPlay;
  $ActivityPlayStateCopyWith<$Res>? get playState;
}

/// @nodoc
class _$ControlActivityModelCopyWithImpl<$Res>
    implements $ControlActivityModelCopyWith<$Res> {
  _$ControlActivityModelCopyWithImpl(this._self, this._then);

  final ControlActivityModel _self;
  final $Res Function(ControlActivityModel) _then;

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? deviceName = freezed,
    Object? client = freezed,
    Object? applicationVersion = freezed,
    Object? activityType = freezed,
    Object? nowPlayingItem = freezed,
    Object? trickPlay = freezed,
    Object? playState = freezed,
    Object? lastActivityDate = freezed,
  }) {
    return _then(_self.copyWith(
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as AccountModel?,
      deviceName: freezed == deviceName
          ? _self.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      client: freezed == client
          ? _self.client
          : client // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationVersion: freezed == applicationVersion
          ? _self.applicationVersion
          : applicationVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      activityType: freezed == activityType
          ? _self.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String?,
      nowPlayingItem: freezed == nowPlayingItem
          ? _self.nowPlayingItem
          : nowPlayingItem // ignore: cast_nullable_to_non_nullable
              as ItemBaseModel?,
      trickPlay: freezed == trickPlay
          ? _self.trickPlay
          : trickPlay // ignore: cast_nullable_to_non_nullable
              as TrickPlayModel?,
      playState: freezed == playState
          ? _self.playState
          : playState // ignore: cast_nullable_to_non_nullable
              as ActivityPlayState?,
      lastActivityDate: freezed == lastActivityDate
          ? _self.lastActivityDate
          : lastActivityDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountModelCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $AccountModelCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrickPlayModelCopyWith<$Res>? get trickPlay {
    if (_self.trickPlay == null) {
      return null;
    }

    return $TrickPlayModelCopyWith<$Res>(_self.trickPlay!, (value) {
      return _then(_self.copyWith(trickPlay: value));
    });
  }

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityPlayStateCopyWith<$Res>? get playState {
    if (_self.playState == null) {
      return null;
    }

    return $ActivityPlayStateCopyWith<$Res>(_self.playState!, (value) {
      return _then(_self.copyWith(playState: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ControlActivityModel].
extension ControlActivityModelPatterns on ControlActivityModel {
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
    TResult Function(_ControlActivityModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlActivityModel() when $default != null:
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
    TResult Function(_ControlActivityModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlActivityModel():
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
    TResult? Function(_ControlActivityModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlActivityModel() when $default != null:
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
            AccountModel? user,
            String? deviceName,
            String? client,
            String? applicationVersion,
            String? activityType,
            ItemBaseModel? nowPlayingItem,
            TrickPlayModel? trickPlay,
            ActivityPlayState? playState,
            DateTime? lastActivityDate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlActivityModel() when $default != null:
        return $default(
            _that.user,
            _that.deviceName,
            _that.client,
            _that.applicationVersion,
            _that.activityType,
            _that.nowPlayingItem,
            _that.trickPlay,
            _that.playState,
            _that.lastActivityDate);
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
            AccountModel? user,
            String? deviceName,
            String? client,
            String? applicationVersion,
            String? activityType,
            ItemBaseModel? nowPlayingItem,
            TrickPlayModel? trickPlay,
            ActivityPlayState? playState,
            DateTime? lastActivityDate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlActivityModel():
        return $default(
            _that.user,
            _that.deviceName,
            _that.client,
            _that.applicationVersion,
            _that.activityType,
            _that.nowPlayingItem,
            _that.trickPlay,
            _that.playState,
            _that.lastActivityDate);
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
            AccountModel? user,
            String? deviceName,
            String? client,
            String? applicationVersion,
            String? activityType,
            ItemBaseModel? nowPlayingItem,
            TrickPlayModel? trickPlay,
            ActivityPlayState? playState,
            DateTime? lastActivityDate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlActivityModel() when $default != null:
        return $default(
            _that.user,
            _that.deviceName,
            _that.client,
            _that.applicationVersion,
            _that.activityType,
            _that.nowPlayingItem,
            _that.trickPlay,
            _that.playState,
            _that.lastActivityDate);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ControlActivityModel implements ControlActivityModel {
  _ControlActivityModel(
      {this.user,
      this.deviceName,
      this.client,
      this.applicationVersion,
      this.activityType,
      this.nowPlayingItem,
      this.trickPlay,
      this.playState,
      this.lastActivityDate});

  @override
  final AccountModel? user;
  @override
  final String? deviceName;
  @override
  final String? client;
  @override
  final String? applicationVersion;
  @override
  final String? activityType;
  @override
  final ItemBaseModel? nowPlayingItem;
  @override
  final TrickPlayModel? trickPlay;
  @override
  final ActivityPlayState? playState;
  @override
  final DateTime? lastActivityDate;

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ControlActivityModelCopyWith<_ControlActivityModel> get copyWith =>
      __$ControlActivityModelCopyWithImpl<_ControlActivityModel>(
          this, _$identity);

  @override
  String toString() {
    return 'ControlActivityModel(user: $user, deviceName: $deviceName, client: $client, applicationVersion: $applicationVersion, activityType: $activityType, nowPlayingItem: $nowPlayingItem, trickPlay: $trickPlay, playState: $playState, lastActivityDate: $lastActivityDate)';
  }
}

/// @nodoc
abstract mixin class _$ControlActivityModelCopyWith<$Res>
    implements $ControlActivityModelCopyWith<$Res> {
  factory _$ControlActivityModelCopyWith(_ControlActivityModel value,
          $Res Function(_ControlActivityModel) _then) =
      __$ControlActivityModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {AccountModel? user,
      String? deviceName,
      String? client,
      String? applicationVersion,
      String? activityType,
      ItemBaseModel? nowPlayingItem,
      TrickPlayModel? trickPlay,
      ActivityPlayState? playState,
      DateTime? lastActivityDate});

  @override
  $AccountModelCopyWith<$Res>? get user;
  @override
  $TrickPlayModelCopyWith<$Res>? get trickPlay;
  @override
  $ActivityPlayStateCopyWith<$Res>? get playState;
}

/// @nodoc
class __$ControlActivityModelCopyWithImpl<$Res>
    implements _$ControlActivityModelCopyWith<$Res> {
  __$ControlActivityModelCopyWithImpl(this._self, this._then);

  final _ControlActivityModel _self;
  final $Res Function(_ControlActivityModel) _then;

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = freezed,
    Object? deviceName = freezed,
    Object? client = freezed,
    Object? applicationVersion = freezed,
    Object? activityType = freezed,
    Object? nowPlayingItem = freezed,
    Object? trickPlay = freezed,
    Object? playState = freezed,
    Object? lastActivityDate = freezed,
  }) {
    return _then(_ControlActivityModel(
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as AccountModel?,
      deviceName: freezed == deviceName
          ? _self.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      client: freezed == client
          ? _self.client
          : client // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationVersion: freezed == applicationVersion
          ? _self.applicationVersion
          : applicationVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      activityType: freezed == activityType
          ? _self.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String?,
      nowPlayingItem: freezed == nowPlayingItem
          ? _self.nowPlayingItem
          : nowPlayingItem // ignore: cast_nullable_to_non_nullable
              as ItemBaseModel?,
      trickPlay: freezed == trickPlay
          ? _self.trickPlay
          : trickPlay // ignore: cast_nullable_to_non_nullable
              as TrickPlayModel?,
      playState: freezed == playState
          ? _self.playState
          : playState // ignore: cast_nullable_to_non_nullable
              as ActivityPlayState?,
      lastActivityDate: freezed == lastActivityDate
          ? _self.lastActivityDate
          : lastActivityDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountModelCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $AccountModelCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrickPlayModelCopyWith<$Res>? get trickPlay {
    if (_self.trickPlay == null) {
      return null;
    }

    return $TrickPlayModelCopyWith<$Res>(_self.trickPlay!, (value) {
      return _then(_self.copyWith(trickPlay: value));
    });
  }

  /// Create a copy of ControlActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityPlayStateCopyWith<$Res>? get playState {
    if (_self.playState == null) {
      return null;
    }

    return $ActivityPlayStateCopyWith<$Res>(_self.playState!, (value) {
      return _then(_self.copyWith(playState: value));
    });
  }
}

/// @nodoc
mixin _$ActivityPlayState {
  Duration get currentPosition;
  String? get playMethod;
  bool? get isPaused;

  /// Create a copy of ActivityPlayState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActivityPlayStateCopyWith<ActivityPlayState> get copyWith =>
      _$ActivityPlayStateCopyWithImpl<ActivityPlayState>(
          this as ActivityPlayState, _$identity);

  @override
  String toString() {
    return 'ActivityPlayState(currentPosition: $currentPosition, playMethod: $playMethod, isPaused: $isPaused)';
  }
}

/// @nodoc
abstract mixin class $ActivityPlayStateCopyWith<$Res> {
  factory $ActivityPlayStateCopyWith(
          ActivityPlayState value, $Res Function(ActivityPlayState) _then) =
      _$ActivityPlayStateCopyWithImpl;
  @useResult
  $Res call({Duration currentPosition, String? playMethod, bool? isPaused});
}

/// @nodoc
class _$ActivityPlayStateCopyWithImpl<$Res>
    implements $ActivityPlayStateCopyWith<$Res> {
  _$ActivityPlayStateCopyWithImpl(this._self, this._then);

  final ActivityPlayState _self;
  final $Res Function(ActivityPlayState) _then;

  /// Create a copy of ActivityPlayState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPosition = null,
    Object? playMethod = freezed,
    Object? isPaused = freezed,
  }) {
    return _then(_self.copyWith(
      currentPosition: null == currentPosition
          ? _self.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Duration,
      playMethod: freezed == playMethod
          ? _self.playMethod
          : playMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      isPaused: freezed == isPaused
          ? _self.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ActivityPlayState].
extension ActivityPlayStatePatterns on ActivityPlayState {
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
    TResult Function(_ActivityPlayState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActivityPlayState() when $default != null:
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
    TResult Function(_ActivityPlayState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivityPlayState():
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
    TResult? Function(_ActivityPlayState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivityPlayState() when $default != null:
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
            Duration currentPosition, String? playMethod, bool? isPaused)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActivityPlayState() when $default != null:
        return $default(
            _that.currentPosition, _that.playMethod, _that.isPaused);
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
            Duration currentPosition, String? playMethod, bool? isPaused)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivityPlayState():
        return $default(
            _that.currentPosition, _that.playMethod, _that.isPaused);
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
            Duration currentPosition, String? playMethod, bool? isPaused)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivityPlayState() when $default != null:
        return $default(
            _that.currentPosition, _that.playMethod, _that.isPaused);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ActivityPlayState implements ActivityPlayState {
  _ActivityPlayState(
      {required this.currentPosition, this.playMethod, this.isPaused});

  @override
  final Duration currentPosition;
  @override
  final String? playMethod;
  @override
  final bool? isPaused;

  /// Create a copy of ActivityPlayState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActivityPlayStateCopyWith<_ActivityPlayState> get copyWith =>
      __$ActivityPlayStateCopyWithImpl<_ActivityPlayState>(this, _$identity);

  @override
  String toString() {
    return 'ActivityPlayState(currentPosition: $currentPosition, playMethod: $playMethod, isPaused: $isPaused)';
  }
}

/// @nodoc
abstract mixin class _$ActivityPlayStateCopyWith<$Res>
    implements $ActivityPlayStateCopyWith<$Res> {
  factory _$ActivityPlayStateCopyWith(
          _ActivityPlayState value, $Res Function(_ActivityPlayState) _then) =
      __$ActivityPlayStateCopyWithImpl;
  @override
  @useResult
  $Res call({Duration currentPosition, String? playMethod, bool? isPaused});
}

/// @nodoc
class __$ActivityPlayStateCopyWithImpl<$Res>
    implements _$ActivityPlayStateCopyWith<$Res> {
  __$ActivityPlayStateCopyWithImpl(this._self, this._then);

  final _ActivityPlayState _self;
  final $Res Function(_ActivityPlayState) _then;

  /// Create a copy of ActivityPlayState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentPosition = null,
    Object? playMethod = freezed,
    Object? isPaused = freezed,
  }) {
    return _then(_ActivityPlayState(
      currentPosition: null == currentPosition
          ? _self.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Duration,
      playMethod: freezed == playMethod
          ? _self.playMethod
          : playMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      isPaused: freezed == isPaused
          ? _self.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
