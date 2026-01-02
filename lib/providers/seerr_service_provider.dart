import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/models/seerr/seerr_item_models.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/seerr/seerr_chopper_service.dart';
import 'package:fladder/seerr/seerr_models.dart';

class SeerrService {
  SeerrService(this.ref, this._api);

  final Ref ref;
  final SeerrChopperService _api;

  Future<Response<SeerrStatus>> status() => _api.getStatus();

  Future<Response<SeerrUserModel>> me() async {
    final response = await _api.getMe();
    final user = response.body;
    if (user == null) return response;
    return response.copyWith(body: _withAbsoluteAvatar(user));
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
    return results.map(_withAbsoluteAvatar).toList(growable: false);
  }

  Future<SeerrUserQuota?> userQuota({required int userId}) async {
    final response = await _api.getUserQuota(userId);
    if (!response.isSuccessful) return null;
    return response.body;
  }

  SeerrUserModel _withAbsoluteAvatar(SeerrUserModel user) {
    final avatar = user.avatar;
    if (avatar == null || avatar.isEmpty) return user;

    final serverUrl = ref.read(userProvider)?.seerrCredentials?.serverUrl;
    final resolvedAvatar = resolveServerUrl(path: avatar, serverUrl: serverUrl);

    if (resolvedAvatar == avatar) return user;

    return SeerrUserModel(
      id: user.id,
      email: user.email,
      username: user.username,
      displayName: user.displayName,
      plexToken: user.plexToken,
      plexUsername: user.plexUsername,
      permissions: user.permissions,
      avatar: resolvedAvatar,
      settings: user.settings,
      movieQuotaLimit: user.movieQuotaLimit,
      movieQuotaDays: user.movieQuotaDays,
      tvQuotaLimit: user.tvQuotaLimit,
      tvQuotaDays: user.tvQuotaDays,
    );
  }

  SeerrDashboardPosterModel? _posterFromDetails({
    required SeerrDashboardMediaType type,
    required int tmdbId,
    required String title,
    required String overview,
    required String? posterPath,
    required SeerrRequestStatus? status,
    required String? backdropPath,
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
        primary: tmdbPrimaryImage(keyPrefix: keyPrefix, posterPath: posterPath),
        backDrop: tmdbBackdropImages(keyPrefix: keyPrefix, backdropPath: backdropPath),
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
    SeerrDashboardPosterModel? existing,
  }) async {
    if (tvdbId != null) {
      if (tmdbId == null) return null;
      final tvResponse = await tvDetails(tvId: tmdbId, language: language);
      if (!tvResponse.isSuccessful || tvResponse.body == null) return null;
      final details = tvResponse.body!;
      final seasonStatusMap = _seasonStatusMap(details.mediaInfo?.seasons);
      final resolvedSeasons = _withResolvedSeasonPosters(details.seasons);
      String? releaseYear;
      final firstAirDate = details.firstAirDate;
      if (firstAirDate != null && firstAirDate.isNotEmpty) {
        releaseYear = firstAirDate.split('-').first;
      }
      final update = _posterFromDetails(
        type: SeerrDashboardMediaType.tv,
        tmdbId: details.id?.toInt() ?? 0,
        jellyfinItemId: details.mediaInfo?.primaryJellyfinMediaId,
        title: details.name ?? '',
        overview: details.overview ?? '',
        posterPath: details.posterPath,
        backdropPath: details.backdropPath,
        status: _statusFromRaw(details.mediaInfo?.status?.toInt()),
        seasons: resolvedSeasons,
        seasonStatuses: seasonStatusMap.isEmpty ? null : seasonStatusMap,
        mediaInfo: details.mediaInfo,
        releaseYear: releaseYear,
      );

      if (update == null) return existing;

      return existing?.copyWith(
            id: update.id,
            type: update.type,
            tmdbId: update.tmdbId,
            jellyfinItemId: update.jellyfinItemId ?? existing.jellyfinItemId,
            title: update.title,
            overview: update.overview,
            images: update.images,
            status: update.status,
            seasons: update.seasons ?? existing.seasons,
            seasonStatuses: update.seasonStatuses ?? existing.seasonStatuses,
            mediaInfo: update.mediaInfo ?? existing.mediaInfo,
          ) ??
          update;
    }

    if (tmdbId != null) {
      final movieResponse = await movieDetails(tmdbId: tmdbId, language: language);
      if (!movieResponse.isSuccessful || movieResponse.body == null) return null;
      final details = movieResponse.body!;
      String? releaseYear;
      final releaseDate = details.releaseDate;
      if (releaseDate != null && releaseDate.isNotEmpty) {
        releaseYear = releaseDate.split('-').first;
      }
      final update = _posterFromDetails(
        type: SeerrDashboardMediaType.movie,
        tmdbId: details.id?.toInt() ?? 0,
        jellyfinItemId: details.mediaInfo?.primaryJellyfinMediaId,
        title: details.title ?? '',
        overview: details.overview ?? '',
        posterPath: details.posterPath,
        backdropPath: details.backdropPath,
        status: _statusFromRaw(details.mediaInfo?.status?.toInt()),
        mediaInfo: details.mediaInfo,
        releaseYear: releaseYear,
      );

      if (update == null) return existing;

      return existing?.copyWith(
            id: update.id,
            type: update.type,
            tmdbId: update.tmdbId,
            jellyfinItemId: update.jellyfinItemId ?? existing.jellyfinItemId,
            title: update.title,
            overview: update.overview,
            images: update.images,
            status: update.status,
            seasons: update.seasons ?? existing.seasons,
            seasonStatuses: update.seasonStatuses ?? existing.seasonStatuses,
            mediaInfo: update.mediaInfo ?? existing.mediaInfo,
          ) ??
          update;
    }

    return null;
  }

