import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/providers/connectivity_provider.dart';

void main() {
  group('mapConnectivityResults', () {
    test('prefers vpn over every other transport', () {
      expect(
        mapConnectivityResults([ConnectivityResult.wifi, ConnectivityResult.vpn]),
        ConnectionState.vpn,
      );
    });

    test('prefers ethernet over wifi and mobile', () {
      expect(
        mapConnectivityResults([ConnectivityResult.mobile, ConnectivityResult.wifi, ConnectivityResult.ethernet]),
        ConnectionState.ethernet,
      );
    });

    test('maps wifi and mobile', () {
      expect(mapConnectivityResults([ConnectivityResult.wifi]), ConnectionState.wifi);
      expect(mapConnectivityResults([ConnectivityResult.mobile]), ConnectionState.mobile);
    });

    test('maps an explicit none to offline', () {
      expect(mapConnectivityResults([ConnectivityResult.none]), ConnectionState.offline);
    });

    // The regression this whole change exists for: on Windows the plugin
    // returns results we cannot classify while the network is perfectly fine.
    // Those must be reported as unknown (null) so the caller probes the server
    // instead of flipping the app into offline mode.
    test('reports unclassifiable transports as unknown, not offline', () {
      expect(mapConnectivityResults([ConnectivityResult.other]), isNull);
      expect(mapConnectivityResults([ConnectivityResult.bluetooth]), isNull);
      expect(mapConnectivityResults([ConnectivityResult.other, ConnectivityResult.bluetooth]), isNull);
    });

    test('reports an empty result list as unknown, not offline', () {
      expect(mapConnectivityResults([]), isNull);
    });

    test('still finds a usable transport alongside unclassifiable ones', () {
      expect(
        mapConnectivityResults([ConnectivityResult.other, ConnectivityResult.ethernet]),
        ConnectionState.ethernet,
      );
    });
  });
}
