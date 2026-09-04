import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/services/local_network_permission.dart';

part 'connectivity_provider.g.dart';

enum ConnectionState {
  offline,
  mobile,
  wifi,
  ethernet,
  vpn; // 1. Added VPN state

  bool get homeInternet => switch (this) {
        ConnectionState.offline => false,
        ConnectionState.mobile => false,
        ConnectionState.wifi => true,
        ConnectionState.ethernet => true,
        ConnectionState.vpn => true,
      };
}

final offlineStateProvider = Provider<bool>((ref) {
  final isLoggedIn = ref.watch(userProvider.select((value) => value != null));
  return ref.watch(connectivityStatusProvider.select((value) => value == ConnectionState.offline)) && isLoggedIn;
});

final localConnectionAvailableProvider = StateProvider<bool>((ref) => false);

@Riverpod(keepAlive: true)
class ConnectivityStatus extends _$ConnectivityStatus {
  Timer? _debounceTimer;
  int _probeVersion = 0;

  final Connectivity _connectivity = Connectivity();

  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    _onHardwareStateChange(results);
  }

  @override
  ConnectionState build() {
    ref.listen(
      userProvider.select((value) => value?.credentials.localUrl),
      (previous, next) {
        if (previous != next) {
          _queueProbe();
        }
      },
    );

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_onHardwareStateChange);
    _connectivity.checkConnectivity().then(_onHardwareStateChange);

    ref.onDispose(() {
      _debounceTimer?.cancel();
      _connectivitySubscription.cancel();
    });

    return ConnectionState.mobile;
  }

  Future<void> _onHardwareStateChange(List<ConnectivityResult> results) async {
    ConnectionState hardwareState = ConnectionState.offline;

    if (results.contains(ConnectivityResult.vpn)) {
      hardwareState = ConnectionState.vpn;
    } else if (results.contains(ConnectivityResult.ethernet)) {
      hardwareState = ConnectionState.ethernet;
    } else if (results.contains(ConnectivityResult.wifi)) {
      hardwareState = ConnectionState.wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      hardwareState = ConnectionState.mobile;
    }

    if (hardwareState == ConnectionState.offline) {
      state = ConnectionState.offline;
      ref.read(localConnectionAvailableProvider.notifier).state = false;
      return;
    }

    state = hardwareState;
    _queueProbe();
  }

  void _queueProbe() {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _probeReachability();
    });
  }

  Future<void> _probeReachability() async {
    final currentProbeId = ++_probeVersion;

    if (state == ConnectionState.offline) {
      ref.read(localConnectionAvailableProvider.notifier).state = false;
      return;
    }

    final user = ref.read(userProvider);
    if (user == null) return;

    final localUrl = user.credentials.localUrl;
    final serverId = user.credentials.serverId;

    ref.read(localConnectionAvailableProvider.notifier).state = false;

    if (localUrl != null && localUrl.isNotEmpty) {
      final permissionStatus = await checkLocalNetworkPermission();
      if (permissionStatus == LocalNetworkPermissionStatus.granted) {
        final localConnection = await fetchSystemInfoDynamic(normalizeUrl(localUrl));

        if (_probeVersion != currentProbeId) return;

        if (localConnection?.id == serverId) {
          ref.read(localConnectionAvailableProvider.notifier).state = true;
          return;
        }
      }
    }

    if (_probeVersion != currentProbeId) return;

    final remoteUrl = ref.read(serverUrlProvider);
    if (remoteUrl != null && remoteUrl.isNotEmpty) {
      final checkServer = await probeJellyfinUrl(remoteUrl);

      if (_probeVersion != currentProbeId) return;

      if (checkServer != null) {
        return;
      }
    }

    if (_probeVersion != currentProbeId) return;
    state = ConnectionState.offline;
  }
}

Future<PublicSystemInfo?> fetchSystemInfoDynamic(String baseUrl) async {
  if (baseUrl.isEmpty) return null;
  try {
    final uri = buildServerUriFromBase(baseUrl, pathSegments: const ['System', 'Info', 'Public']);
    if (uri == null) return null;

    final response = await http.get(uri).timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      return PublicSystemInfo.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    log(e.toString());
    return null;
  }
}
