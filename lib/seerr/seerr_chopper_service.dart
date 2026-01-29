import 'package:chopper/chopper.dart';

import 'seerr_models.dart';

part 'seerr_chopper_service.chopper.dart';

@ChopperApi(baseUrl: '/api/v1')
abstract class SeerrChopperService extends ChopperService {
  static SeerrChopperService create([ChopperClient? client]) {
    return _$SeerrChopperService(client);
  }

  @GET(path: '/status')
  Future<Response<SeerrStatus>> getStatus();

  @GET(path: '/auth/me')
  Future<Response<SeerrUserModel>> getMe();

  @POST(path: '/auth/local')
  Future<Response<SeerrUserModel>> authenticateLocal(
    @Body() SeerrAuthLocalBody body, {
    Map<String, String>? headers,
  });

  @POST(path: '/auth/jellyfin')
  Future<Response<SeerrUserModel>> authenticateJellyfin(
    @Body() SeerrAuthJellyfinBody body, {
    Map<String, String>? headers,
  });

  @POST(path: '/auth/logout')
  Future<Response<dynamic>> logout();

  @GET(path: '/service/sonarr')
  Future<Response<List<SeerrSonarrServer>>> getSonarrServers();

  @GET(path: '/service/sonarr/{sonarrId}')
  Future<Response<SeerrSonarrServerResponse>> getSonarrServer(@Path('sonarrId') int sonarrId);

  @GET(path: '/service/radarr')
  Future<Response<List<SeerrRadarrServer>>> getRadarrServers();

  @GET(path: '/service/radarr/{radarrId}')
  Future<Response<SeerrRadarrServerResponse>> getRadarrServer(@Path('radarrId') int radarrId);

  @GET(path: '/user')
  Future<Response<SeerrUsersResponse>> getUsers({
    @Query('take') int? take,
    @Query('skip') int? skip,
    @Query('sort') String? sort,
  });

  @GET(path: '/movie/{movieId}')
  Future<Response<SeerrMovieDetails>> getMovieDetails(
    @Path('movieId') int movieId, {
    @Query('language') String? language,
  });

  @GET(path: '/tv/{tvId}')
  Future<Response<SeerrTvDetails>> getTvDetails(
    @Path('tvId') int tvId, {
    @Query('language') String? language,
  });

  @GET(path: '/tv/{tvId}/season/{seasonNumber}')
  Future<Response<SeerrSeasonDetails>> getSeasonDetails(
    @Path('tvId') int tvId,
    @Path('seasonNumber') int seasonNumber, {
    @Query('language') String? language,
  });

  @GET(path: '/request')
  Future<Response<SeerrRequestsResponse>> getRequests({
    @Query('take') int? take,
    @Query('skip') int? skip,
    @Query('filter') String? filter,
    @Query('sort') String? sort,
    @Query('sortDirection') String? sortDirection,
    @Query('requestedBy') int? requestedBy,
  });

  @GET(path: '/user/{userId}/requests')
  Future<Response<SeerrRequestsResponse>> getUserRequests(
    @Path('userId') int userId, {
    @Query('take') int? take,
    @Query('skip') int? skip,
  });

  @GET(path: '/user/{userId}/quota')
  Future<Response<SeerrUserQuota>> getUserQuota(
    @Path('userId') int userId,
  );

  @POST(path: '/request')
  Future<Response<SeerrMediaRequest>> createRequest(@Body() SeerrCreateRequestBody body);

  @POST(path: '/request/{requestId}/approve')
  Future<Response<SeerrMediaRequest>> approveRequest(@Path('requestId') int requestId);

  @DELETE(path: '/request/{requestId}')
  Future<Response<dynamic>> deleteRequest(@Path('requestId') int requestId);

  @GET(path: '/media')
  Future<Response<SeerrMediaResponse>> getMedia({
    @Query('take') int? take,
    @Query('skip') int? skip,
    @Query('filter') String? filter,
    @Query('sort') String? sort,
  });

  @DELETE(path: '/media/{mediaId}')
  Future<Response<dynamic>> deleteMedia(@Path('mediaId') int mediaId);

  @DELETE(path: '/media/{mediaId}/file')
  Future<Response<dynamic>> deleteMediaFile(
    @Path('mediaId') int mediaId, {
    @Query('is4k') bool? is4k,
  });

  @POST(path: '/media/{mediaId}/{status}')
  Future<Response<SeerrMediaInfo>> updateMediaStatus(
    @Path('mediaId') int mediaId,
    @Path('status') String status, {
    @Body() Map<String, dynamic>? body,
  });

  @GET(path: '/discover/trending')
  Future<Response<SeerrDiscoverResponse>> getDiscoverTrending({
    @Query('page') int? page,
    @Query('language') String? language,
  });

