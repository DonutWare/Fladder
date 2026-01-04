import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/seerr/seerr_models.dart';

class SeerrHelpers {
  SeerrHelpers._();

  /// Builds a season status map from TV details, incorporating both mediaInfo seasons and requests
  static Map<int, SeerrRequestStatus> buildSeasonStatusMap(SeerrTvDetails details) {
    final Map<int, SeerrRequestStatus> seasonStatusMap = {
      for (final season in details.mediaInfo?.seasons ?? const <SeerrMediaInfoSeason>[])
        if (season.seasonNumber != null) season.seasonNumber!: SeerrRequestStatus.fromRaw(season.status),
    };

    final knownSeasonNumbers = <int>{
      ...seasonStatusMap.keys,
      ...?details.seasons?.map((season) => season.seasonNumber).whereType<int>(),
    };

    final requests = details.mediaInfo?.requests ?? const <SeerrMediaRequest>[];
    if (requests.isNotEmpty) {
      for (final request in requests) {
        final requestStatus = SeerrRequestStatus.fromRaw(request.status);
        if (requestStatus == SeerrRequestStatus.unknown || requestStatus == SeerrRequestStatus.deleted) continue;

        final requestSeasonNumbers = request.seasons?.whereType<int>().toList(growable: false);
        final seasonsToUpdate =
            (requestSeasonNumbers == null || requestSeasonNumbers.isEmpty) ? knownSeasonNumbers : requestSeasonNumbers;
        for (final seasonNumber in seasonsToUpdate) {
          final current = seasonStatusMap[seasonNumber];
          if (current == SeerrRequestStatus.available || current == SeerrRequestStatus.deleted) continue;
          seasonStatusMap[seasonNumber] = requestStatus;
        }
      }
    }

    return seasonStatusMap;
  }

  /// Extracts the content rating for the user's region, with US fallback
  static String? extractContentRating(List<SeerrContentRating>? contentRatings, String userRegion) {
    if (contentRatings == null || contentRatings.isEmpty) return null;

    final userRegionUpper = userRegion.toUpperCase();
    String? usFallback;
    String? anyFallback;

    for (final rating in contentRatings) {
      final countryCode = (rating.countryCode ?? '').toUpperCase();
      final ratingValue = rating.rating;

      if (ratingValue == null || ratingValue.isEmpty) continue;

      if (countryCode == userRegionUpper) {
        return ratingValue;
      }

      if (usFallback == null && countryCode == 'US') {
        usFallback = ratingValue;
      }

      anyFallback ??= ratingValue;
    }

    return usFallback ?? anyFallback;
  }

  /// Determines if a TV show is anime based on keywords and genres
  static bool isAnime(SeerrTvDetails details) {
    final keywordHit = details.keywords?.any((k) => (k.name ?? '').toLowerCase() == 'anime') ?? false;
    if (keywordHit) return true;
    final genreHit = details.genres
            ?.any((g) => (g.name ?? '').toLowerCase() == 'animation' || (g.name ?? '').toLowerCase() == 'anime') ??
        false;
    return genreHit;
  }
}
