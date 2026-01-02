// dart format width=80
//Generated jellyfin api code

part of 'seerr_chopper_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SeerrChopperService extends SeerrChopperService {
  _$SeerrChopperService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SeerrChopperService;

  @override
  Future<Response<SeerrStatus>> getStatus() {
    final Uri $url = Uri.parse('/api/v1/status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SeerrStatus, SeerrStatus>($request);
  }

  @override
  Future<Response<SeerrUserModel>> getMe() {
    final Uri $url = Uri.parse('/api/v1/auth/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SeerrUserModel, SeerrUserModel>($request);
  }

  @override
  Future<Response<SeerrUserModel>> authenticateLocal(SeerrAuthLocalBody body) {
    final Uri $url = Uri.parse('/api/v1/auth/local');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SeerrUserModel, SeerrUserModel>($request);
  }

  @override
  Future<Response<SeerrUserModel>> authenticateJellyfin(
      SeerrAuthJellyfinBody body) {
    final Uri $url = Uri.parse('/api/v1/auth/jellyfin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SeerrUserModel, SeerrUserModel>($request);
  }

  @override
  Future<Response<dynamic>> logout() {
    final Uri $url = Uri.parse('/api/v1/auth/logout');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SeerrSonarrServer>>> getSonarrServers() {
    final Uri $url = Uri.parse('/api/v1/service/sonarr');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SeerrSonarrServer>, SeerrSonarrServer>($request);
  }

  @override
  Future<Response<SeerrSonarrServerResponse>> getSonarrServer(int sonarrId) {
    final Uri $url = Uri.parse('/api/v1/service/sonarr/${sonarrId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<SeerrSonarrServerResponse, SeerrSonarrServerResponse>($request);
  }

  @override
  Future<Response<List<SeerrRadarrServer>>> getRadarrServers() {
    final Uri $url = Uri.parse('/api/v1/service/radarr');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SeerrRadarrServer>, SeerrRadarrServer>($request);
  }

  @override
  Future<Response<SeerrRadarrServerResponse>> getRadarrServer(int radarrId) {
    final Uri $url = Uri.parse('/api/v1/service/radarr/${radarrId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<SeerrRadarrServerResponse, SeerrRadarrServerResponse>($request);
  }

  @override
  Future<Response<SeerrUsersResponse>> getUsers({
    int? take,
    int? skip,
    String? sort,
  }) {
    final Uri $url = Uri.parse('/api/v1/user');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'sort': sort,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrUsersResponse, SeerrUsersResponse>($request);
  }

  @override
  Future<Response<SeerrMovieDetails>> getMovieDetails(
    int movieId, {
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/movie/${movieId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrMovieDetails, SeerrMovieDetails>($request);
  }

  @override
  Future<Response<SeerrTvDetails>> getTvDetails(
    int tvId, {
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/tv/${tvId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrTvDetails, SeerrTvDetails>($request);
  }

  @override
  Future<Response<SeerrRequestsResponse>> getRequests({
    int? take,
    int? skip,
    String? filter,
    String? sort,
    String? sortDirection,
    int? requestedBy,
  }) {
    final Uri $url = Uri.parse('/api/v1/request');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'filter': filter,
      'sort': sort,
      'sortDirection': sortDirection,
      'requestedBy': requestedBy,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrRequestsResponse, SeerrRequestsResponse>($request);
  }

  @override
  Future<Response<SeerrRequestsResponse>> getUserRequests(
    int userId, {
    int? take,
    int? skip,
  }) {
    final Uri $url = Uri.parse('/api/v1/user/${userId}/requests');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrRequestsResponse, SeerrRequestsResponse>($request);
  }

  @override
  Future<Response<SeerrUserQuota>> getUserQuota(int userId) {
    final Uri $url = Uri.parse('/api/v1/user/${userId}/quota');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SeerrUserQuota, SeerrUserQuota>($request);
  }

  @override
  Future<Response<SeerrMediaRequest>> createRequest(
      SeerrCreateRequestBody body) {
    final Uri $url = Uri.parse('/api/v1/request');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SeerrMediaRequest, SeerrMediaRequest>($request);
  }

  @override
  Future<Response<SeerrMediaResponse>> getMedia({
    int? take,
    int? skip,
    String? filter,
    String? sort,
  }) {
    final Uri $url = Uri.parse('/api/v1/media');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'filter': filter,
      'sort': sort,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrMediaResponse, SeerrMediaResponse>($request);
  }

  @override
  Future<Response<SeerrDiscoverResponse>> getDiscoverTrending({
    int? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/discover/trending');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrDiscoverResponse, SeerrDiscoverResponse>($request);
  }

  @override
  Future<Response<SeerrDiscoverResponse>> getDiscoverMovies({
    int? page,
    String? language,
    String? sortBy,
  }) {
    final Uri $url = Uri.parse('/api/v1/discover/movies');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
      'sortBy': sortBy,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrDiscoverResponse, SeerrDiscoverResponse>($request);
  }

  @override
  Future<Response<SeerrDiscoverResponse>> getDiscoverMoviesUpcoming({
    int? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/discover/movies/upcoming');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrDiscoverResponse, SeerrDiscoverResponse>($request);
  }

  @override
  Future<Response<SeerrDiscoverResponse>> getDiscoverTvUpcoming({
    int? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/discover/tv/upcoming');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrDiscoverResponse, SeerrDiscoverResponse>($request);
  }

  @override
  Future<Response<SeerrSearchResponse>> search({
    required String query,
    int? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeerrSearchResponse, SeerrSearchResponse>($request);
  }
}
