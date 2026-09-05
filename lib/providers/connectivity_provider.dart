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
  vpn;

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
  int _probeId = 0;
  Completer<void>? _probeCompleter;

  @override
  ConnectionState build() {
    ref.listen(
      userProvider.select((value) => value?.credentials.localUrl),
      (previous, next) {
        if (previous != next) {
          checkConnectivity(immediate: true);
        }
      },
    );

    final subscription = Connectivity().onConnectivityChanged.listen((results) {
      _handleHardwareChange(results);
    });

    ref.onDispose(() {
      _debounceTimer?.cancel();
      subscription.cancel();
      _probeId++;
      _resolveProbe();
    });

    checkConnectivity(immediate: true);

    return ConnectionState.mobile;
  }

  Future<void> checkConnectivity({bool immediate = false}) async {
    final results = await Connectivity().checkConnectivity();
    _handleHardwareChange(results, immediate: immediate);
  }

  Future<void> waitForProbe() async => _probeCompleter?.future;

  void _handleHardwareChange(List<ConnectivityResult> results, {bool immediate = false}) {
    final hardwareState = _parseHardwareState(results);

    if (hardwareState == ConnectionState.offline) {
      _debounceTimer?.cancel();
      _probeId++;
      _resolveProbe();
      _updateState(ConnectionState.offline, isLocal: false);
      return;
    }

    _queueProbe(hardwareState, immediate: immediate);
  }

  void _queueProbe(ConnectionState candidateState, {bool immediate = false}) {
    _debounceTimer?.cancel();
    final id = ++_probeId;
    _probeCompleter ??= Completer<void>();

    if (immediate) {
      unawaited(_probeReachability(id, candidateState));
    } else {
      _debounceTimer = Timer(
        const Duration(milliseconds: 500),
        () => unawaited(_probeReachability(id, candidateState)),
      );
    }
  }

  Future<void> _probeReachability(int id, ConnectionState candidateState) async {
    try {
      final user = ref.read(userProvider);
      if (user == null) return;

      final localUrl = user.credentials.localUrl;
      if (localUrl != null && localUrl.isNotEmpty) {
        final permission = await checkLocalNetworkPermission();
        if (permission == LocalNetworkPermissionStatus.granted) {
          final localConnection = await fetchSystemInfoDynamic(normalizeUrl(localUrl));

          if (_probeId != id) return;

          if (localConnection?.id == user.credentials.serverId) {
            _updateState(candidateState, isLocal: true);
            return;
          }
        }
      }

      if (_probeId != id) return;

      final remoteUrl = ref.read(serverUrlProvider);
      if (remoteUrl != null && remoteUrl.isNotEmpty) {
        final checkServer = await fetchSystemInfoDynamic(normalizeUrl(remoteUrl));

        if (_probeId != id) return;

        if (checkServer != null) {
          _updateState(candidateState, isLocal: false);
          return;
        }
      }

      if (_probeId == id) {
        _updateState(ConnectionState.offline, isLocal: false);
      }
    } finally {
      if (_probeId == id) {
        _resolveProbe();
      }
    }
  }

  void _updateState(ConnectionState newState, {required bool isLocal}) {
    ref.read(localConnectionAvailableProvider.notifier).state = isLocal;
    state = newState;
  }

  void _resolveProbe() {
    if (!(_probeCompleter?.isCompleted ?? true)) {
      _probeCompleter?.complete();
    }
    _probeCompleter = null;
  }

  ConnectionState _parseHardwareState(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.vpn)) return ConnectionState.vpn;
    if (results.contains(ConnectivityResult.ethernet)) return ConnectionState.ethernet;
    if (results.contains(ConnectivityResult.wifi)) return ConnectionState.wifi;
    if (results.contains(ConnectivityResult.mobile)) return ConnectionState.mobile;
    return ConnectionState.offline;
  }
}

Future<PublicSystemInfo?> fetchSystemInfoDynamic(String baseUrl) async {
  if (baseUrl.isEmpty) return null;
  try {
    final uri = buildServerUriFromBase(baseUrl, pathSegments: const ['System', 'Info', 'Public']);
    if (uri == null) return null;

    final response = await http.get(uri).timeout(const Duration(seconds: 2));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PublicSystemInfo.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    log(e.toString());
    return null;
  }
}
