import 'package:fladder/providers/api_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('authQueryParams', () {
    test('carries the token under both names the server may bind', () {
      // Dropping either name breaks one server generation: 12 ignores the legacy `api_key` by default,
      // and `ApiKey` is what every server reads first.
      expect(authQueryParams('tok-123'), {'ApiKey': 'tok-123', 'api_key': 'tok-123'});
    });

    test('a null token yields entries the URI builder drops', () {
      final uri = buildServerUriFromBase(
        'https://jelly.example.com',
        pathSegments: ['Items', 'abc', 'Download'],
        queryParameters: authQueryParams(null),
      );

      expect(uri, isNotNull);
      expect(uri!.queryParameters, isEmpty);
      expect(uri.toString(), 'https://jelly.example.com/Items/abc/Download');
    });
  });

  group('download URLs built from the helper', () {
    test('both parameters survive into the built URI', () {
      final uri = buildServerUriFromBase(
        'https://jelly.example.com',
        pathSegments: ['Items', 'abc123', 'Download'],
        queryParameters: authQueryParams('tok-123'),
      );

      expect(uri, isNotNull);
      expect(uri!.path, '/Items/abc123/Download');
      expect(uri.queryParameters['ApiKey'], 'tok-123');
      expect(uri.queryParameters['api_key'], 'tok-123');
    });

    test('a base URL with a trailing slash does not double the path separator', () {
      final uri = buildServerUriFromBase(
        'https://jelly.example.com/jellyfin/',
        pathSegments: ['Items', 'abc123', 'Download'],
        queryParameters: authQueryParams('t'),
      );

      expect(uri, isNotNull);
      expect(uri!.path, '/jellyfin/Items/abc123/Download');
      expect(uri.toString(), isNot(contains('//Items')));
    });

    test('an unusable base URL yields null rather than a "null/Items/..." string', () {
      // `createDownloadUrl` passes '' when signed out; its caller treats null as "cannot download".
      expect(buildServerUriFromBase('', pathSegments: ['Items', 'abc', 'Download']), isNull);
    });
  });
}
