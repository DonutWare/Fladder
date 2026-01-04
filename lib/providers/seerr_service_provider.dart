import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/models/seerr/seerr_item_models.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/seerr/seerr_chopper_service.dart';
import 'package:fladder/seerr/seerr_models.dart';

const tmbdUrl = 'https://image.tmdb.org/t/p/original';

class SeerrService {
  SeerrService(this.ref, this._api);

  final Ref ref;
  final SeerrChopperService _api;

  Future<Response<SeerrStatus>> status() => _api.getStatus();

  Future<Response<SeerrUserModel>> me() async {
    final response = await _api.getMe();
    final user = response.body;
    if (user == null) return response;

    final avatar = user.avatar;
    if (avatar != null && avatar.isNotEmpty) {
      final serverUrl = ref.read(userProvider)?.seerrCredentials?.serverUrl;
      final resolvedAvatar = resolveServerUrl(path: avatar, serverUrl: serverUrl);

      if (resolvedAvatar != avatar) {
        return response.copyWith(body: user.copyWith(avatar: resolvedAvatar));
      }
    }

    return response;
  }

  Future<List<SeerrSonarrServer>> sonarrServers() async {
    final servers = await _api.getSonarrServers();

    List<SeerrSonarrServer> sonarrServers = [];

    if (servers.isSuccessful && servers.body?.isNotEmpty == true) {
      for (final server in servers.body!) {
        final serverSettings = await _api.getSonarrServer(server.id ?? 0);
        if (serverSettings.isSuccessful && serverSettings.body != null) {
          final response = serverSettings.body!;
          final server = response.server;
          if (server != null) {
            final updatedServer = server.copyWith(
              profiles: response.profiles,
              tags: response.tags ?? server.tags,
              rootFolders: response.rootFolders ?? server.rootFolders,
            );
            sonarrServers.add(updatedServer);
          }
        }
      }
    }

    return sonarrServers;
  }

  Future<List<SeerrRadarrServer>> radarrServers() async {
    final servers = await _api.getRadarrServers();

    List<SeerrRadarrServer> radarrServers = [];

    if (servers.isSuccessful && servers.body?.isNotEmpty == true) {
      for (final server in servers.body!) {
        final serverSettings = await _api.getRadarrServer(server.id ?? 0);
        if (serverSettings.isSuccessful && serverSettings.body != null) {
          final response = serverSettings.body!;
          final server = response.server;
          if (server != null) {
            radarrServers.add(
              server.copyWith(
                profiles: response.profiles,
                tags: response.tags ?? server.tags,
                rootFolders: response.rootFolders,
              ),
            );
          }
        }
      }
    }

    return radarrServers;
  }

  Future<List<SeerrUserModel>> users({int? take, int? skip, String sort = 'displayname'}) async {
    final response = await _api.getUsers(take: take, skip: skip, sort: sort);
    final results = response.body?.results ?? [];
    final serverUrl = ref.read(userProvider)?.seerrCredentials?.serverUrl;

    return results.map((user) {
      final avatar = user.avatar;
      if (avatar == null || avatar.isEmpty) return user;

      final resolvedAvatar = resolveServerUrl(path: avatar, serverUrl: serverUrl);
      if (resolvedAvatar == avatar) return user;

      return user.copyWith(avatar: resolvedAvatar);
    }).toList(growable: false);
  }

  Future<SeerrUserQuota?> userQuota({required int userId}) async {
    final response = await _api.getUserQuota(userId);
    if (!response.isSuccessful) return null;
    return response.body;
  }