  @GET(path: '/discover/movies')
  Future<Response<SeerrDiscoverResponse>> getDiscoverMovies({
    @Query('page') int? page,
    @Query('language') String? language,
    @Query('sortBy') String? sortBy,
    @Query('genre') String? genre,
    @Query('studio') int? studio,
    @Query('keywords') String? keywords,
    @Query('excludeKeywords') String? excludeKeywords,
    @Query('primaryReleaseDateGte') String? primaryReleaseDateGte,
    @Query('primaryReleaseDateLte') String? primaryReleaseDateLte,
    @Query('withRuntimeGte') int? withRuntimeGte,
    @Query('withRuntimeLte') int? withRuntimeLte,
    @Query('voteAverageGte') double? voteAverageGte,
    @Query('voteAverageLte') double? voteAverageLte,
    @Query('voteCountGte') int? voteCountGte,
    @Query('voteCountLte') int? voteCountLte,
    @Query('watchRegion') String? watchRegion,
    @Query('watchProviders') String? watchProviders,
    @Query('certification') String? certification,
    @Query('certificationGte') String? certificationGte,
    @Query('certificationLte') String? certificationLte,
    @Query('certificationCountry') String? certificationCountry,
    @Query('certificationMode') String? certificationMode,
  });

  @GET(path: '/discover/movies/upcoming')
  Future<Response<SeerrDiscoverResponse>> getDiscoverMoviesUpcoming({
    @Query('page') int? page,
    @Query('language') String? language,
  });

  @GET(path: '/discover/tv')
  Future<Response<SeerrDiscoverResponse>> getDiscoverTv({
    @Query('page') int? page,
    @Query('language') String? language,
    @Query('sortBy') String? sortBy,
    @Query('genre') String? genre,
    @Query('keywords') String? keywords,
    @Query('excludeKeywords') String? excludeKeywords,
    @Query('firstAirDateGte') String? firstAirDateGte,
    @Query('firstAirDateLte') String? firstAirDateLte,
    @Query('voteAverageGte') double? voteAverageGte,
    @Query('voteAverageLte') double? voteAverageLte,
    @Query('voteCountGte') int? voteCountGte,
    @Query('voteCountLte') int? voteCountLte,
    @Query('watchRegion') String? watchRegion,
    @Query('watchProviders') String? watchProviders,
  });

  @GET(path: '/discover/tv/upcoming')
  Future<Response<SeerrDiscoverResponse>> getDiscoverTvUpcoming({
    @Query('page') int? page,
    @Query('language') String? language,
  });

  @GET(path: '/movie/{movieId}/similar')
  Future<Response<SeerrDiscoverResponse>> getMovieSimilar(
    @Path('movieId') int movieId, {
    @Query('language') String? language,
  });

  @GET(path: '/tv/{tvId}/similar')
  Future<Response<SeerrDiscoverResponse>> getTvSimilar(
    @Path('tvId') int tvId, {
    @Query('language') String? language,
  });

  @GET(path: '/movie/{movieId}/recommendations')
  Future<Response<SeerrDiscoverResponse>> getMovieRecommendations(
    @Path('movieId') int movieId, {
    @Query('language') String? language,
  });

  @GET(path: '/movie/{movieId}/ratingscombined')
  Future<Response<SeerrRatingsResponse>> getMovieRatings(
    @Path('movieId') int movieId,
  );

  @GET(path: '/tv/{tvId}/ratings')
  Future<Response<SeerrRtRating>> getTvRatings(
    @Path('tvId') int tvId,
  );

  @GET(path: '/tv/{tvId}/recommendations')
  Future<Response<SeerrDiscoverResponse>> getTvRecommendations(
    @Path('tvId') int tvId, {
    @Query('language') String? language,
  });

  @GET(path: '/search')
  Future<Response<SeerrDiscoverResponse>> search({
    @Query('query') required String query,
    @Query('page') int? page,
    @Query('language') String? language,
  });

  @GET(path: '/search/company')
  Future<Response<SeerrSearchCompanyResponse>> searchCompany({
    @Query('query') required String query,
    @Query('page') int? page,
  });

  @GET(path: '/genres/movie')
  Future<Response<List<SeerrGenre>>> getMovieGenres();

  @GET(path: '/genres/tv')
  Future<Response<List<SeerrGenre>>> getTvGenres();

  @GET(path: '/watchproviders/movies')
  Future<Response<List<SeerrWatchProvider>>> getMovieWatchProviders({
    @Query('watchRegion') String? watchRegion,
  });

  @GET(path: '/watchproviders/tv')
  Future<Response<List<SeerrWatchProvider>>> getTvWatchProviders({
    @Query('watchRegion') String? watchRegion,
  });

  @GET(path: '/watchproviders/regions')
  Future<Response<List<SeerrWatchProviderRegion>>> getWatchProviderRegions();

  @GET(path: '/certifications/movie')
  Future<Response<SeerrCertificationsResponse>> getMovieCertifications();

  @GET(path: '/certifications/tv')
  Future<Response<SeerrCertificationsResponse>> getTvCertifications();
}
