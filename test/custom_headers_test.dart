import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/util/custom_headers.dart';

void main() {
  setUp(ServerCustomHeaders.clear);
  tearDown(ServerCustomHeaders.clear);

  group('ServerCustomHeaders', () {
    const headers = {
      'CF-Access-Client-Id': 'client-id',
      'CF-Access-Client-Secret': 'client-secret',
    };

    test('hands the headers to requests aimed at the server', () {
      ServerCustomHeaders.update(headers: headers, serverUrls: ['https://jellyfin.example.com']);

      expect(
        ServerCustomHeaders.forUrl('https://jellyfin.example.com/Items/1/Images/Primary'),
        headers,
      );
    });

    test('matches the host case insensitively and ignores port and scheme', () {
      ServerCustomHeaders.update(headers: headers, serverUrls: ['https://Jellyfin.Example.com:8096']);

      expect(ServerCustomHeaders.forUrl('http://jellyfin.example.com/System/Info/Public'), headers);
    });

    test('covers the local url as well', () {
      ServerCustomHeaders.update(
        headers: headers,
        serverUrls: ['https://jellyfin.example.com', 'http://192.168.1.10:8096'],
      );

      expect(ServerCustomHeaders.forUrl('http://192.168.1.10:8096/Items/1/Images/Primary'), headers);
    });

    test('never leaks the headers to third party hosts', () {
      ServerCustomHeaders.update(headers: headers, serverUrls: ['https://jellyfin.example.com']);

      expect(ServerCustomHeaders.forUrl('https://image.tmdb.org/t/p/w500/poster.jpg'), isEmpty);
      expect(ServerCustomHeaders.forUrl('https://evil.example.com'), isEmpty);
    });

    test('returns nothing when no headers are configured', () {
      ServerCustomHeaders.update(headers: const {}, serverUrls: ['https://jellyfin.example.com']);

      expect(ServerCustomHeaders.forUrl('https://jellyfin.example.com'), isEmpty);
    });

    test('shrugs off empty and unparseable urls', () {
      ServerCustomHeaders.update(headers: headers, serverUrls: ['', null, 'not a url']);

      expect(ServerCustomHeaders.forUrl(null), isEmpty);
      expect(ServerCustomHeaders.forUrl(''), isEmpty);
      expect(ServerCustomHeaders.forUrl('https://jellyfin.example.com'), isEmpty);
    });
  });

  group('parseCustomHeaders', () {
    test('keeps usable entries and drops blank names', () {
      expect(
        parseCustomHeaders({'CF-Access-Client-Id': 'id', '  ': 'ignored', 'X-Empty': null}),
        {'CF-Access-Client-Id': 'id', 'X-Empty': ''},
      );
    });

    test('returns an empty map for anything that is not a map', () {
      expect(parseCustomHeaders(null), isEmpty);
      expect(parseCustomHeaders('CF-Access-Client-Id'), isEmpty);
    });
  });
}
