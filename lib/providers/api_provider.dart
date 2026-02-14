import 'dart:developer';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punycoder/punycoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
part 'api_provider.g.dart';

final serverUrlProvider = StateProvider<String?>((ref) {
  final localUrlAvailable = ref.watch(localConnectionAvailableProvider);
  final userCredentials = ref.watch(userProvider.select((value) => value?.credentials));
  final tempUrl = ref.watch(authProvider.select((value) => value.serverLoginModel?.tempCredentials.url));
  String? newUrl;

  if (localUrlAvailable && userCredentials?.localUrl?.isNotEmpty == true) {
    newUrl = userCredentials?.localUrl;
  } else if (userCredentials?.url.isNotEmpty == true) {
    newUrl = userCredentials?.url;
  } else if (tempUrl?.isNotEmpty == true) {
    newUrl = tempUrl;
  } else {
    newUrl = null;
  }

  return normalizeUrl(newUrl ?? "");
});

@riverpod
class JellyApi extends _$JellyApi {
  @override
  JellyService build() => JellyService(
        ref,
        JellyfinOpenApi.create(
          interceptors: [
            JellyRequest(ref),
            JellyResponse(ref),
            HttpLoggingInterceptor(level: Level.basic),
          ],
        ),
      );
}

JellyfinOpenApi createJellyfinApiForAccount(Ref ref, String baseUrl, Map<String, String> headers) {
  return JellyfinOpenApi.create(
    interceptors: [
      _TempJellyRequest(baseUrl: baseUrl, headers: headers),
      JellyResponse(ref),
      HttpLoggingInterceptor(level: Level.basic),
    ],
  );
}

class _TempJellyRequest implements Interceptor {
  _TempJellyRequest({required this.baseUrl, required this.headers});

  final String baseUrl;
  final Map<String, String> headers;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    if (baseUrl.isEmpty) throw const HttpException('No server URL provided for temp request');

    final request = applyHeaders(chain.request.copyWith(baseUri: Uri.parse(baseUrl)), headers);
    return chain.proceed(request);
  }
}

class JellyRequest implements Interceptor {
  JellyRequest(this.ref);

  final Ref ref;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final connectivityNotifier = ref.read(connectivityStatusProvider.notifier);
    String? serverUrl = ref.read(serverUrlProvider);

    try {
      if (serverUrl?.isEmpty == true || serverUrl == null) throw const HttpException("Failed to connect");

      //Use current logged in user otherwise use the authProvider
      var loginModel = ref.read(userProvider)?.credentials ?? ref.read(authProvider).serverLoginModel?.tempCredentials;

      if (loginModel == null) throw UnimplementedError();

      var headers = loginModel.header(ref);
      final Response<BodyType> response = await chain.proceed(
        applyHeaders(
            chain.request.copyWith(
              baseUri: Uri.parse(serverUrl),
            ),
            headers),
      );

      connectivityNotifier.checkConnectivity();
      return response;
    } catch (e) {
      connectivityNotifier.onStateChange([ConnectivityResult.none]);
      throw Exception('Failed to make request\n$e');
    }
  }
}

String normalizeUrl(String url) {
  final trimmed = url.trim();
  if (trimmed.isEmpty) return '';

  final withScheme = (trimmed.startsWith('http://') || trimmed.startsWith('https://')) ? trimmed : 'http://$trimmed';
  final parsed = Uri.parse(withScheme);

  // Only punycode non-ASCII hostnames. IP addresses are always ASCII, so no special handling needed.
  final host = parsed.host;
  final hasNonAscii = host.runes.any((c) => c > 0x7F);

  if (!hasNonAscii) return parsed.toString();

  try {
    final encodedHost = const PunycodeCodec().encode(host);
    return parsed.replace(host: encodedHost).toString();
  } catch (_) {
    return parsed.toString();
  }
}

Uri? tryParseServerBaseUri(String? url) {
  if (url == null) return null;
  final trimmed = url.trim();
  if (trimmed.isEmpty) return null;

  final parsed = Uri.tryParse(trimmed);
  if (parsed == null || parsed.scheme.isEmpty || parsed.host.isEmpty) return null;
  return parsed;
}

Uri? serverBaseUri(Ref ref) => tryParseServerBaseUri(ref.read(serverUrlProvider));

Uri? buildServerUriFromBase(
  String baseUrl, {
  List<String> pathSegments = const [],
  String? relativeUrl,
  Map<String, String?>? queryParameters,
}) {
  final base = tryParseServerBaseUri(baseUrl);
  if (base == null) return null;

  Uri? relative;
  if (relativeUrl != null && relativeUrl.trim().isNotEmpty) {
    relative = Uri.tryParse(relativeUrl.trim());
  }

  if (relative?.hasScheme == true && relative?.host.isNotEmpty == true) {
    return relative;
  }

  final baseSegments = base.pathSegments.where((s) => s.isNotEmpty).toList(growable: false);
  final relSegments = (relative?.pathSegments ?? const <String>[]).where((s) => s.isNotEmpty).toList(growable: false);
  final extraSegments = pathSegments.where((s) => s.isNotEmpty).toList(growable: false);

  final mergedSegments = <String>[...baseSegments, ...relSegments, ...extraSegments];

  final mergedQuery = <String, String>{...?(relative?.queryParameters)};
  if (queryParameters != null) {
    for (final entry in queryParameters.entries) {
      final value = entry.value;
      if (value == null) continue;
      mergedQuery[entry.key] = value;
    }
  }

  return Uri(
    scheme: base.scheme,
    userInfo: base.userInfo,
    host: base.host,
    port: base.hasPort ? base.port : null,
    pathSegments: mergedSegments,
    queryParameters: mergedQuery.isNotEmpty ? mergedQuery : null,
    fragment: relative?.hasFragment == true ? relative!.fragment : null,
  );
}

Uri? buildServerUri(
  Ref ref, {
  List<String> pathSegments = const [],
  String? relativeUrl,
  Map<String, String?>? queryParameters,
}) {
  final baseUrl = ref.read(serverUrlProvider);
  if (baseUrl == null || baseUrl.isEmpty) return null;
  return buildServerUriFromBase(
    baseUrl,
    pathSegments: pathSegments,
    relativeUrl: relativeUrl,
    queryParameters: queryParameters,
  );
}

String buildServerUrl(
  Ref ref, {
  List<String> pathSegments = const [],
  String? relativeUrl,
  Map<String, String?>? queryParameters,
}) {
  return buildServerUri(
        ref,
        pathSegments: pathSegments,
        relativeUrl: relativeUrl,
        queryParameters: queryParameters,
      )?.toString() ??
      '';
}

class JellyResponse implements Interceptor {
  JellyResponse(this.ref);

  final Ref ref;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final Response<BodyType> response = await chain.proceed(chain.request);

    if (!response.isSuccessful) {
      log('x- ${response.base.statusCode} - ${response.base.reasonPhrase} - ${response.error} - ${response.base.request?.method} ${response.base.request?.url.toString()}');
    }
    if (response.statusCode == 404) {
      chopperLogger.severe('404 NOT FOUND');
    }

    return response;
  }
}
