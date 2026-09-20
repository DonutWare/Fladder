import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/screens/shared/custom_headers_editor.dart';
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

  group('CustomHeadersController', () {
    test('starts on the Cloudflare preset when nothing is configured', () {
      final controller = CustomHeadersController();
      addTearDown(controller.dispose);

      expect(controller.preset, CustomHeaderPreset.cloudflareAccess);
      expect(controller.headers, isEmpty);
    });

    test('starts on the Cloudflare preset when Cloudflare headers exist', () {
      final controller = CustomHeadersController(headers: const {'CF-Access-Client-Id': 'id'});
      addTearDown(controller.dispose);

      expect(controller.preset, CustomHeaderPreset.cloudflareAccess);
      expect(controller.clientId.text, 'id');
    });

    test('starts on the custom preset for unrelated headers', () {
      final controller = CustomHeadersController(headers: const {'X-Authelia-User': 'geoffrey'});
      addTearDown(controller.dispose);

      expect(controller.preset, CustomHeaderPreset.custom);
    });

    test('keeps Cloudflare fields that were typed but never added', () {
      final controller = CustomHeadersController();
      addTearDown(controller.dispose);

      controller.clientId.text = 'client-id';
      controller.clientSecret.text = 'client-secret';

      expect(controller.headers, {
        'CF-Access-Client-Id': 'client-id',
        'CF-Access-Client-Secret': 'client-secret',
      });
    });

    test('keeps a custom header that was typed but never added', () {
      final controller = CustomHeadersController(headers: const {'X-Kept': 'yes'});
      addTearDown(controller.dispose);

      controller.name.text = 'X-Typed';
      controller.value.text = 'pending';

      expect(controller.headers, {'X-Kept': 'yes', 'X-Typed': 'pending'});
    });

    test('carries typed values across a preset switch', () {
      final controller = CustomHeadersController();
      addTearDown(controller.dispose);

      controller.clientId.text = 'client-id';
      controller.preset = CustomHeaderPreset.custom;

      expect(controller.headers, {'CF-Access-Client-Id': 'client-id'});
    });

    test('clearing a Cloudflare field drops the header', () {
      final controller = CustomHeadersController(headers: const {'CF-Access-Client-Id': 'id'});
      addTearDown(controller.dispose);

      controller.clientId.text = '';

      expect(controller.headers, isEmpty);
    });

    test('removing a header clears its field', () {
      final controller = CustomHeadersController(headers: const {'CF-Access-Client-Secret': 'secret'});
      addTearDown(controller.dispose);

      controller.remove('CF-Access-Client-Secret');

      expect(controller.clientSecret.text, isEmpty);
      expect(controller.headers, isEmpty);
    });

    test('hides preset backed headers from the chip list', () {
      final controller = CustomHeadersController(headers: const {
        'CF-Access-Client-Id': 'id',
        'X-Other': 'kept',
      });
      addTearDown(controller.dispose);

      expect(controller.listedHeaders, {'X-Other': 'kept'});
      expect(controller.headers, {'CF-Access-Client-Id': 'id', 'X-Other': 'kept'});
    });
  });
}
