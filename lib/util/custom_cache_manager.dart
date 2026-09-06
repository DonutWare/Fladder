import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

import 'package:fladder/util/custom_headers.dart';

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 3),
      maxNrOfCacheObjects: 256,
      fileService: HttpFileService(httpClient: _ServerHeadersHttpClient()),
    ),
  );
}

/// Adds the active server's custom headers to image requests aimed at that
/// server. Artwork is fetched from both the Jellyfin server and third parties,
/// and [ServerCustomHeaders] only hands out headers for the former.
class _ServerHeadersHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(ServerCustomHeaders.forUri(request.url));
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
