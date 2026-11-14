import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/providers/jellyfin_websocket_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final credentials = CredentialsModel.internal(token: 'tok-123', deviceId: 'dev-abc');

  group('jellyfinWebSocketUri', () {
    test('carries the token as ApiKey', () {
      final uri = jellyfinWebSocketUri('https://jelly.example.com', credentials)!;

      // Jellyfin 12 ignores the legacy `api_key` name by default, so the socket must send `ApiKey`.
      expect(uri.queryParameters['ApiKey'], 'tok-123');
      expect(uri.queryParameters.containsKey('api_key'), isFalse);
      expect(uri.queryParameters['deviceId'], 'dev-abc');
    });

    test('upgrades the scheme and keeps host, port and base path', () {
      final uri = jellyfinWebSocketUri('https://jelly.example.com:8920/jellyfin/', credentials)!;

      expect(uri.scheme, 'wss');
      expect(uri.host, 'jelly.example.com');
      expect(uri.port, 8920);
      expect(uri.path, '/jellyfin/socket');
    });

    test('uses ws for a plain-http server', () {
      final uri = jellyfinWebSocketUri('http://192.168.1.10:8096', credentials)!;

      expect(uri.scheme, 'ws');
      expect(uri.path, '/socket');
    });
  });
}
