// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel implements DiagnosticableTreeMixin {
  String get name;
  String get id;
  String get avatar;
  DateTime get lastUsed;
  Authentication get authMethod;
  String get localPin;
  @CredentialsConverter()
  CredentialsModel get credentials;
  SeerrCredentialsModel? get seerrCredentials;
  List<String> get latestItemsExcludes;
  List<String> get searchQueryHistory;
  bool get quickConnectState;
  List<LibraryFiltersModel> get libraryFilters;
  bool get updateNotificationsEnabled;
  bool get seerrRequestsEnabled;
  bool get includeHiddenViews; //Server values not stored in the database
  @JsonKey(includeFromJson: false, includeToJson: false)
  UserPolicy? get policy;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ServerConfiguration? get serverConfiguration;
  @JsonKey(includeFromJson: false, includeToJson: false)
  UserConfiguration? get userConfiguration;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? get hasPassword;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? get hasConfiguredPassword;
  UserSettings? get userSettings;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountModelCopyWith<AccountModel> get copyWith =>
      _$AccountModelCopyWithImpl<AccountModel>(
          this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'AccountModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('lastUsed', lastUsed))
      ..add(DiagnosticsProperty('authMethod', authMethod))
      ..add(DiagnosticsProperty('localPin', localPin))
      ..add(DiagnosticsProperty('credentials', credentials))
      ..add(DiagnosticsProperty('seerrCredentials', seerrCredentials))
      ..add(DiagnosticsProperty('latestItemsExcludes', latestItemsExcludes))
      ..add(DiagnosticsProperty('searchQueryHistory', searchQueryHistory))
      ..add(DiagnosticsProperty('quickConnectState', quickConnectState))
      ..add(DiagnosticsProperty('libraryFilters', libraryFilters))
      ..add(DiagnosticsProperty(
          'updateNotificationsEnabled', updateNotificationsEnabled))
      ..add(DiagnosticsProperty('seerrRequestsEnabled', seerrRequestsEnabled))
      ..add(DiagnosticsProperty('includeHiddenViews', includeHiddenViews))
      ..add(DiagnosticsProperty('policy', policy))
      ..add(DiagnosticsProperty('serverConfiguration', serverConfiguration))
      ..add(DiagnosticsProperty('userConfiguration', userConfiguration))
      ..add(DiagnosticsProperty('hasPassword', hasPassword))
      ..add(DiagnosticsProperty('hasConfiguredPassword', hasConfiguredPassword))
      ..add(DiagnosticsProperty('userSettings', userSettings));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountModel(name: $name, id: $id, avatar: $avatar, lastUsed: $lastUsed, authMethod: $authMethod, localPin: $localPin, credentials: $credentials, seerrCredentials: $seerrCredentials, latestItemsExcludes: $latestItemsExcludes, searchQueryHistory: $searchQueryHistory, quickConnectState: $quickConnectState, libraryFilters: $libraryFilters, updateNotificationsEnabled: $updateNotificationsEnabled, seerrRequestsEnabled: $seerrRequestsEnabled, includeHiddenViews: $includeHiddenViews, policy: $policy, serverConfiguration: $serverConfiguration, userConfiguration: $userConfiguration, hasPassword: $hasPassword, hasConfiguredPassword: $hasConfiguredPassword, userSettings: $userSettings)';
  }
}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res> {
  factory $AccountModelCopyWith(
          AccountModel value, $Res Function(AccountModel) _then) =
      _$AccountModelCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String id,
      String avatar,
      DateTime lastUsed,
      Authentication authMethod,
      String localPin,
      @CredentialsConverter() CredentialsModel credentials,
      SeerrCredentialsModel? seerrCredentials,
      List<String> latestItemsExcludes,
      List<String> searchQueryHistory,
      bool quickConnectState,
      List<LibraryFiltersModel> libraryFilters,
      bool updateNotificationsEnabled,
      bool seerrRequestsEnabled,
      bool includeHiddenViews,
      @JsonKey(includeFromJson: false, includeToJson: false) UserPolicy? policy,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ServerConfiguration? serverConfiguration,
      @JsonKey(includeFromJson: false, includeToJson: false)
      UserConfiguration? userConfiguration,
      @JsonKey(includeFromJson: false, includeToJson: false) bool? hasPassword,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool? hasConfiguredPassword,
      UserSettings? userSettings});

  $CredentialsModelCopyWith<$Res> get credentials;
  $SeerrCredentialsModelCopyWith<$Res>? get seerrCredentials;
  $UserSettingsCopyWith<$Res>? get userSettings;
}

