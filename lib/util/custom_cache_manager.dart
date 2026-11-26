import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fladder/util/http_client.dart';

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 1000,
      fileService: HttpFileService(httpClient: createHttpClient()),
    ),
  );
}
