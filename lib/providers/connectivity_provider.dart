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

/// Maps the platform's connectivity results onto a [ConnectionState].
///
/// Returns `null` for transports we cannot classify ([ConnectivityResult.other],
/// [ConnectivityResult.bluetooth]) or an empty result. Neither `null` nor
/// [ConnectionState.offline] may be committed without a reachability probe: on
/// Windows the plugin only counts adapters the OS marks `IsConnectedToInternet`,
/// a verdict that is transiently wrong on healthy networks.
ConnectionState? mapConnectivityResults(List<ConnectivityResult> results) {
  if (results.contains(ConnectivityResult.vpn)) return ConnectionState.vpn;
  if (results.contains(ConnectivityResult.ethernet)) return ConnectionState.ethernet;
  if (results.contains(ConnectivityResult.wifi)) return ConnectionState.wifi;
  if (results.contains(ConnectivityResult.mobile)) return ConnectionState.mobile;
  if (results.contains(ConnectivityResult.none)) return ConnectionState.offline;
  return null;
}

@Riverpod(keepAlive: true)
class ConnectivityStatus extends _$ConnectivityStatus {
  Timer? _debounceTimer;
  int _probeId = 0;
  Completer<void>? _probeCompleter;

  /// Last transport the OS reported. Used as the candidate state when the OS
  /// reports nothing usable, since that report is only a hint.
  ConnectionState _lastKnownTransport = ConnectionState.mobile;

  /// Retry while offline so a false negative recovers on its own. Desktop
  /// platforms rarely emit lifecycle events, so nothing else would re-check.
  /// Backs off so a device that is genuinely offline is not polled every 15s.
  static const _offlineRetryInitial = Duration(seconds: 15);
  static const _offlineRetryMax = Duration(minutes: 2);
  Duration _offlineRetryDelay = _offlineRetryInitial;
  Timer? _offlineRetryTimer;

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
      _offlineRetryTimer?.cancel();
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
    final hardwareState = mapConnectivityResults(results);

    // The OS signal is a hint, never a verdict. A usable transport is recorded
    // for bitrate selection; "offline" or an unclassifiable transport is
    // verified against the server instead of being committed. Committing it
    // directly pinned the app offline on healthy networks with no way back.
    if (hardwareState != null && hardwareState != ConnectionState.offline) {
      _lastKnownTransport = hardwareState;
    }

    _queueProbe(_lastKnownTransport, immediate: immediate);
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

      final remoteUrl = user.credentials.url;
      if (remoteUrl.isNotEmpty) {
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

    if (newState == ConnectionState.offline) {
      _scheduleOfflineRetry();
    } else {
      _offlineRetryTimer?.cancel();
      _offlineRetryTimer = null;
      _offlineRetryDelay = _offlineRetryInitial;
    }
  }

  void _scheduleOfflineRetry() {
    // Advance the backoff only when a retry is actually scheduled; several
    // failing requests can confirm offline inside one pending window.
    if (_offlineRetryTimer != null) return;
    _offlineRetryTimer = Timer(_offlineRetryDelay, () {
      _offlineRetryTimer = null;
      _queueProbe(_lastKnownTransport, immediate: true);
    });
    final next = _offlineRetryDelay * 2;
    _offlineRetryDelay = next > _offlineRetryMax ? _offlineRetryMax : next;
  }

  void _resolveProbe() {
    if (!(_probeCompleter?.isCompleted ?? true)) {
      _probeCompleter?.complete();
    }
    _probeCompleter = null;
  }
}

Future<PublicSystemInfo?> fetchSystemInfoDynamic(String baseUrl) async {
  if (baseUrl.isEmpty) return null;
  try {
    final uri = buildServerUriFromBase(baseUrl, pathSegments: const ['System', 'Info', 'Public']);
    if (uri == null) return null;

    // 5s rather than 2s: this now guards the remote URL too, and a cold server
    // or a slow link routinely needs more than two seconds. Timing out here
    // is what commits offline, so the budget has to be generous.
    final response = await http.get(uri).timeout(const Duration(seconds: 5));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PublicSystemInfo.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    log(e.toString());
    return null;
  }
}