/// @nodoc
class _$AccountModelCopyWithImpl<$Res> implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? avatar = null,
    Object? lastUsed = null,
    Object? authMethod = null,
    Object? localPin = null,
    Object? credentials = null,
    Object? seerrCredentials = freezed,
    Object? latestItemsExcludes = null,
    Object? searchQueryHistory = null,
    Object? quickConnectState = null,
    Object? libraryFilters = null,
    Object? updateNotificationsEnabled = null,
    Object? seerrRequestsEnabled = null,
    Object? includeHiddenViews = null,
    Object? policy = freezed,
    Object? serverConfiguration = freezed,
    Object? userConfiguration = freezed,
    Object? hasPassword = freezed,
    Object? hasConfiguredPassword = freezed,
    Object? userSettings = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      lastUsed: null == lastUsed
          ? _self.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authMethod: null == authMethod
          ? _self.authMethod
          : authMethod // ignore: cast_nullable_to_non_nullable
              as Authentication,
      localPin: null == localPin
          ? _self.localPin
          : localPin // ignore: cast_nullable_to_non_nullable
              as String,
      credentials: null == credentials
          ? _self.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as CredentialsModel,
      seerrCredentials: freezed == seerrCredentials
          ? _self.seerrCredentials
          : seerrCredentials // ignore: cast_nullable_to_non_nullable
              as SeerrCredentialsModel?,
      latestItemsExcludes: null == latestItemsExcludes
          ? _self.latestItemsExcludes
          : latestItemsExcludes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchQueryHistory: null == searchQueryHistory
          ? _self.searchQueryHistory
          : searchQueryHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quickConnectState: null == quickConnectState
          ? _self.quickConnectState
          : quickConnectState // ignore: cast_nullable_to_non_nullable
              as bool,
      libraryFilters: null == libraryFilters
          ? _self.libraryFilters
          : libraryFilters // ignore: cast_nullable_to_non_nullable
              as List<LibraryFiltersModel>,
      updateNotificationsEnabled: null == updateNotificationsEnabled
          ? _self.updateNotificationsEnabled
          : updateNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      seerrRequestsEnabled: null == seerrRequestsEnabled
          ? _self.seerrRequestsEnabled
          : seerrRequestsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      includeHiddenViews: null == includeHiddenViews
          ? _self.includeHiddenViews
          : includeHiddenViews // ignore: cast_nullable_to_non_nullable
              as bool,
      policy: freezed == policy
          ? _self.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as UserPolicy?,
      serverConfiguration: freezed == serverConfiguration
          ? _self.serverConfiguration
          : serverConfiguration // ignore: cast_nullable_to_non_nullable
              as ServerConfiguration?,
      userConfiguration: freezed == userConfiguration
          ? _self.userConfiguration
          : userConfiguration // ignore: cast_nullable_to_non_nullable
              as UserConfiguration?,
      hasPassword: freezed == hasPassword
          ? _self.hasPassword
          : hasPassword // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasConfiguredPassword: freezed == hasConfiguredPassword
          ? _self.hasConfiguredPassword
          : hasConfiguredPassword // ignore: cast_nullable_to_non_nullable
              as bool?,
      userSettings: freezed == userSettings
          ? _self.userSettings
          : userSettings // ignore: cast_nullable_to_non_nullable
              as UserSettings?,
    ));
  }

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialsModelCopyWith<$Res> get credentials {
    return $CredentialsModelCopyWith<$Res>(_self.credentials, (value) {
      return _then(_self.copyWith(credentials: value));
    });
  }

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrCredentialsModelCopyWith<$Res>? get seerrCredentials {
    if (_self.seerrCredentials == null) {
      return null;
    }

    return $SeerrCredentialsModelCopyWith<$Res>(_self.seerrCredentials!,
        (value) {
      return _then(_self.copyWith(seerrCredentials: value));
    });
  }

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<$Res>? get userSettings {
    if (_self.userSettings == null) {
      return null;
    }

    return $UserSettingsCopyWith<$Res>(_self.userSettings!, (value) {
      return _then(_self.copyWith(userSettings: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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
    TResult Function(_AccountModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccountModel() when $default != null:
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
    TResult Function(_AccountModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccountModel():
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
    TResult? Function(_AccountModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccountModel() when $default != null:
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
            String name,
            String id,
            String avatar,
            DateTime lastUsed,
            Authentication authMethod,
            String localPin,
            @CredentialsConverter() CredentialsModel credentials,
            SeerrCredentialsModel? seerrCredentials,
            List<String> latestItemsExcludes,
            List<String> searchQueryHistory,
            bool quickConnectState,
            List<LibraryFiltersModel> libraryFilters,
            bool updateNotificationsEnabled,
            bool seerrRequestsEnabled,
            bool includeHiddenViews,
            @JsonKey(includeFromJson: false, includeToJson: false)
            UserPolicy? policy,
            @JsonKey(includeFromJson: false, includeToJson: false)
            ServerConfiguration? serverConfiguration,
            @JsonKey(includeFromJson: false, includeToJson: false)
            UserConfiguration? userConfiguration,
            @JsonKey(includeFromJson: false, includeToJson: false)
            bool? hasPassword,
            @JsonKey(includeFromJson: false, includeToJson: false)
            bool? hasConfiguredPassword,
            UserSettings? userSettings)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccountModel() when $default != null:
        return $default(
            _that.name,
            _that.id,
            _that.avatar,
            _that.lastUsed,
            _that.authMethod,
            _that.localPin,
            _that.credentials,
            _that.seerrCredentials,
            _that.latestItemsExcludes,
            _that.searchQueryHistory,
            _that.quickConnectState,
            _that.libraryFilters,
            _that.updateNotificationsEnabled,
            _that.seerrRequestsEnabled,
            _that.includeHiddenViews,
            _that.policy,
            _that.serverConfiguration,
            _that.userConfiguration,
            _that.hasPassword,
            _that.hasConfiguredPassword,
            _that.userSettings);
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
            String name,
            String id,
            String avatar,
            DateTime lastUsed,
            Authentication authMethod,
            String localPin,
            @CredentialsConverter() CredentialsModel credentials,
            SeerrCredentialsModel? seerrCredentials,
            List<String> latestItemsExcludes,
            List<String> searchQueryHistory,
            bool quickConnectState,
            List<LibraryFiltersModel> libraryFilters,
            bool updateNotificationsEnabled,
            bool seerrRequestsEnabled,
            bool includeHiddenViews,
            @JsonKey(includeFromJson: false, includeToJson: false)
            UserPolicy? policy,
            @JsonKey(includeFromJson: false, includeToJson: false)
            ServerConfiguration? serverConfiguration,
            @JsonKey(includeFromJson: false, includeToJson: false)
            UserConfiguration? userConfiguration,
            @JsonKey(includeFromJson: false, includeToJson: false)
            bool? hasPassword,
            @JsonKey(includeFromJson: false, includeToJson: false)
            bool? hasConfiguredPassword,
            UserSettings? userSettings)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccountModel():
        return $default(
            _that.name,
            _that.id,
            _that.avatar,
            _that.lastUsed,
            _that.authMethod,
            _that.localPin,
            _that.credentials,
            _that.seerrCredentials,
            _that.latestItemsExcludes,
            _that.searchQueryHistory,
            _that.quickConnectState,
            _that.libraryFilters,
            _that.updateNotificationsEnabled,
            _that.seerrRequestsEnabled,
            _that.includeHiddenViews,
            _that.policy,
            _that.serverConfiguration,
            _that.userConfiguration,
            _that.hasPassword,
            _that.hasConfiguredPassword,
            _that.userSettings);
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
            String name,
            String id,
            String avatar,
            DateTime lastUsed,
            Authentication authMethod,
            String localPin,
            @CredentialsConverter() CredentialsModel credentials,
            SeerrCredentialsModel? seerrCredentials,
            List<String> latestItemsExcludes,
            List<String> searchQueryHistory,
            bool quickConnectState,
            List<LibraryFiltersModel> libraryFilters,
            bool updateNotificationsEnabled,
            bool seerrRequestsEnabled,
            bool includeHiddenViews,
            @JsonKey(includeFromJson: false, includeToJson: false)
            UserPolicy? policy,
            @JsonKey(includeFromJson: false, includeToJson: false)
            ServerConfiguration? serverConfiguration,
            @JsonKey(includeFromJson: false, includeToJson: false)
            UserConfiguration? userConfiguration,
            @JsonKey(includeFromJson: false, includeToJson: false)
            bool? hasPassword,
            @JsonKey(includeFromJson: false, includeToJson: false)
            bool? hasConfiguredPassword,
            UserSettings? userSettings)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccountModel() when $default != null:
        return $default(
            _that.name,
            _that.id,
            _that.avatar,
            _that.lastUsed,
            _that.authMethod,
            _that.localPin,
            _that.credentials,
            _that.seerrCredentials,
            _that.latestItemsExcludes,
            _that.searchQueryHistory,
            _that.quickConnectState,
            _that.libraryFilters,
            _that.updateNotificationsEnabled,
            _that.seerrRequestsEnabled,
            _that.includeHiddenViews,
            _that.policy,
            _that.serverConfiguration,
            _that.userConfiguration,
            _that.hasPassword,
            _that.hasConfiguredPassword,
            _that.userSettings);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AccountModel extends AccountModel with DiagnosticableTreeMixin {
  const _AccountModel(
      {required this.name,
      required this.id,
      required this.avatar,
      required this.lastUsed,
      this.authMethod = Authentication.autoLogin,
      this.localPin = "",
      @CredentialsConverter() required this.credentials,
      this.seerrCredentials,
      final List<String> latestItemsExcludes = const [],
      final List<String> searchQueryHistory = const [],
      this.quickConnectState = false,
      final List<LibraryFiltersModel> libraryFilters = const [],
      this.updateNotificationsEnabled = false,
      this.seerrRequestsEnabled = false,
      this.includeHiddenViews = false,
      @JsonKey(includeFromJson: false, includeToJson: false) this.policy,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.serverConfiguration,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.userConfiguration,
      @JsonKey(includeFromJson: false, includeToJson: false) this.hasPassword,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.hasConfiguredPassword,
      this.userSettings})
      : _latestItemsExcludes = latestItemsExcludes,
        _searchQueryHistory = searchQueryHistory,
        _libraryFilters = libraryFilters,
        super._();
  factory _AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  final String avatar;
  @override
  final DateTime lastUsed;
  @override
  @JsonKey()
  final Authentication authMethod;
  @override
  @JsonKey()
  final String localPin;
  @override
  @CredentialsConverter()
  final CredentialsModel credentials;
  @override
  final SeerrCredentialsModel? seerrCredentials;
  final List<String> _latestItemsExcludes;
  @override
  @JsonKey()
  List<String> get latestItemsExcludes {
    if (_latestItemsExcludes is EqualUnmodifiableListView)
      return _latestItemsExcludes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_latestItemsExcludes);
  }

  final List<String> _searchQueryHistory;
  @override
  @JsonKey()
  List<String> get searchQueryHistory {
    if (_searchQueryHistory is EqualUnmodifiableListView)
      return _searchQueryHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchQueryHistory);
  }

  @override
  @JsonKey()
  final bool quickConnectState;
  final List<LibraryFiltersModel> _libraryFilters;
  @override
  @JsonKey()
  List<LibraryFiltersModel> get libraryFilters {
    if (_libraryFilters is EqualUnmodifiableListView) return _libraryFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_libraryFilters);
  }

  @override
  @JsonKey()
  final bool updateNotificationsEnabled;
  @override
  @JsonKey()
  final bool seerrRequestsEnabled;
  @override
  @JsonKey()
  final bool includeHiddenViews;
//Server values not stored in the database
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final UserPolicy? policy;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ServerConfiguration? serverConfiguration;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final UserConfiguration? userConfiguration;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? hasPassword;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? hasConfiguredPassword;
  @override
  final UserSettings? userSettings;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccountModelCopyWith<_AccountModel> get copyWith =>
      __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AccountModelToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'AccountModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('lastUsed', lastUsed))
      ..add(DiagnosticsProperty('authMethod', authMethod))
      ..add(DiagnosticsProperty('localPin', localPin))
      ..add(DiagnosticsProperty('credentials', credentials))
      ..add(DiagnosticsProperty('seerrCredentials', seerrCredentials))
      ..add(DiagnosticsProperty('latestItemsExcludes', latestItemsExcludes))
      ..add(DiagnosticsProperty('searchQueryHistory', searchQueryHistory))
      ..add(DiagnosticsProperty('quickConnectState', quickConnectState))
      ..add(DiagnosticsProperty('libraryFilters', libraryFilters))
      ..add(DiagnosticsProperty(
          'updateNotificationsEnabled', updateNotificationsEnabled))
      ..add(DiagnosticsProperty('seerrRequestsEnabled', seerrRequestsEnabled))
      ..add(DiagnosticsProperty('includeHiddenViews', includeHiddenViews))
      ..add(DiagnosticsProperty('policy', policy))
      ..add(DiagnosticsProperty('serverConfiguration', serverConfiguration))
      ..add(DiagnosticsProperty('userConfiguration', userConfiguration))
      ..add(DiagnosticsProperty('hasPassword', hasPassword))
      ..add(DiagnosticsProperty('hasConfiguredPassword', hasConfiguredPassword))
      ..add(DiagnosticsProperty('userSettings', userSettings));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountModel(name: $name, id: $id, avatar: $avatar, lastUsed: $lastUsed, authMethod: $authMethod, localPin: $localPin, credentials: $credentials, seerrCredentials: $seerrCredentials, latestItemsExcludes: $latestItemsExcludes, searchQueryHistory: $searchQueryHistory, quickConnectState: $quickConnectState, libraryFilters: $libraryFilters, updateNotificationsEnabled: $updateNotificationsEnabled, seerrRequestsEnabled: $seerrRequestsEnabled, includeHiddenViews: $includeHiddenViews, policy: $policy, serverConfiguration: $serverConfiguration, userConfiguration: $userConfiguration, hasPassword: $hasPassword, hasConfiguredPassword: $hasConfiguredPassword, userSettings: $userSettings)';
  }
}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res>
    implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(
          _AccountModel value, $Res Function(_AccountModel) _then) =
      __$AccountModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      String id,
      String avatar,
      DateTime lastUsed,
      Authentication authMethod,
      String localPin,
      @CredentialsConverter() CredentialsModel credentials,
      SeerrCredentialsModel? seerrCredentials,
      List<String> latestItemsExcludes,
      List<String> searchQueryHistory,
      bool quickConnectState,
      List<LibraryFiltersModel> libraryFilters,
      bool updateNotificationsEnabled,
      bool seerrRequestsEnabled,
      bool includeHiddenViews,
      @JsonKey(includeFromJson: false, includeToJson: false) UserPolicy? policy,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ServerConfiguration? serverConfiguration,
      @JsonKey(includeFromJson: false, includeToJson: false)
      UserConfiguration? userConfiguration,
      @JsonKey(includeFromJson: false, includeToJson: false) bool? hasPassword,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool? hasConfiguredPassword,
      UserSettings? userSettings});

  @override
  $CredentialsModelCopyWith<$Res> get credentials;
  @override
  $SeerrCredentialsModelCopyWith<$Res>? get seerrCredentials;
  @override
  $UserSettingsCopyWith<$Res>? get userSettings;
}

