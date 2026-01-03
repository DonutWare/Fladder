// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seerr_request_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeerrRequestModel {
  SeerrDashboardPosterModel? get poster;
  List<SeerrSonarrServer> get sonarrServers;
  List<SeerrRadarrServer> get radarrServers;
  SeerrSonarrServer? get selectedSonarrServer;
  SeerrRadarrServer? get selectedRadarrServer;
  SeerrServiceProfile? get selectedProfile;
  String? get selectedRootFolder;
  List<SeerrServiceTag> get selectedTags;
  Map<int, bool> get selectedSeasons;
  Map<int, SeerrRequestStatus> get seasonStatuses;
  Map<int, SeerrUserQuota> get userQuotas;
  SeerrUserModel? get currentUser;
  SeerrUserModel? get selectedUser;
  List<SeerrUserModel> get availableUsers;
  bool get use4k;
  bool get isAnime;

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeerrRequestModelCopyWith<SeerrRequestModel> get copyWith =>
      _$SeerrRequestModelCopyWithImpl<SeerrRequestModel>(
          this as SeerrRequestModel, _$identity);

  @override
  String toString() {
    return 'SeerrRequestModel(poster: $poster, sonarrServers: $sonarrServers, radarrServers: $radarrServers, selectedSonarrServer: $selectedSonarrServer, selectedRadarrServer: $selectedRadarrServer, selectedProfile: $selectedProfile, selectedRootFolder: $selectedRootFolder, selectedTags: $selectedTags, selectedSeasons: $selectedSeasons, seasonStatuses: $seasonStatuses, userQuotas: $userQuotas, currentUser: $currentUser, selectedUser: $selectedUser, availableUsers: $availableUsers, use4k: $use4k, isAnime: $isAnime)';
  }
}

