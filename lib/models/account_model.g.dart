// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountModelImpl _$$AccountModelImplFromJson(Map<String, dynamic> json) =>
    _$AccountModelImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      avatar: json['avatar'] as String,
      lastUsed: DateTime.parse(json['lastUsed'] as String),
      authMethod:
          $enumDecodeNullable(_$AuthenticationEnumMap, json['authMethod']) ??
              Authentication.autoLogin,
      localPin: json['localPin'] as String? ?? "",
      credentials: CredentialsModel.fromJson(json['credentials'] as String),
      latestItemsExcludes: (json['latestItemsExcludes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      searchQueryHistory: (json['searchQueryHistory'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      quickConnectState: json['quickConnectState'] as bool? ?? false,
      savedFilters: (json['savedFilters'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryFiltersModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      userSettings: json['userSettings'] == null
          ? null
          : UserSettings.fromJson(json['userSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AccountModelImplToJson(_$AccountModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'avatar': instance.avatar,
      'lastUsed': instance.lastUsed.toIso8601String(),
      'authMethod': _$AuthenticationEnumMap[instance.authMethod]!,
      'localPin': instance.localPin,
      'credentials': instance.credentials,
      'latestItemsExcludes': instance.latestItemsExcludes,
      'searchQueryHistory': instance.searchQueryHistory,
      'quickConnectState': instance.quickConnectState,
      'savedFilters': instance.savedFilters,
      'userSettings': instance.userSettings,
    };

const _$AuthenticationEnumMap = {
  Authentication.autoLogin: 'autoLogin',
  Authentication.biometrics: 'biometrics',
  Authentication.passcode: 'passcode',
  Authentication.none: 'none',
};

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      skipForwardDuration: json['skipForwardDuration'] == null
          ? const Duration(seconds: 30)
          : Duration(
              microseconds: (json['skipForwardDuration'] as num).toInt()),
      skipBackDuration: json['skipBackDuration'] == null
          ? const Duration(seconds: 10)
          : Duration(microseconds: (json['skipBackDuration'] as num).toInt()),
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'skipForwardDuration': instance.skipForwardDuration.inMicroseconds,
      'skipBackDuration': instance.skipBackDuration.inMicroseconds,
    };
