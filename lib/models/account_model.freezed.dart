// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) {
  return _AccountModel.fromJson(json);
}

/// @nodoc
mixin _$AccountModel {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  DateTime get lastUsed => throw _privateConstructorUsedError;
  Authentication get authMethod => throw _privateConstructorUsedError;
  String get localPin => throw _privateConstructorUsedError;
  CredentialsModel get credentials => throw _privateConstructorUsedError;
  List<String> get latestItemsExcludes => throw _privateConstructorUsedError;
  List<String> get searchQueryHistory => throw _privateConstructorUsedError;
  bool get quickConnectState => throw _privateConstructorUsedError;
  List<LibraryFiltersModel> get savedFilters =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  UserPolicy? get policy => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ServerConfiguration? get serverConfiguration =>
      throw _privateConstructorUsedError;

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountModelCopyWith<AccountModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountModelCopyWith<$Res> {
  factory $AccountModelCopyWith(
          AccountModel value, $Res Function(AccountModel) then) =
      _$AccountModelCopyWithImpl<$Res, AccountModel>;
  @useResult
  $Res call(
      {String name,
      String id,
      String avatar,
      DateTime lastUsed,
      Authentication authMethod,
      String localPin,
      CredentialsModel credentials,
      List<String> latestItemsExcludes,
      List<String> searchQueryHistory,
      bool quickConnectState,
      List<LibraryFiltersModel> savedFilters,
      @JsonKey(includeFromJson: false, includeToJson: false) UserPolicy? policy,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ServerConfiguration? serverConfiguration});
}

/// @nodoc
class _$AccountModelCopyWithImpl<$Res, $Val extends AccountModel>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    Object? latestItemsExcludes = null,
    Object? searchQueryHistory = null,
    Object? quickConnectState = null,
    Object? savedFilters = null,
    Object? policy = freezed,
    Object? serverConfiguration = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      lastUsed: null == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authMethod: null == authMethod
          ? _value.authMethod
          : authMethod // ignore: cast_nullable_to_non_nullable
              as Authentication,
      localPin: null == localPin
          ? _value.localPin
          : localPin // ignore: cast_nullable_to_non_nullable
              as String,
      credentials: null == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as CredentialsModel,
      latestItemsExcludes: null == latestItemsExcludes
          ? _value.latestItemsExcludes
          : latestItemsExcludes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchQueryHistory: null == searchQueryHistory
          ? _value.searchQueryHistory
          : searchQueryHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quickConnectState: null == quickConnectState
          ? _value.quickConnectState
          : quickConnectState // ignore: cast_nullable_to_non_nullable
              as bool,
      savedFilters: null == savedFilters
          ? _value.savedFilters
          : savedFilters // ignore: cast_nullable_to_non_nullable
              as List<LibraryFiltersModel>,
      policy: freezed == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as UserPolicy?,
      serverConfiguration: freezed == serverConfiguration
          ? _value.serverConfiguration
          : serverConfiguration // ignore: cast_nullable_to_non_nullable
              as ServerConfiguration?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountModelImplCopyWith<$Res>
    implements $AccountModelCopyWith<$Res> {
  factory _$$AccountModelImplCopyWith(
          _$AccountModelImpl value, $Res Function(_$AccountModelImpl) then) =
      __$$AccountModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String id,
      String avatar,
      DateTime lastUsed,
      Authentication authMethod,
      String localPin,
      CredentialsModel credentials,
      List<String> latestItemsExcludes,
      List<String> searchQueryHistory,
      bool quickConnectState,
      List<LibraryFiltersModel> savedFilters,
      @JsonKey(includeFromJson: false, includeToJson: false) UserPolicy? policy,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ServerConfiguration? serverConfiguration});
}

