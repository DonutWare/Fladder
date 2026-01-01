import 'package:fladder/models/items/images_models.dart';

const _tmdbPosterBaseUrl = 'https://image.tmdb.org/t/p/w500';
const _tmdbBackdropBaseUrl = 'https://image.tmdb.org/t/p/w780';

String? tmdbUrl(String base, String? path) {
  if (path == null) return null;
  final trimmed = path.trim();
  if (trimmed.isEmpty) return null;
  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) return trimmed;
  return '$base$trimmed';
}

String? resolveImageUrl({
  required String? path,
  String? serverUrl,
  String tmdbBase = _tmdbPosterBaseUrl,
}) {
  if (path == null || path.trim().isEmpty) return path;
  final trimmed = path.trim();
  
  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return trimmed;
  }
  
  final tmdb = tmdbUrl(tmdbBase, trimmed);
  if (tmdb != null) return tmdb;
  
  return resolveServerUrl(path: trimmed, serverUrl: serverUrl);
}

String? resolveServerUrl({required String? path, required String? serverUrl}) {
  if (path == null || path.trim().isEmpty) return path;
  final trimmed = path.trim();
  
  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return trimmed;
  }
  
  if (serverUrl == null || serverUrl.trim().isEmpty) return trimmed;
  final cleanServerUrl = serverUrl.trim();
  
  final needsSlash = !cleanServerUrl.endsWith('/') && !trimmed.startsWith('/');
  return '$cleanServerUrl${needsSlash ? '/' : ''}$trimmed';
}

ImageData? tmdbPrimaryImage({required String keyPrefix, required String? posterPath}) {
  final url = tmdbUrl(_tmdbPosterBaseUrl, posterPath);
  if (url == null) return null;
  return ImageData(path: url, key: '${keyPrefix}_primary');
}

List<ImageData>? tmdbBackdropImages({required String keyPrefix, required String? backdropPath}) {
  final url = tmdbUrl(_tmdbBackdropBaseUrl, backdropPath);
  if (url == null) return null;
  return [ImageData(path: url, key: '${keyPrefix}_backdrop')];
}
