// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_screen_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginScreenModel {
  List<AccountModel> get accounts;
  LoginScreenType get screen;
  ServerLoginModel? get serverLoginModel;
  String? get errorMessage;
  bool get hasBaseUrl;
  bool get loading;

  /// Create a copy of LoginScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginScreenModelCopyWith<LoginScreenModel> get copyWith =>
      _$LoginScreenModelCopyWithImpl<LoginScreenModel>(
          this as LoginScreenModel, _$identity);

  @override
  String toString() {
    return 'LoginScreenModel(accounts: $accounts, screen: $screen, serverLoginModel: $serverLoginModel, errorMessage: $errorMessage, hasBaseUrl: $hasBaseUrl, loading: $loading)';
  }
}

/// @nodoc
abstract mixin class $LoginScreenModelCopyWith<$Res> {
  factory $LoginScreenModelCopyWith(
          LoginScreenModel value, $Res Function(LoginScreenModel) _then) =
      _$LoginScreenModelCopyWithImpl;
  @useResult
  $Res call(
      {List<AccountModel> accounts,
      LoginScreenType screen,
      ServerLoginModel? serverLoginModel,
      String? errorMessage,
      bool hasBaseUrl,
      bool loading});

  $ServerLoginModelCopyWith<$Res>? get serverLoginModel;
}

/// @nodoc
class _$LoginScreenModelCopyWithImpl<$Res>
    implements $LoginScreenModelCopyWith<$Res> {
  _$LoginScreenModelCopyWithImpl(this._self, this._then);

  final LoginScreenModel _self;
  final $Res Function(LoginScreenModel) _then;

  /// Create a copy of LoginScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? screen = null,
    Object? serverLoginModel = freezed,
    Object? errorMessage = freezed,
    Object? hasBaseUrl = null,
    Object? loading = null,
  }) {
    return _then(_self.copyWith(
      accounts: null == accounts
          ? _self.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>,
      screen: null == screen
          ? _self.screen
          : screen // ignore: cast_nullable_to_non_nullable
              as LoginScreenType,
      serverLoginModel: freezed == serverLoginModel
          ? _self.serverLoginModel
          : serverLoginModel // ignore: cast_nullable_to_non_nullable
              as ServerLoginModel?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasBaseUrl: null == hasBaseUrl
          ? _self.hasBaseUrl
          : hasBaseUrl // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of LoginScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServerLoginModelCopyWith<$Res>? get serverLoginModel {
    if (_self.serverLoginModel == null) {
      return null;
    }

    return $ServerLoginModelCopyWith<$Res>(_self.serverLoginModel!, (value) {
      return _then(_self.copyWith(serverLoginModel: value));
    });
  }
}

/// Adds pattern-matching-related methods to [LoginScreenModel].
extension LoginScreenModelPatterns on LoginScreenModel {
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
    TResult Function(_LoginScreenModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginScreenModel() when $default != null:
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
    TResult Function(_LoginScreenModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginScreenModel():
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
    TResult? Function(_LoginScreenModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginScreenModel() when $default != null:
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
            List<AccountModel> accounts,
            LoginScreenType screen,
            ServerLoginModel? serverLoginModel,
            String? errorMessage,
            bool hasBaseUrl,
            bool loading)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginScreenModel() when $default != null:
        return $default(_that.accounts, _that.screen, _that.serverLoginModel,
            _that.errorMessage, _that.hasBaseUrl, _that.loading);
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
            List<AccountModel> accounts,
            LoginScreenType screen,
            ServerLoginModel? serverLoginModel,
            String? errorMessage,
            bool hasBaseUrl,
            bool loading)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginScreenModel():
        return $default(_that.accounts, _that.screen, _that.serverLoginModel,
            _that.errorMessage, _that.hasBaseUrl, _that.loading);
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
            List<AccountModel> accounts,
            LoginScreenType screen,
            ServerLoginModel? serverLoginModel,
            String? errorMessage,
            bool hasBaseUrl,
            bool loading)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginScreenModel() when $default != null:
        return $default(_that.accounts, _that.screen, _that.serverLoginModel,
            _that.errorMessage, _that.hasBaseUrl, _that.loading);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LoginScreenModel implements LoginScreenModel {
  _LoginScreenModel(
      {final List<AccountModel> accounts = const [],
      this.screen = LoginScreenType.users,
      this.serverLoginModel,
      this.errorMessage,
      this.hasBaseUrl = false,
      this.loading = false})
      : _accounts = accounts;

  final List<AccountModel> _accounts;
  @override
  @JsonKey()
  List<AccountModel> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  @JsonKey()
  final LoginScreenType screen;
  @override
  final ServerLoginModel? serverLoginModel;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool hasBaseUrl;
  @override
  @JsonKey()
  final bool loading;

  /// Create a copy of LoginScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginScreenModelCopyWith<_LoginScreenModel> get copyWith =>
      __$LoginScreenModelCopyWithImpl<_LoginScreenModel>(this, _$identity);

  @override
  String toString() {
    return 'LoginScreenModel(accounts: $accounts, screen: $screen, serverLoginModel: $serverLoginModel, errorMessage: $errorMessage, hasBaseUrl: $hasBaseUrl, loading: $loading)';
  }
}

/// @nodoc
abstract mixin class _$LoginScreenModelCopyWith<$Res>
    implements $LoginScreenModelCopyWith<$Res> {
  factory _$LoginScreenModelCopyWith(
          _LoginScreenModel value, $Res Function(_LoginScreenModel) _then) =
      __$LoginScreenModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<AccountModel> accounts,
      LoginScreenType screen,
      ServerLoginModel? serverLoginModel,
      String? errorMessage,
      bool hasBaseUrl,
      bool loading});

  @override
  $ServerLoginModelCopyWith<$Res>? get serverLoginModel;
}

