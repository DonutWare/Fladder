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
    };

const _$AuthenticationEnumMap = {
  Authentication.autoLogin: 'autoLogin',
  Authentication.biometrics: 'biometrics',
  Authentication.passcode: 'passcode',
  Authentication.none: 'none',
};
