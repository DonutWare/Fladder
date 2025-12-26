import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/models/seerr/seerr_item_models.dart';
import 'package:fladder/models/seerr/seerr_search_model.dart';
import 'package:fladder/seerr/seerr_open_api.enums.swagger.dart' as seerr_enums;
import 'package:fladder/seerr/seerr_open_api.swagger.dart';

class SeerrService {
  SeerrService(this.ref, this._api);

  final Ref ref;
  final SeerrOpenApi _api;

  Future<Response<StatusGet$Response>> status() => _api.statusGet();

  Future<Response<User>> me() => _api.authMeGet();

  SeerrDashboardPosterModel? _posterFromDetails({
    required SeerrDashboardMediaType type,
    required int tmdbId,
    required String title,
    required String overview,
    required String? posterPath,
    required String? backdropPath,
  }) {
    if (tmdbId <= 0) return null;

    final keyPrefix = type == SeerrDashboardMediaType.movie ? 'tmdb_movie_$tmdbId' : 'tmdb_tv_$tmdbId';
    final id = type == SeerrDashboardMediaType.movie ? 'tmdb:movie:$tmdbId' : 'tmdb:tv:$tmdbId';

    return SeerrDashboardPosterModel(
      id: id,
      type: type,
      tmdbId: tmdbId,
      jellyfinItemId: null,
      title: title,
      overview: overview,
      images: ImagesData(
        primary: tmdbPrimaryImage(keyPrefix: keyPrefix, posterPath: posterPath),
        backDrop: tmdbBackdropImages(keyPrefix: keyPrefix, backdropPath: backdropPath),
      ),
    );
  }

  Future<SeerrDashboardPosterModel?> fetchDashboardPosterFromIds({
    int? tmdbId,
    int? tvdbId,
    String? language,
  }) async {
    if (tvdbId != null) {
      if (tmdbId == null) return null;
      final tvResponse = await tvDetails(tvId: tmdbId, language: language);
      if (!tvResponse.isSuccessful || tvResponse.body == null) return null;
      final details = tvResponse.body!;
      return _posterFromDetails(
        type: SeerrDashboardMediaType.tv,
        tmdbId: details.id?.toInt() ?? 0,
        title: details.name ?? '',
        overview: details.overview ?? '',
        posterPath: details.posterPath,
        backdropPath: details.backdropPath,
      );
    }

    if (tmdbId != null) {
      final movieResponse = await movieDetails(tmdbId: tmdbId, language: language);
      if (!movieResponse.isSuccessful || movieResponse.body == null) return null;
      final details = movieResponse.body!;
      return _posterFromDetails(
        type: SeerrDashboardMediaType.movie,
        tmdbId: details.id?.toInt() ?? 0,
        title: details.title ?? '',
        overview: details.overview ?? '',
        posterPath: details.posterPath,
        backdropPath: details.backdropPath,
      );
    }

    return null;
  }

  Future<Response<MovieDetails>> movieDetails({required int tmdbId, String? language}) {
    return _api.movieMovieIdGet(movieId: tmdbId, language: language);
  }

  Future<Response<TvDetails>> tvDetails({required int tvId, String? language}) {
    return _api.tvTvIdGet(tvId: tvId, language: language);
  }

  Future<Response<RequestGet$Response>> listRequests({
    num? take,
    num? skip,
    RequestGetFilter? filter,
    RequestGetSort? sort,
    RequestGetSortDirection? sortDirection,
    num? requestedBy,
  }) async {
    return _api.request$Get(
      take: take,
      skip: skip,
      filter: filter,
      sort: sort,
      sortDirection: sortDirection,
      requestedBy: requestedBy,
    );
  }

  Future<Response<MediaGet$Response>> media({
    num? take,
    num? skip,
    seerr_enums.MediaGetFilter? filter,
    seerr_enums.MediaGetSort? sort,
  }) {
    return _api.mediaGet(
      take: take,
      skip: skip,
      filter: filter,
      sort: sort,
    );
  }

