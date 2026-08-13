import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';

void main() {
  group('selectPlaybackBitrate', () {
    const maxHomeBitrate = Bitrate.auto;
    const maxInternetBitrate = Bitrate.b10Mbps;

    test('uses the home Auto setting on Wi-Fi and Ethernet', () {
      for (final connectionState in [
        ConnectionState.wifi,
        ConnectionState.ethernet,
      ]) {
        final selectedBitrate = selectPlaybackBitrate(
          homeInternet: connectionState.homeInternet,
          maxHomeBitrate: maxHomeBitrate,
          maxInternetBitrate: maxInternetBitrate,
        );

        expect(selectedBitrate, Bitrate.auto);
        expect(_requestBitrate(selectedBitrate), 0);
      }
    });

    test('uses the fixed internet setting on mobile data', () {
      final selectedBitrate = selectPlaybackBitrate(
        homeInternet: ConnectionState.mobile.homeInternet,
        maxHomeBitrate: maxHomeBitrate,
        maxInternetBitrate: maxInternetBitrate,
      );

      expect(selectedBitrate, Bitrate.b10Mbps);
      expect(_requestBitrate(selectedBitrate), 10000000);
    });

    test('keeps offline connectivity on the existing non-home path', () {
      expect(
        selectPlaybackBitrate(
          homeInternet: ConnectionState.offline.homeInternet,
          maxHomeBitrate: maxHomeBitrate,
          maxInternetBitrate: maxInternetBitrate,
        ),
        Bitrate.b10Mbps,
      );
    });
  });
}

int? _requestBitrate(Bitrate maxBitrate) {
  final qualityOptions = getVideoQualityOptions(
    VideoQualitySettings(
      maxBitRate: maxBitrate,
      videoBitRate: 23900000,
      videoCodec: 'hevc',
    ),
  );

  return qualityOptions.enabledFirst.keys.first.bitRate;
}
