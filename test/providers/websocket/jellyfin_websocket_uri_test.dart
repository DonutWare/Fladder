import 'package:fladder/providers/websocket/jellyfin_websocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('buildWebSocketUri', () {
    test('carries the token as ApiKey', () {
      final uri = buildWebSocketUri(
        serverUrl: 'https://jelly.example.com',
        token: 'tok-123',
        deviceId: 'dev-abc',
      );

      // Jellyfin 12 ignores the legacy `api_key` name by default, so the socket must send `ApiKey`.
      expect(uri.queryParameters['ApiKey'], 'tok-123');
      expect(uri.queryParameters.containsKey('api_key'), isFalse);
      expect(uri.queryParameters['deviceId'], 'dev-abc');
    });

    test('upgrades the scheme and keeps host, port and base path', () {
      final uri = buildWebSocketUri(
        serverUrl: 'https://jelly.example.com:8920/jellyfin/',
        token: 't',
        deviceId: 'd',
      );

      expect(uri.scheme, 'wss');
      expect(uri.host, 'jelly.example.com');
      expect(uri.port, 8920);
      expect(uri.path, '/jellyfin/socket');
    });

    test('uses ws for a plain-http server', () {
      final uri = buildWebSocketUri(serverUrl: 'http://192.168.1.10:8096', token: 't', deviceId: 'd');

      expect(uri.scheme, 'ws');
      expect(uri.path, '/socket');
    });
  });

  group('redactSocketUri', () {
    test('masks the token but keeps the rest readable', () {
      final uri = buildWebSocketUri(
        serverUrl: 'https://jelly.example.com',
        token: 'super-secret',
        deviceId: 'dev-abc',
      );

      final redacted = redactSocketUri(uri);

      expect(redacted, isNot(contains('super-secret')));
      expect(redacted, contains('ApiKey=***'));
      expect(redacted, contains('deviceId=dev-abc'));
    });
  });
}