/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? avatar = null,
    Object? lastUsed = null,
    Object? authMethod = null,
    Object? localPin = null,
    Object? credentials = null,
    Object? seerrCredentials = freezed,
    Object? latestItemsExcludes = null,
    Object? searchQueryHistory = null,
    Object? quickConnectState = null,
    Object? libraryFilters = null,
    Object? updateNotificationsEnabled = null,
    Object? seerrRequestsEnabled = null,
    Object? includeHiddenViews = null,
    Object? policy = freezed,
    Object? serverConfiguration = freezed,
    Object? userConfiguration = freezed,
    Object? hasPassword = freezed,
    Object? hasConfiguredPassword = freezed,
    Object? userSettings = freezed,
  }) {
    return _then(_AccountModel(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      lastUsed: null == lastUsed
          ? _self.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authMethod: null == authMethod
          ? _self.authMethod
          : authMethod // ignore: cast_nullable_to_non_nullable
              as Authentication,
      localPin: null == localPin
          ? _self.localPin
          : localPin // ignore: cast_nullable_to_non_nullable
              as String,
      credentials: null == credentials
          ? _self.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as CredentialsModel,
      seerrCredentials: freezed == seerrCredentials
          ? _self.seerrCredentials
          : seerrCredentials // ignore: cast_nullable_to_non_nullable
              as SeerrCredentialsModel?,
      latestItemsExcludes: null == latestItemsExcludes
          ? _self._latestItemsExcludes
          : latestItemsExcludes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchQueryHistory: null == searchQueryHistory
          ? _self._searchQueryHistory
          : searchQueryHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quickConnectState: null == quickConnectState
          ? _self.quickConnectState
          : quickConnectState // ignore: cast_nullable_to_non_nullable
              as bool,
      libraryFilters: null == libraryFilters
          ? _self._libraryFilters
          : libraryFilters // ignore: cast_nullable_to_non_nullable
              as List<LibraryFiltersModel>,
      updateNotificationsEnabled: null == updateNotificationsEnabled
          ? _self.updateNotificationsEnabled
          : updateNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      seerrRequestsEnabled: null == seerrRequestsEnabled
          ? _self.seerrRequestsEnabled
          : seerrRequestsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      includeHiddenViews: null == includeHiddenViews
          ? _self.includeHiddenViews
          : includeHiddenViews // ignore: cast_nullable_to_non_nullable
              as bool,
      policy: freezed == policy
          ? _self.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as UserPolicy?,
      serverConfiguration: freezed == serverConfiguration
          ? _self.serverConfiguration
          : serverConfiguration // ignore: cast_nullable_to_non_nullable
              as ServerConfiguration?,
      userConfiguration: freezed == userConfiguration
          ? _self.userConfiguration
          : userConfiguration // ignore: cast_nullable_to_non_nullable
              as UserConfiguration?,
      hasPassword: freezed == hasPassword
          ? _self.hasPassword
          : hasPassword // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasConfiguredPassword: freezed == hasConfiguredPassword
          ? _self.hasConfiguredPassword
          : hasConfiguredPassword // ignore: cast_nullable_to_non_nullable
              as bool?,
      userSettings: freezed == userSettings
          ? _self.userSettings
          : userSettings // ignore: cast_nullable_to_non_nullable
              as UserSettings?,
    ));
  }

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialsModelCopyWith<$Res> get credentials {
    return $CredentialsModelCopyWith<$Res>(_self.credentials, (value) {
      return _then(_self.copyWith(credentials: value));
    });
  }

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrCredentialsModelCopyWith<$Res>? get seerrCredentials {
    if (_self.seerrCredentials == null) {
      return null;
    }

    return $SeerrCredentialsModelCopyWith<$Res>(_self.seerrCredentials!,
        (value) {
      return _then(_self.copyWith(seerrCredentials: value));
    });
  }

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<$Res>? get userSettings {
    if (_self.userSettings == null) {
      return null;
    }

    return $UserSettingsCopyWith<$Res>(_self.userSettings!, (value) {
      return _then(_self.copyWith(userSettings: value));
    });
  }
}