  SeerrDashboardPosterModel? _posterFromDetails({
    required SeerrDashboardMediaType type,
    required int tmdbId,
    required String title,
    required String overview,
    required String? posterUrl,
    required SeerrRequestStatus? status,
    required String? backdropUrl,
    SeerrMediaInfo? mediaInfo,
    String? jellyfinItemId,
    List<SeerrSeason>? seasons,
    Map<int, SeerrRequestStatus>? seasonStatuses,
    String? releaseYear,
  }) {
    final keyPrefix = type == SeerrDashboardMediaType.movie ? 'tmdb_movie_$tmdbId' : 'tmdb_tv_$tmdbId';
    final id = type == SeerrDashboardMediaType.movie ? 'tmdb:movie:$tmdbId' : 'tmdb:tv:$tmdbId';

    return SeerrDashboardPosterModel(
      id: id,
      type: type,
      tmdbId: tmdbId,
      jellyfinItemId: jellyfinItemId,
      title: title,
      overview: overview,
      images: ImagesData(
        primary: posterUrl != null ? ImageData(path: posterUrl, key: '${keyPrefix}_primary') : null,
        backDrop: backdropUrl != null ? [ImageData(path: backdropUrl, key: '${keyPrefix}_backdrop')] : null,
      ),
      status: status ?? SeerrRequestStatus.unknown,
      seasons: seasons,
      seasonStatuses: seasonStatuses,
      mediaInfo: mediaInfo,
      releaseYear: releaseYear,
    );
  }

  SeerrRequestStatus? _statusFromRaw(int? raw) => raw != null ? SeerrRequestStatus.fromRaw(raw) : null;

  Map<int, SeerrRequestStatus> _seasonStatusMap(List<SeerrMediaInfoSeason>? seasons) {
    if (seasons == null) return const {};
    return {
      for (final season in seasons)
        if (season.seasonNumber != null) season.seasonNumber!: SeerrRequestStatus.fromRaw(season.status),
    };
  }

  Future<SeerrDashboardPosterModel?> fetchDashboardPosterFromIds({
    int? tmdbId,
    int? tvdbId,
    String? language,
    SeerrDashboardMediaType? mediaType,
  }) async {
    if (tvdbId != null) {
      if (tmdbId == null) return null;
      final tvResponse = await tvDetails(tvId: tmdbId, language: language);
      if (!tvResponse.isSuccessful || tvResponse.body == null) return null;
      final details = tvResponse.body!;
      final seasonStatusMap = _seasonStatusMap(details.mediaInfo?.seasons);
      String? releaseYear;
      final firstAirDate = details.firstAirDate;
      if (firstAirDate != null && firstAirDate.isNotEmpty) {
        releaseYear = firstAirDate.split('-').first;
      }
      return _posterFromDetails(
        type: SeerrDashboardMediaType.tv,
        tmdbId: details.id?.toInt() ?? 0,
        jellyfinItemId: details.mediaInfo?.primaryJellyfinMediaId,
        title: details.name ?? '',
        overview: details.overview ?? '',
        posterUrl: details.posterUrl,
        backdropUrl: details.backdropUrl,
        status: _statusFromRaw(details.mediaInfo?.status?.toInt()),
        seasons: details.seasons,
        seasonStatuses: seasonStatusMap.isEmpty ? null : seasonStatusMap,
        mediaInfo: details.mediaInfo,
        releaseYear: releaseYear,
      );
    }

    if (tmdbId != null) {
      if (mediaType == SeerrDashboardMediaType.tv) {
        final tvResponse = await tvDetails(tvId: tmdbId, language: language);
        if (!tvResponse.isSuccessful || tvResponse.body == null) return null;
        final details = tvResponse.body!;
        final seasonStatusMap = _seasonStatusMap(details.mediaInfo?.seasons);
        String? releaseYear;
        final firstAirDate = details.firstAirDate;
        if (firstAirDate != null && firstAirDate.isNotEmpty) {
          releaseYear = firstAirDate.split('-').first;
        }
        return _posterFromDetails(
          type: SeerrDashboardMediaType.tv,
          tmdbId: details.id?.toInt() ?? 0,
          jellyfinItemId: details.mediaInfo?.primaryJellyfinMediaId,
          title: details.name ?? '',
          overview: details.overview ?? '',
          posterUrl: details.posterUrl,
          backdropUrl: details.backdropUrl,
          status: _statusFromRaw(details.mediaInfo?.status?.toInt()),
          seasons: details.seasons,
          seasonStatuses: seasonStatusMap.isEmpty ? null : seasonStatusMap,
          mediaInfo: details.mediaInfo,
          releaseYear: releaseYear,
        );
      } else {
        final movieResponse = await movieDetails(tmdbId: tmdbId, language: language);
        if (!movieResponse.isSuccessful || movieResponse.body == null) return null;
        final details = movieResponse.body!;
        String? releaseYear;
        final releaseDate = details.releaseDate;
        if (releaseDate != null && releaseDate.isNotEmpty) {
          releaseYear = releaseDate.split('-').first;
        }
        return _posterFromDetails(
          type: SeerrDashboardMediaType.movie,
          tmdbId: details.id?.toInt() ?? 0,
          jellyfinItemId: details.mediaInfo?.primaryJellyfinMediaId,
          title: details.title ?? '',
          overview: details.overview ?? '',
          posterUrl: details.posterUrl,
          backdropUrl: details.backdropUrl,
          status: _statusFromRaw(details.mediaInfo?.status?.toInt()),
          mediaInfo: details.mediaInfo,
          releaseYear: releaseYear,
        );
      }
    }

    return null;
  }

