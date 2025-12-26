import 'dart:developer';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/seerr_service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/seerr/seerr_safe_converter.dart';
import 'package:fladder/seerr/seerr_open_api.swagger.dart';

part 'seerr_api_provider.g.dart';

@riverpod
class SeerrApi extends _$SeerrApi {
  @override
  SeerrService build() {
    ref.watch(userProvider.select((u) => u?.seerrCredentials));

    return SeerrService(
      ref,
      SeerrOpenApi.create(
        converter: const SeerrSafeJsonSerializableConverter(),
        interceptors: [
          SeerrRequest(ref),
          SeerrResponse(ref),
          HttpLoggingInterceptor(level: Level.basic),
        ],
      ),
    );
  }
}

class SeerrRequest implements Interceptor {
  SeerrRequest(this.ref);

  final Ref ref;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final connectivityNotifier = ref.read(connectivityStatusProvider.notifier);

    Uri? fullRequestUri;

    try {
      final creds = ref.read(userProvider)?.seerrCredentials;
      final serverUrl = creds?.serverUrl;
      if (serverUrl == null || serverUrl.trim().isEmpty) {
        throw const HttpException('Seerr server not configured');
      }

      final apiKey = creds?.apiKey.trim() ?? '';
      final cookie = creds?.sessionCookie.trim() ?? '';

      final requestPath = chain.request.url.path.toLowerCase();
      final isAuthPath = requestPath.startsWith('/auth/');
      final isAuthMe = requestPath == '/auth/me';
      final shouldSkipAuthHeaders = isAuthPath && !isAuthMe;

      final headers = <String, String>{};
      if (!shouldSkipAuthHeaders) {
        if (apiKey.isNotEmpty) {
          headers['X-Api-Key'] = apiKey;
        } else if (cookie.isNotEmpty) {
          headers['Cookie'] = cookie;
        }
      }

      final apiBaseUri = _apiBaseUri(serverUrl);

      try {
        fullRequestUri = apiBaseUri.resolveUri(chain.request.url);
      } catch (_) {
        fullRequestUri = chain.request.url;
      }

      final Response<BodyType> response = await chain.proceed(
        applyHeaders(
          chain.request.copyWith(
            baseUri: apiBaseUri,
          ),
          headers,
        ),
      );

      connectivityNotifier.checkConnectivity();
      return response;
    } catch (e, st) {
      connectivityNotifier.onStateChange([]);

      final method = chain.request.method;

      // Best-effort URL logging, even if we failed before applying `baseUri`.
      Uri urlToLog = fullRequestUri ?? chain.request.url;
      final serverUrl = ref.read(userProvider)?.seerrCredentials?.serverUrl;
      if (fullRequestUri == null && serverUrl != null && serverUrl.trim().isNotEmpty) {
        try {
          final apiBaseUri = _apiBaseUri(serverUrl);
          urlToLog = apiBaseUri.resolveUri(chain.request.url);
        } catch (_) {
          urlToLog = chain.request.url;
        }
      }

      log(
        'Failed to make Seerr request\n$method $urlToLog\n$e',
        stackTrace: st,
      );
      throw Exception('Failed to make Seerr request\n$method $urlToLog\n$e');
    }
  }
}

class SeerrResponse implements Interceptor {
  SeerrResponse(this.ref);

  final Ref ref;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final Response<BodyType> response = await chain.proceed(chain.request);

    if (!response.isSuccessful) {
      final method = response.base.request?.method;
      final url = response.base.request?.url.toString();
      final status = response.base.statusCode;
      final reason = response.base.reasonPhrase;

      final body = response.bodyString;
      final bodyPreview = body.length <= 1500 ? body : '${body.substring(0, 1500)}…';

      log(
        'x- $status - $reason - ${response.error} - $method $url\n$bodyPreview',
      );
    }

    return response;
  }
}

String _normalizeUrl(String url) {
  url = url.trim();
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'http://$url';
  }
  return url;
}

Uri _apiBaseUri(String serverUrl) {
  final base = Uri.parse(_normalizeUrl(serverUrl));
  final segments = base.pathSegments.where((s) => s.trim().isNotEmpty).toList(growable: true);

  final alreadyPrefixed = segments.length >= 2 &&
      segments[segments.length - 2].toLowerCase() == 'api' &&
      segments[segments.length - 1].toLowerCase() == 'v1';

  if (!alreadyPrefixed) {
    segments.addAll(const ['api', 'v1']);
  }

  return base.replace(path: '/${segments.join('/')}');
}
