import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/user_provider.dart';

part 'api_provider.g.dart';

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
    try {
      final serverUrl = Uri.parse(
          ref.read(userProvider)?.server ?? ref.read(authProvider).serverLoginModel?.tempCredentials.url ?? "");

      //Use current logged in user otherwise use the authprovider
      var loginModel = ref.read(userProvider)?.credentials ?? ref.read(authProvider).serverLoginModel?.tempCredentials;

      if (loginModel == null) throw UnimplementedError();

      var headers = loginModel.header(ref);
      final Response<BodyType> response = await chain.proceed(
        applyHeaders(
            chain.request.copyWith(
              baseUri: serverUrl,
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
