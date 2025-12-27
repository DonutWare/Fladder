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

  final newPath = normalizeUrl(newUrl ?? "");

  log(newPath);

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

class JellyRequest implements Interceptor {
  JellyRequest(this.ref);

  final Ref ref;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final connectivityNotifier = ref.read(connectivityStatusProvider.notifier);
    String? serverUrl = ref.read(serverUrlProvider);

    try {
      if (serverUrl?.isEmpty == true || serverUrl == null) throw const HttpException("Failed to connect");

      //Use current logged in user otherwise use the authprovider
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

  // Only punycode the host; keep the rest (path/query/fragment) exactly as parsed.
  final host = parsed.host;
  final isIpv4 = RegExp(r'^\d{1,3}(?:\.\d{1,3}){3}$').hasMatch(host);
  final isIpv6 = host.contains(':');
  final hasNonAscii = host.runes.any((c) => c > 0x7F);

  final encodedHost = (!isIpv4 && !isIpv6 && hasNonAscii) ? const PunycodeCodec().encode(host) : host;

  var normalized = parsed.replace(host: encodedHost);

  final path = normalized.path;
  if (path.isEmpty) {
    normalized = normalized.replace(path: '/');
  } else if (!path.endsWith('/')) {
    normalized = normalized.replace(path: '$path/');
  }

  return normalized.toString();
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
