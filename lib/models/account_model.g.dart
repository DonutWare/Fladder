// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      name: json['name'] as String,
      id: json['id'] as String,
      avatar: json['avatar'] as String,
      lastUsed: DateTime.parse(json['lastUsed'] as String),
      authMethod:
          $enumDecodeNullable(_$AuthenticationEnumMap, json['authMethod']) ??
              Authentication.autoLogin,
      askForAuthOnLaunch: json['askForAuthOnLaunch'] as bool? ?? false,
      localPin: json['localPin'] as String? ?? "",
      credentials: const CredentialsConverter().fromJson(json['credentials']),
      seerrCredentials: json['seerrCredentials'] == null
          ? null
          : SeerrCredentialsModel.fromJson(
              json['seerrCredentials'] as Map<String, dynamic>),
      latestItemsExcludes: (json['latestItemsExcludes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      searchQueryHistory: (json['searchQueryHistory'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      quickConnectState: json['quickConnectState'] as bool? ?? false,
      libraryFilters: (json['libraryFilters'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryFiltersModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      updateNotificationsEnabled:
          json['updateNotificationsEnabled'] as bool? ?? false,
      seerrRequestsEnabled: json['seerrRequestsEnabled'] as bool? ?? false,
      includeHiddenViews: json['includeHiddenViews'] as bool? ?? false,
      userSettings: json['userSettings'] == null
          ? null
          : UserSettings.fromJson(json['userSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'avatar': instance.avatar,
      'lastUsed': instance.lastUsed.toIso8601String(),
      'authMethod': _$AuthenticationEnumMap[instance.authMethod]!,
      'askForAuthOnLaunch': instance.askForAuthOnLaunch,
      'localPin': instance.localPin,
      'credentials': const CredentialsConverter().toJson(instance.credentials),
      'seerrCredentials': instance.seerrCredentials,
      'latestItemsExcludes': instance.latestItemsExcludes,
      'searchQueryHistory': instance.searchQueryHistory,
      'quickConnectState': instance.quickConnectState,
      'libraryFilters': instance.libraryFilters,
      'updateNotificationsEnabled': instance.updateNotificationsEnabled,
      'seerrRequestsEnabled': instance.seerrRequestsEnabled,
      'includeHiddenViews': instance.includeHiddenViews,
      'userSettings': instance.userSettings,
    };

const _$AuthenticationEnumMap = {
  Authentication.autoLogin: 'autoLogin',
  Authentication.biometrics: 'biometrics',
  Authentication.passcode: 'passcode',
  Authentication.none: 'none',
};

_UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) =>
    _UserSettings(
      skipForwardDuration: json['skipForwardDuration'] == null
          ? const Duration(seconds: 30)
          : Duration(
              microseconds: (json['skipForwardDuration'] as num).toInt()),
      skipBackDuration: json['skipBackDuration'] == null
          ? const Duration(seconds: 10)
          : Duration(microseconds: (json['skipBackDuration'] as num).toInt()),
    );

Map<String, dynamic> _$UserSettingsToJson(_UserSettings instance) =>
    <String, dynamic>{
      'skipForwardDuration': instance.skipForwardDuration.inMicroseconds,
      'skipBackDuration': instance.skipBackDuration.inMicroseconds,
    };
