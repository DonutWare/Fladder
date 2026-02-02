import 'dart:developer';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/seerr_service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/seerr/seerr_chopper_service.dart';
import 'package:fladder/seerr/seerr_json_converter.dart';

part 'seerr_api_provider.g.dart';

@riverpod
class SeerrApi extends _$SeerrApi {
  @override
  SeerrService build() {
    ref.watch(userProvider.select((u) => u?.seerrCredentials));

    final chopperClient = ChopperClient(
      converter: const SeerrJsonConverter(),
      interceptors: [
        SeerrRequest(ref),
        SeerrResponse(ref),
        HttpLoggingInterceptor(level: Level.basic),
      ],
    );

    return SeerrService(
      ref,
      SeerrChopperService.create(chopperClient),
    );
  }
}

class SeerrRequest implements Interceptor {
  SeerrRequest(this.ref);

  final Ref ref;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final connectivityNotifier = ref.read(connectivityStatusProvider.notifier);
    final creds = ref.read(userProvider)?.seerrCredentials;
    final serverUrl = creds?.serverUrl.trim();

    if (serverUrl == null || serverUrl.isEmpty) {
      throw const HttpException('Seerr server not configured');
    }

    final apiKey = creds?.apiKey.trim() ?? '';
    final cookie = creds?.sessionCookie.trim() ?? '';

    final authHeaders = _authHeaders(apiKey: apiKey, cookie: cookie);
    final customHeaders = creds?.customHeaders ?? <String, String>{};
    final headers = {...authHeaders, ...customHeaders};
    final apiBaseUri = Uri.parse(serverUrl);

    Uri resolvedRequestUri;
    try {
      resolvedRequestUri = apiBaseUri.resolveUri(chain.request.url);
    } catch (_) {
      resolvedRequestUri = chain.request.url;
    }

    final requestWithHeaders = applyHeaders(
      chain.request.copyWith(baseUri: apiBaseUri),
      headers,
    );

    try {
      final response = await chain.proceed(requestWithHeaders);
      connectivityNotifier.checkConnectivity();
      return response;
    } catch (e, st) {
      connectivityNotifier.onStateChange([]);
      throw HttpException(
        'Seerr API request failed: ${chain.request.method} $resolvedRequestUri\nError: $e\n$st',
      );
    }
  }
}

Map<String, String> _authHeaders({required String apiKey, required String cookie}) {
  if (apiKey.isNotEmpty) return {'X-Api-Key': apiKey};
  if (cookie.isNotEmpty) return {'Cookie': cookie};
  return const {};
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
