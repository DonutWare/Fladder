import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xid/xid.dart';

import 'package:fladder/util/application_info.dart';

class CredentialsModel {
  final String token;
  final String server;
  final String serverName;
  final String serverId;
  final String deviceId;
  CredentialsModel({
    this.token = "",
    this.server = "",
    this.serverName = "",
    this.serverId = "",
    required this.deviceId,
  });

  factory CredentialsModel.createNewCredentials() {
    return CredentialsModel(deviceId: Xid().toString());
  }

  Map<String, String> header(Ref ref) {
    final application = ref.read(applicationInfoProvider);
    final headers = {
      'content-type': 'application/json',
      'authorization':
          'MediaBrowser Token="$token", Client="${application.name}", Device="${application.os}", DeviceId="$deviceId", Version="${application.version}"'
    };
    return headers;
  }

  CredentialsModel copyWith({
    String? token,
    String? server,
    String? serverName,
    String? serverId,
    String? deviceId,
  }) {
    return CredentialsModel(
      token: token ?? this.token,
      server: server ?? this.server,
      serverName: serverName ?? this.serverName,
      serverId: serverId ?? this.serverId,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'server': server,
      'serverName': serverName,
      'serverId': serverId,
      'deviceId': deviceId,
    };
  }

  factory CredentialsModel.fromMap(Map<String, dynamic> map) {
    return CredentialsModel(
      token: map['token'] ?? '',
      server: map['server'] ?? '',
      serverName: map['serverName'] ?? '',
      serverId: map['serverId'] ?? '',
      deviceId: map['deviceId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CredentialsModel.fromJson(String source) => CredentialsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CredentialsModel(token: $token, server: $server, serverName: $serverName, serverId: $serverId, header: $header)';
  }
}