/// @nodoc
class __$$AccountModelImplCopyWithImpl<$Res>
    extends _$AccountModelCopyWithImpl<$Res, _$AccountModelImpl>
    implements _$$AccountModelImplCopyWith<$Res> {
  __$$AccountModelImplCopyWithImpl(
      _$AccountModelImpl _value, $Res Function(_$AccountModelImpl) _then)
      : super(_value, _then);

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
    Object? latestItemsExcludes = null,
    Object? searchQueryHistory = null,
    Object? quickConnectState = null,
    Object? savedFilters = null,
    Object? policy = freezed,
    Object? serverConfiguration = freezed,
  }) {
    return _then(_$AccountModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      lastUsed: null == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authMethod: null == authMethod
          ? _value.authMethod
          : authMethod // ignore: cast_nullable_to_non_nullable
              as Authentication,
      localPin: null == localPin
          ? _value.localPin
          : localPin // ignore: cast_nullable_to_non_nullable
              as String,
      credentials: null == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as CredentialsModel,
      latestItemsExcludes: null == latestItemsExcludes
          ? _value._latestItemsExcludes
          : latestItemsExcludes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchQueryHistory: null == searchQueryHistory
          ? _value._searchQueryHistory
          : searchQueryHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quickConnectState: null == quickConnectState
          ? _value.quickConnectState
          : quickConnectState // ignore: cast_nullable_to_non_nullable
              as bool,
      savedFilters: null == savedFilters
          ? _value._savedFilters
          : savedFilters // ignore: cast_nullable_to_non_nullable
              as List<LibraryFiltersModel>,
      policy: freezed == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as UserPolicy?,
      serverConfiguration: freezed == serverConfiguration
          ? _value.serverConfiguration
          : serverConfiguration // ignore: cast_nullable_to_non_nullable
              as ServerConfiguration?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountModelImpl extends _AccountModel with DiagnosticableTreeMixin {
  const _$AccountModelImpl(
      {required this.name,
      required this.id,
      required this.avatar,
      required this.lastUsed,
      this.authMethod = Authentication.autoLogin,
      this.localPin = "",
      required this.credentials,
      final List<String> latestItemsExcludes = const [],
      final List<String> searchQueryHistory = const [],
      this.quickConnectState = false,
      final List<LibraryFiltersModel> savedFilters = const [],
      @JsonKey(includeFromJson: false, includeToJson: false) this.policy,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.serverConfiguration})
      : _latestItemsExcludes = latestItemsExcludes,
        _searchQueryHistory = searchQueryHistory,
        _savedFilters = savedFilters,
        super._();

  factory _$AccountModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountModelImplFromJson(json);

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
  final CredentialsModel credentials;
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
  final List<LibraryFiltersModel> _savedFilters;
  @override
  @JsonKey()
  List<LibraryFiltersModel> get savedFilters {
    if (_savedFilters is EqualUnmodifiableListView) return _savedFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedFilters);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final UserPolicy? policy;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ServerConfiguration? serverConfiguration;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountModel(name: $name, id: $id, avatar: $avatar, lastUsed: $lastUsed, authMethod: $authMethod, localPin: $localPin, credentials: $credentials, latestItemsExcludes: $latestItemsExcludes, searchQueryHistory: $searchQueryHistory, quickConnectState: $quickConnectState, savedFilters: $savedFilters, policy: $policy, serverConfiguration: $serverConfiguration)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('lastUsed', lastUsed))
      ..add(DiagnosticsProperty('authMethod', authMethod))
      ..add(DiagnosticsProperty('localPin', localPin))
      ..add(DiagnosticsProperty('credentials', credentials))
      ..add(DiagnosticsProperty('latestItemsExcludes', latestItemsExcludes))
      ..add(DiagnosticsProperty('searchQueryHistory', searchQueryHistory))
      ..add(DiagnosticsProperty('quickConnectState', quickConnectState))
      ..add(DiagnosticsProperty('savedFilters', savedFilters))
      ..add(DiagnosticsProperty('policy', policy))
      ..add(DiagnosticsProperty('serverConfiguration', serverConfiguration));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed) &&
            (identical(other.authMethod, authMethod) ||
                other.authMethod == authMethod) &&
            (identical(other.localPin, localPin) ||
                other.localPin == localPin) &&
            (identical(other.credentials, credentials) ||
                other.credentials == credentials) &&
            const DeepCollectionEquality()
                .equals(other._latestItemsExcludes, _latestItemsExcludes) &&
            const DeepCollectionEquality()
                .equals(other._searchQueryHistory, _searchQueryHistory) &&
            (identical(other.quickConnectState, quickConnectState) ||
                other.quickConnectState == quickConnectState) &&
            const DeepCollectionEquality()
                .equals(other._savedFilters, _savedFilters) &&
            (identical(other.policy, policy) || other.policy == policy) &&
            (identical(other.serverConfiguration, serverConfiguration) ||
                other.serverConfiguration == serverConfiguration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      id,
      avatar,
      lastUsed,
      authMethod,
      localPin,
      credentials,
      const DeepCollectionEquality().hash(_latestItemsExcludes),
      const DeepCollectionEquality().hash(_searchQueryHistory),
      quickConnectState,
      const DeepCollectionEquality().hash(_savedFilters),
      policy,
      serverConfiguration);

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountModelImplCopyWith<_$AccountModelImpl> get copyWith =>
      __$$AccountModelImplCopyWithImpl<_$AccountModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountModelImplToJson(
      this,
    );
  }
}

abstract class _AccountModel extends AccountModel {
  const factory _AccountModel(
      {required final String name,
      required final String id,
      required final String avatar,
      required final DateTime lastUsed,
      final Authentication authMethod,
      final String localPin,
      required final CredentialsModel credentials,
      final List<String> latestItemsExcludes,
      final List<String> searchQueryHistory,
      final bool quickConnectState,
      final List<LibraryFiltersModel> savedFilters,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final UserPolicy? policy,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final ServerConfiguration? serverConfiguration}) = _$AccountModelImpl;
  const _AccountModel._() : super._();

  factory _AccountModel.fromJson(Map<String, dynamic> json) =
      _$AccountModelImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  String get avatar;
  @override
  DateTime get lastUsed;
  @override
  Authentication get authMethod;
  @override
  String get localPin;
  @override
  CredentialsModel get credentials;
  @override
  List<String> get latestItemsExcludes;
  @override
  List<String> get searchQueryHistory;
  @override
  bool get quickConnectState;
  @override
  List<LibraryFiltersModel> get savedFilters;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  UserPolicy? get policy;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ServerConfiguration? get serverConfiguration;

  /// Create a copy of AccountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountModelImplCopyWith<_$AccountModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
