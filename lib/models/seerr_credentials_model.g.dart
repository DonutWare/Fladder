// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerr_credentials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeerrCredentialsModel _$SeerrCredentialsModelFromJson(
        Map<String, dynamic> json) =>
    _SeerrCredentialsModel(
      serverUrl: json['serverUrl'] as String? ?? "",
      apiKey: json['apiKey'] as String? ?? "",
      sessionCookie: json['sessionCookie'] as String? ?? "",
    );

Map<String, dynamic> _$SeerrCredentialsModelToJson(
        _SeerrCredentialsModel instance) =>
    <String, dynamic>{
      'serverUrl': instance.serverUrl,
      'apiKey': instance.apiKey,
      'sessionCookie': instance.sessionCookie,
    };