  Future<List<SeerrDashboardPosterModel>> discoverTrending({num? page, String? language}) async {
    final response = await _api.discoverTrendingGet(page: page, language: language);
    final results = response.body?.results ?? const <Object>[];
    return results.map(_posterFromDiscoverObject).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Map<String, dynamic>? _stringKeyedMap(Object value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return null;
  }

  int _toInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  int _tmdbIdFromMap(Map<String, dynamic> map) {
    final rawId = map['id'] ?? (map['mediaInfo'] is Map ? (map['mediaInfo'] as Map)['tmdbId'] : null);
    return _toInt(rawId);
  }

  SeerrDashboardPosterModel? _posterFromMap(Map<String, dynamic> map) {
    final mediaType = (map['mediaType'] ?? '').toString().toLowerCase();

    // Explicit mediaType (preferred when present).
    if (mediaType == 'movie') {
      return _posterFromDetails(
        type: SeerrDashboardMediaType.movie,
        tmdbId: _tmdbIdFromMap(map),
        title: (map['title'] ?? map['originalTitle'] ?? map['name'] ?? '').toString(),
        overview: (map['overview'] ?? '').toString(),
        posterPath: map['posterPath']?.toString(),
        backdropPath: map['backdropPath']?.toString(),
      );
    }
    if (mediaType == 'tv' || mediaType == 'series') {
      return _posterFromDetails(
        type: SeerrDashboardMediaType.tv,
        tmdbId: _tmdbIdFromMap(map),
        title: (map['name'] ?? map['originalName'] ?? map['title'] ?? '').toString(),
        overview: (map['overview'] ?? '').toString(),
        posterPath: map['posterPath']?.toString(),
        backdropPath: map['backdropPath']?.toString(),
      );
    }

    // Heuristics if mediaType is missing.
    if (map.containsKey('name') || map.containsKey('firstAirDate')) {
      return _posterFromDetails(
        type: SeerrDashboardMediaType.tv,
        tmdbId: _tmdbIdFromMap(map),
        title: (map['name'] ?? map['originalName'] ?? '').toString(),
        overview: (map['overview'] ?? '').toString(),
        posterPath: map['posterPath']?.toString(),
        backdropPath: map['backdropPath']?.toString(),
      );
    }
    if (map.containsKey('title') || map.containsKey('releaseDate')) {
      return _posterFromDetails(
        type: SeerrDashboardMediaType.movie,
        tmdbId: _tmdbIdFromMap(map),
        title: (map['title'] ?? map['originalTitle'] ?? '').toString(),
        overview: (map['overview'] ?? '').toString(),
        posterPath: map['posterPath']?.toString(),
        backdropPath: map['backdropPath']?.toString(),
      );
    }

    return null;
  }

  SeerrDashboardPosterModel? _posterFromDiscoverObject(Object value) {
    // Generated types (preferred when available).
    if (value is MovieResult) {
      return _posterFromDetails(
        type: SeerrDashboardMediaType.movie,
        tmdbId: value.id.toInt(),
        title: value.title,
        overview: value.overview ?? '',
        posterPath: value.posterPath,
        backdropPath: value.backdropPath,
      );
    }
    if (value is TvResult) {
      return _posterFromDetails(
        type: SeerrDashboardMediaType.tv,
        tmdbId: (value.id ?? 0).toInt(),
        title: value.name ?? '',
        overview: value.overview ?? '',
        posterPath: value.posterPath,
        backdropPath: value.backdropPath,
      );
    }
    if (value is PersonResult) return null;

    // Runtime Map payloads (common for discover/trending results).
    final map = _stringKeyedMap(value);
    if (map == null) return null;

    return _posterFromMap(map);
  }

  Future<List<SeerrDashboardPosterModel>> discoverPopularMovies({num? page, String? language}) async {
    final response = await _api.discoverMoviesGet(
      page: page,
      language: language,
      sortBy: 'popularity.desc',
    );
    final results = response.body?.results ?? const <MovieResult>[];
    return results
        .map((result) => _posterFromDetails(
              type: SeerrDashboardMediaType.movie,
              tmdbId: result.id.toInt(),
              title: result.title,
              overview: result.overview ?? '',
              posterPath: result.posterPath,
              backdropPath: result.backdropPath,
            ))
        .whereType<SeerrDashboardPosterModel>()
        .toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverExpectedMovies({num? page, String? language}) async {
    final response = await _api.discoverMoviesUpcomingGet(page: page, language: language);
    final results = response.body?.results ?? const <MovieResult>[];
    return results
        .map((result) => _posterFromDetails(
              type: SeerrDashboardMediaType.movie,
              tmdbId: result.id.toInt(),
              title: result.title,
              overview: result.overview ?? '',
              posterPath: result.posterPath,
              backdropPath: result.backdropPath,
            ))
        .whereType<SeerrDashboardPosterModel>()
        .toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverExpectedSeries({num? page, String? language}) async {
    final response = await _api.discoverTvUpcomingGet(page: page, language: language);
    final results = response.body?.results ?? const <TvResult>[];
    return results
        .map((result) => _posterFromDetails(
              type: SeerrDashboardMediaType.tv,
              tmdbId: (result.id ?? 0).toInt(),
              title: result.name ?? '',
              overview: result.overview ?? '',
              posterPath: result.posterPath,
              backdropPath: result.backdropPath,
            ))
        .whereType<SeerrDashboardPosterModel>()
        .toList(growable: false);
  }

  Future<Response<UserUserIdRequestsGet$Response>> myRequests({
    num? take,
    num? skip,
  }) async {
    final meResponse = await me();
    if (!meResponse.isSuccessful) {
      return Response(
        meResponse.base,
        null,
        error: meResponse.error ?? 'Failed to fetch Seerr user',
      );
    }
    final userId = meResponse.body?.id;
    if (userId == null) {
      return Response(
        meResponse.base,
        null,
        error: 'No user id returned by Seerr',
      );
    }

    return _api.userUserIdRequestsGet(userId: userId, take: take, skip: skip);
  }

  Future<Response<MediaRequest>> requestMovie({
    required int tmdbId,
    bool? is4k,
  }) {
    return _api.request$Post(
      body: RequestPost$RequestBody(
        mediaType: seerr_enums.RequestPost$RequestBodyMediaType.movie,
        mediaId: tmdbId.toDouble(),
        is4k: is4k,
      ),
    );
  }

  Future<Response<MediaRequest>> requestSeries({
    required int tmdbId,
    bool? is4k,
    List<int>? seasons,
  }) {
    return _api.request$Post(
      body: RequestPost$RequestBody(
        mediaType: seerr_enums.RequestPost$RequestBodyMediaType.tv,
        mediaId: tmdbId.toDouble(),
        is4k: is4k,
        seasons: seasons?.map((e) => e.toDouble()).toList(growable: false),
      ),
    );
  }

  Future<List<SeerrSearchResultItem>> searchPosters({required String query, num? page, String? language}) async {
    if (query.trim().isEmpty) return const [];

    final response = await _api.searchGet(query: query, page: page, language: language);
    final results = response.body?.results ?? const <Object>[];

    final items = <SeerrSearchResultItem>[];
    for (final result in results) {
      final poster = _posterFromDiscoverObject(result);
      if (poster == null) continue;
      items.add(SeerrSearchResultItem(poster: poster));
    }
    return items;
  }

  Future<String> authenticateLocal({required String email, required String password}) async {
    final response = await _api.authLocalPost(
      body: AuthLocalPost$RequestBody(email: email, password: password),
    );
    if (!response.isSuccessful) {
      throw HttpException('Local authentication failed (${response.statusCode})');
    }
    final cookie = _extractSessionCookie(response);
    if (cookie == null || cookie.isEmpty) {
      throw const HttpException('No session cookie returned by server');
    }
    return cookie;
  }

  Future<String> authenticateJellyfin({required String username, required String password}) async {
    final response = await _authenticateJellyfin(username: username, password: password);
    return _requireSessionCookie(response, label: 'Jellyfin');
  }

  Future<Response<dynamic>> _authenticateJellyfin({required String username, required String password}) async {
    var response = await _api.authJellyfinPost(
      body: AuthJellyfinPost$RequestBody(username: username, password: password),
    );

    if (!response.isSuccessful && _shouldRetryWithHostname(response)) {
      response = await _api.authJellyfinPost(
        body: AuthJellyfinPost$RequestBody(
          username: username,
          password: password,
          hostname: Platform.localHostname,
        ),
      );
    }

    return response;
  }

  bool _shouldRetryWithHostname(Response<dynamic> response) {
    final details = response.error ?? response.body;
    final detailsString = details?.toString().toLowerCase() ?? '';
    return detailsString.contains('hostname') &&
        (detailsString.contains('not configured') ||
            detailsString.contains('missing') ||
            detailsString.contains('required'));
  }

  String _requireSessionCookie(Response<dynamic> response, {required String label}) {
    if (!response.isSuccessful) {
      final details = response.error ?? response.body;
      throw HttpException('$label authentication failed (${response.statusCode})\n$details');
    }
    final cookie = _extractSessionCookie(response);
    if (cookie == null || cookie.isEmpty) {
      throw const HttpException('No session cookie returned by server');
    }
    return cookie;
  }

  String? _extractSessionCookie(Response<dynamic> response) {
    final setCookie = response.base.headers['set-cookie'];
    if (setCookie == null || setCookie.isEmpty) return null;
    return setCookie.split(';').first.trim();
  }
}
