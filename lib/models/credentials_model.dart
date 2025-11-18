// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xid/xid.dart';

import 'package:fladder/util/application_info.dart';

part 'credentials_model.freezed.dart';
part 'credentials_model.g.dart';

@Freezed(copyWith: true)
abstract class CredentialsModel with _$CredentialsModel {
  const CredentialsModel._();

  factory CredentialsModel.internal({
    @Default("") String token,
    @Default("") String url,
    String? localUrl,
    String? networkName,
    @Default("") String serverName,
    @Default("") String serverId,
    @Default("") String deviceId,
  }) = _CredentialsModel;

  factory CredentialsModel.createNewCredentials() => CredentialsModel.internal(deviceId: Xid().toString());

  Map<String, String> header(Ref ref) {
    final application = ref.read(applicationInfoProvider);
    final headers = {
      'authorization':
          'MediaBrowser Token="$token", Client="${application.name}", Device="${application.os}", DeviceId="$deviceId", Version="${application.version}"'
    };
    return headers;
  }

  factory CredentialsModel.fromJson(Map<String, dynamic> json) => _$CredentialsModelFromJson(json);

  factory CredentialsModel.fromJsonString(String source) => CredentialsModel.fromMap(json.decode(source));

  factory CredentialsModel.fromMap(Map<String, dynamic> map) {
    return CredentialsModel.internal(
      token: map['token'] ?? '',
      url: map['server'] ?? '',
      serverName: map['serverName'] ?? '',
      serverId: map['serverId'] ?? '',
      deviceId: map['deviceId'] ?? '',
    );
  }
}