  Future<Response<SeerrMovieDetails>> movieDetails({required int tmdbId, String? language}) {
    return _api.getMovieDetails(tmdbId, language: language);
  }

  Future<Response<SeerrTvDetails>> tvDetails({required int tvId, String? language}) async {
    final response = await _api.getTvDetails(tvId, language: language);
    final body = response.body;
    if (body == null) return response;

    final resolvedSeasons = _withResolvedSeasonPosters(body.seasons);
    final resolvedBody = SeerrTvDetails(
      id: body.id,
      name: body.name,
      originalName: body.originalName,
      overview: body.overview,
      posterPath: body.posterPath,
      backdropPath: body.backdropPath,
      firstAirDate: body.firstAirDate,
      lastAirDate: body.lastAirDate,
      voteAverage: body.voteAverage,
      voteCount: body.voteCount,
      numberOfSeasons: body.numberOfSeasons,
      numberOfEpisodes: body.numberOfEpisodes,
      genres: body.genres,
      seasons: resolvedSeasons,
      mediaInfo: body.mediaInfo,
      externalIds: body.externalIds,
      keywords: body.keywords,
      mediaId: body.mediaId,
    );

    return response.copyWith(body: resolvedBody);
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
      jellyfinItemId: item.mediaId,
      title: title,
      overview: item.overview ?? '',
      posterPath: item.posterPath,
      backdropPath: item.backdropPath,
      status: item.mediaInfo?.status != null ? SeerrRequestStatus.fromRaw(item.mediaInfo?.status) : null,
      mediaInfo: item.mediaInfo,
      releaseYear: releaseYear,
    );
  }

  Future<List<SeerrDashboardPosterModel>> discoverPopularMovies({int? page, String? language}) async {
    final response = await _api.getDiscoverMovies(
      page: page,
      language: language,
      sortBy: DiscoverSortBy.popularityDesc.value,
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

  List<SeerrSeason>? _withResolvedSeasonPosters(List<SeerrSeason>? seasons) {
    if (seasons == null) return null;
    final serverUrl = ref.read(userProvider)?.seerrCredentials?.serverUrl;
    return seasons
        .map(
          (season) => SeerrSeason(
            id: season.id,
            name: season.name,
            overview: season.overview,
            seasonNumber: season.seasonNumber,
            posterPath: resolveImageUrl(
              path: season.posterPath,
              serverUrl: serverUrl,
              tmdbBase: 'https://image.tmdb.org/t/p/original',
            ),
            episodeCount: season.episodeCount,
            mediaId: season.mediaId,
          ),
        )
        .toList(growable: false);
  }

  String? _extractSessionCookie(Response<dynamic> response) {
    final setCookie = response.base.headers['set-cookie'];
    if (setCookie == null || setCookie.isEmpty) return null;
    return setCookie.split(';').first.trim();
  }
}