/// @nodoc
class __$LoginScreenModelCopyWithImpl<$Res>
    implements _$LoginScreenModelCopyWith<$Res> {
  __$LoginScreenModelCopyWithImpl(this._self, this._then);

  final _LoginScreenModel _self;
  final $Res Function(_LoginScreenModel) _then;

  /// Create a copy of LoginScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accounts = null,
    Object? screen = null,
    Object? serverLoginModel = freezed,
    Object? errorMessage = freezed,
    Object? hasBaseUrl = null,
    Object? loading = null,
  }) {
    return _then(_LoginScreenModel(
      accounts: null == accounts
          ? _self._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>,
      screen: null == screen
          ? _self.screen
          : screen // ignore: cast_nullable_to_non_nullable
              as LoginScreenType,
      serverLoginModel: freezed == serverLoginModel
          ? _self.serverLoginModel
          : serverLoginModel // ignore: cast_nullable_to_non_nullable
              as ServerLoginModel?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasBaseUrl: null == hasBaseUrl
          ? _self.hasBaseUrl
          : hasBaseUrl // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of LoginScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServerLoginModelCopyWith<$Res>? get serverLoginModel {
    if (_self.serverLoginModel == null) {
      return null;
    }

    return $ServerLoginModelCopyWith<$Res>(_self.serverLoginModel!, (value) {
      return _then(_self.copyWith(serverLoginModel: value));
    });
  }
}

/// @nodoc
mixin _$ServerLoginModel {
  CredentialsModel get tempCredentials;
  List<AccountModel> get accounts;
  String? get serverMessage;
  bool get hasQuickConnect;

  /// Create a copy of ServerLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServerLoginModelCopyWith<ServerLoginModel> get copyWith =>
      _$ServerLoginModelCopyWithImpl<ServerLoginModel>(
          this as ServerLoginModel, _$identity);

  @override
  String toString() {
    return 'ServerLoginModel(tempCredentials: $tempCredentials, accounts: $accounts, serverMessage: $serverMessage, hasQuickConnect: $hasQuickConnect)';
  }
}

/// @nodoc
abstract mixin class $ServerLoginModelCopyWith<$Res> {
  factory $ServerLoginModelCopyWith(
          ServerLoginModel value, $Res Function(ServerLoginModel) _then) =
      _$ServerLoginModelCopyWithImpl;
  @useResult
  $Res call(
      {CredentialsModel tempCredentials,
      List<AccountModel> accounts,
      String? serverMessage,
      bool hasQuickConnect});

  $CredentialsModelCopyWith<$Res> get tempCredentials;
}

/// @nodoc
class _$ServerLoginModelCopyWithImpl<$Res>
    implements $ServerLoginModelCopyWith<$Res> {
  _$ServerLoginModelCopyWithImpl(this._self, this._then);

  final ServerLoginModel _self;
  final $Res Function(ServerLoginModel) _then;

  /// Create a copy of ServerLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempCredentials = null,
    Object? accounts = null,
    Object? serverMessage = freezed,
    Object? hasQuickConnect = null,
  }) {
    return _then(_self.copyWith(
      tempCredentials: null == tempCredentials
          ? _self.tempCredentials
          : tempCredentials // ignore: cast_nullable_to_non_nullable
              as CredentialsModel,
      accounts: null == accounts
          ? _self.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>,
      serverMessage: freezed == serverMessage
          ? _self.serverMessage
          : serverMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasQuickConnect: null == hasQuickConnect
          ? _self.hasQuickConnect
          : hasQuickConnect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of ServerLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialsModelCopyWith<$Res> get tempCredentials {
    return $CredentialsModelCopyWith<$Res>(_self.tempCredentials, (value) {
      return _then(_self.copyWith(tempCredentials: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ServerLoginModel].
extension ServerLoginModelPatterns on ServerLoginModel {
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
    TResult Function(_ServerLoginModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServerLoginModel() when $default != null:
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
    TResult Function(_ServerLoginModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServerLoginModel():
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
    TResult? Function(_ServerLoginModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServerLoginModel() when $default != null:
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
            CredentialsModel tempCredentials,
            List<AccountModel> accounts,
            String? serverMessage,
            bool hasQuickConnect)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServerLoginModel() when $default != null:
        return $default(_that.tempCredentials, _that.accounts,
            _that.serverMessage, _that.hasQuickConnect);
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
            CredentialsModel tempCredentials,
            List<AccountModel> accounts,
            String? serverMessage,
            bool hasQuickConnect)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServerLoginModel():
        return $default(_that.tempCredentials, _that.accounts,
            _that.serverMessage, _that.hasQuickConnect);
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
            CredentialsModel tempCredentials,
            List<AccountModel> accounts,
            String? serverMessage,
            bool hasQuickConnect)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServerLoginModel() when $default != null:
        return $default(_that.tempCredentials, _that.accounts,
            _that.serverMessage, _that.hasQuickConnect);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ServerLoginModel implements ServerLoginModel {
  _ServerLoginModel(
      {required this.tempCredentials,
      final List<AccountModel> accounts = const [],
      this.serverMessage,
      this.hasQuickConnect = false})
      : _accounts = accounts;

  @override
  final CredentialsModel tempCredentials;
  final List<AccountModel> _accounts;
  @override
  @JsonKey()
  List<AccountModel> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  final String? serverMessage;
  @override
  @JsonKey()
  final bool hasQuickConnect;

  /// Create a copy of ServerLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServerLoginModelCopyWith<_ServerLoginModel> get copyWith =>
      __$ServerLoginModelCopyWithImpl<_ServerLoginModel>(this, _$identity);

  @override
  String toString() {
    return 'ServerLoginModel(tempCredentials: $tempCredentials, accounts: $accounts, serverMessage: $serverMessage, hasQuickConnect: $hasQuickConnect)';
  }
}

/// @nodoc
abstract mixin class _$ServerLoginModelCopyWith<$Res>
    implements $ServerLoginModelCopyWith<$Res> {
  factory _$ServerLoginModelCopyWith(
          _ServerLoginModel value, $Res Function(_ServerLoginModel) _then) =
      __$ServerLoginModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {CredentialsModel tempCredentials,
      List<AccountModel> accounts,
      String? serverMessage,
      bool hasQuickConnect});

  @override
  $CredentialsModelCopyWith<$Res> get tempCredentials;
}

/// @nodoc
class __$ServerLoginModelCopyWithImpl<$Res>
    implements _$ServerLoginModelCopyWith<$Res> {
  __$ServerLoginModelCopyWithImpl(this._self, this._then);

  final _ServerLoginModel _self;
  final $Res Function(_ServerLoginModel) _then;

  /// Create a copy of ServerLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tempCredentials = null,
    Object? accounts = null,
    Object? serverMessage = freezed,
    Object? hasQuickConnect = null,
  }) {
    return _then(_ServerLoginModel(
      tempCredentials: null == tempCredentials
          ? _self.tempCredentials
          : tempCredentials // ignore: cast_nullable_to_non_nullable
              as CredentialsModel,
      accounts: null == accounts
          ? _self._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>,
      serverMessage: freezed == serverMessage
          ? _self.serverMessage
          : serverMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasQuickConnect: null == hasQuickConnect
          ? _self.hasQuickConnect
          : hasQuickConnect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of ServerLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialsModelCopyWith<$Res> get tempCredentials {
    return $CredentialsModelCopyWith<$Res>(_self.tempCredentials, (value) {
      return _then(_self.copyWith(tempCredentials: value));
    });
  }
}

// dart format on
