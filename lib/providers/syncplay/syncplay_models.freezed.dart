// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syncplay_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeSyncMeasurement {
  DateTime get requestSent;
  DateTime get requestReceived;
  DateTime get responseSent;
  DateTime get responseReceived;

  /// Create a copy of TimeSyncMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimeSyncMeasurementCopyWith<TimeSyncMeasurement> get copyWith =>
      _$TimeSyncMeasurementCopyWithImpl<TimeSyncMeasurement>(
          this as TimeSyncMeasurement, _$identity);

  @override
  String toString() {
    return 'TimeSyncMeasurement(requestSent: $requestSent, requestReceived: $requestReceived, responseSent: $responseSent, responseReceived: $responseReceived)';
  }
}

/// @nodoc
abstract mixin class $TimeSyncMeasurementCopyWith<$Res> {
  factory $TimeSyncMeasurementCopyWith(
          TimeSyncMeasurement value, $Res Function(TimeSyncMeasurement) _then) =
      _$TimeSyncMeasurementCopyWithImpl;
  @useResult
  $Res call(
      {DateTime requestSent,
      DateTime requestReceived,
      DateTime responseSent,
      DateTime responseReceived});
}

/// @nodoc
class _$TimeSyncMeasurementCopyWithImpl<$Res>
    implements $TimeSyncMeasurementCopyWith<$Res> {
  _$TimeSyncMeasurementCopyWithImpl(this._self, this._then);

  final TimeSyncMeasurement _self;
  final $Res Function(TimeSyncMeasurement) _then;

  /// Create a copy of TimeSyncMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestSent = null,
    Object? requestReceived = null,
    Object? responseSent = null,
    Object? responseReceived = null,
  }) {
    return _then(_self.copyWith(
      requestSent: null == requestSent
          ? _self.requestSent
          : requestSent // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requestReceived: null == requestReceived
          ? _self.requestReceived
          : requestReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
      responseSent: null == responseSent
          ? _self.responseSent
          : responseSent // ignore: cast_nullable_to_non_nullable
              as DateTime,
      responseReceived: null == responseReceived
          ? _self.responseReceived
          : responseReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimeSyncMeasurement].
extension TimeSyncMeasurementPatterns on TimeSyncMeasurement {
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
    TResult Function(_TimeSyncMeasurement value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeSyncMeasurement() when $default != null:
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
    TResult Function(_TimeSyncMeasurement value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeSyncMeasurement():
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
    TResult? Function(_TimeSyncMeasurement value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeSyncMeasurement() when $default != null:
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
    TResult Function(DateTime requestSent, DateTime requestReceived,
            DateTime responseSent, DateTime responseReceived)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeSyncMeasurement() when $default != null:
        return $default(_that.requestSent, _that.requestReceived,
            _that.responseSent, _that.responseReceived);
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
    TResult Function(DateTime requestSent, DateTime requestReceived,
            DateTime responseSent, DateTime responseReceived)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeSyncMeasurement():
        return $default(_that.requestSent, _that.requestReceived,
            _that.responseSent, _that.responseReceived);
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
    TResult? Function(DateTime requestSent, DateTime requestReceived,
            DateTime responseSent, DateTime responseReceived)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeSyncMeasurement() when $default != null:
        return $default(_that.requestSent, _that.requestReceived,
            _that.responseSent, _that.responseReceived);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TimeSyncMeasurement extends TimeSyncMeasurement {
  _TimeSyncMeasurement(
      {required this.requestSent,
      required this.requestReceived,
      required this.responseSent,
      required this.responseReceived})
      : super._();

  @override
  final DateTime requestSent;
  @override
  final DateTime requestReceived;
  @override
  final DateTime responseSent;
  @override
  final DateTime responseReceived;

  /// Create a copy of TimeSyncMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimeSyncMeasurementCopyWith<_TimeSyncMeasurement> get copyWith =>
      __$TimeSyncMeasurementCopyWithImpl<_TimeSyncMeasurement>(
          this, _$identity);

  @override
  String toString() {
    return 'TimeSyncMeasurement(requestSent: $requestSent, requestReceived: $requestReceived, responseSent: $responseSent, responseReceived: $responseReceived)';
  }
}

/// @nodoc
abstract mixin class _$TimeSyncMeasurementCopyWith<$Res>
    implements $TimeSyncMeasurementCopyWith<$Res> {
  factory _$TimeSyncMeasurementCopyWith(_TimeSyncMeasurement value,
          $Res Function(_TimeSyncMeasurement) _then) =
      __$TimeSyncMeasurementCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime requestSent,
      DateTime requestReceived,
      DateTime responseSent,
      DateTime responseReceived});
}

/// @nodoc
class __$TimeSyncMeasurementCopyWithImpl<$Res>
    implements _$TimeSyncMeasurementCopyWith<$Res> {
  __$TimeSyncMeasurementCopyWithImpl(this._self, this._then);

  final _TimeSyncMeasurement _self;
  final $Res Function(_TimeSyncMeasurement) _then;

  /// Create a copy of TimeSyncMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? requestSent = null,
    Object? requestReceived = null,
    Object? responseSent = null,
    Object? responseReceived = null,
  }) {
    return _then(_TimeSyncMeasurement(
      requestSent: null == requestSent
          ? _self.requestSent
          : requestSent // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requestReceived: null == requestReceived
          ? _self.requestReceived
          : requestReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
      responseSent: null == responseSent
          ? _self.responseSent
          : responseSent // ignore: cast_nullable_to_non_nullable
              as DateTime,
      responseReceived: null == responseReceived
          ? _self.responseReceived
          : responseReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$SyncPlayState {
  bool get isConnected;
  bool get isInGroup;
  String? get groupId;
  String? get groupName;
  SyncPlayGroupState get groupState;
  String? get stateReason;
  List<String> get participants;
  String? get playingItemId;
  String? get playlistItemId;
  int get positionTicks;
  DateTime? get lastCommandTime;

  /// Create a copy of SyncPlayState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyncPlayStateCopyWith<SyncPlayState> get copyWith =>
      _$SyncPlayStateCopyWithImpl<SyncPlayState>(
          this as SyncPlayState, _$identity);

  @override
  String toString() {
    return 'SyncPlayState(isConnected: $isConnected, isInGroup: $isInGroup, groupId: $groupId, groupName: $groupName, groupState: $groupState, stateReason: $stateReason, participants: $participants, playingItemId: $playingItemId, playlistItemId: $playlistItemId, positionTicks: $positionTicks, lastCommandTime: $lastCommandTime)';
  }
}

/// @nodoc
abstract mixin class $SyncPlayStateCopyWith<$Res> {
  factory $SyncPlayStateCopyWith(
          SyncPlayState value, $Res Function(SyncPlayState) _then) =
      _$SyncPlayStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isConnected,
      bool isInGroup,
      String? groupId,
      String? groupName,
      SyncPlayGroupState groupState,
      String? stateReason,
      List<String> participants,
      String? playingItemId,
      String? playlistItemId,
      int positionTicks,
      DateTime? lastCommandTime});
}

/// @nodoc
class _$SyncPlayStateCopyWithImpl<$Res>
    implements $SyncPlayStateCopyWith<$Res> {
  _$SyncPlayStateCopyWithImpl(this._self, this._then);

  final SyncPlayState _self;
  final $Res Function(SyncPlayState) _then;

  /// Create a copy of SyncPlayState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? isInGroup = null,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? groupState = null,
    Object? stateReason = freezed,
    Object? participants = null,
    Object? playingItemId = freezed,
    Object? playlistItemId = freezed,
    Object? positionTicks = null,
    Object? lastCommandTime = freezed,
  }) {
    return _then(_self.copyWith(
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isInGroup: null == isInGroup
          ? _self.isInGroup
          : isInGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      groupId: freezed == groupId
          ? _self.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupName: freezed == groupName
          ? _self.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      groupState: null == groupState
          ? _self.groupState
          : groupState // ignore: cast_nullable_to_non_nullable
              as SyncPlayGroupState,
      stateReason: freezed == stateReason
          ? _self.stateReason
          : stateReason // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: null == participants
          ? _self.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playingItemId: freezed == playingItemId
          ? _self.playingItemId
          : playingItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      playlistItemId: freezed == playlistItemId
          ? _self.playlistItemId
          : playlistItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      positionTicks: null == positionTicks
          ? _self.positionTicks
          : positionTicks // ignore: cast_nullable_to_non_nullable
              as int,
      lastCommandTime: freezed == lastCommandTime
          ? _self.lastCommandTime
          : lastCommandTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SyncPlayState].
extension SyncPlayStatePatterns on SyncPlayState {
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
    TResult Function(_SyncPlayState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncPlayState() when $default != null:
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
    TResult Function(_SyncPlayState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncPlayState():
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
    TResult? Function(_SyncPlayState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncPlayState() when $default != null:
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
            bool isConnected,
            bool isInGroup,
            String? groupId,
            String? groupName,
            SyncPlayGroupState groupState,
            String? stateReason,
            List<String> participants,
            String? playingItemId,
            String? playlistItemId,
            int positionTicks,
            DateTime? lastCommandTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncPlayState() when $default != null:
        return $default(
            _that.isConnected,
            _that.isInGroup,
            _that.groupId,
            _that.groupName,
            _that.groupState,
            _that.stateReason,
            _that.participants,
            _that.playingItemId,
            _that.playlistItemId,
            _that.positionTicks,
            _that.lastCommandTime);
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
            bool isConnected,
            bool isInGroup,
            String? groupId,
            String? groupName,
            SyncPlayGroupState groupState,
            String? stateReason,
            List<String> participants,
            String? playingItemId,
            String? playlistItemId,
            int positionTicks,
            DateTime? lastCommandTime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncPlayState():
        return $default(
            _that.isConnected,
            _that.isInGroup,
            _that.groupId,
            _that.groupName,
            _that.groupState,
            _that.stateReason,
            _that.participants,
            _that.playingItemId,
            _that.playlistItemId,
            _that.positionTicks,
            _that.lastCommandTime);
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
            bool isConnected,
            bool isInGroup,
            String? groupId,
            String? groupName,
            SyncPlayGroupState groupState,
            String? stateReason,
            List<String> participants,
            String? playingItemId,
            String? playlistItemId,
            int positionTicks,
            DateTime? lastCommandTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncPlayState() when $default != null:
        return $default(
            _that.isConnected,
            _that.isInGroup,
            _that.groupId,
            _that.groupName,
            _that.groupState,
            _that.stateReason,
            _that.participants,
            _that.playingItemId,
            _that.playlistItemId,
            _that.positionTicks,
            _that.lastCommandTime);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SyncPlayState extends SyncPlayState {
  _SyncPlayState(
      {this.isConnected = false,
      this.isInGroup = false,
      this.groupId,
      this.groupName,
      this.groupState = SyncPlayGroupState.idle,
      this.stateReason,
      final List<String> participants = const [],
      this.playingItemId,
      this.playlistItemId,
      this.positionTicks = 0,
      this.lastCommandTime})
      : _participants = participants,
        super._();

  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final bool isInGroup;
  @override
  final String? groupId;
  @override
  final String? groupName;
  @override
  @JsonKey()
  final SyncPlayGroupState groupState;
  @override
  final String? stateReason;
  final List<String> _participants;
  @override
  @JsonKey()
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final String? playingItemId;
  @override
  final String? playlistItemId;
  @override
  @JsonKey()
  final int positionTicks;
  @override
  final DateTime? lastCommandTime;

  /// Create a copy of SyncPlayState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyncPlayStateCopyWith<_SyncPlayState> get copyWith =>
      __$SyncPlayStateCopyWithImpl<_SyncPlayState>(this, _$identity);

  @override
  String toString() {
    return 'SyncPlayState(isConnected: $isConnected, isInGroup: $isInGroup, groupId: $groupId, groupName: $groupName, groupState: $groupState, stateReason: $stateReason, participants: $participants, playingItemId: $playingItemId, playlistItemId: $playlistItemId, positionTicks: $positionTicks, lastCommandTime: $lastCommandTime)';
  }
}

/// @nodoc
abstract mixin class _$SyncPlayStateCopyWith<$Res>
    implements $SyncPlayStateCopyWith<$Res> {
  factory _$SyncPlayStateCopyWith(
          _SyncPlayState value, $Res Function(_SyncPlayState) _then) =
      __$SyncPlayStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isConnected,
      bool isInGroup,
      String? groupId,
      String? groupName,
      SyncPlayGroupState groupState,
      String? stateReason,
      List<String> participants,
      String? playingItemId,
      String? playlistItemId,
      int positionTicks,
      DateTime? lastCommandTime});
}

/// @nodoc
class __$SyncPlayStateCopyWithImpl<$Res>
    implements _$SyncPlayStateCopyWith<$Res> {
  __$SyncPlayStateCopyWithImpl(this._self, this._then);

  final _SyncPlayState _self;
  final $Res Function(_SyncPlayState) _then;

  /// Create a copy of SyncPlayState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isConnected = null,
    Object? isInGroup = null,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? groupState = null,
    Object? stateReason = freezed,
    Object? participants = null,
    Object? playingItemId = freezed,
    Object? playlistItemId = freezed,
    Object? positionTicks = null,
    Object? lastCommandTime = freezed,
  }) {
    return _then(_SyncPlayState(
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isInGroup: null == isInGroup
          ? _self.isInGroup
          : isInGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      groupId: freezed == groupId
          ? _self.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupName: freezed == groupName
          ? _self.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      groupState: null == groupState
          ? _self.groupState
          : groupState // ignore: cast_nullable_to_non_nullable
              as SyncPlayGroupState,
      stateReason: freezed == stateReason
          ? _self.stateReason
          : stateReason // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: null == participants
          ? _self._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playingItemId: freezed == playingItemId
          ? _self.playingItemId
          : playingItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      playlistItemId: freezed == playlistItemId
          ? _self.playlistItemId
          : playlistItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      positionTicks: null == positionTicks
          ? _self.positionTicks
          : positionTicks // ignore: cast_nullable_to_non_nullable
              as int,
      lastCommandTime: freezed == lastCommandTime
          ? _self.lastCommandTime
          : lastCommandTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$LastSyncPlayCommand {
  String get when;
  int get positionTicks;
  String get command;
  String get playlistItemId;

  /// Create a copy of LastSyncPlayCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LastSyncPlayCommandCopyWith<LastSyncPlayCommand> get copyWith =>
      _$LastSyncPlayCommandCopyWithImpl<LastSyncPlayCommand>(
          this as LastSyncPlayCommand, _$identity);

  @override
  String toString() {
    return 'LastSyncPlayCommand(when: $when, positionTicks: $positionTicks, command: $command, playlistItemId: $playlistItemId)';
  }
}

/// @nodoc
abstract mixin class $LastSyncPlayCommandCopyWith<$Res> {
  factory $LastSyncPlayCommandCopyWith(
          LastSyncPlayCommand value, $Res Function(LastSyncPlayCommand) _then) =
      _$LastSyncPlayCommandCopyWithImpl;
  @useResult
  $Res call(
      {String when, int positionTicks, String command, String playlistItemId});
}

/// @nodoc
class _$LastSyncPlayCommandCopyWithImpl<$Res>
    implements $LastSyncPlayCommandCopyWith<$Res> {
  _$LastSyncPlayCommandCopyWithImpl(this._self, this._then);

  final LastSyncPlayCommand _self;
  final $Res Function(LastSyncPlayCommand) _then;

  /// Create a copy of LastSyncPlayCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? when = null,
    Object? positionTicks = null,
    Object? command = null,
    Object? playlistItemId = null,
  }) {
    return _then(_self.copyWith(
      when: null == when
          ? _self.when
          : when // ignore: cast_nullable_to_non_nullable
              as String,
      positionTicks: null == positionTicks
          ? _self.positionTicks
          : positionTicks // ignore: cast_nullable_to_non_nullable
              as int,
      command: null == command
          ? _self.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      playlistItemId: null == playlistItemId
          ? _self.playlistItemId
          : playlistItemId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [LastSyncPlayCommand].
extension LastSyncPlayCommandPatterns on LastSyncPlayCommand {
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
    TResult Function(_LastSyncPlayCommand value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LastSyncPlayCommand() when $default != null:
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
    TResult Function(_LastSyncPlayCommand value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSyncPlayCommand():
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
    TResult? Function(_LastSyncPlayCommand value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSyncPlayCommand() when $default != null:
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
    TResult Function(String when, int positionTicks, String command,
            String playlistItemId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LastSyncPlayCommand() when $default != null:
        return $default(_that.when, _that.positionTicks, _that.command,
            _that.playlistItemId);
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
    TResult Function(String when, int positionTicks, String command,
            String playlistItemId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSyncPlayCommand():
        return $default(_that.when, _that.positionTicks, _that.command,
            _that.playlistItemId);
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
    TResult? Function(String when, int positionTicks, String command,
            String playlistItemId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSyncPlayCommand() when $default != null:
        return $default(_that.when, _that.positionTicks, _that.command,
            _that.playlistItemId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LastSyncPlayCommand implements LastSyncPlayCommand {
  _LastSyncPlayCommand(
      {required this.when,
      required this.positionTicks,
      required this.command,
      required this.playlistItemId});

  @override
  final String when;
  @override
  final int positionTicks;
  @override
  final String command;
  @override
  final String playlistItemId;

  /// Create a copy of LastSyncPlayCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LastSyncPlayCommandCopyWith<_LastSyncPlayCommand> get copyWith =>
      __$LastSyncPlayCommandCopyWithImpl<_LastSyncPlayCommand>(
          this, _$identity);

  @override
  String toString() {
    return 'LastSyncPlayCommand(when: $when, positionTicks: $positionTicks, command: $command, playlistItemId: $playlistItemId)';
  }
}

/// @nodoc
abstract mixin class _$LastSyncPlayCommandCopyWith<$Res>
    implements $LastSyncPlayCommandCopyWith<$Res> {
  factory _$LastSyncPlayCommandCopyWith(_LastSyncPlayCommand value,
          $Res Function(_LastSyncPlayCommand) _then) =
      __$LastSyncPlayCommandCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String when, int positionTicks, String command, String playlistItemId});
}

/// @nodoc
class __$LastSyncPlayCommandCopyWithImpl<$Res>
    implements _$LastSyncPlayCommandCopyWith<$Res> {
  __$LastSyncPlayCommandCopyWithImpl(this._self, this._then);

  final _LastSyncPlayCommand _self;
  final $Res Function(_LastSyncPlayCommand) _then;

  /// Create a copy of LastSyncPlayCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? when = null,
    Object? positionTicks = null,
    Object? command = null,
    Object? playlistItemId = null,
  }) {
    return _then(_LastSyncPlayCommand(
      when: null == when
          ? _self.when
          : when // ignore: cast_nullable_to_non_nullable
              as String,
      positionTicks: null == positionTicks
          ? _self.positionTicks
          : positionTicks // ignore: cast_nullable_to_non_nullable
              as int,
      command: null == command
          ? _self.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      playlistItemId: null == playlistItemId
          ? _self.playlistItemId
          : playlistItemId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