/// @nodoc
mixin _$UserSettings implements DiagnosticableTreeMixin {
  Duration get skipForwardDuration;
  Duration get skipBackDuration;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      _$UserSettingsCopyWithImpl<UserSettings>(
          this as UserSettings, _$identity);

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'UserSettings'))
      ..add(DiagnosticsProperty('skipForwardDuration', skipForwardDuration))
      ..add(DiagnosticsProperty('skipBackDuration', skipBackDuration));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserSettings(skipForwardDuration: $skipForwardDuration, skipBackDuration: $skipBackDuration)';
  }
}

/// @nodoc
abstract mixin class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) _then) =
      _$UserSettingsCopyWithImpl;
  @useResult
  $Res call({Duration skipForwardDuration, Duration skipBackDuration});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res> implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._self, this._then);

  final UserSettings _self;
  final $Res Function(UserSettings) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skipForwardDuration = null,
    Object? skipBackDuration = null,
  }) {
    return _then(_self.copyWith(
      skipForwardDuration: null == skipForwardDuration
          ? _self.skipForwardDuration
          : skipForwardDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      skipBackDuration: null == skipBackDuration
          ? _self.skipBackDuration
          : skipBackDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserSettings].
extension UserSettingsPatterns on UserSettings {
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
    TResult Function(_UserSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
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
    TResult Function(_UserSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings():
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
    TResult? Function(_UserSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
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
    TResult Function(Duration skipForwardDuration, Duration skipBackDuration)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
        return $default(_that.skipForwardDuration, _that.skipBackDuration);
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
    TResult Function(Duration skipForwardDuration, Duration skipBackDuration)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings():
        return $default(_that.skipForwardDuration, _that.skipBackDuration);
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
    TResult? Function(Duration skipForwardDuration, Duration skipBackDuration)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
        return $default(_that.skipForwardDuration, _that.skipBackDuration);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserSettings with DiagnosticableTreeMixin implements UserSettings {
  _UserSettings(
      {this.skipForwardDuration = const Duration(seconds: 30),
      this.skipBackDuration = const Duration(seconds: 10)});
  factory _UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  @override
  @JsonKey()
  final Duration skipForwardDuration;
  @override
  @JsonKey()
  final Duration skipBackDuration;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserSettingsCopyWith<_UserSettings> get copyWith =>
      __$UserSettingsCopyWithImpl<_UserSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserSettingsToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'UserSettings'))
      ..add(DiagnosticsProperty('skipForwardDuration', skipForwardDuration))
      ..add(DiagnosticsProperty('skipBackDuration', skipBackDuration));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserSettings(skipForwardDuration: $skipForwardDuration, skipBackDuration: $skipBackDuration)';
  }
}

/// @nodoc
abstract mixin class _$UserSettingsCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$UserSettingsCopyWith(
          _UserSettings value, $Res Function(_UserSettings) _then) =
      __$UserSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({Duration skipForwardDuration, Duration skipBackDuration});
}

/// @nodoc
class __$UserSettingsCopyWithImpl<$Res>
    implements _$UserSettingsCopyWith<$Res> {
  __$UserSettingsCopyWithImpl(this._self, this._then);

  final _UserSettings _self;
  final $Res Function(_UserSettings) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? skipForwardDuration = null,
    Object? skipBackDuration = null,
  }) {
    return _then(_UserSettings(
      skipForwardDuration: null == skipForwardDuration
          ? _self.skipForwardDuration
          : skipForwardDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      skipBackDuration: null == skipBackDuration
          ? _self.skipBackDuration
          : skipBackDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

// dart format on
