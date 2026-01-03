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
  Future<Response<dynamic>> deleteRequest(int requestId) {
    final Uri $url = Uri.parse('/api/v1/request/${requestId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
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
    String? genre,
    int? studio,
    String? keywords,
    String? excludeKeywords,
    String? primaryReleaseDateGte,
    String? primaryReleaseDateLte,
    int? withRuntimeGte,
    int? withRuntimeLte,
    double? voteAverageGte,
    double? voteAverageLte,
    int? voteCountGte,
    int? voteCountLte,
    String? watchRegion,
    String? watchProviders,
    String? certification,
    String? certificationGte,
    String? certificationLte,
    String? certificationCountry,
    String? certificationMode,
  }) {
    final Uri $url = Uri.parse('/api/v1/discover/movies');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
      'sortBy': sortBy,
      'genre': genre,
      'studio': studio,
      'keywords': keywords,
      'excludeKeywords': excludeKeywords,
      'primaryReleaseDateGte': primaryReleaseDateGte,
      'primaryReleaseDateLte': primaryReleaseDateLte,
      'withRuntimeGte': withRuntimeGte,
      'withRuntimeLte': withRuntimeLte,
      'voteAverageGte': voteAverageGte,
      'voteAverageLte': voteAverageLte,
      'voteCountGte': voteCountGte,
      'voteCountLte': voteCountLte,
      'watchRegion': watchRegion,
      'watchProviders': watchProviders,
      'certification': certification,
      'certificationGte': certificationGte,
      'certificationLte': certificationLte,
      'certificationCountry': certificationCountry,
      'certificationMode': certificationMode,
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
  Future<Response<SeerrDiscoverResponse>> getDiscoverTv({
    int? page,
    String? language,
    String? sortBy,
    String? genre,
    String? keywords,
    String? excludeKeywords,
    String? firstAirDateGte,
    String? firstAirDateLte,
    double? voteAverageGte,
    double? voteAverageLte,
    int? voteCountGte,
    int? voteCountLte,
    String? watchRegion,
    String? watchProviders,
  }) {
    final Uri $url = Uri.parse('/api/v1/discover/tv');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
      'sortBy': sortBy,
      'genre': genre,
      'keywords': keywords,
      'excludeKeywords': excludeKeywords,
      'firstAirDateGte': firstAirDateGte,
      'firstAirDateLte': firstAirDateLte,
      'voteAverageGte': voteAverageGte,
      'voteAverageLte': voteAverageLte,
      'voteCountGte': voteCountGte,
      'voteCountLte': voteCountLte,
      'watchRegion': watchRegion,
      'watchProviders': watchProviders,
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
  Future<Response<SeerrDiscoverResponse>> getMovieSimilar(
    int movieId, {
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/movie/${movieId}/similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
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
  Future<Response<SeerrDiscoverResponse>> getTvSimilar(
    int tvId, {
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/tv/${tvId}/similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
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
  Future<Response<SeerrDiscoverResponse>> getMovieRecommendations(
    int movieId, {
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/movie/${movieId}/recommendations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
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
  Future<Response<SeerrDiscoverResponse>> getTvRecommendations(
    int tvId, {
    String? language,
  }) {
    final Uri $url = Uri.parse('/api/v1/tv/${tvId}/recommendations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
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
  Future<Response<SeerrDiscoverResponse>> search({
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
    return client.send<SeerrDiscoverResponse, SeerrDiscoverResponse>($request);
  }

  @override
  Future<Response<SeerrSearchCompanyResponse>> searchCompany({
    required String query,
    int? page,
  }) {
    final Uri $url = Uri.parse('/api/v1/search/company');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'page': page,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<SeerrSearchCompanyResponse, SeerrSearchCompanyResponse>($request);
  }

  @override
  Future<Response<List<SeerrGenre>>> getMovieGenres() {
    final Uri $url = Uri.parse('/api/v1/genres/movie');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SeerrGenre>, SeerrGenre>($request);
  }

  @override
  Future<Response<List<SeerrGenre>>> getTvGenres() {
    final Uri $url = Uri.parse('/api/v1/genres/tv');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SeerrGenre>, SeerrGenre>($request);
  }

  @override
  Future<Response<List<SeerrWatchProvider>>> getMovieWatchProviders(
      {String? watchRegion}) {
    final Uri $url = Uri.parse('/api/v1/watchproviders/movies');
    final Map<String, dynamic> $params = <String, dynamic>{
      'watchRegion': watchRegion
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<SeerrWatchProvider>, SeerrWatchProvider>($request);
  }

  @override
  Future<Response<List<SeerrWatchProvider>>> getTvWatchProviders(
      {String? watchRegion}) {
    final Uri $url = Uri.parse('/api/v1/watchproviders/tv');
    final Map<String, dynamic> $params = <String, dynamic>{
      'watchRegion': watchRegion
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<SeerrWatchProvider>, SeerrWatchProvider>($request);
  }

  @override
  Future<Response<List<SeerrWatchProviderRegion>>> getWatchProviderRegions() {
    final Uri $url = Uri.parse('/api/v1/watchproviders/regions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SeerrWatchProviderRegion>,
        SeerrWatchProviderRegion>($request);
  }

  @override
  Future<Response<SeerrCertificationsResponse>> getMovieCertifications() {
    final Uri $url = Uri.parse('/api/v1/certifications/movie');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SeerrCertificationsResponse,
        SeerrCertificationsResponse>($request);
  }

  @override
  Future<Response<SeerrCertificationsResponse>> getTvCertifications() {
    final Uri $url = Uri.parse('/api/v1/certifications/tv');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SeerrCertificationsResponse,
        SeerrCertificationsResponse>($request);
  }
}
