import 'dart:developer';

import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';

class FakeJellyfinOpenApi extends JellyfinOpenApi {
  @override
  Type get definitionType => throw UnimplementedError();

  @override
  Future<chopper.Response<List<UserDto>>> usersPublicGet() async => chopper.Response(
        FakeHelper.fakeCorrectResponse,
        FakeHelper.fakeUsers,
      );

  @override
  Future<chopper.Response<AuthenticationResult>> usersAuthenticateByNamePost({
    required AuthenticateUserByName? body,
  }) async {
    if (body?.username == FakeHelper.fakeCorrectUser.name) {
      log(FakeHelper.fakeAuthResult.accessToken ?? "Null");
      return chopper.Response(
        FakeHelper.fakeCorrectResponse,
        FakeHelper.fakeAuthResult,
      );
    } else {
      return chopper.Response(http.Response("You clicked the wrong one dummy", 401), null);
    }
  }

  ///Gets public information about the server.
  @override
  Future<chopper.Response<PublicSystemInfo>> systemInfoPublicGet() async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      FakeHelper.fakePublicSystemInfo,
    );
  }

  @override
  Future<chopper.Response<BaseItemDtoQueryResult>> userViewsGet({
    String? userId,
    bool? includeExternalContent,
    List<enums.CollectionType>? presetViews,
    bool? includeHidden,
  }) async {
    return chopper.Response(
        FakeHelper.fakeCorrectResponse,
        BaseItemDtoQueryResult(
          items: [
            FakeHelper.fakeMoviesView,
            FakeHelper.fakeSeriesView,
          ],
          totalRecordCount: 2,
          startIndex: 0,
        ));
  }

  @override
  Future<chopper.Response<UserDto>> usersMeGet() async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      FakeHelper.fakeCorrectUser,
    );
  }

  @override
  Future<chopper.Response<bool>> quickConnectEnabledGet() async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      FakeHelper.fakeServerConfig.quickConnectAvailable,
    );
  }

  @override
  Future<chopper.Response<ServerConfiguration>> systemConfigurationGet() async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      FakeHelper.fakeServerConfig,
    );
  }

  @override
  Future<chopper.Response<List<BaseItemDto>>> itemsLatestGet({
    String? userId,
    String? parentId,
    List<enums.ItemFields>? fields,
    List<enums.BaseItemKind>? includeItemTypes,
    bool? isPlayed,
    bool? enableImages,
    int? imageTypeLimit,
    List<enums.ImageType>? enableImageTypes,
    bool? enableUserData,
    int? limit,
    bool? groupItems,
  }) async {
    final List<BaseItemDto> itemsList = switch (parentId) {
      "moviesId" => FakeHelper.fakeMovies,
      "seriesId" => [],
      _ => [],
    };
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      itemsList,
    );
  }

  @override
  Future<chopper.Response<QueryFilters>> itemsFilters2Get({
    String? userId,
    String? parentId,
    List<enums.BaseItemKind>? includeItemTypes,
    bool? isAiring,
    bool? isMovie,
    bool? isSports,
    bool? isKids,
    bool? isNews,
    bool? isSeries,
    bool? recursive,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      QueryFilters(),
    );
  }

  @override
  Future<chopper.Response<BaseItemDtoQueryResult>> itemsGet({
    String? userId,
    String? maxOfficialRating,
    bool? hasThemeSong,
    bool? hasThemeVideo,
    bool? hasSubtitles,
    bool? hasSpecialFeature,
    bool? hasTrailer,
    String? adjacentTo,
    int? indexNumber,
    int? parentIndexNumber,
    bool? hasParentalRating,
    bool? isHd,
    bool? is4K,
    List<enums.LocationType>? locationTypes,
    List<enums.LocationType>? excludeLocationTypes,
    bool? isMissing,
    bool? isUnaired,
    num? minCommunityRating,
    num? minCriticRating,
    DateTime? minPremiereDate,
    DateTime? minDateLastSaved,
    DateTime? minDateLastSavedForUser,
    DateTime? maxPremiereDate,
    bool? hasOverview,
    bool? hasImdbId,
    bool? hasTmdbId,
    bool? hasTvdbId,
    bool? isMovie,
    bool? isSeries,
    bool? isNews,
    bool? isKids,
    bool? isSports,
    List<String>? excludeItemIds,
    int? startIndex,
    int? limit,
    bool? recursive,
    String? searchTerm,
    List<enums.SortOrder>? sortOrder,
    String? parentId,
    List<enums.ItemFields>? fields,
    List<enums.BaseItemKind>? excludeItemTypes,
    List<enums.BaseItemKind>? includeItemTypes,
    List<enums.ItemFilter>? filters,
    bool? isFavorite,
    List<enums.MediaType>? mediaTypes,
    List<enums.ImageType>? imageTypes,
    List<enums.ItemSortBy>? sortBy,
    bool? isPlayed,
    List<String>? genres,
    List<String>? officialRatings,
    List<String>? tags,
    List<int>? years,
    bool? enableUserData,
    int? imageTypeLimit,
    List<enums.ImageType>? enableImageTypes,
    String? person,
    List<String>? personIds,
    List<String>? personTypes,
    List<String>? studios,
    List<String>? artists,
    List<String>? excludeArtistIds,
    List<String>? artistIds,
    List<String>? albumArtistIds,
    List<String>? contributingArtistIds,
    List<String>? albums,
    List<String>? albumIds,
    List<String>? ids,
    List<enums.VideoType>? videoTypes,
    String? minOfficialRating,
    bool? isLocked,
    bool? isPlaceHolder,
    bool? hasOfficialRating,
    bool? collapseBoxSetItems,
    int? minWidth,
    int? minHeight,
    int? maxWidth,
    int? maxHeight,
    bool? is3D,
    List<enums.SeriesStatus>? seriesStatus,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    List<String>? studioIds,
    List<String>? genreIds,
    bool? enableTotalRecordCount,
    bool? enableImages,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      BaseItemDtoQueryResult(),
    );
  }
}

