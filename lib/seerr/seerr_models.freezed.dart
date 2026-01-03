// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seerr_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeerrUserModel {
  int? get id;
  String? get email;
  String? get username;
  String? get displayName;
  String? get plexToken;
  String? get plexUsername;
  int? get permissions;
  String? get avatar;
  SeerrUserSettings? get settings;
  int? get movieQuotaLimit;
  int? get movieQuotaDays;
  int? get tvQuotaLimit;
  int? get tvQuotaDays;

  /// Create a copy of SeerrUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrUserModelCopyWith<SeerrUserModel> get copyWith =>
      _$SeerrUserModelCopyWithImpl<SeerrUserModel>(
          this as SeerrUserModel, _$identity);

  /// Serializes this SeerrUserModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SeerrUserModel(id: $id, email: $email, username: $username, displayName: $displayName, plexToken: $plexToken, plexUsername: $plexUsername, permissions: $permissions, avatar: $avatar, settings: $settings, movieQuotaLimit: $movieQuotaLimit, movieQuotaDays: $movieQuotaDays, tvQuotaLimit: $tvQuotaLimit, tvQuotaDays: $tvQuotaDays)';
  }
}

/// @nodoc
abstract mixin class $SeerrUserModelCopyWith<$Res> {
  factory $SeerrUserModelCopyWith(
          SeerrUserModel value, $Res Function(SeerrUserModel) _then) =
      _$SeerrUserModelCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? email,
      String? username,
      String? displayName,
      String? plexToken,
      String? plexUsername,
      int? permissions,
      String? avatar,
      SeerrUserSettings? settings,
      int? movieQuotaLimit,
      int? movieQuotaDays,
      int? tvQuotaLimit,
      int? tvQuotaDays});
}

/// @nodoc
class _$SeerrUserModelCopyWithImpl<$Res>
    implements $SeerrUserModelCopyWith<$Res> {
  _$SeerrUserModelCopyWithImpl(this._self, this._then);

  final SeerrUserModel _self;
  final $Res Function(SeerrUserModel) _then;

  /// Create a copy of SeerrUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? plexToken = freezed,
    Object? plexUsername = freezed,
    Object? permissions = freezed,
    Object? avatar = freezed,
    Object? settings = freezed,
    Object? movieQuotaLimit = freezed,
    Object? movieQuotaDays = freezed,
    Object? tvQuotaLimit = freezed,
    Object? tvQuotaDays = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      plexToken: freezed == plexToken
          ? _self.plexToken
          : plexToken // ignore: cast_nullable_to_non_nullable
              as String?,
      plexUsername: freezed == plexUsername
          ? _self.plexUsername
          : plexUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: freezed == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as int?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: freezed == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SeerrUserSettings?,
      movieQuotaLimit: freezed == movieQuotaLimit
          ? _self.movieQuotaLimit
          : movieQuotaLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      movieQuotaDays: freezed == movieQuotaDays
          ? _self.movieQuotaDays
          : movieQuotaDays // ignore: cast_nullable_to_non_nullable
              as int?,
      tvQuotaLimit: freezed == tvQuotaLimit
          ? _self.tvQuotaLimit
          : tvQuotaLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      tvQuotaDays: freezed == tvQuotaDays
          ? _self.tvQuotaDays
          : tvQuotaDays // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeerrUserModel].
extension SeerrUserModelPatterns on SeerrUserModel {
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
    TResult Function(_SeerrUserModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrUserModel() when $default != null:
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
    TResult Function(_SeerrUserModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrUserModel():
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
    TResult? Function(_SeerrUserModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrUserModel() when $default != null:
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
            int? id,
            String? email,
            String? username,
            String? displayName,
            String? plexToken,
            String? plexUsername,
            int? permissions,
            String? avatar,
            SeerrUserSettings? settings,
            int? movieQuotaLimit,
            int? movieQuotaDays,
            int? tvQuotaLimit,
            int? tvQuotaDays)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrUserModel() when $default != null:
        return $default(
            _that.id,
            _that.email,
            _that.username,
            _that.displayName,
            _that.plexToken,
            _that.plexUsername,
            _that.permissions,
            _that.avatar,
            _that.settings,
            _that.movieQuotaLimit,
            _that.movieQuotaDays,
            _that.tvQuotaLimit,
            _that.tvQuotaDays);
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
            int? id,
            String? email,
            String? username,
            String? displayName,
            String? plexToken,
            String? plexUsername,
            int? permissions,
            String? avatar,
            SeerrUserSettings? settings,
            int? movieQuotaLimit,
            int? movieQuotaDays,
            int? tvQuotaLimit,
            int? tvQuotaDays)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrUserModel():
        return $default(
            _that.id,
            _that.email,
            _that.username,
            _that.displayName,
            _that.plexToken,
            _that.plexUsername,
            _that.permissions,
            _that.avatar,
            _that.settings,
            _that.movieQuotaLimit,
            _that.movieQuotaDays,
            _that.tvQuotaLimit,
            _that.tvQuotaDays);
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
            int? id,
            String? email,
            String? username,
            String? displayName,
            String? plexToken,
            String? plexUsername,
            int? permissions,
            String? avatar,
            SeerrUserSettings? settings,
            int? movieQuotaLimit,
            int? movieQuotaDays,
            int? tvQuotaLimit,
            int? tvQuotaDays)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrUserModel() when $default != null:
        return $default(
            _that.id,
            _that.email,
            _that.username,
            _that.displayName,
            _that.plexToken,
            _that.plexUsername,
            _that.permissions,
            _that.avatar,
            _that.settings,
            _that.movieQuotaLimit,
            _that.movieQuotaDays,
            _that.tvQuotaLimit,
            _that.tvQuotaDays);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeerrUserModel implements SeerrUserModel {
  const _SeerrUserModel(
      {this.id,
      this.email,
      this.username,
      this.displayName,
      this.plexToken,
      this.plexUsername,
      this.permissions,
      this.avatar,
      this.settings,
      this.movieQuotaLimit,
      this.movieQuotaDays,
      this.tvQuotaLimit,
      this.tvQuotaDays});
  factory _SeerrUserModel.fromJson(Map<String, dynamic> json) =>
      _$SeerrUserModelFromJson(json);

  @override
  final int? id;
  @override
  final String? email;
  @override
  final String? username;
  @override
  final String? displayName;
  @override
  final String? plexToken;
  @override
  final String? plexUsername;
  @override
  final int? permissions;
  @override
  final String? avatar;
  @override
  final SeerrUserSettings? settings;
  @override
  final int? movieQuotaLimit;
  @override
  final int? movieQuotaDays;
  @override
  final int? tvQuotaLimit;
  @override
  final int? tvQuotaDays;

  /// Create a copy of SeerrUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrUserModelCopyWith<_SeerrUserModel> get copyWith =>
      __$SeerrUserModelCopyWithImpl<_SeerrUserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeerrUserModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SeerrUserModel(id: $id, email: $email, username: $username, displayName: $displayName, plexToken: $plexToken, plexUsername: $plexUsername, permissions: $permissions, avatar: $avatar, settings: $settings, movieQuotaLimit: $movieQuotaLimit, movieQuotaDays: $movieQuotaDays, tvQuotaLimit: $tvQuotaLimit, tvQuotaDays: $tvQuotaDays)';
  }
}

/// @nodoc
abstract mixin class _$SeerrUserModelCopyWith<$Res>
    implements $SeerrUserModelCopyWith<$Res> {
  factory _$SeerrUserModelCopyWith(
          _SeerrUserModel value, $Res Function(_SeerrUserModel) _then) =
      __$SeerrUserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? email,
      String? username,
      String? displayName,
      String? plexToken,
      String? plexUsername,
      int? permissions,
      String? avatar,
      SeerrUserSettings? settings,
      int? movieQuotaLimit,
      int? movieQuotaDays,
      int? tvQuotaLimit,
      int? tvQuotaDays});
}

/// @nodoc
class __$SeerrUserModelCopyWithImpl<$Res>
    implements _$SeerrUserModelCopyWith<$Res> {
  __$SeerrUserModelCopyWithImpl(this._self, this._then);

  final _SeerrUserModel _self;
  final $Res Function(_SeerrUserModel) _then;

  /// Create a copy of SeerrUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? plexToken = freezed,
    Object? plexUsername = freezed,
    Object? permissions = freezed,
    Object? avatar = freezed,
    Object? settings = freezed,
    Object? movieQuotaLimit = freezed,
    Object? movieQuotaDays = freezed,
    Object? tvQuotaLimit = freezed,
    Object? tvQuotaDays = freezed,
  }) {
    return _then(_SeerrUserModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      plexToken: freezed == plexToken
          ? _self.plexToken
          : plexToken // ignore: cast_nullable_to_non_nullable
              as String?,
      plexUsername: freezed == plexUsername
          ? _self.plexUsername
          : plexUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: freezed == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as int?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: freezed == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SeerrUserSettings?,
      movieQuotaLimit: freezed == movieQuotaLimit
          ? _self.movieQuotaLimit
          : movieQuotaLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      movieQuotaDays: freezed == movieQuotaDays
          ? _self.movieQuotaDays
          : movieQuotaDays // ignore: cast_nullable_to_non_nullable
              as int?,
      tvQuotaLimit: freezed == tvQuotaLimit
          ? _self.tvQuotaLimit
          : tvQuotaLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      tvQuotaDays: freezed == tvQuotaDays
          ? _self.tvQuotaDays
          : tvQuotaDays // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$SeerrSonarrServer {
  int? get id;
  String? get name;
  String? get hostname;
  int? get port;
  String? get apiKey;
  bool? get useSsl;
  String? get baseUrl;
  int? get activeProfileId;
  String? get activeProfileName;
  int? get activeLanguageProfileId;
  String? get activeDirectory;
  int? get activeAnimeProfileId;
  int? get activeAnimeLanguageProfileId;
  String? get activeAnimeProfileName;
  String? get activeAnimeDirectory;
  bool? get is4k;
  bool? get isDefault;
  String? get externalUrl;
  bool? get syncEnabled;
  bool? get preventSearch;
  List<SeerrServiceProfile>? get profiles;
  List<SeerrServiceTag>? get tags;
  List<SeerrRootFolder>? get rootFolders;
  List<int>? get activeTags;

  /// Create a copy of SeerrSonarrServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrSonarrServerCopyWith<SeerrSonarrServer> get copyWith =>
      _$SeerrSonarrServerCopyWithImpl<SeerrSonarrServer>(
          this as SeerrSonarrServer, _$identity);

  /// Serializes this SeerrSonarrServer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SeerrSonarrServer(id: $id, name: $name, hostname: $hostname, port: $port, apiKey: $apiKey, useSsl: $useSsl, baseUrl: $baseUrl, activeProfileId: $activeProfileId, activeProfileName: $activeProfileName, activeLanguageProfileId: $activeLanguageProfileId, activeDirectory: $activeDirectory, activeAnimeProfileId: $activeAnimeProfileId, activeAnimeLanguageProfileId: $activeAnimeLanguageProfileId, activeAnimeProfileName: $activeAnimeProfileName, activeAnimeDirectory: $activeAnimeDirectory, is4k: $is4k, isDefault: $isDefault, externalUrl: $externalUrl, syncEnabled: $syncEnabled, preventSearch: $preventSearch, profiles: $profiles, tags: $tags, rootFolders: $rootFolders, activeTags: $activeTags)';
  }
}

