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
