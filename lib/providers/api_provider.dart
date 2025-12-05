import 'dart:developer';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:punycoder/punycoder.dart';
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
  url = url.trim();
  if (!url.startsWith("http://") && !url.startsWith("https://")) {
    url = "http://$url";
  }
  //host needs to be separated as punycodec breaks if its given any extras / or other characters
  int? port = Uri.parse(url).port;
  String scheme = Uri.parse(url).scheme;
  String? host = url.replaceAll(RegExp(r'^(https?://)|(:\S+)|(/)'), ''); //removes scheme and port
  String path = Uri.parse(url).path; //case for proxy use that requires a path

  String decodedhost = const PunycodeCodec().encode(host);
  url = "$scheme://$decodedhost:$port/$path";

  return url;
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
