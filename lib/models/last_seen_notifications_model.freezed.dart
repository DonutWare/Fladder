// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_seen_notifications_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LastSeenNotificationsModel {
  List<LastSeenModel> get lastSeen;
  DateTime? get updatedAt;

  /// Create a copy of LastSeenNotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LastSeenNotificationsModelCopyWith<LastSeenNotificationsModel>
      get copyWith =>
          _$LastSeenNotificationsModelCopyWithImpl<LastSeenNotificationsModel>(
              this as LastSeenNotificationsModel, _$identity);

  /// Serializes this LastSeenNotificationsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'LastSeenNotificationsModel(lastSeen: $lastSeen, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $LastSeenNotificationsModelCopyWith<$Res> {
  factory $LastSeenNotificationsModelCopyWith(LastSeenNotificationsModel value,
          $Res Function(LastSeenNotificationsModel) _then) =
      _$LastSeenNotificationsModelCopyWithImpl;
  @useResult
  $Res call({List<LastSeenModel> lastSeen, DateTime? updatedAt});
}

/// @nodoc
class _$LastSeenNotificationsModelCopyWithImpl<$Res>
    implements $LastSeenNotificationsModelCopyWith<$Res> {
  _$LastSeenNotificationsModelCopyWithImpl(this._self, this._then);

  final LastSeenNotificationsModel _self;
  final $Res Function(LastSeenNotificationsModel) _then;

  /// Create a copy of LastSeenNotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSeen = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      lastSeen: null == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as List<LastSeenModel>,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LastSeenNotificationsModel].
extension LastSeenNotificationsModelPatterns on LastSeenNotificationsModel {
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
    TResult Function(_LastSeenNotificationsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LastSeenNotificationsModel() when $default != null:
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
    TResult Function(_LastSeenNotificationsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSeenNotificationsModel():
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
    TResult? Function(_LastSeenNotificationsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSeenNotificationsModel() when $default != null:
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
    TResult Function(List<LastSeenModel> lastSeen, DateTime? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LastSeenNotificationsModel() when $default != null:
        return $default(_that.lastSeen, _that.updatedAt);
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
    TResult Function(List<LastSeenModel> lastSeen, DateTime? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSeenNotificationsModel():
        return $default(_that.lastSeen, _that.updatedAt);
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
    TResult? Function(List<LastSeenModel> lastSeen, DateTime? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSeenNotificationsModel() when $default != null:
        return $default(_that.lastSeen, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LastSeenNotificationsModel extends LastSeenNotificationsModel {
  const _LastSeenNotificationsModel(
      {final List<LastSeenModel> lastSeen = const [], this.updatedAt})
      : _lastSeen = lastSeen,
        super._();
  factory _LastSeenNotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$LastSeenNotificationsModelFromJson(json);

  final List<LastSeenModel> _lastSeen;
  @override
  @JsonKey()
  List<LastSeenModel> get lastSeen {
    if (_lastSeen is EqualUnmodifiableListView) return _lastSeen;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lastSeen);
  }

  @override
  final DateTime? updatedAt;

  /// Create a copy of LastSeenNotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LastSeenNotificationsModelCopyWith<_LastSeenNotificationsModel>
      get copyWith => __$LastSeenNotificationsModelCopyWithImpl<
          _LastSeenNotificationsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LastSeenNotificationsModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'LastSeenNotificationsModel(lastSeen: $lastSeen, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$LastSeenNotificationsModelCopyWith<$Res>
    implements $LastSeenNotificationsModelCopyWith<$Res> {
  factory _$LastSeenNotificationsModelCopyWith(
          _LastSeenNotificationsModel value,
          $Res Function(_LastSeenNotificationsModel) _then) =
      __$LastSeenNotificationsModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<LastSeenModel> lastSeen, DateTime? updatedAt});
}

/// @nodoc
class __$LastSeenNotificationsModelCopyWithImpl<$Res>
    implements _$LastSeenNotificationsModelCopyWith<$Res> {
  __$LastSeenNotificationsModelCopyWithImpl(this._self, this._then);

  final _LastSeenNotificationsModel _self;
  final $Res Function(_LastSeenNotificationsModel) _then;

  /// Create a copy of LastSeenNotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastSeen = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_LastSeenNotificationsModel(
      lastSeen: null == lastSeen
          ? _self._lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as List<LastSeenModel>,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$LastSeenModel {
  String get userId;
  List<String> get lastSeenIds;

  /// Create a copy of LastSeenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LastSeenModelCopyWith<LastSeenModel> get copyWith =>
      _$LastSeenModelCopyWithImpl<LastSeenModel>(
          this as LastSeenModel, _$identity);

  /// Serializes this LastSeenModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'LastSeenModel(userId: $userId, lastSeenIds: $lastSeenIds)';
  }
}

/// @nodoc
abstract mixin class $LastSeenModelCopyWith<$Res> {
  factory $LastSeenModelCopyWith(
          LastSeenModel value, $Res Function(LastSeenModel) _then) =
      _$LastSeenModelCopyWithImpl;
  @useResult
  $Res call({String userId, List<String> lastSeenIds});
}

/// @nodoc
class _$LastSeenModelCopyWithImpl<$Res>
    implements $LastSeenModelCopyWith<$Res> {
  _$LastSeenModelCopyWithImpl(this._self, this._then);

  final LastSeenModel _self;
  final $Res Function(LastSeenModel) _then;

  /// Create a copy of LastSeenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? lastSeenIds = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      lastSeenIds: null == lastSeenIds
          ? _self.lastSeenIds
          : lastSeenIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LastSeenModel].
extension LastSeenModelPatterns on LastSeenModel {
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
    TResult Function(_LastSeenModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LastSeenModel() when $default != null:
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
    TResult Function(_LastSeenModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSeenModel():
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
    TResult? Function(_LastSeenModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSeenModel() when $default != null:
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
    TResult Function(String userId, List<String> lastSeenIds)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LastSeenModel() when $default != null:
        return $default(_that.userId, _that.lastSeenIds);
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
    TResult Function(String userId, List<String> lastSeenIds) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSeenModel():
        return $default(_that.userId, _that.lastSeenIds);
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
    TResult? Function(String userId, List<String> lastSeenIds)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LastSeenModel() when $default != null:
        return $default(_that.userId, _that.lastSeenIds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LastSeenModel extends LastSeenModel {
  const _LastSeenModel(
      {required this.userId, final List<String> lastSeenIds = const <String>[]})
      : _lastSeenIds = lastSeenIds,
        super._();
  factory _LastSeenModel.fromJson(Map<String, dynamic> json) =>
      _$LastSeenModelFromJson(json);

  @override
  final String userId;
  final List<String> _lastSeenIds;
  @override
  @JsonKey()
  List<String> get lastSeenIds {
    if (_lastSeenIds is EqualUnmodifiableListView) return _lastSeenIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lastSeenIds);
  }

  /// Create a copy of LastSeenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LastSeenModelCopyWith<_LastSeenModel> get copyWith =>
      __$LastSeenModelCopyWithImpl<_LastSeenModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LastSeenModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'LastSeenModel(userId: $userId, lastSeenIds: $lastSeenIds)';
  }
}

/// @nodoc
abstract mixin class _$LastSeenModelCopyWith<$Res>
    implements $LastSeenModelCopyWith<$Res> {
  factory _$LastSeenModelCopyWith(
          _LastSeenModel value, $Res Function(_LastSeenModel) _then) =
      __$LastSeenModelCopyWithImpl;
  @override
  @useResult
  $Res call({String userId, List<String> lastSeenIds});
}

/// @nodoc
class __$LastSeenModelCopyWithImpl<$Res>
    implements _$LastSeenModelCopyWith<$Res> {
  __$LastSeenModelCopyWithImpl(this._self, this._then);

  final _LastSeenModel _self;
  final $Res Function(_LastSeenModel) _then;

  /// Create a copy of LastSeenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? lastSeenIds = null,
  }) {
    return _then(_LastSeenModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      lastSeenIds: null == lastSeenIds
          ? _self._lastSeenIds
          : lastSeenIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
