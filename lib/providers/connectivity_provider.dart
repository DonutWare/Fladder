import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  @override
  ConnectionState build() {
    Connectivity().onConnectivityChanged.listen(onStateChange);
    return ConnectionState.offline;
  }

  void onStateChange(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      state = ConnectionState.ethernet;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      state = ConnectionState.wifi;
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      state = ConnectionState.mobile;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      state = ConnectionState.offline;
    }
  }

  void checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    onStateChange(connectivityResult);
  }
}
