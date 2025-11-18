// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CredentialsModel _$CredentialsModelFromJson(Map<String, dynamic> json) =>
    _CredentialsModel(
      token: json['token'] as String? ?? "",
      url: json['url'] as String? ?? "",
      localUrl: json['localUrl'] as String?,
      networkName: json['networkName'] as String?,
      serverName: json['serverName'] as String? ?? "",
      serverId: json['serverId'] as String? ?? "",
      deviceId: json['deviceId'] as String? ?? "",
    );

Map<String, dynamic> _$CredentialsModelToJson(_CredentialsModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'url': instance.url,
      'localUrl': instance.localUrl,
      'networkName': instance.networkName,
      'serverName': instance.serverName,
      'serverId': instance.serverId,
      'deviceId': instance.deviceId,
    };