/// @nodoc
abstract mixin class $SeerrRequestModelCopyWith<$Res> {
  factory $SeerrRequestModelCopyWith(
          SeerrRequestModel value, $Res Function(SeerrRequestModel) _then) =
      _$SeerrRequestModelCopyWithImpl;
  @useResult
  $Res call(
      {SeerrDashboardPosterModel? poster,
      List<SeerrSonarrServer> sonarrServers,
      List<SeerrRadarrServer> radarrServers,
      SeerrSonarrServer? selectedSonarrServer,
      SeerrRadarrServer? selectedRadarrServer,
      SeerrServiceProfile? selectedProfile,
      String? selectedRootFolder,
      List<SeerrServiceTag> selectedTags,
      Map<int, bool> selectedSeasons,
      Map<int, SeerrRequestStatus> seasonStatuses,
      Map<int, SeerrUserQuota> userQuotas,
      SeerrUserModel? currentUser,
      SeerrUserModel? selectedUser,
      List<SeerrUserModel> availableUsers,
      bool use4k,
      bool isAnime});

  $SeerrSonarrServerCopyWith<$Res>? get selectedSonarrServer;
  $SeerrRadarrServerCopyWith<$Res>? get selectedRadarrServer;
  $SeerrServiceProfileCopyWith<$Res>? get selectedProfile;
  $SeerrUserModelCopyWith<$Res>? get currentUser;
  $SeerrUserModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class _$SeerrRequestModelCopyWithImpl<$Res>
    implements $SeerrRequestModelCopyWith<$Res> {
  _$SeerrRequestModelCopyWithImpl(this._self, this._then);

  final SeerrRequestModel _self;
  final $Res Function(SeerrRequestModel) _then;

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poster = freezed,
    Object? sonarrServers = null,
    Object? radarrServers = null,
    Object? selectedSonarrServer = freezed,
    Object? selectedRadarrServer = freezed,
    Object? selectedProfile = freezed,
    Object? selectedRootFolder = freezed,
    Object? selectedTags = null,
    Object? selectedSeasons = null,
    Object? seasonStatuses = null,
    Object? userQuotas = null,
    Object? currentUser = freezed,
    Object? selectedUser = freezed,
    Object? availableUsers = null,
    Object? use4k = null,
    Object? isAnime = null,
  }) {
    return _then(_self.copyWith(
      poster: freezed == poster
          ? _self.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as SeerrDashboardPosterModel?,
      sonarrServers: null == sonarrServers
          ? _self.sonarrServers
          : sonarrServers // ignore: cast_nullable_to_non_nullable
              as List<SeerrSonarrServer>,
      radarrServers: null == radarrServers
          ? _self.radarrServers
          : radarrServers // ignore: cast_nullable_to_non_nullable
              as List<SeerrRadarrServer>,
      selectedSonarrServer: freezed == selectedSonarrServer
          ? _self.selectedSonarrServer
          : selectedSonarrServer // ignore: cast_nullable_to_non_nullable
              as SeerrSonarrServer?,
      selectedRadarrServer: freezed == selectedRadarrServer
          ? _self.selectedRadarrServer
          : selectedRadarrServer // ignore: cast_nullable_to_non_nullable
              as SeerrRadarrServer?,
      selectedProfile: freezed == selectedProfile
          ? _self.selectedProfile
          : selectedProfile // ignore: cast_nullable_to_non_nullable
              as SeerrServiceProfile?,
      selectedRootFolder: freezed == selectedRootFolder
          ? _self.selectedRootFolder
          : selectedRootFolder // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTags: null == selectedTags
          ? _self.selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>,
      selectedSeasons: null == selectedSeasons
          ? _self.selectedSeasons
          : selectedSeasons // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      seasonStatuses: null == seasonStatuses
          ? _self.seasonStatuses
          : seasonStatuses // ignore: cast_nullable_to_non_nullable
              as Map<int, SeerrRequestStatus>,
      userQuotas: null == userQuotas
          ? _self.userQuotas
          : userQuotas // ignore: cast_nullable_to_non_nullable
              as Map<int, SeerrUserQuota>,
      currentUser: freezed == currentUser
          ? _self.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as SeerrUserModel?,
      selectedUser: freezed == selectedUser
          ? _self.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as SeerrUserModel?,
      availableUsers: null == availableUsers
          ? _self.availableUsers
          : availableUsers // ignore: cast_nullable_to_non_nullable
              as List<SeerrUserModel>,
      use4k: null == use4k
          ? _self.use4k
          : use4k // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnime: null == isAnime
          ? _self.isAnime
          : isAnime // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrSonarrServerCopyWith<$Res>? get selectedSonarrServer {
    if (_self.selectedSonarrServer == null) {
      return null;
    }

    return $SeerrSonarrServerCopyWith<$Res>(_self.selectedSonarrServer!,
        (value) {
      return _then(_self.copyWith(selectedSonarrServer: value));
    });
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrRadarrServerCopyWith<$Res>? get selectedRadarrServer {
    if (_self.selectedRadarrServer == null) {
      return null;
    }

    return $SeerrRadarrServerCopyWith<$Res>(_self.selectedRadarrServer!,
        (value) {
      return _then(_self.copyWith(selectedRadarrServer: value));
    });
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrServiceProfileCopyWith<$Res>? get selectedProfile {
    if (_self.selectedProfile == null) {
      return null;
    }

    return $SeerrServiceProfileCopyWith<$Res>(_self.selectedProfile!, (value) {
      return _then(_self.copyWith(selectedProfile: value));
    });
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrUserModelCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
      return null;
    }

    return $SeerrUserModelCopyWith<$Res>(_self.currentUser!, (value) {
      return _then(_self.copyWith(currentUser: value));
    });
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrUserModelCopyWith<$Res>? get selectedUser {
    if (_self.selectedUser == null) {
      return null;
    }

    return $SeerrUserModelCopyWith<$Res>(_self.selectedUser!, (value) {
      return _then(_self.copyWith(selectedUser: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SeerrRequestModel].
extension SeerrRequestModelPatterns on SeerrRequestModel {
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
    TResult Function(_SeerrRequestModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrRequestModel() when $default != null:
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
    TResult Function(_SeerrRequestModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRequestModel():
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
    TResult? Function(_SeerrRequestModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRequestModel() when $default != null:
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
            SeerrDashboardPosterModel? poster,
            List<SeerrSonarrServer> sonarrServers,
            List<SeerrRadarrServer> radarrServers,
            SeerrSonarrServer? selectedSonarrServer,
            SeerrRadarrServer? selectedRadarrServer,
            SeerrServiceProfile? selectedProfile,
            String? selectedRootFolder,
            List<SeerrServiceTag> selectedTags,
            Map<int, bool> selectedSeasons,
            Map<int, SeerrRequestStatus> seasonStatuses,
            Map<int, SeerrUserQuota> userQuotas,
            SeerrUserModel? currentUser,
            SeerrUserModel? selectedUser,
            List<SeerrUserModel> availableUsers,
            bool use4k,
            bool isAnime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeerrRequestModel() when $default != null:
        return $default(
            _that.poster,
            _that.sonarrServers,
            _that.radarrServers,
            _that.selectedSonarrServer,
            _that.selectedRadarrServer,
            _that.selectedProfile,
            _that.selectedRootFolder,
            _that.selectedTags,
            _that.selectedSeasons,
            _that.seasonStatuses,
            _that.userQuotas,
            _that.currentUser,
            _that.selectedUser,
            _that.availableUsers,
            _that.use4k,
            _that.isAnime);
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
            SeerrDashboardPosterModel? poster,
            List<SeerrSonarrServer> sonarrServers,
            List<SeerrRadarrServer> radarrServers,
            SeerrSonarrServer? selectedSonarrServer,
            SeerrRadarrServer? selectedRadarrServer,
            SeerrServiceProfile? selectedProfile,
            String? selectedRootFolder,
            List<SeerrServiceTag> selectedTags,
            Map<int, bool> selectedSeasons,
            Map<int, SeerrRequestStatus> seasonStatuses,
            Map<int, SeerrUserQuota> userQuotas,
            SeerrUserModel? currentUser,
            SeerrUserModel? selectedUser,
            List<SeerrUserModel> availableUsers,
            bool use4k,
            bool isAnime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRequestModel():
        return $default(
            _that.poster,
            _that.sonarrServers,
            _that.radarrServers,
            _that.selectedSonarrServer,
            _that.selectedRadarrServer,
            _that.selectedProfile,
            _that.selectedRootFolder,
            _that.selectedTags,
            _that.selectedSeasons,
            _that.seasonStatuses,
            _that.userQuotas,
            _that.currentUser,
            _that.selectedUser,
            _that.availableUsers,
            _that.use4k,
            _that.isAnime);
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
            SeerrDashboardPosterModel? poster,
            List<SeerrSonarrServer> sonarrServers,
            List<SeerrRadarrServer> radarrServers,
            SeerrSonarrServer? selectedSonarrServer,
            SeerrRadarrServer? selectedRadarrServer,
            SeerrServiceProfile? selectedProfile,
            String? selectedRootFolder,
            List<SeerrServiceTag> selectedTags,
            Map<int, bool> selectedSeasons,
            Map<int, SeerrRequestStatus> seasonStatuses,
            Map<int, SeerrUserQuota> userQuotas,
            SeerrUserModel? currentUser,
            SeerrUserModel? selectedUser,
            List<SeerrUserModel> availableUsers,
            bool use4k,
            bool isAnime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeerrRequestModel() when $default != null:
        return $default(
            _that.poster,
            _that.sonarrServers,
            _that.radarrServers,
            _that.selectedSonarrServer,
            _that.selectedRadarrServer,
            _that.selectedProfile,
            _that.selectedRootFolder,
            _that.selectedTags,
            _that.selectedSeasons,
            _that.seasonStatuses,
            _that.userQuotas,
            _that.currentUser,
            _that.selectedUser,
            _that.availableUsers,
            _that.use4k,
            _that.isAnime);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SeerrRequestModel extends SeerrRequestModel {
  _SeerrRequestModel(
      {this.poster,
      final List<SeerrSonarrServer> sonarrServers = const [],
      final List<SeerrRadarrServer> radarrServers = const [],
      this.selectedSonarrServer,
      this.selectedRadarrServer,
      this.selectedProfile,
      this.selectedRootFolder,
      final List<SeerrServiceTag> selectedTags = const [],
      final Map<int, bool> selectedSeasons = const {},
      final Map<int, SeerrRequestStatus> seasonStatuses = const {},
      final Map<int, SeerrUserQuota> userQuotas = const {},
      this.currentUser,
      this.selectedUser,
      final List<SeerrUserModel> availableUsers = const [],
      this.use4k = false,
      this.isAnime = false})
      : _sonarrServers = sonarrServers,
        _radarrServers = radarrServers,
        _selectedTags = selectedTags,
        _selectedSeasons = selectedSeasons,
        _seasonStatuses = seasonStatuses,
        _userQuotas = userQuotas,
        _availableUsers = availableUsers,
        super._();

  @override
  final SeerrDashboardPosterModel? poster;
  final List<SeerrSonarrServer> _sonarrServers;
  @override
  @JsonKey()
  List<SeerrSonarrServer> get sonarrServers {
    if (_sonarrServers is EqualUnmodifiableListView) return _sonarrServers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sonarrServers);
  }

  final List<SeerrRadarrServer> _radarrServers;
  @override
  @JsonKey()
  List<SeerrRadarrServer> get radarrServers {
    if (_radarrServers is EqualUnmodifiableListView) return _radarrServers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_radarrServers);
  }

  @override
  final SeerrSonarrServer? selectedSonarrServer;
  @override
  final SeerrRadarrServer? selectedRadarrServer;
  @override
  final SeerrServiceProfile? selectedProfile;
  @override
  final String? selectedRootFolder;
  final List<SeerrServiceTag> _selectedTags;
  @override
  @JsonKey()
  List<SeerrServiceTag> get selectedTags {
    if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTags);
  }

  final Map<int, bool> _selectedSeasons;
  @override
  @JsonKey()
  Map<int, bool> get selectedSeasons {
    if (_selectedSeasons is EqualUnmodifiableMapView) return _selectedSeasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedSeasons);
  }

  final Map<int, SeerrRequestStatus> _seasonStatuses;
  @override
  @JsonKey()
  Map<int, SeerrRequestStatus> get seasonStatuses {
    if (_seasonStatuses is EqualUnmodifiableMapView) return _seasonStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_seasonStatuses);
  }

  final Map<int, SeerrUserQuota> _userQuotas;
  @override
  @JsonKey()
  Map<int, SeerrUserQuota> get userQuotas {
    if (_userQuotas is EqualUnmodifiableMapView) return _userQuotas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userQuotas);
  }

  @override
  final SeerrUserModel? currentUser;
  @override
  final SeerrUserModel? selectedUser;
  final List<SeerrUserModel> _availableUsers;
  @override
  @JsonKey()
  List<SeerrUserModel> get availableUsers {
    if (_availableUsers is EqualUnmodifiableListView) return _availableUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableUsers);
  }

  @override
  @JsonKey()
  final bool use4k;
  @override
  @JsonKey()
  final bool isAnime;

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeerrRequestModelCopyWith<_SeerrRequestModel> get copyWith =>
      __$SeerrRequestModelCopyWithImpl<_SeerrRequestModel>(this, _$identity);

  @override
  String toString() {
    return 'SeerrRequestModel(poster: $poster, sonarrServers: $sonarrServers, radarrServers: $radarrServers, selectedSonarrServer: $selectedSonarrServer, selectedRadarrServer: $selectedRadarrServer, selectedProfile: $selectedProfile, selectedRootFolder: $selectedRootFolder, selectedTags: $selectedTags, selectedSeasons: $selectedSeasons, seasonStatuses: $seasonStatuses, userQuotas: $userQuotas, currentUser: $currentUser, selectedUser: $selectedUser, availableUsers: $availableUsers, use4k: $use4k, isAnime: $isAnime)';
  }
}

/// @nodoc
abstract mixin class _$SeerrRequestModelCopyWith<$Res>
    implements $SeerrRequestModelCopyWith<$Res> {
  factory _$SeerrRequestModelCopyWith(
          _SeerrRequestModel value, $Res Function(_SeerrRequestModel) _then) =
      __$SeerrRequestModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SeerrDashboardPosterModel? poster,
      List<SeerrSonarrServer> sonarrServers,
      List<SeerrRadarrServer> radarrServers,
      SeerrSonarrServer? selectedSonarrServer,
      SeerrRadarrServer? selectedRadarrServer,
      SeerrServiceProfile? selectedProfile,
      String? selectedRootFolder,
      List<SeerrServiceTag> selectedTags,
      Map<int, bool> selectedSeasons,
      Map<int, SeerrRequestStatus> seasonStatuses,
      Map<int, SeerrUserQuota> userQuotas,
      SeerrUserModel? currentUser,
      SeerrUserModel? selectedUser,
      List<SeerrUserModel> availableUsers,
      bool use4k,
      bool isAnime});

  @override
  $SeerrSonarrServerCopyWith<$Res>? get selectedSonarrServer;
  @override
  $SeerrRadarrServerCopyWith<$Res>? get selectedRadarrServer;
  @override
  $SeerrServiceProfileCopyWith<$Res>? get selectedProfile;
  @override
  $SeerrUserModelCopyWith<$Res>? get currentUser;
  @override
  $SeerrUserModelCopyWith<$Res>? get selectedUser;
}

/// @nodoc
class __$SeerrRequestModelCopyWithImpl<$Res>
    implements _$SeerrRequestModelCopyWith<$Res> {
  __$SeerrRequestModelCopyWithImpl(this._self, this._then);

  final _SeerrRequestModel _self;
  final $Res Function(_SeerrRequestModel) _then;

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? poster = freezed,
    Object? sonarrServers = null,
    Object? radarrServers = null,
    Object? selectedSonarrServer = freezed,
    Object? selectedRadarrServer = freezed,
    Object? selectedProfile = freezed,
    Object? selectedRootFolder = freezed,
    Object? selectedTags = null,
    Object? selectedSeasons = null,
    Object? seasonStatuses = null,
    Object? userQuotas = null,
    Object? currentUser = freezed,
    Object? selectedUser = freezed,
    Object? availableUsers = null,
    Object? use4k = null,
    Object? isAnime = null,
  }) {
    return _then(_SeerrRequestModel(
      poster: freezed == poster
          ? _self.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as SeerrDashboardPosterModel?,
      sonarrServers: null == sonarrServers
          ? _self._sonarrServers
          : sonarrServers // ignore: cast_nullable_to_non_nullable
              as List<SeerrSonarrServer>,
      radarrServers: null == radarrServers
          ? _self._radarrServers
          : radarrServers // ignore: cast_nullable_to_non_nullable
              as List<SeerrRadarrServer>,
      selectedSonarrServer: freezed == selectedSonarrServer
          ? _self.selectedSonarrServer
          : selectedSonarrServer // ignore: cast_nullable_to_non_nullable
              as SeerrSonarrServer?,
      selectedRadarrServer: freezed == selectedRadarrServer
          ? _self.selectedRadarrServer
          : selectedRadarrServer // ignore: cast_nullable_to_non_nullable
              as SeerrRadarrServer?,
      selectedProfile: freezed == selectedProfile
          ? _self.selectedProfile
          : selectedProfile // ignore: cast_nullable_to_non_nullable
              as SeerrServiceProfile?,
      selectedRootFolder: freezed == selectedRootFolder
          ? _self.selectedRootFolder
          : selectedRootFolder // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTags: null == selectedTags
          ? _self._selectedTags
          : selectedTags // ignore: cast_nullable_to_non_nullable
              as List<SeerrServiceTag>,
      selectedSeasons: null == selectedSeasons
          ? _self._selectedSeasons
          : selectedSeasons // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      seasonStatuses: null == seasonStatuses
          ? _self._seasonStatuses
          : seasonStatuses // ignore: cast_nullable_to_non_nullable
              as Map<int, SeerrRequestStatus>,
      userQuotas: null == userQuotas
          ? _self._userQuotas
          : userQuotas // ignore: cast_nullable_to_non_nullable
              as Map<int, SeerrUserQuota>,
      currentUser: freezed == currentUser
          ? _self.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as SeerrUserModel?,
      selectedUser: freezed == selectedUser
          ? _self.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as SeerrUserModel?,
      availableUsers: null == availableUsers
          ? _self._availableUsers
          : availableUsers // ignore: cast_nullable_to_non_nullable
              as List<SeerrUserModel>,
      use4k: null == use4k
          ? _self.use4k
          : use4k // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnime: null == isAnime
          ? _self.isAnime
          : isAnime // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrSonarrServerCopyWith<$Res>? get selectedSonarrServer {
    if (_self.selectedSonarrServer == null) {
      return null;
    }

    return $SeerrSonarrServerCopyWith<$Res>(_self.selectedSonarrServer!,
        (value) {
      return _then(_self.copyWith(selectedSonarrServer: value));
    });
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrRadarrServerCopyWith<$Res>? get selectedRadarrServer {
    if (_self.selectedRadarrServer == null) {
      return null;
    }

    return $SeerrRadarrServerCopyWith<$Res>(_self.selectedRadarrServer!,
        (value) {
      return _then(_self.copyWith(selectedRadarrServer: value));
    });
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrServiceProfileCopyWith<$Res>? get selectedProfile {
    if (_self.selectedProfile == null) {
      return null;
    }

    return $SeerrServiceProfileCopyWith<$Res>(_self.selectedProfile!, (value) {
      return _then(_self.copyWith(selectedProfile: value));
    });
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrUserModelCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
      return null;
    }

    return $SeerrUserModelCopyWith<$Res>(_self.currentUser!, (value) {
      return _then(_self.copyWith(currentUser: value));
    });
  }

  /// Create a copy of SeerrRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeerrUserModelCopyWith<$Res>? get selectedUser {
    if (_self.selectedUser == null) {
      return null;
    }

    return $SeerrUserModelCopyWith<$Res>(_self.selectedUser!, (value) {
      return _then(_self.copyWith(selectedUser: value));
    });
  }
}

// dart format on