/// @nodoc
abstract mixin class $SeerrSonarrServerCopyWith<$Res> {
  factory $SeerrSonarrServerCopyWith(
          SeerrSonarrServer value, $Res Function(SeerrSonarrServer) _then) =
      _$SeerrSonarrServerCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hostname,
      int? port,
      String? apiKey,
      bool? useSsl,
      String? baseUrl,
      int? activeProfileId,
      String? activeProfileName,
      int? activeLanguageProfileId,
      String? activeDirectory,
      int? activeAnimeProfileId,
      int? activeAnimeLanguageProfileId,
      String? activeAnimeProfileName,
      String? activeAnimeDirectory,
      bool? is4k,
      bool? isDefault,
      String? externalUrl,
      bool? syncEnabled,
      bool? preventSearch,
      List<SeerrServiceProfile>? profiles,
      List<SeerrServiceTag>? tags,
      List<SeerrRootFolder>? rootFolders,
      List<int>? activeTags});
}

/// @nodoc
class _$SeerrSonarrServerCopyWithImpl<$Res>
    implements $SeerrSonarrServerCopyWith<$Res> {
  _$SeerrSonarrServerCopyWithImpl(this._self, this._then);

  final SeerrSonarrServer _self;
  final $Res Function(SeerrSonarrServer) _then;

  /// Create a copy of SeerrSonarrServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hostname = freezed,
    Object? port = freezed,
    Object? apiKey = freezed,
    Object? useSsl = freezed,
    Object? baseUrl = freezed,
    Object? activeProfileId = freezed,
    Object? activeProfileName = freezed,
    Object? activeLanguageProfileId = freezed,
    Object? activeDirectory = freezed,
    Object? activeAnimeProfileId = freezed,
    Object? activeAnimeLanguageProfileId = freezed,
    Object? activeAnimeProfileName = freezed,
    Object? activeAnimeDirectory = freezed,
    Object? is4k = freezed,
    Object? isDefault = freezed,
    Object? externalUrl = freezed,
    Object? syncEnabled = freezed,
    Object? preventSearch = freezed,
    Object? profiles = freezed,
    Object? tags = freezed,
    Object? rootFolders = freezed,
    Object? activeTags = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hostname: freezed == hostname
          ? _self.hostname
          : hostname // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _self.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      apiKey: freezed == apiKey
          ? _self.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      useSsl: freezed == useSsl
          ? _self.useSsl
          : useSsl // ignore: cast_nullable_to_non_nullable
              as bool?,
      baseUrl: freezed == baseUrl
          ? _self.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      activeProfileId: freezed == activeProfileId
          ? _self.activeProfileId
          : activeProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeProfileName: freezed == activeProfileName
          ? _self.activeProfileName
          : activeProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      activeLanguageProfileId: freezed == activeLanguageProfileId
          ? _self.activeLanguageProfileId
          : activeLanguageProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeDirectory: freezed == activeDirectory
          ? _self.activeDirectory
          : activeDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAnimeProfileId: freezed == activeAnimeProfileId
          ? _self.activeAnimeProfileId
          : activeAnimeProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeAnimeLanguageProfileId: freezed == activeAnimeLanguageProfileId
          ? _self.activeAnimeLanguageProfileId
          : activeAnimeLanguageProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeAnimeProfileName: freezed == activeAnimeProfileName
          ? _self.activeAnimeProfileName
          : activeAnimeProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAnimeDirectory: freezed == activeAnimeDirectory
          ? _self.activeAnimeDirectory
          : activeAnimeDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      is4k: freezed == is4k
          ? _self.is4k
          : is4k // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      externalUrl: freezed == externalUrl
          ? _self.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      syncEnabled: freezed == syncEnabled
          ? _self.syncEnabled
          : syncEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      preventSearch: freezed == preventSearch
          ? _self.preventSearch
          : preventSearch // ignore: cast_nullable_to_non_nullable
              as bool?,
      profiles: freezed == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceProfile>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>?,
      rootFolders: freezed == rootFolders
          ? _self.rootFolders
          : rootFolders // ignore: cast_nullable_to_non_nullable
              as List<SeerrRootFolder>?,
      activeTags: freezed == activeTags
          ? _self.activeTags
          : activeTags // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeerrSonarrServer].
extension SeerrSonarrServerPatterns on SeerrSonarrServer {
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
    TResult Function(_SeerrSonarrServer value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServer() when $default != null:
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
    TResult Function(_SeerrSonarrServer value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServer():
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
    TResult? Function(_SeerrSonarrServer value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServer() when $default != null:
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
            int? id,
            String? name,
            String? hostname,
            int? port,
            String? apiKey,
            bool? useSsl,
            String? baseUrl,
            int? activeProfileId,
            String? activeProfileName,
            int? activeLanguageProfileId,
            String? activeDirectory,
            int? activeAnimeProfileId,
            int? activeAnimeLanguageProfileId,
            String? activeAnimeProfileName,
            String? activeAnimeDirectory,
            bool? is4k,
            bool? isDefault,
            String? externalUrl,
            bool? syncEnabled,
            bool? preventSearch,
            List<SeerrServiceProfile>? profiles,
            List<SeerrServiceTag>? tags,
            List<SeerrRootFolder>? rootFolders,
            List<int>? activeTags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServer() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.hostname,
            _that.port,
            _that.apiKey,
            _that.useSsl,
            _that.baseUrl,
            _that.activeProfileId,
            _that.activeProfileName,
            _that.activeLanguageProfileId,
            _that.activeDirectory,
            _that.activeAnimeProfileId,
            _that.activeAnimeLanguageProfileId,
            _that.activeAnimeProfileName,
            _that.activeAnimeDirectory,
            _that.is4k,
            _that.isDefault,
            _that.externalUrl,
            _that.syncEnabled,
            _that.preventSearch,
            _that.profiles,
            _that.tags,
            _that.rootFolders,
            _that.activeTags);
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
            int? id,
            String? name,
            String? hostname,
            int? port,
            String? apiKey,
            bool? useSsl,
            String? baseUrl,
            int? activeProfileId,
            String? activeProfileName,
            int? activeLanguageProfileId,
            String? activeDirectory,
            int? activeAnimeProfileId,
            int? activeAnimeLanguageProfileId,
            String? activeAnimeProfileName,
            String? activeAnimeDirectory,
            bool? is4k,
            bool? isDefault,
            String? externalUrl,
            bool? syncEnabled,
            bool? preventSearch,
            List<SeerrServiceProfile>? profiles,
            List<SeerrServiceTag>? tags,
            List<SeerrRootFolder>? rootFolders,
            List<int>? activeTags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServer():
        return $default(
            _that.id,
            _that.name,
            _that.hostname,
            _that.port,
            _that.apiKey,
            _that.useSsl,
            _that.baseUrl,
            _that.activeProfileId,
            _that.activeProfileName,
            _that.activeLanguageProfileId,
            _that.activeDirectory,
            _that.activeAnimeProfileId,
            _that.activeAnimeLanguageProfileId,
            _that.activeAnimeProfileName,
            _that.activeAnimeDirectory,
            _that.is4k,
            _that.isDefault,
            _that.externalUrl,
            _that.syncEnabled,
            _that.preventSearch,
            _that.profiles,
            _that.tags,
            _that.rootFolders,
            _that.activeTags);
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
            int? id,
            String? name,
            String? hostname,
            int? port,
            String? apiKey,
            bool? useSsl,
            String? baseUrl,
            int? activeProfileId,
            String? activeProfileName,
            int? activeLanguageProfileId,
            String? activeDirectory,
            int? activeAnimeProfileId,
            int? activeAnimeLanguageProfileId,
            String? activeAnimeProfileName,
            String? activeAnimeDirectory,
            bool? is4k,
            bool? isDefault,
            String? externalUrl,
            bool? syncEnabled,
            bool? preventSearch,
            List<SeerrServiceProfile>? profiles,
            List<SeerrServiceTag>? tags,
            List<SeerrRootFolder>? rootFolders,
            List<int>? activeTags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServer() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.hostname,
            _that.port,
            _that.apiKey,
            _that.useSsl,
            _that.baseUrl,
            _that.activeProfileId,
            _that.activeProfileName,
            _that.activeLanguageProfileId,
            _that.activeDirectory,
            _that.activeAnimeProfileId,
            _that.activeAnimeLanguageProfileId,
            _that.activeAnimeProfileName,
            _that.activeAnimeDirectory,
            _that.is4k,
            _that.isDefault,
            _that.externalUrl,
            _that.syncEnabled,
            _that.preventSearch,
            _that.profiles,
            _that.tags,
            _that.rootFolders,
            _that.activeTags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeerrSonarrServer implements SeerrSonarrServer {
  const _SeerrSonarrServer(
      {this.id,
      this.name,
      this.hostname,
      this.port,
      this.apiKey,
      this.useSsl,
      this.baseUrl,
      this.activeProfileId,
      this.activeProfileName,
      this.activeLanguageProfileId,
      this.activeDirectory,
      this.activeAnimeProfileId,
      this.activeAnimeLanguageProfileId,
      this.activeAnimeProfileName,
      this.activeAnimeDirectory,
      this.is4k,
      this.isDefault,
      this.externalUrl,
      this.syncEnabled,
      this.preventSearch,
      this.profiles,
      this.tags,
      this.rootFolders,
      this.activeTags});
  factory _SeerrSonarrServer.fromJson(Map<String, dynamic> json) =>
      _$SeerrSonarrServerFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? hostname;
  @override
  final int? port;
  @override
  final String? apiKey;
  @override
  final bool? useSsl;
  @override
  final String? baseUrl;
  @override
  final int? activeProfileId;
  @override
  final String? activeProfileName;
  @override
  final int? activeLanguageProfileId;
  @override
  final String? activeDirectory;
  @override
  final int? activeAnimeProfileId;
  @override
  final int? activeAnimeLanguageProfileId;
  @override
  final String? activeAnimeProfileName;
  @override
  final String? activeAnimeDirectory;
  @override
  final bool? is4k;
  @override
  final bool? isDefault;
  @override
  final String? externalUrl;
  @override
  final bool? syncEnabled;
  @override
  final bool? preventSearch;
  @override
  final List<SeerrServiceProfile>? profiles;
  @override
  final List<SeerrServiceTag>? tags;
  @override
  final List<SeerrRootFolder>? rootFolders;
  @override
  final List<int>? activeTags;

  /// Create a copy of SeerrSonarrServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrSonarrServerCopyWith<_SeerrSonarrServer> get copyWith =>
      __$SeerrSonarrServerCopyWithImpl<_SeerrSonarrServer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeerrSonarrServerToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SeerrSonarrServer(id: $id, name: $name, hostname: $hostname, port: $port, apiKey: $apiKey, useSsl: $useSsl, baseUrl: $baseUrl, activeProfileId: $activeProfileId, activeProfileName: $activeProfileName, activeLanguageProfileId: $activeLanguageProfileId, activeDirectory: $activeDirectory, activeAnimeProfileId: $activeAnimeProfileId, activeAnimeLanguageProfileId: $activeAnimeLanguageProfileId, activeAnimeProfileName: $activeAnimeProfileName, activeAnimeDirectory: $activeAnimeDirectory, is4k: $is4k, isDefault: $isDefault, externalUrl: $externalUrl, syncEnabled: $syncEnabled, preventSearch: $preventSearch, profiles: $profiles, tags: $tags, rootFolders: $rootFolders, activeTags: $activeTags)';
  }
}

/// @nodoc
abstract mixin class _$SeerrSonarrServerCopyWith<$Res>
    implements $SeerrSonarrServerCopyWith<$Res> {
  factory _$SeerrSonarrServerCopyWith(
          _SeerrSonarrServer value, $Res Function(_SeerrSonarrServer) _then) =
      __$SeerrSonarrServerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hostname,
      int? port,
      String? apiKey,
      bool? useSsl,
      String? baseUrl,
      int? activeProfileId,
      String? activeProfileName,
      int? activeLanguageProfileId,
      String? activeDirectory,
      int? activeAnimeProfileId,
      int? activeAnimeLanguageProfileId,
      String? activeAnimeProfileName,
      String? activeAnimeDirectory,
      bool? is4k,
      bool? isDefault,
      String? externalUrl,
      bool? syncEnabled,
      bool? preventSearch,
      List<SeerrServiceProfile>? profiles,
      List<SeerrServiceTag>? tags,
      List<SeerrRootFolder>? rootFolders,
      List<int>? activeTags});
}

/// @nodoc
class __$SeerrSonarrServerCopyWithImpl<$Res>
    implements _$SeerrSonarrServerCopyWith<$Res> {
  __$SeerrSonarrServerCopyWithImpl(this._self, this._then);

  final _SeerrSonarrServer _self;
  final $Res Function(_SeerrSonarrServer) _then;

  /// Create a copy of SeerrSonarrServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hostname = freezed,
    Object? port = freezed,
    Object? apiKey = freezed,
    Object? useSsl = freezed,
    Object? baseUrl = freezed,
    Object? activeProfileId = freezed,
    Object? activeProfileName = freezed,
    Object? activeLanguageProfileId = freezed,
    Object? activeDirectory = freezed,
    Object? activeAnimeProfileId = freezed,
    Object? activeAnimeLanguageProfileId = freezed,
    Object? activeAnimeProfileName = freezed,
    Object? activeAnimeDirectory = freezed,
    Object? is4k = freezed,
    Object? isDefault = freezed,
    Object? externalUrl = freezed,
    Object? syncEnabled = freezed,
    Object? preventSearch = freezed,
    Object? profiles = freezed,
    Object? tags = freezed,
    Object? rootFolders = freezed,
    Object? activeTags = freezed,
  }) {
    return _then(_SeerrSonarrServer(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hostname: freezed == hostname
          ? _self.hostname
          : hostname // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _self.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      apiKey: freezed == apiKey
          ? _self.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      useSsl: freezed == useSsl
          ? _self.useSsl
          : useSsl // ignore: cast_nullable_to_non_nullable
              as bool?,
      baseUrl: freezed == baseUrl
          ? _self.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      activeProfileId: freezed == activeProfileId
          ? _self.activeProfileId
          : activeProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeProfileName: freezed == activeProfileName
          ? _self.activeProfileName
          : activeProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      activeLanguageProfileId: freezed == activeLanguageProfileId
          ? _self.activeLanguageProfileId
          : activeLanguageProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeDirectory: freezed == activeDirectory
          ? _self.activeDirectory
          : activeDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAnimeProfileId: freezed == activeAnimeProfileId
          ? _self.activeAnimeProfileId
          : activeAnimeProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeAnimeLanguageProfileId: freezed == activeAnimeLanguageProfileId
          ? _self.activeAnimeLanguageProfileId
          : activeAnimeLanguageProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeAnimeProfileName: freezed == activeAnimeProfileName
          ? _self.activeAnimeProfileName
          : activeAnimeProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAnimeDirectory: freezed == activeAnimeDirectory
          ? _self.activeAnimeDirectory
          : activeAnimeDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      is4k: freezed == is4k
          ? _self.is4k
          : is4k // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      externalUrl: freezed == externalUrl
          ? _self.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      syncEnabled: freezed == syncEnabled
          ? _self.syncEnabled
          : syncEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      preventSearch: freezed == preventSearch
          ? _self.preventSearch
          : preventSearch // ignore: cast_nullable_to_non_nullable
              as bool?,
      profiles: freezed == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceProfile>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>?,
      rootFolders: freezed == rootFolders
          ? _self.rootFolders
          : rootFolders // ignore: cast_nullable_to_non_nullable
              as List<SeerrRootFolder>?,
      activeTags: freezed == activeTags
          ? _self.activeTags
          : activeTags // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
mixin _$SeerrSonarrServerResponse {
  SeerrSonarrServer? get server;
  List<SeerrServiceProfile>? get profiles;
  List<SeerrRootFolder>? get rootFolders;
  List<SeerrServiceTag>? get tags;

  /// Create a copy of SeerrSonarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrSonarrServerResponseCopyWith<SeerrSonarrServerResponse> get copyWith =>
      _$SeerrSonarrServerResponseCopyWithImpl<SeerrSonarrServerResponse>(
          this as SeerrSonarrServerResponse, _$identity);

  /// Serializes this SeerrSonarrServerResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SeerrSonarrServerResponse(server: $server, profiles: $profiles, rootFolders: $rootFolders, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class $SeerrSonarrServerResponseCopyWith<$Res> {
  factory $SeerrSonarrServerResponseCopyWith(SeerrSonarrServerResponse value,
          $Res Function(SeerrSonarrServerResponse) _then) =
      _$SeerrSonarrServerResponseCopyWithImpl;
  @useResult
  $Res call(
      {SeerrSonarrServer? server,
      List<SeerrServiceProfile>? profiles,
      List<SeerrRootFolder>? rootFolders,
      List<SeerrServiceTag>? tags});

  $SeerrSonarrServerCopyWith<$Res>? get server;
}

/// @nodoc
class _$SeerrSonarrServerResponseCopyWithImpl<$Res>
    implements $SeerrSonarrServerResponseCopyWith<$Res> {
  _$SeerrSonarrServerResponseCopyWithImpl(this._self, this._then);

  final SeerrSonarrServerResponse _self;
  final $Res Function(SeerrSonarrServerResponse) _then;

  /// Create a copy of SeerrSonarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? server = freezed,
    Object? profiles = freezed,
    Object? rootFolders = freezed,
    Object? tags = freezed,
  }) {
    return _then(_self.copyWith(
      server: freezed == server
          ? _self.server
          : server // ignore: cast_nullable_to_non_nullable
              as SeerrSonarrServer?,
      profiles: freezed == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceProfile>?,
      rootFolders: freezed == rootFolders
          ? _self.rootFolders
          : rootFolders // ignore: cast_nullable_to_non_nullable
              as List<SeerrRootFolder>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>?,
    ));
  }

  /// Create a copy of SeerrSonarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrSonarrServerCopyWith<$Res>? get server {
    if (_self.server == null) {
      return null;
    }

    return $SeerrSonarrServerCopyWith<$Res>(_self.server!, (value) {
      return _then(_self.copyWith(server: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SeerrSonarrServerResponse].
extension SeerrSonarrServerResponsePatterns on SeerrSonarrServerResponse {
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
    TResult Function(_SeerrSonarrServerResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServerResponse() when $default != null:
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
    TResult Function(_SeerrSonarrServerResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServerResponse():
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
    TResult? Function(_SeerrSonarrServerResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServerResponse() when $default != null:
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
            SeerrSonarrServer? server,
            List<SeerrServiceProfile>? profiles,
            List<SeerrRootFolder>? rootFolders,
            List<SeerrServiceTag>? tags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServerResponse() when $default != null:
        return $default(
            _that.server, _that.profiles, _that.rootFolders, _that.tags);
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
            SeerrSonarrServer? server,
            List<SeerrServiceProfile>? profiles,
            List<SeerrRootFolder>? rootFolders,
            List<SeerrServiceTag>? tags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServerResponse():
        return $default(
            _that.server, _that.profiles, _that.rootFolders, _that.tags);
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
            SeerrSonarrServer? server,
            List<SeerrServiceProfile>? profiles,
            List<SeerrRootFolder>? rootFolders,
            List<SeerrServiceTag>? tags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrSonarrServerResponse() when $default != null:
        return $default(
            _that.server, _that.profiles, _that.rootFolders, _that.tags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeerrSonarrServerResponse implements SeerrSonarrServerResponse {
  const _SeerrSonarrServerResponse(
      {this.server, this.profiles, this.rootFolders, this.tags});
  factory _SeerrSonarrServerResponse.fromJson(Map<String, dynamic> json) =>
      _$SeerrSonarrServerResponseFromJson(json);

  @override
  final SeerrSonarrServer? server;
  @override
  final List<SeerrServiceProfile>? profiles;
  @override
  final List<SeerrRootFolder>? rootFolders;
  @override
  final List<SeerrServiceTag>? tags;

  /// Create a copy of SeerrSonarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrSonarrServerResponseCopyWith<_SeerrSonarrServerResponse>
      get copyWith =>
          __$SeerrSonarrServerResponseCopyWithImpl<_SeerrSonarrServerResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeerrSonarrServerResponseToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SeerrSonarrServerResponse(server: $server, profiles: $profiles, rootFolders: $rootFolders, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class _$SeerrSonarrServerResponseCopyWith<$Res>
    implements $SeerrSonarrServerResponseCopyWith<$Res> {
  factory _$SeerrSonarrServerResponseCopyWith(_SeerrSonarrServerResponse value,
          $Res Function(_SeerrSonarrServerResponse) _then) =
      __$SeerrSonarrServerResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SeerrSonarrServer? server,
      List<SeerrServiceProfile>? profiles,
      List<SeerrRootFolder>? rootFolders,
      List<SeerrServiceTag>? tags});

  @override
  $SeerrSonarrServerCopyWith<$Res>? get server;
}

/// @nodoc
class __$SeerrSonarrServerResponseCopyWithImpl<$Res>
    implements _$SeerrSonarrServerResponseCopyWith<$Res> {
  __$SeerrSonarrServerResponseCopyWithImpl(this._self, this._then);

  final _SeerrSonarrServerResponse _self;
  final $Res Function(_SeerrSonarrServerResponse) _then;

  /// Create a copy of SeerrSonarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? server = freezed,
    Object? profiles = freezed,
    Object? rootFolders = freezed,
    Object? tags = freezed,
  }) {
    return _then(_SeerrSonarrServerResponse(
      server: freezed == server
          ? _self.server
          : server // ignore: cast_nullable_to_non_nullable
              as SeerrSonarrServer?,
      profiles: freezed == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceProfile>?,
      rootFolders: freezed == rootFolders
          ? _self.rootFolders
          : rootFolders // ignore: cast_nullable_to_non_nullable
              as List<SeerrRootFolder>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>?,
    ));
  }

  /// Create a copy of SeerrSonarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrSonarrServerCopyWith<$Res>? get server {
    if (_self.server == null) {
      return null;
    }

    return $SeerrSonarrServerCopyWith<$Res>(_self.server!, (value) {
      return _then(_self.copyWith(server: value));
    });
  }
}

/// @nodoc
mixin _$SeerrRadarrServer {
  int? get id;
  String? get name;
  String? get hostname;
  int? get port;
  String? get apiKey;
  bool? get useSsl;
  String? get baseUrl;
  int? get activeProfileId;
  String? get activeProfileName;
  int? get activeLanguageProfileId;
  String? get activeDirectory;
  int? get activeAnimeProfileId;
  int? get activeAnimeLanguageProfileId;
  String? get activeAnimeProfileName;
  String? get activeAnimeDirectory;
  bool? get is4k;
  bool? get isDefault;
  String? get externalUrl;
  bool? get syncEnabled;
  bool? get preventSearch;
  List<SeerrServiceProfile>? get profiles;
  List<SeerrServiceTag>? get tags;
  List<SeerrRootFolder>? get rootFolders;
  List<int>? get activeTags;

  /// Create a copy of SeerrRadarrServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrRadarrServerCopyWith<SeerrRadarrServer> get copyWith =>
      _$SeerrRadarrServerCopyWithImpl<SeerrRadarrServer>(
          this as SeerrRadarrServer, _$identity);

  /// Serializes this SeerrRadarrServer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SeerrRadarrServer(id: $id, name: $name, hostname: $hostname, port: $port, apiKey: $apiKey, useSsl: $useSsl, baseUrl: $baseUrl, activeProfileId: $activeProfileId, activeProfileName: $activeProfileName, activeLanguageProfileId: $activeLanguageProfileId, activeDirectory: $activeDirectory, activeAnimeProfileId: $activeAnimeProfileId, activeAnimeLanguageProfileId: $activeAnimeLanguageProfileId, activeAnimeProfileName: $activeAnimeProfileName, activeAnimeDirectory: $activeAnimeDirectory, is4k: $is4k, isDefault: $isDefault, externalUrl: $externalUrl, syncEnabled: $syncEnabled, preventSearch: $preventSearch, profiles: $profiles, tags: $tags, rootFolders: $rootFolders, activeTags: $activeTags)';
  }
}

/// @nodoc
abstract mixin class $SeerrRadarrServerCopyWith<$Res> {
  factory $SeerrRadarrServerCopyWith(
          SeerrRadarrServer value, $Res Function(SeerrRadarrServer) _then) =
      _$SeerrRadarrServerCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hostname,
      int? port,
      String? apiKey,
      bool? useSsl,
      String? baseUrl,
      int? activeProfileId,
      String? activeProfileName,
      int? activeLanguageProfileId,
      String? activeDirectory,
      int? activeAnimeProfileId,
      int? activeAnimeLanguageProfileId,
      String? activeAnimeProfileName,
      String? activeAnimeDirectory,
      bool? is4k,
      bool? isDefault,
      String? externalUrl,
      bool? syncEnabled,
      bool? preventSearch,
      List<SeerrServiceProfile>? profiles,
      List<SeerrServiceTag>? tags,
      List<SeerrRootFolder>? rootFolders,
      List<int>? activeTags});
}

/// @nodoc
class _$SeerrRadarrServerCopyWithImpl<$Res>
    implements $SeerrRadarrServerCopyWith<$Res> {
  _$SeerrRadarrServerCopyWithImpl(this._self, this._then);

  final SeerrRadarrServer _self;
  final $Res Function(SeerrRadarrServer) _then;

  /// Create a copy of SeerrRadarrServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hostname = freezed,
    Object? port = freezed,
    Object? apiKey = freezed,
    Object? useSsl = freezed,
    Object? baseUrl = freezed,
    Object? activeProfileId = freezed,
    Object? activeProfileName = freezed,
    Object? activeLanguageProfileId = freezed,
    Object? activeDirectory = freezed,
    Object? activeAnimeProfileId = freezed,
    Object? activeAnimeLanguageProfileId = freezed,
    Object? activeAnimeProfileName = freezed,
    Object? activeAnimeDirectory = freezed,
    Object? is4k = freezed,
    Object? isDefault = freezed,
    Object? externalUrl = freezed,
    Object? syncEnabled = freezed,
    Object? preventSearch = freezed,
    Object? profiles = freezed,
    Object? tags = freezed,
    Object? rootFolders = freezed,
    Object? activeTags = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hostname: freezed == hostname
          ? _self.hostname
          : hostname // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _self.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      apiKey: freezed == apiKey
          ? _self.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      useSsl: freezed == useSsl
          ? _self.useSsl
          : useSsl // ignore: cast_nullable_to_non_nullable
              as bool?,
      baseUrl: freezed == baseUrl
          ? _self.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      activeProfileId: freezed == activeProfileId
          ? _self.activeProfileId
          : activeProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeProfileName: freezed == activeProfileName
          ? _self.activeProfileName
          : activeProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      activeLanguageProfileId: freezed == activeLanguageProfileId
          ? _self.activeLanguageProfileId
          : activeLanguageProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeDirectory: freezed == activeDirectory
          ? _self.activeDirectory
          : activeDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAnimeProfileId: freezed == activeAnimeProfileId
          ? _self.activeAnimeProfileId
          : activeAnimeProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeAnimeLanguageProfileId: freezed == activeAnimeLanguageProfileId
          ? _self.activeAnimeLanguageProfileId
          : activeAnimeLanguageProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeAnimeProfileName: freezed == activeAnimeProfileName
          ? _self.activeAnimeProfileName
          : activeAnimeProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAnimeDirectory: freezed == activeAnimeDirectory
          ? _self.activeAnimeDirectory
          : activeAnimeDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      is4k: freezed == is4k
          ? _self.is4k
          : is4k // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      externalUrl: freezed == externalUrl
          ? _self.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      syncEnabled: freezed == syncEnabled
          ? _self.syncEnabled
          : syncEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      preventSearch: freezed == preventSearch
          ? _self.preventSearch
          : preventSearch // ignore: cast_nullable_to_non_nullable
              as bool?,
      profiles: freezed == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceProfile>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>?,
      rootFolders: freezed == rootFolders
          ? _self.rootFolders
          : rootFolders // ignore: cast_nullable_to_non_nullable
              as List<SeerrRootFolder>?,
      activeTags: freezed == activeTags
          ? _self.activeTags
          : activeTags // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeerrRadarrServer].
extension SeerrRadarrServerPatterns on SeerrRadarrServer {
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
    TResult Function(_SeerrRadarrServer value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServer() when $default != null:
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
    TResult Function(_SeerrRadarrServer value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServer():
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
    TResult? Function(_SeerrRadarrServer value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServer() when $default != null:
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
            int? id,
            String? name,
            String? hostname,
            int? port,
            String? apiKey,
            bool? useSsl,
            String? baseUrl,
            int? activeProfileId,
            String? activeProfileName,
            int? activeLanguageProfileId,
            String? activeDirectory,
            int? activeAnimeProfileId,
            int? activeAnimeLanguageProfileId,
            String? activeAnimeProfileName,
            String? activeAnimeDirectory,
            bool? is4k,
            bool? isDefault,
            String? externalUrl,
            bool? syncEnabled,
            bool? preventSearch,
            List<SeerrServiceProfile>? profiles,
            List<SeerrServiceTag>? tags,
            List<SeerrRootFolder>? rootFolders,
            List<int>? activeTags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServer() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.hostname,
            _that.port,
            _that.apiKey,
            _that.useSsl,
            _that.baseUrl,
            _that.activeProfileId,
            _that.activeProfileName,
            _that.activeLanguageProfileId,
            _that.activeDirectory,
            _that.activeAnimeProfileId,
            _that.activeAnimeLanguageProfileId,
            _that.activeAnimeProfileName,
            _that.activeAnimeDirectory,
            _that.is4k,
            _that.isDefault,
            _that.externalUrl,
            _that.syncEnabled,
            _that.preventSearch,
            _that.profiles,
            _that.tags,
            _that.rootFolders,
            _that.activeTags);
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
            int? id,
            String? name,
            String? hostname,
            int? port,
            String? apiKey,
            bool? useSsl,
            String? baseUrl,
            int? activeProfileId,
            String? activeProfileName,
            int? activeLanguageProfileId,
            String? activeDirectory,
            int? activeAnimeProfileId,
            int? activeAnimeLanguageProfileId,
            String? activeAnimeProfileName,
            String? activeAnimeDirectory,
            bool? is4k,
            bool? isDefault,
            String? externalUrl,
            bool? syncEnabled,
            bool? preventSearch,
            List<SeerrServiceProfile>? profiles,
            List<SeerrServiceTag>? tags,
            List<SeerrRootFolder>? rootFolders,
            List<int>? activeTags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServer():
        return $default(
            _that.id,
            _that.name,
            _that.hostname,
            _that.port,
            _that.apiKey,
            _that.useSsl,
            _that.baseUrl,
            _that.activeProfileId,
            _that.activeProfileName,
            _that.activeLanguageProfileId,
            _that.activeDirectory,
            _that.activeAnimeProfileId,
            _that.activeAnimeLanguageProfileId,
            _that.activeAnimeProfileName,
            _that.activeAnimeDirectory,
            _that.is4k,
            _that.isDefault,
            _that.externalUrl,
            _that.syncEnabled,
            _that.preventSearch,
            _that.profiles,
            _that.tags,
            _that.rootFolders,
            _that.activeTags);
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
            int? id,
            String? name,
            String? hostname,
            int? port,
            String? apiKey,
            bool? useSsl,
            String? baseUrl,
            int? activeProfileId,
            String? activeProfileName,
            int? activeLanguageProfileId,
            String? activeDirectory,
            int? activeAnimeProfileId,
            int? activeAnimeLanguageProfileId,
            String? activeAnimeProfileName,
            String? activeAnimeDirectory,
            bool? is4k,
            bool? isDefault,
            String? externalUrl,
            bool? syncEnabled,
            bool? preventSearch,
            List<SeerrServiceProfile>? profiles,
            List<SeerrServiceTag>? tags,
            List<SeerrRootFolder>? rootFolders,
            List<int>? activeTags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServer() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.hostname,
            _that.port,
            _that.apiKey,
            _that.useSsl,
            _that.baseUrl,
            _that.activeProfileId,
            _that.activeProfileName,
            _that.activeLanguageProfileId,
            _that.activeDirectory,
            _that.activeAnimeProfileId,
            _that.activeAnimeLanguageProfileId,
            _that.activeAnimeProfileName,
            _that.activeAnimeDirectory,
            _that.is4k,
            _that.isDefault,
            _that.externalUrl,
            _that.syncEnabled,
            _that.preventSearch,
            _that.profiles,
            _that.tags,
            _that.rootFolders,
            _that.activeTags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeerrRadarrServer implements SeerrRadarrServer {
  const _SeerrRadarrServer(
      {this.id,
      this.name,
      this.hostname,
      this.port,
      this.apiKey,
      this.useSsl,
      this.baseUrl,
      this.activeProfileId,
      this.activeProfileName,
      this.activeLanguageProfileId,
      this.activeDirectory,
      this.activeAnimeProfileId,
      this.activeAnimeLanguageProfileId,
      this.activeAnimeProfileName,
      this.activeAnimeDirectory,
      this.is4k,
      this.isDefault,
      this.externalUrl,
      this.syncEnabled,
      this.preventSearch,
      this.profiles,
      this.tags,
      this.rootFolders,
      this.activeTags});
  factory _SeerrRadarrServer.fromJson(Map<String, dynamic> json) =>
      _$SeerrRadarrServerFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? hostname;
  @override
  final int? port;
  @override
  final String? apiKey;
  @override
  final bool? useSsl;
  @override
  final String? baseUrl;
  @override
  final int? activeProfileId;
  @override
  final String? activeProfileName;
  @override
  final int? activeLanguageProfileId;
  @override
  final String? activeDirectory;
  @override
  final int? activeAnimeProfileId;
  @override
  final int? activeAnimeLanguageProfileId;
  @override
  final String? activeAnimeProfileName;
  @override
  final String? activeAnimeDirectory;
  @override
  final bool? is4k;
  @override
  final bool? isDefault;
  @override
  final String? externalUrl;
  @override
  final bool? syncEnabled;
  @override
  final bool? preventSearch;
  @override
  final List<SeerrServiceProfile>? profiles;
  @override
  final List<SeerrServiceTag>? tags;
  @override
  final List<SeerrRootFolder>? rootFolders;
  @override
  final List<int>? activeTags;

  /// Create a copy of SeerrRadarrServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrRadarrServerCopyWith<_SeerrRadarrServer> get copyWith =>
      __$SeerrRadarrServerCopyWithImpl<_SeerrRadarrServer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeerrRadarrServerToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SeerrRadarrServer(id: $id, name: $name, hostname: $hostname, port: $port, apiKey: $apiKey, useSsl: $useSsl, baseUrl: $baseUrl, activeProfileId: $activeProfileId, activeProfileName: $activeProfileName, activeLanguageProfileId: $activeLanguageProfileId, activeDirectory: $activeDirectory, activeAnimeProfileId: $activeAnimeProfileId, activeAnimeLanguageProfileId: $activeAnimeLanguageProfileId, activeAnimeProfileName: $activeAnimeProfileName, activeAnimeDirectory: $activeAnimeDirectory, is4k: $is4k, isDefault: $isDefault, externalUrl: $externalUrl, syncEnabled: $syncEnabled, preventSearch: $preventSearch, profiles: $profiles, tags: $tags, rootFolders: $rootFolders, activeTags: $activeTags)';
  }
}

/// @nodoc
abstract mixin class _$SeerrRadarrServerCopyWith<$Res>
    implements $SeerrRadarrServerCopyWith<$Res> {
  factory _$SeerrRadarrServerCopyWith(
          _SeerrRadarrServer value, $Res Function(_SeerrRadarrServer) _then) =
      __$SeerrRadarrServerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hostname,
      int? port,
      String? apiKey,
      bool? useSsl,
      String? baseUrl,
      int? activeProfileId,
      String? activeProfileName,
      int? activeLanguageProfileId,
      String? activeDirectory,
      int? activeAnimeProfileId,
      int? activeAnimeLanguageProfileId,
      String? activeAnimeProfileName,
      String? activeAnimeDirectory,
      bool? is4k,
      bool? isDefault,
      String? externalUrl,
      bool? syncEnabled,
      bool? preventSearch,
      List<SeerrServiceProfile>? profiles,
      List<SeerrServiceTag>? tags,
      List<SeerrRootFolder>? rootFolders,
      List<int>? activeTags});
}

/// @nodoc
class __$SeerrRadarrServerCopyWithImpl<$Res>
    implements _$SeerrRadarrServerCopyWith<$Res> {
  __$SeerrRadarrServerCopyWithImpl(this._self, this._then);

  final _SeerrRadarrServer _self;
  final $Res Function(_SeerrRadarrServer) _then;

  /// Create a copy of SeerrRadarrServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hostname = freezed,
    Object? port = freezed,
    Object? apiKey = freezed,
    Object? useSsl = freezed,
    Object? baseUrl = freezed,
    Object? activeProfileId = freezed,
    Object? activeProfileName = freezed,
    Object? activeLanguageProfileId = freezed,
    Object? activeDirectory = freezed,
    Object? activeAnimeProfileId = freezed,
    Object? activeAnimeLanguageProfileId = freezed,
    Object? activeAnimeProfileName = freezed,
    Object? activeAnimeDirectory = freezed,
    Object? is4k = freezed,
    Object? isDefault = freezed,
    Object? externalUrl = freezed,
    Object? syncEnabled = freezed,
    Object? preventSearch = freezed,
    Object? profiles = freezed,
    Object? tags = freezed,
    Object? rootFolders = freezed,
    Object? activeTags = freezed,
  }) {
    return _then(_SeerrRadarrServer(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hostname: freezed == hostname
          ? _self.hostname
          : hostname // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _self.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      apiKey: freezed == apiKey
          ? _self.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      useSsl: freezed == useSsl
          ? _self.useSsl
          : useSsl // ignore: cast_nullable_to_non_nullable
              as bool?,
      baseUrl: freezed == baseUrl
          ? _self.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      activeProfileId: freezed == activeProfileId
          ? _self.activeProfileId
          : activeProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeProfileName: freezed == activeProfileName
          ? _self.activeProfileName
          : activeProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      activeLanguageProfileId: freezed == activeLanguageProfileId
          ? _self.activeLanguageProfileId
          : activeLanguageProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeDirectory: freezed == activeDirectory
          ? _self.activeDirectory
          : activeDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAnimeProfileId: freezed == activeAnimeProfileId
          ? _self.activeAnimeProfileId
          : activeAnimeProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeAnimeLanguageProfileId: freezed == activeAnimeLanguageProfileId
          ? _self.activeAnimeLanguageProfileId
          : activeAnimeLanguageProfileId // ignore: cast_nullable_to_non_nullable
              as int?,
      activeAnimeProfileName: freezed == activeAnimeProfileName
          ? _self.activeAnimeProfileName
          : activeAnimeProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAnimeDirectory: freezed == activeAnimeDirectory
          ? _self.activeAnimeDirectory
          : activeAnimeDirectory // ignore: cast_nullable_to_non_nullable
              as String?,
      is4k: freezed == is4k
          ? _self.is4k
          : is4k // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      externalUrl: freezed == externalUrl
          ? _self.externalUrl
          : externalUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      syncEnabled: freezed == syncEnabled
          ? _self.syncEnabled
          : syncEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      preventSearch: freezed == preventSearch
          ? _self.preventSearch
          : preventSearch // ignore: cast_nullable_to_non_nullable
              as bool?,
      profiles: freezed == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceProfile>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>?,
      rootFolders: freezed == rootFolders
          ? _self.rootFolders
          : rootFolders // ignore: cast_nullable_to_non_nullable
              as List<SeerrRootFolder>?,
      activeTags: freezed == activeTags
          ? _self.activeTags
          : activeTags // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
mixin _$SeerrRadarrServerResponse {
  SeerrRadarrServer? get server;
  List<SeerrServiceProfile>? get profiles;
  List<SeerrRootFolder>? get rootFolders;
  List<SeerrServiceTag>? get tags;

  /// Create a copy of SeerrRadarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrRadarrServerResponseCopyWith<SeerrRadarrServerResponse> get copyWith =>
      _$SeerrRadarrServerResponseCopyWithImpl<SeerrRadarrServerResponse>(
          this as SeerrRadarrServerResponse, _$identity);

  /// Serializes this SeerrRadarrServerResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SeerrRadarrServerResponse(server: $server, profiles: $profiles, rootFolders: $rootFolders, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class $SeerrRadarrServerResponseCopyWith<$Res> {
  factory $SeerrRadarrServerResponseCopyWith(SeerrRadarrServerResponse value,
          $Res Function(SeerrRadarrServerResponse) _then) =
      _$SeerrRadarrServerResponseCopyWithImpl;
  @useResult
  $Res call(
      {SeerrRadarrServer? server,
      List<SeerrServiceProfile>? profiles,
      List<SeerrRootFolder>? rootFolders,
      List<SeerrServiceTag>? tags});

  $SeerrRadarrServerCopyWith<$Res>? get server;
}

/// @nodoc
class _$SeerrRadarrServerResponseCopyWithImpl<$Res>
    implements $SeerrRadarrServerResponseCopyWith<$Res> {
  _$SeerrRadarrServerResponseCopyWithImpl(this._self, this._then);

  final SeerrRadarrServerResponse _self;
  final $Res Function(SeerrRadarrServerResponse) _then;

  /// Create a copy of SeerrRadarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? server = freezed,
    Object? profiles = freezed,
    Object? rootFolders = freezed,
    Object? tags = freezed,
  }) {
    return _then(_self.copyWith(
      server: freezed == server
          ? _self.server
          : server // ignore: cast_nullable_to_non_nullable
              as SeerrRadarrServer?,
      profiles: freezed == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceProfile>?,
      rootFolders: freezed == rootFolders
          ? _self.rootFolders
          : rootFolders // ignore: cast_nullable_to_non_nullable
              as List<SeerrRootFolder>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>?,
    ));
  }

  /// Create a copy of SeerrRadarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrRadarrServerCopyWith<$Res>? get server {
    if (_self.server == null) {
      return null;
    }

    return $SeerrRadarrServerCopyWith<$Res>(_self.server!, (value) {
      return _then(_self.copyWith(server: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SeerrRadarrServerResponse].
extension SeerrRadarrServerResponsePatterns on SeerrRadarrServerResponse {
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
    TResult Function(_SeerrRadarrServerResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServerResponse() when $default != null:
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
    TResult Function(_SeerrRadarrServerResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServerResponse():
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
    TResult? Function(_SeerrRadarrServerResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServerResponse() when $default != null:
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
            SeerrRadarrServer? server,
            List<SeerrServiceProfile>? profiles,
            List<SeerrRootFolder>? rootFolders,
            List<SeerrServiceTag>? tags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServerResponse() when $default != null:
        return $default(
            _that.server, _that.profiles, _that.rootFolders, _that.tags);
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
            SeerrRadarrServer? server,
            List<SeerrServiceProfile>? profiles,
            List<SeerrRootFolder>? rootFolders,
            List<SeerrServiceTag>? tags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServerResponse():
        return $default(
            _that.server, _that.profiles, _that.rootFolders, _that.tags);
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
            SeerrRadarrServer? server,
            List<SeerrServiceProfile>? profiles,
            List<SeerrRootFolder>? rootFolders,
            List<SeerrServiceTag>? tags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRadarrServerResponse() when $default != null:
        return $default(
            _that.server, _that.profiles, _that.rootFolders, _that.tags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeerrRadarrServerResponse implements SeerrRadarrServerResponse {
  const _SeerrRadarrServerResponse(
      {this.server, this.profiles, this.rootFolders, this.tags});
  factory _SeerrRadarrServerResponse.fromJson(Map<String, dynamic> json) =>
      _$SeerrRadarrServerResponseFromJson(json);

  @override
  final SeerrRadarrServer? server;
  @override
  final List<SeerrServiceProfile>? profiles;
  @override
  final List<SeerrRootFolder>? rootFolders;
  @override
  final List<SeerrServiceTag>? tags;

  /// Create a copy of SeerrRadarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrRadarrServerResponseCopyWith<_SeerrRadarrServerResponse>
      get copyWith =>
          __$SeerrRadarrServerResponseCopyWithImpl<_SeerrRadarrServerResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeerrRadarrServerResponseToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SeerrRadarrServerResponse(server: $server, profiles: $profiles, rootFolders: $rootFolders, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class _$SeerrRadarrServerResponseCopyWith<$Res>
    implements $SeerrRadarrServerResponseCopyWith<$Res> {
  factory _$SeerrRadarrServerResponseCopyWith(_SeerrRadarrServerResponse value,
          $Res Function(_SeerrRadarrServerResponse) _then) =
      __$SeerrRadarrServerResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SeerrRadarrServer? server,
      List<SeerrServiceProfile>? profiles,
      List<SeerrRootFolder>? rootFolders,
      List<SeerrServiceTag>? tags});

  @override
  $SeerrRadarrServerCopyWith<$Res>? get server;
}

/// @nodoc
class __$SeerrRadarrServerResponseCopyWithImpl<$Res>
    implements _$SeerrRadarrServerResponseCopyWith<$Res> {
  __$SeerrRadarrServerResponseCopyWithImpl(this._self, this._then);

  final _SeerrRadarrServerResponse _self;
  final $Res Function(_SeerrRadarrServerResponse) _then;

  /// Create a copy of SeerrRadarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? server = freezed,
    Object? profiles = freezed,
    Object? rootFolders = freezed,
    Object? tags = freezed,
  }) {
    return _then(_SeerrRadarrServerResponse(
      server: freezed == server
          ? _self.server
          : server // ignore: cast_nullable_to_non_nullable
              as SeerrRadarrServer?,
      profiles: freezed == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceProfile>?,
      rootFolders: freezed == rootFolders
          ? _self.rootFolders
          : rootFolders // ignore: cast_nullable_to_non_nullable
              as List<SeerrRootFolder>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>?,
    ));
  }

  /// Create a copy of SeerrRadarrServerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrRadarrServerCopyWith<$Res>? get server {
    if (_self.server == null) {
      return null;
    }

    return $SeerrRadarrServerCopyWith<$Res>(_self.server!, (value) {
      return _then(_self.copyWith(server: value));
    });
  }
}

/// @nodoc
mixin _$SeerrServiceProfile {
  int? get id;
  String? get name;

  /// Create a copy of SeerrServiceProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrServiceProfileCopyWith<SeerrServiceProfile> get copyWith =>
      _$SeerrServiceProfileCopyWithImpl<SeerrServiceProfile>(
          this as SeerrServiceProfile, _$identity);

  /// Serializes this SeerrServiceProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SeerrServiceProfile(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $SeerrServiceProfileCopyWith<$Res> {
  factory $SeerrServiceProfileCopyWith(
          SeerrServiceProfile value, $Res Function(SeerrServiceProfile) _then) =
      _$SeerrServiceProfileCopyWithImpl;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$SeerrServiceProfileCopyWithImpl<$Res>
    implements $SeerrServiceProfileCopyWith<$Res> {
  _$SeerrServiceProfileCopyWithImpl(this._self, this._then);

  final SeerrServiceProfile _self;
  final $Res Function(SeerrServiceProfile) _then;

  /// Create a copy of SeerrServiceProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeerrServiceProfile].
extension SeerrServiceProfilePatterns on SeerrServiceProfile {
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
    TResult Function(_SeerrServiceProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceProfile() when $default != null:
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
    TResult Function(_SeerrServiceProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceProfile():
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
    TResult? Function(_SeerrServiceProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceProfile() when $default != null:
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
    TResult Function(int? id, String? name)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceProfile() when $default != null:
        return $default(_that.id, _that.name);
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
    TResult Function(int? id, String? name) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceProfile():
        return $default(_that.id, _that.name);
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
    TResult? Function(int? id, String? name)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceProfile() when $default != null:
        return $default(_that.id, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeerrServiceProfile implements SeerrServiceProfile {
  const _SeerrServiceProfile({this.id, this.name});
  factory _SeerrServiceProfile.fromJson(Map<String, dynamic> json) =>
      _$SeerrServiceProfileFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  /// Create a copy of SeerrServiceProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrServiceProfileCopyWith<_SeerrServiceProfile> get copyWith =>
      __$SeerrServiceProfileCopyWithImpl<_SeerrServiceProfile>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeerrServiceProfileToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SeerrServiceProfile(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$SeerrServiceProfileCopyWith<$Res>
    implements $SeerrServiceProfileCopyWith<$Res> {
  factory _$SeerrServiceProfileCopyWith(_SeerrServiceProfile value,
          $Res Function(_SeerrServiceProfile) _then) =
      __$SeerrServiceProfileCopyWithImpl;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$SeerrServiceProfileCopyWithImpl<$Res>
    implements _$SeerrServiceProfileCopyWith<$Res> {
  __$SeerrServiceProfileCopyWithImpl(this._self, this._then);

  final _SeerrServiceProfile _self;
  final $Res Function(_SeerrServiceProfile) _then;

  /// Create a copy of SeerrServiceProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_SeerrServiceProfile(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$SeerrServiceTag {
  int? get id;
  String? get label;

  /// Create a copy of SeerrServiceTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrServiceTagCopyWith<SeerrServiceTag> get copyWith =>
      _$SeerrServiceTagCopyWithImpl<SeerrServiceTag>(
          this as SeerrServiceTag, _$identity);

  /// Serializes this SeerrServiceTag to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SeerrServiceTag(id: $id, label: $label)';
  }
}

/// @nodoc
abstract mixin class $SeerrServiceTagCopyWith<$Res> {
  factory $SeerrServiceTagCopyWith(
          SeerrServiceTag value, $Res Function(SeerrServiceTag) _then) =
      _$SeerrServiceTagCopyWithImpl;
  @useResult
  $Res call({int? id, String? label});
}

/// @nodoc
class _$SeerrServiceTagCopyWithImpl<$Res>
    implements $SeerrServiceTagCopyWith<$Res> {
  _$SeerrServiceTagCopyWithImpl(this._self, this._then);

  final SeerrServiceTag _self;
  final $Res Function(SeerrServiceTag) _then;

  /// Create a copy of SeerrServiceTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeerrServiceTag].
extension SeerrServiceTagPatterns on SeerrServiceTag {
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
    TResult Function(_SeerrServiceTag value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceTag() when $default != null:
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
    TResult Function(_SeerrServiceTag value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceTag():
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
    TResult? Function(_SeerrServiceTag value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceTag() when $default != null:
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
    TResult Function(int? id, String? label)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceTag() when $default != null:
        return $default(_that.id, _that.label);
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
    TResult Function(int? id, String? label) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceTag():
        return $default(_that.id, _that.label);
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
    TResult? Function(int? id, String? label)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrServiceTag() when $default != null:
        return $default(_that.id, _that.label);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeerrServiceTag implements SeerrServiceTag {
  const _SeerrServiceTag({this.id, this.label});
  factory _SeerrServiceTag.fromJson(Map<String, dynamic> json) =>
      _$SeerrServiceTagFromJson(json);

  @override
  final int? id;
  @override
  final String? label;

  /// Create a copy of SeerrServiceTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrServiceTagCopyWith<_SeerrServiceTag> get copyWith =>
      __$SeerrServiceTagCopyWithImpl<_SeerrServiceTag>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeerrServiceTagToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SeerrServiceTag(id: $id, label: $label)';
  }
}

/// @nodoc
abstract mixin class _$SeerrServiceTagCopyWith<$Res>
    implements $SeerrServiceTagCopyWith<$Res> {
  factory _$SeerrServiceTagCopyWith(
          _SeerrServiceTag value, $Res Function(_SeerrServiceTag) _then) =
      __$SeerrServiceTagCopyWithImpl;
  @override
  @useResult
  $Res call({int? id, String? label});
}

/// @nodoc
class __$SeerrServiceTagCopyWithImpl<$Res>
    implements _$SeerrServiceTagCopyWith<$Res> {
  __$SeerrServiceTagCopyWithImpl(this._self, this._then);

  final _SeerrServiceTag _self;
  final $Res Function(_SeerrServiceTag) _then;

  /// Create a copy of SeerrServiceTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? label = freezed,
  }) {
    return _then(_SeerrServiceTag(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$SeerrRootFolder {
  int? get id;
  int? get freeSpace;
  String? get path;

  /// Create a copy of SeerrRootFolder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrRootFolderCopyWith<SeerrRootFolder> get copyWith =>
      _$SeerrRootFolderCopyWithImpl<SeerrRootFolder>(
          this as SeerrRootFolder, _$identity);

  /// Serializes this SeerrRootFolder to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SeerrRootFolder(id: $id, freeSpace: $freeSpace, path: $path)';
  }
}

/// @nodoc
abstract mixin class $SeerrRootFolderCopyWith<$Res> {
  factory $SeerrRootFolderCopyWith(
          SeerrRootFolder value, $Res Function(SeerrRootFolder) _then) =
      _$SeerrRootFolderCopyWithImpl;
  @useResult
  $Res call({int? id, int? freeSpace, String? path});
}

/// @nodoc
class _$SeerrRootFolderCopyWithImpl<$Res>
    implements $SeerrRootFolderCopyWith<$Res> {
  _$SeerrRootFolderCopyWithImpl(this._self, this._then);

  final SeerrRootFolder _self;
  final $Res Function(SeerrRootFolder) _then;

  /// Create a copy of SeerrRootFolder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? freeSpace = freezed,
    Object? path = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      freeSpace: freezed == freeSpace
          ? _self.freeSpace
          : freeSpace // ignore: cast_nullable_to_non_nullable
              as int?,
      path: freezed == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeerrRootFolder].
extension SeerrRootFolderPatterns on SeerrRootFolder {
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
    TResult Function(_SeerrRootFolder value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrRootFolder() when $default != null:
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
    TResult Function(_SeerrRootFolder value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRootFolder():
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
    TResult? Function(_SeerrRootFolder value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRootFolder() when $default != null:
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
    TResult Function(int? id, int? freeSpace, String? path)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrRootFolder() when $default != null:
        return $default(_that.id, _that.freeSpace, _that.path);
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
    TResult Function(int? id, int? freeSpace, String? path) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRootFolder():
        return $default(_that.id, _that.freeSpace, _that.path);
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
    TResult? Function(int? id, int? freeSpace, String? path)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRootFolder() when $default != null:
        return $default(_that.id, _that.freeSpace, _that.path);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeerrRootFolder implements SeerrRootFolder {
  const _SeerrRootFolder({this.id, this.freeSpace, this.path});
  factory _SeerrRootFolder.fromJson(Map<String, dynamic> json) =>
      _$SeerrRootFolderFromJson(json);

  @override
  final int? id;
  @override
  final int? freeSpace;
  @override
  final String? path;

  /// Create a copy of SeerrRootFolder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrRootFolderCopyWith<_SeerrRootFolder> get copyWith =>
      __$SeerrRootFolderCopyWithImpl<_SeerrRootFolder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeerrRootFolderToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SeerrRootFolder(id: $id, freeSpace: $freeSpace, path: $path)';
  }
}

/// @nodoc
abstract mixin class _$SeerrRootFolderCopyWith<$Res>
    implements $SeerrRootFolderCopyWith<$Res> {
  factory _$SeerrRootFolderCopyWith(
          _SeerrRootFolder value, $Res Function(_SeerrRootFolder) _then) =
      __$SeerrRootFolderCopyWithImpl;
  @override
  @useResult
  $Res call({int? id, int? freeSpace, String? path});
}

/// @nodoc
class __$SeerrRootFolderCopyWithImpl<$Res>
    implements _$SeerrRootFolderCopyWith<$Res> {
  __$SeerrRootFolderCopyWithImpl(this._self, this._then);

  final _SeerrRootFolder _self;
  final $Res Function(_SeerrRootFolder) _then;

  /// Create a copy of SeerrRootFolder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? freeSpace = freezed,
    Object? path = freezed,
  }) {
    return _then(_SeerrRootFolder(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      freeSpace: freezed == freeSpace
          ? _self.freeSpace
          : freeSpace // ignore: cast_nullable_to_non_nullable
              as int?,
      path: freezed == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$SeerrFilterModel {
  Map<SeerrGenre, bool> get genres;
  int? get yearGte;
  int? get yearLte;
  Map<SeerrWatchProvider, bool> get watchProviders;
  Map<SeerrCertification, bool> get certifications;
  double? get voteAverageGte;
  double? get voteAverageLte;
  int? get runtimeGte;
  int? get runtimeLte;
  String? get certificationGte;
  String? get certificationLte;
  SeerrSortBy get sortBy;
  String? get watchRegion;
  SeerrCompany? get studio;

  /// Create a copy of SeerrFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrFilterModelCopyWith<SeerrFilterModel> get copyWith =>
      _$SeerrFilterModelCopyWithImpl<SeerrFilterModel>(
          this as SeerrFilterModel, _$identity);

  @override
  String toString() {
    return 'SeerrFilterModel(genres: $genres, yearGte: $yearGte, yearLte: $yearLte, watchProviders: $watchProviders, certifications: $certifications, voteAverageGte: $voteAverageGte, voteAverageLte: $voteAverageLte, runtimeGte: $runtimeGte, runtimeLte: $runtimeLte, certificationGte: $certificationGte, certificationLte: $certificationLte, sortBy: $sortBy, watchRegion: $watchRegion, studio: $studio)';
  }
}

/// @nodoc
abstract mixin class $SeerrFilterModelCopyWith<$Res> {
  factory $SeerrFilterModelCopyWith(
          SeerrFilterModel value, $Res Function(SeerrFilterModel) _then) =
      _$SeerrFilterModelCopyWithImpl;
  @useResult
  $Res call(
      {Map<SeerrGenre, bool> genres,
      int? yearGte,
      int? yearLte,
      Map<SeerrWatchProvider, bool> watchProviders,
      Map<SeerrCertification, bool> certifications,
      double? voteAverageGte,
      double? voteAverageLte,
      int? runtimeGte,
      int? runtimeLte,
      String? certificationGte,
      String? certificationLte,
      SeerrSortBy sortBy,
      String? watchRegion,
      SeerrCompany? studio});
}

/// @nodoc
class _$SeerrFilterModelCopyWithImpl<$Res>
    implements $SeerrFilterModelCopyWith<$Res> {
  _$SeerrFilterModelCopyWithImpl(this._self, this._then);

  final SeerrFilterModel _self;
  final $Res Function(SeerrFilterModel) _then;

  /// Create a copy of SeerrFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genres = null,
    Object? yearGte = freezed,
    Object? yearLte = freezed,
    Object? watchProviders = null,
    Object? certifications = null,
    Object? voteAverageGte = freezed,
    Object? voteAverageLte = freezed,
    Object? runtimeGte = freezed,
    Object? runtimeLte = freezed,
    Object? certificationGte = freezed,
    Object? certificationLte = freezed,
    Object? sortBy = null,
    Object? watchRegion = freezed,
    Object? studio = freezed,
  }) {
    return _then(_self.copyWith(
      genres: null == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<SeerrGenre, bool>,
      yearGte: freezed == yearGte
          ? _self.yearGte
          : yearGte // ignore: cast_nullable_to_non_nullable
              as int?,
      yearLte: freezed == yearLte
          ? _self.yearLte
          : yearLte // ignore: cast_nullable_to_non_nullable
              as int?,
      watchProviders: null == watchProviders
          ? _self.watchProviders
          : watchProviders // ignore: cast_nullable_to_non_nullable
              as Map<SeerrWatchProvider, bool>,
      certifications: null == certifications
          ? _self.certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as Map<SeerrCertification, bool>,
      voteAverageGte: freezed == voteAverageGte
          ? _self.voteAverageGte
          : voteAverageGte // ignore: cast_nullable_to_non_nullable
              as double?,
      voteAverageLte: freezed == voteAverageLte
          ? _self.voteAverageLte
          : voteAverageLte // ignore: cast_nullable_to_non_nullable
              as double?,
      runtimeGte: freezed == runtimeGte
          ? _self.runtimeGte
          : runtimeGte // ignore: cast_nullable_to_non_nullable
              as int?,
      runtimeLte: freezed == runtimeLte
          ? _self.runtimeLte
          : runtimeLte // ignore: cast_nullable_to_non_nullable
              as int?,
      certificationGte: freezed == certificationGte
          ? _self.certificationGte
          : certificationGte // ignore: cast_nullable_to_non_nullable
              as String?,
      certificationLte: freezed == certificationLte
          ? _self.certificationLte
          : certificationLte // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: null == sortBy
          ? _self.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SeerrSortBy,
      watchRegion: freezed == watchRegion
          ? _self.watchRegion
          : watchRegion // ignore: cast_nullable_to_non_nullable
              as String?,
      studio: freezed == studio
          ? _self.studio
          : studio // ignore: cast_nullable_to_non_nullable
              as SeerrCompany?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeerrFilterModel].
extension SeerrFilterModelPatterns on SeerrFilterModel {
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
    TResult Function(_SeerrFilterModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrFilterModel() when $default != null:
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
    TResult Function(_SeerrFilterModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrFilterModel():
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
    TResult? Function(_SeerrFilterModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrFilterModel() when $default != null:
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
            Map<SeerrGenre, bool> genres,
            int? yearGte,
            int? yearLte,
            Map<SeerrWatchProvider, bool> watchProviders,
            Map<SeerrCertification, bool> certifications,
            double? voteAverageGte,
            double? voteAverageLte,
            int? runtimeGte,
            int? runtimeLte,
            String? certificationGte,
            String? certificationLte,
            SeerrSortBy sortBy,
            String? watchRegion,
            SeerrCompany? studio)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrFilterModel() when $default != null:
        return $default(
            _that.genres,
            _that.yearGte,
            _that.yearLte,
            _that.watchProviders,
            _that.certifications,
            _that.voteAverageGte,
            _that.voteAverageLte,
            _that.runtimeGte,
            _that.runtimeLte,
            _that.certificationGte,
            _that.certificationLte,
            _that.sortBy,
            _that.watchRegion,
            _that.studio);
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
            Map<SeerrGenre, bool> genres,
            int? yearGte,
            int? yearLte,
            Map<SeerrWatchProvider, bool> watchProviders,
            Map<SeerrCertification, bool> certifications,
            double? voteAverageGte,
            double? voteAverageLte,
            int? runtimeGte,
            int? runtimeLte,
            String? certificationGte,
            String? certificationLte,
            SeerrSortBy sortBy,
            String? watchRegion,
            SeerrCompany? studio)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrFilterModel():
        return $default(
            _that.genres,
            _that.yearGte,
            _that.yearLte,
            _that.watchProviders,
            _that.certifications,
            _that.voteAverageGte,
            _that.voteAverageLte,
            _that.runtimeGte,
            _that.runtimeLte,
            _that.certificationGte,
            _that.certificationLte,
            _that.sortBy,
            _that.watchRegion,
            _that.studio);
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
            Map<SeerrGenre, bool> genres,
            int? yearGte,
            int? yearLte,
            Map<SeerrWatchProvider, bool> watchProviders,
            Map<SeerrCertification, bool> certifications,
            double? voteAverageGte,
            double? voteAverageLte,
            int? runtimeGte,
            int? runtimeLte,
            String? certificationGte,
            String? certificationLte,
            SeerrSortBy sortBy,
            String? watchRegion,
            SeerrCompany? studio)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrFilterModel() when $default != null:
        return $default(
            _that.genres,
            _that.yearGte,
            _that.yearLte,
            _that.watchProviders,
            _that.certifications,
            _that.voteAverageGte,
            _that.voteAverageLte,
            _that.runtimeGte,
            _that.runtimeLte,
            _that.certificationGte,
            _that.certificationLte,
            _that.sortBy,
            _that.watchRegion,
            _that.studio);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SeerrFilterModel implements SeerrFilterModel {
  const _SeerrFilterModel(
      {final Map<SeerrGenre, bool> genres = const {},
      this.yearGte,
      this.yearLte,
      final Map<SeerrWatchProvider, bool> watchProviders = const {},
      final Map<SeerrCertification, bool> certifications = const {},
      this.voteAverageGte,
      this.voteAverageLte,
      this.runtimeGte,
      this.runtimeLte,
      this.certificationGte,
      this.certificationLte,
      this.sortBy = SeerrSortBy.popularityDesc,
      this.watchRegion = 'US',
      this.studio})
      : _genres = genres,
        _watchProviders = watchProviders,
        _certifications = certifications;

  final Map<SeerrGenre, bool> _genres;
  @override
  @JsonKey()
  Map<SeerrGenre, bool> get genres {
    if (_genres is EqualUnmodifiableMapView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_genres);
  }

  @override
  final int? yearGte;
  @override
  final int? yearLte;
  final Map<SeerrWatchProvider, bool> _watchProviders;
  @override
  @JsonKey()
  Map<SeerrWatchProvider, bool> get watchProviders {
    if (_watchProviders is EqualUnmodifiableMapView) return _watchProviders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_watchProviders);
  }

  final Map<SeerrCertification, bool> _certifications;
  @override
  @JsonKey()
  Map<SeerrCertification, bool> get certifications {
    if (_certifications is EqualUnmodifiableMapView) return _certifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_certifications);
  }

  @override
  final double? voteAverageGte;
  @override
  final double? voteAverageLte;
  @override
  final int? runtimeGte;
  @override
  final int? runtimeLte;
  @override
  final String? certificationGte;
  @override
  final String? certificationLte;
  @override
  @JsonKey()
  final SeerrSortBy sortBy;
  @override
  @JsonKey()
  final String? watchRegion;
  @override
  final SeerrCompany? studio;

  /// Create a copy of SeerrFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrFilterModelCopyWith<_SeerrFilterModel> get copyWith =>
      __$SeerrFilterModelCopyWithImpl<_SeerrFilterModel>(this, _$identity);

  @override
  String toString() {
    return 'SeerrFilterModel(genres: $genres, yearGte: $yearGte, yearLte: $yearLte, watchProviders: $watchProviders, certifications: $certifications, voteAverageGte: $voteAverageGte, voteAverageLte: $voteAverageLte, runtimeGte: $runtimeGte, runtimeLte: $runtimeLte, certificationGte: $certificationGte, certificationLte: $certificationLte, sortBy: $sortBy, watchRegion: $watchRegion, studio: $studio)';
  }
}

/// @nodoc
abstract mixin class _$SeerrFilterModelCopyWith<$Res>
    implements $SeerrFilterModelCopyWith<$Res> {
  factory _$SeerrFilterModelCopyWith(
          _SeerrFilterModel value, $Res Function(_SeerrFilterModel) _then) =
      __$SeerrFilterModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Map<SeerrGenre, bool> genres,
      int? yearGte,
      int? yearLte,
      Map<SeerrWatchProvider, bool> watchProviders,
      Map<SeerrCertification, bool> certifications,
      double? voteAverageGte,
      double? voteAverageLte,
      int? runtimeGte,
      int? runtimeLte,
      String? certificationGte,
      String? certificationLte,
      SeerrSortBy sortBy,
      String? watchRegion,
      SeerrCompany? studio});
}

/// @nodoc
class __$SeerrFilterModelCopyWithImpl<$Res>
    implements _$SeerrFilterModelCopyWith<$Res> {
  __$SeerrFilterModelCopyWithImpl(this._self, this._then);

  final _SeerrFilterModel _self;
  final $Res Function(_SeerrFilterModel) _then;

  /// Create a copy of SeerrFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? genres = null,
    Object? yearGte = freezed,
    Object? yearLte = freezed,
    Object? watchProviders = null,
    Object? certifications = null,
    Object? voteAverageGte = freezed,
    Object? voteAverageLte = freezed,
    Object? runtimeGte = freezed,
    Object? runtimeLte = freezed,
    Object? certificationGte = freezed,
    Object? certificationLte = freezed,
    Object? sortBy = null,
    Object? watchRegion = freezed,
    Object? studio = freezed,
  }) {
    return _then(_SeerrFilterModel(
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Map<SeerrGenre, bool>,
      yearGte: freezed == yearGte
          ? _self.yearGte
          : yearGte // ignore: cast_nullable_to_non_nullable
              as int?,
      yearLte: freezed == yearLte
          ? _self.yearLte
          : yearLte // ignore: cast_nullable_to_non_nullable
              as int?,
      watchProviders: null == watchProviders
          ? _self._watchProviders
          : watchProviders // ignore: cast_nullable_to_non_nullable
              as Map<SeerrWatchProvider, bool>,
      certifications: null == certifications
          ? _self._certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as Map<SeerrCertification, bool>,
      voteAverageGte: freezed == voteAverageGte
          ? _self.voteAverageGte
          : voteAverageGte // ignore: cast_nullable_to_non_nullable
              as double?,
      voteAverageLte: freezed == voteAverageLte
          ? _self.voteAverageLte
          : voteAverageLte // ignore: cast_nullable_to_non_nullable
              as double?,
      runtimeGte: freezed == runtimeGte
          ? _self.runtimeGte
          : runtimeGte // ignore: cast_nullable_to_non_nullable
              as int?,
      runtimeLte: freezed == runtimeLte
          ? _self.runtimeLte
          : runtimeLte // ignore: cast_nullable_to_non_nullable
              as int?,
      certificationGte: freezed == certificationGte
          ? _self.certificationGte
          : certificationGte // ignore: cast_nullable_to_non_nullable
              as String?,
      certificationLte: freezed == certificationLte
          ? _self.certificationLte
          : certificationLte // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: null == sortBy
          ? _self.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SeerrSortBy,
      watchRegion: freezed == watchRegion
          ? _self.watchRegion
          : watchRegion // ignore: cast_nullable_to_non_nullable
              as String?,
      studio: freezed == studio
          ? _self.studio
          : studio // ignore: cast_nullable_to_non_nullable
              as SeerrCompany?,
    ));
  }
}

// dart format on
