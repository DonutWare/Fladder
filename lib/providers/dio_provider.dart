import 'package:dio/dio.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final apiKey = ref.watch(apiKeyProvider);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['X-Emby-Token'] = apiKey;
        return handler.next(options);
      },
    ),
  );
  return dio;
});
