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
  Future<Response<SeerrUserModel>> authenticateLocal(@Body() SeerrAuthLocalBody body);

  @POST(path: '/auth/jellyfin')
  Future<Response<SeerrUserModel>> authenticateJellyfin(@Body() SeerrAuthJellyfinBody body);

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

  @GET(path: '/media')
  Future<Response<SeerrMediaResponse>> getMedia({
    @Query('take') int? take,
    @Query('skip') int? skip,
    @Query('filter') String? filter,
    @Query('sort') String? sort,
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
  });

  @GET(path: '/discover/movies/upcoming')
  Future<Response<SeerrDiscoverResponse>> getDiscoverMoviesUpcoming({
    @Query('page') int? page,
    @Query('language') String? language,
  });

  @GET(path: '/discover/tv/upcoming')
  Future<Response<SeerrDiscoverResponse>> getDiscoverTvUpcoming({
    @Query('page') int? page,
    @Query('language') String? language,
  });

  @GET(path: '/search')
  Future<Response<SeerrSearchResponse>> search({
    @Query('query') required String query,
    @Query('page') int? page,
    @Query('language') String? language,
  });
}
