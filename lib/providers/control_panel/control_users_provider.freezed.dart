// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_users_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlUsersModel {
  List<AccountModel> get users;
  List<ViewModel> get views;
  AccountModel? get selectedUser;
  UserPolicy? get editingPolicy;
  List<DeviceInfoDto>? get availableDevices;
  List<ParentalRating>? get parentalRatings;

  /// Create a copy of ControlUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ControlUsersModelCopyWith<ControlUsersModel> get copyWith =>
      _$ControlUsersModelCopyWithImpl<ControlUsersModel>(
          this as ControlUsersModel, _$identity);

  @override
  String toString() {
    return 'ControlUsersModel(users: $users, views: $views, selectedUser: $selectedUser, editingPolicy: $editingPolicy, availableDevices: $availableDevices, parentalRatings: $parentalRatings)';
  }
}

/// @nodoc
abstract mixin class $ControlUsersModelCopyWith<$Res> {
  factory $ControlUsersModelCopyWith(
          ControlUsersModel value, $Res Function(ControlUsersModel) _then) =
      _$ControlUsersModelCopyWithImpl;
  @useResult
  $Res call(
      {List<AccountModel> users,
      List<ViewModel> views,
      AccountModel? selectedUser,
      UserPolicy? editingPolicy,
      List<DeviceInfoDto>? availableDevices,
      List<ParentalRating>? parentalRatings});

  $AccountModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class _$ControlUsersModelCopyWithImpl<$Res>
    implements $ControlUsersModelCopyWith<$Res> {
  _$ControlUsersModelCopyWithImpl(this._self, this._then);

  final ControlUsersModel _self;
  final $Res Function(ControlUsersModel) _then;

  /// Create a copy of ControlUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? views = null,
    Object? selectedUser = freezed,
    Object? editingPolicy = freezed,
    Object? availableDevices = freezed,
    Object? parentalRatings = freezed,
  }) {
    return _then(_self.copyWith(
      users: null == users
          ? _self.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>,
      views: null == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as List<ViewModel>,
      selectedUser: freezed == selectedUser
          ? _self.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as AccountModel?,
      editingPolicy: freezed == editingPolicy
          ? _self.editingPolicy
          : editingPolicy // ignore: cast_nullable_to_non_nullable
              as UserPolicy?,
      availableDevices: freezed == availableDevices
          ? _self.availableDevices
          : availableDevices // ignore: cast_nullable_to_non_nullable
              as List<DeviceInfoDto>?,
      parentalRatings: freezed == parentalRatings
          ? _self.parentalRatings
          : parentalRatings // ignore: cast_nullable_to_non_nullable
              as List<ParentalRating>?,
    ));
  }

  /// Create a copy of ControlUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountModelCopyWith<$Res>? get selectedUser {
    if (_self.selectedUser == null) {
      return null;
    }

    return $AccountModelCopyWith<$Res>(_self.selectedUser!, (value) {
      return _then(_self.copyWith(selectedUser: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ControlUsersModel].
extension ControlUsersModelPatterns on ControlUsersModel {
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
    TResult Function(_ControlUsersModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlUsersModel() when $default != null:
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
    TResult Function(_ControlUsersModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlUsersModel():
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
    TResult? Function(_ControlUsersModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlUsersModel() when $default != null:
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
            List<AccountModel> users,
            List<ViewModel> views,
            AccountModel? selectedUser,
            UserPolicy? editingPolicy,
            List<DeviceInfoDto>? availableDevices,
            List<ParentalRating>? parentalRatings)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlUsersModel() when $default != null:
        return $default(_that.users, _that.views, _that.selectedUser,
            _that.editingPolicy, _that.availableDevices, _that.parentalRatings);
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
            List<AccountModel> users,
            List<ViewModel> views,
            AccountModel? selectedUser,
            UserPolicy? editingPolicy,
            List<DeviceInfoDto>? availableDevices,
            List<ParentalRating>? parentalRatings)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlUsersModel():
        return $default(_that.users, _that.views, _that.selectedUser,
            _that.editingPolicy, _that.availableDevices, _that.parentalRatings);
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
            List<AccountModel> users,
            List<ViewModel> views,
            AccountModel? selectedUser,
            UserPolicy? editingPolicy,
            List<DeviceInfoDto>? availableDevices,
            List<ParentalRating>? parentalRatings)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlUsersModel() when $default != null:
        return $default(_that.users, _that.views, _that.selectedUser,
            _that.editingPolicy, _that.availableDevices, _that.parentalRatings);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ControlUsersModel implements ControlUsersModel {
  _ControlUsersModel(
      {final List<AccountModel> users = const [],
      final List<ViewModel> views = const [],
      this.selectedUser,
      this.editingPolicy,
      final List<DeviceInfoDto>? availableDevices,
      final List<ParentalRating>? parentalRatings})
      : _users = users,
        _views = views,
        _availableDevices = availableDevices,
        _parentalRatings = parentalRatings;

  final List<AccountModel> _users;
  @override
  @JsonKey()
  List<AccountModel> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  final List<ViewModel> _views;
  @override
  @JsonKey()
  List<ViewModel> get views {
    if (_views is EqualUnmodifiableListView) return _views;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_views);
  }

  @override
  final AccountModel? selectedUser;
  @override
  final UserPolicy? editingPolicy;
  final List<DeviceInfoDto>? _availableDevices;
  @override
  List<DeviceInfoDto>? get availableDevices {
    final value = _availableDevices;
    if (value == null) return null;
    if (_availableDevices is EqualUnmodifiableListView)
      return _availableDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ParentalRating>? _parentalRatings;
  @override
  List<ParentalRating>? get parentalRatings {
    final value = _parentalRatings;
    if (value == null) return null;
    if (_parentalRatings is EqualUnmodifiableListView) return _parentalRatings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of ControlUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ControlUsersModelCopyWith<_ControlUsersModel> get copyWith =>
      __$ControlUsersModelCopyWithImpl<_ControlUsersModel>(this, _$identity);

  @override
  String toString() {
    return 'ControlUsersModel(users: $users, views: $views, selectedUser: $selectedUser, editingPolicy: $editingPolicy, availableDevices: $availableDevices, parentalRatings: $parentalRatings)';
  }
}

/// @nodoc
abstract mixin class _$ControlUsersModelCopyWith<$Res>
    implements $ControlUsersModelCopyWith<$Res> {
  factory _$ControlUsersModelCopyWith(
          _ControlUsersModel value, $Res Function(_ControlUsersModel) _then) =
      __$ControlUsersModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<AccountModel> users,
      List<ViewModel> views,
      AccountModel? selectedUser,
      UserPolicy? editingPolicy,
      List<DeviceInfoDto>? availableDevices,
      List<ParentalRating>? parentalRatings});

  @override
  $AccountModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class __$ControlUsersModelCopyWithImpl<$Res>
    implements _$ControlUsersModelCopyWith<$Res> {
  __$ControlUsersModelCopyWithImpl(this._self, this._then);

  final _ControlUsersModel _self;
  final $Res Function(_ControlUsersModel) _then;

  /// Create a copy of ControlUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? users = null,
    Object? views = null,
    Object? selectedUser = freezed,
    Object? editingPolicy = freezed,
    Object? availableDevices = freezed,
    Object? parentalRatings = freezed,
  }) {
    return _then(_ControlUsersModel(
      users: null == users
          ? _self._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>,
      views: null == views
          ? _self._views
          : views // ignore: cast_nullable_to_non_nullable
              as List<ViewModel>,
      selectedUser: freezed == selectedUser
          ? _self.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as AccountModel?,
      editingPolicy: freezed == editingPolicy
          ? _self.editingPolicy
          : editingPolicy // ignore: cast_nullable_to_non_nullable
              as UserPolicy?,
      availableDevices: freezed == availableDevices
          ? _self._availableDevices
          : availableDevices // ignore: cast_nullable_to_non_nullable
              as List<DeviceInfoDto>?,
      parentalRatings: freezed == parentalRatings
          ? _self._parentalRatings
          : parentalRatings // ignore: cast_nullable_to_non_nullable
              as List<ParentalRating>?,
    ));
  }

  /// Create a copy of ControlUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountModelCopyWith<$Res>? get selectedUser {
    if (_self.selectedUser == null) {
      return null;
    }

    return $AccountModelCopyWith<$Res>(_self.selectedUser!, (value) {
      return _then(_self.copyWith(selectedUser: value));
    });
  }
}

// dart format on