  Future<Response<SeerrMovieDetails>> movieDetails({required int tmdbId, String? language}) {
    return _api.getMovieDetails(tmdbId, language: language);
  }

  Future<Response<SeerrTvDetails>> tvDetails({required int tvId, String? language}) {
    return _api.getTvDetails(tvId, language: language);
  }

  Future<Response<SeerrSeasonDetails>> seasonDetails({
    required int tvId,
    required int seasonNumber,
    String? language,
  }) {
    return _api.getSeasonDetails(tvId, seasonNumber, language: language);
  }

  Future<Response<SeerrRequestsResponse>> listRequests({
    int? take,
    int? skip,
    RequestFilter? filter,
    RequestSort? sort,
    SortDirection? sortDirection,
    int? requestedBy,
  }) async {
    return _api.getRequests(
      take: take,
      skip: skip,
      filter: filter?.value,
      sort: sort?.value,
      sortDirection: sortDirection?.value,
      requestedBy: requestedBy,
    );
  }

  Future<Response<SeerrMediaResponse>> media({
    int? take,
    int? skip,
    MediaFilter? filter,
    MediaSort? sort,
  }) {
    return _api.getMedia(
      take: take,
      skip: skip,
      filter: filter?.value,
      sort: sort?.value,
    );
  }

  Future<List<SeerrDashboardPosterModel>> discoverTrending({int? page, String? language}) async {
    final response = await _api.getDiscoverTrending(page: page, language: language);
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  SeerrDashboardMediaType? _resolveMediaType(SeerrDiscoverItem item) {
    switch (item.mediaType) {
      case SeerrMediaType.movie:
        return SeerrDashboardMediaType.movie;
      case SeerrMediaType.tv:
      case SeerrMediaType.series:
        return SeerrDashboardMediaType.tv;
      case SeerrMediaType.person:
        return null;
      case null:
        if (item.mediaInfo?.tvdbId != null) {
          return SeerrDashboardMediaType.tv;
        } else if (item.mediaInfo?.tmdbId != null) {
          return SeerrDashboardMediaType.movie;
        }
        return null;
    }
  }

  SeerrDashboardPosterModel? _posterFromDiscoverItem(SeerrDiscoverItem item) {
    final type = _resolveMediaType(item);
    if (type == null) return null;

    final tmdbId = item.id ?? item.mediaInfo?.tmdbId ?? 0;
    final title = type == SeerrDashboardMediaType.tv
        ? (item.name ?? item.originalName ?? item.title ?? '')
        : (item.title ?? item.originalTitle ?? item.name ?? '');

    String? releaseYear;
    final dateString = type == SeerrDashboardMediaType.tv ? item.firstAirDate : item.releaseDate;
    if (dateString != null && dateString.isNotEmpty) {
      releaseYear = dateString.split('-').first;
    }

    return _posterFromDetails(
      type: type,
      tmdbId: tmdbId,
      jellyfinItemId: item.mediaInfo?.primaryJellyfinMediaId,
      title: title,
      overview: item.overview ?? '',
      posterUrl: item.posterUrl,
      backdropUrl: item.backdropUrl,
      status: item.mediaInfo?.status != null ? SeerrRequestStatus.fromRaw(item.mediaInfo?.status) : null,
      mediaInfo: item.mediaInfo,
      releaseYear: releaseYear,
    );
  }

  Future<List<SeerrDashboardPosterModel>> discoverPopularMovies({int? page, String? language}) async {
    final response = await _api.getDiscoverMovies(
      page: page,
      language: language,
      sortBy: SeerrSortBy.popularityDesc.valueForMode(SeerrSearchMode.discoverMovies),
    );
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverPopularSeries({int? page, String? language}) async {
    final response = await _api.getDiscoverTv(
      page: page,
      language: language,
      sortBy: SeerrSortBy.popularityDesc.valueForMode(SeerrSearchMode.discoverTv),
    );
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverExpectedMovies({int? page, String? language}) async {
    final response = await _api.getDiscoverMoviesUpcoming(page: page, language: language);
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverExpectedSeries({int? page, String? language}) async {
    final response = await _api.getDiscoverTvUpcoming(page: page, language: language);
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverRelatedMovies({
    required int tmdbId,
    String? language,
  }) async {
    final response = await _api.getMovieSimilar(tmdbId, language: language);
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverRelatedSeries({
    required int tmdbId,
    String? language,
  }) async {
    final response = await _api.getTvSimilar(tmdbId, language: language);
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverRecommendedMovies({
    required int tmdbId,
    String? language,
  }) async {
    final response = await _api.getMovieRecommendations(tmdbId, language: language);
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Future<List<SeerrDashboardPosterModel>> discoverRecommendedSeries({
    required int tmdbId,
    String? language,
  }) async {
    final response = await _api.getTvRecommendations(tmdbId, language: language);
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];
    return results.map(_posterFromDiscoverItem).whereType<SeerrDashboardPosterModel>().toList(growable: false);
  }

  Future<Response<SeerrRequestsResponse>> myRequests({
    int? take,
    int? skip,
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

    return _api.getUserRequests(userId, take: take, skip: skip);
  }

  Future<Response<SeerrMediaRequest>> requestMovie({
    required int tmdbId,
    bool? is4k,
    int? userId,
    int? serverId,
    int? profileId,
    String? rootFolder,
    List<int>? tags,
  }) {
    return _api.createRequest(
      SeerrCreateRequestBody(
        mediaType: 'movie',
        mediaId: tmdbId,
        is4k: is4k,
        userId: userId,
        serverId: serverId,
        profileId: profileId,
        rootFolder: rootFolder,
        tags: tags,
      ),
    );
  }

  Future<Response<SeerrMediaRequest>> requestSeries({
    required int tmdbId,
    bool? is4k,
    List<int>? seasons,
    int? userId,
    int? serverId,
    int? profileId,
    String? rootFolder,
    List<int>? tags,
  }) {
    return _api.createRequest(
      SeerrCreateRequestBody(
        mediaType: 'tv',
        mediaId: tmdbId,
        is4k: is4k,
        seasons: seasons,
        userId: userId,
        serverId: serverId,
        profileId: profileId,
        rootFolder: rootFolder,
        tags: tags,
      ),
    );
  }

  Future<Response<dynamic>> deleteRequest({required int requestId}) {
    return _api.deleteRequest(requestId);
  }

  Future<Response<dynamic>> deleteMedia({required int mediaId}) {
    return _api.deleteMedia(mediaId);
  }

  Future<Response<dynamic>> deleteMediaFile({required int mediaId, bool? is4k}) {
    return _api.deleteMediaFile(mediaId, is4k: is4k);
  }

  Future<Response<SeerrMediaInfo>> updateMediaStatus({
    required int mediaId,
    required String status,
    Map<String, dynamic>? body,
  }) {
    return _api.updateMediaStatus(mediaId, status, body: body);
  }

  Future<List<SeerrDashboardPosterModel>> searchPosters({required String query, int? page, String? language}) async {
    if (query.trim().isEmpty) return const [];

    final response = await _api.search(query: query, page: page, language: language);
    final results = response.body?.results ?? const <SeerrDiscoverItem>[];

    final items = <SeerrDashboardPosterModel>[];
    for (final result in results) {
      final poster = _posterFromDiscoverItem(result);
      if (poster == null) continue;
      items.add(poster);
    }
    return items;
  }

  // New API methods for genres, watch providers, and certifications
  Future<Response<List<SeerrGenre>>> getMovieGenres() => _api.getMovieGenres();

  Future<Response<List<SeerrGenre>>> getTvGenres() => _api.getTvGenres();

  Future<Response<List<SeerrWatchProvider>>> getMovieWatchProviders({String? watchRegion}) {
    return _api.getMovieWatchProviders(watchRegion: watchRegion);
  }

  Future<Response<List<SeerrWatchProvider>>> getTvWatchProviders({String? watchRegion}) {
    return _api.getTvWatchProviders(watchRegion: watchRegion);
  }

  Future<Response<List<SeerrWatchProviderRegion>>> getWatchProviderRegions() => _api.getWatchProviderRegions();

  Future<Response<SeerrCertificationsResponse>> getMovieCertifications() => _api.getMovieCertifications();

  Future<Response<SeerrCertificationsResponse>> getTvCertifications() => _api.getTvCertifications();

  Future<Response<SeerrDiscoverResponse>> discoverTrendingPaged({int? page, String? language}) =>
      _api.getDiscoverTrending(page: page, language: language);

  // Helper method for discover search
  Future<Response<SeerrDiscoverResponse>> discoverMovies({
    int? page,
    String? sortBy,
    String? genre,
    int? studio,
    String? primaryReleaseDateGte,
    String? primaryReleaseDateLte,
    double? voteAverageGte,
    double? voteAverageLte,
    int? withRuntimeGte,
    int? withRuntimeLte,
    String? watchRegion,
    String? watchProviders,
    String? certification,
    String? certificationCountry,
    String? certificationMode,
  }) =>
      _api.getDiscoverMovies(
        page: page,
        sortBy: sortBy,
        genre: genre,
        studio: studio,
        primaryReleaseDateGte: primaryReleaseDateGte,
        primaryReleaseDateLte: primaryReleaseDateLte,
        voteAverageGte: voteAverageGte,
        voteAverageLte: voteAverageLte,
        withRuntimeGte: withRuntimeGte,
        withRuntimeLte: withRuntimeLte,
        watchRegion: watchRegion,
        watchProviders: watchProviders,
        certification: certification,
        certificationCountry: certificationCountry,
        certificationMode: certificationMode,
      );

  Future<Response<SeerrDiscoverResponse>> discoverTv({
    int? page,
    String? sortBy,
    String? genre,
    String? firstAirDateGte,
    String? firstAirDateLte,
    double? voteAverageGte,
    double? voteAverageLte,
    String? watchRegion,
    String? watchProviders,
  }) =>
      _api.getDiscoverTv(
        page: page,
        sortBy: sortBy,
        genre: genre,
        firstAirDateGte: firstAirDateGte,
        firstAirDateLte: firstAirDateLte,
        voteAverageGte: voteAverageGte,
        voteAverageLte: voteAverageLte,
        watchRegion: watchRegion,
        watchProviders: watchProviders,
      );

  Future<Response<SeerrDiscoverResponse>> search({
    required String query,
    int? page,
    String? language,
  }) =>
      _api.search(query: query, page: page, language: language);

  Future<Response<SeerrSearchCompanyResponse>> searchCompany({
    required String query,
    int? page,
  }) =>
      _api.searchCompany(query: query, page: page);

  SeerrDashboardPosterModel? posterFromDiscoverItem(SeerrDiscoverItem item) => _posterFromDiscoverItem(item);

  Future<String> authenticateLocal({required String email, required String password}) async {
    final response = await _api.authenticateLocal(
      SeerrAuthLocalBody(email: email, password: password),
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

  Future<void> logout() async => await _api.logout();

  Future<Response<dynamic>> _authenticateJellyfin({required String username, required String password}) async {
    var response = await _api.authenticateJellyfin(
      SeerrAuthJellyfinBody(username: username, password: password),
    );

    if (!response.isSuccessful && _shouldRetryWithHostname(response)) {
      response = await _api.authenticateJellyfin(
        SeerrAuthJellyfinBody(
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
