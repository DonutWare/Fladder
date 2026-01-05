import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/user_provider.dart';

part 'connectivity_provider.g.dart';

enum ConnectionState {
  offline,
  mobile,
  wifi,
  ethernet;

  bool get homeInternet => switch (this) {
        ConnectionState.offline => false,
        ConnectionState.mobile => false,
        ConnectionState.wifi => true,
        ConnectionState.ethernet => true,
      };
}

@Riverpod(keepAlive: true)
class ConnectivityStatus extends _$ConnectivityStatus {
  String? localUrl;

  @override
  ConnectionState build() {
    ref.listen(userProvider, (previous, next) {
      checkLocalUrl(previous, next);
    });
    Connectivity().onConnectivityChanged.listen(onStateChange);
    checkConnectivity();
    return ConnectionState.mobile;
  }

  void checkLocalUrl(AccountModel? previous, AccountModel? next) {
    final newUrl = next?.credentials.localUrl;
    if (localUrl != newUrl) {
      checkConnectivity();
    }
  }

  void onStateChange(List<ConnectivityResult> connectivityResult) async {
    if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      state = ConnectionState.ethernet;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      state = ConnectionState.wifi;
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      state = ConnectionState.mobile;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      state = ConnectionState.offline;
    }
    final newUrl = ref.read(userProvider.select((value) => value?.credentials.localUrl));
    if (localUrl == newUrl) return;
    localUrl = newUrl;
    final localConnection =
        localUrl != null && localUrl?.isNotEmpty == true ? await fetchSystemInfoDynamic(normalizeUrl(localUrl!)) : null;
    final correctServerResponse =
        localConnection?.id == ref.read(userProvider.select((value) => value?.credentials.serverId));
    ref.read(localConnectionAvailableProvider.notifier).update((state) => correctServerResponse);
  }

  void checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    onStateChange(connectivityResult);
  }
}

Future<PublicSystemInfo?> fetchSystemInfoDynamic(String baseUrl) async {
  if (baseUrl.isEmpty) return null;
  try {
    final uri = buildServerUriFromBase(baseUrl, pathSegments: const ['System', 'Info', 'Public']);
    if (uri == null) return null;
    final response = await http.get(uri).timeout(const Duration(seconds: 1));
    if (response.statusCode == 200) {
      return PublicSystemInfo.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    log(e.toString());
    return null;
  }
}

final localConnectionAvailableProvider = StateProvider<bool>((ref) {
  return false;
});