class FakeHelper {
  static http.BaseResponse fakeCorrectResponse = http.Response('You did it reviewer', 200);

  static String fakeTestServerUrl = "https://obvfake.sk38la21k.server";

  static UserDto fakeCorrectUser = const UserDto(id: '1', name: 'Fake Employee', configuration: UserConfiguration());

  static ServerConfiguration fakeServerConfig = const ServerConfiguration(
    isStartupWizardCompleted: true,
    quickConnectAvailable: false,
  );

  static PublicSystemInfo fakePublicSystemInfo = PublicSystemInfo(
    localAddress: FakeHelper.fakeTestServerUrl,
    serverName: "Stand in server",
    version: "GOOG",
    startupWizardCompleted: true,
    id: "sldfkjsldjkf",
  );

  static BaseItemDto fakeMoviesView = BaseItemDto(
    name: "Movies",
    id: 'moviesId',
    serverId: fakePublicSystemInfo.id,
    dateCreated: DateTime.now(),
    canDelete: false,
    canDownload: false,
    parentId: "CollectionID",
    collectionType: CollectionType.movies,
    playAccess: PlayAccess.none,
    childCount: 5,
  );

  static List<BaseItemDto> fakeMovies = [
    BaseItemDto(
      name: "The revenge of the viewer",
      id: "1",
      type: BaseItemKind.movie,
      overview: "A simple placeholder about the revenge of a viewer",
      startDate: DateTime.now(),
      officialRating: "All Ages",
      userData: const UserItemDataDto(
        isFavorite: true,
      ),
    ),
    BaseItemDto(
      name: "BasicExtinct",
      id: "2",
      type: BaseItemKind.movie,
      overview: "Basic Instinct but different",
      startDate: DateTime.now(),
      officialRating: "All Ages",
    )
  ];

  static BaseItemDto fakeSeriesView = BaseItemDto(
    name: "Series",
    id: 'seriesId',
    serverId: fakePublicSystemInfo.id,
    dateCreated: DateTime.now(),
    canDelete: false,
    canDownload: false,
    parentId: "CollectionID",
    collectionType: CollectionType.tvshows,
    playAccess: PlayAccess.none,
    childCount: 5,
  );

  static List<UserDto> fakeUsers = [
    fakeCorrectUser,
    const UserDto(id: '2', name: 'Fake 2'),
  ];

  static AuthenticationResult fakeAuthResult = AuthenticationResult(
    user: fakeCorrectUser,
    accessToken: 'A_TOTALLY_REAL_TOKEN',
    serverId: "1",
  );
}
