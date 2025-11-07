import 'dart:developer';

import 'package:chopper/chopper.dart' as chopper;
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';

List<BaseItemDto> _baseItems = [
  BaseItemDto(
    parentId: FakeHelper.fakeMoviesView.id,
    name: "The revenge of the viewer",
    type: BaseItemKind.movie,
    overview: "A simple placeholder about the revenge of a viewer",
    startDate: DateTime.now(),
    officialRating: "PG3",
    runTimeTicks: const Duration(minutes: 30).inMilliseconds * 10000,
    userData: const UserItemDataDto(
      isFavorite: true,
    ),
  ),
  BaseItemDto(
    parentId: FakeHelper.fakeMoviesView.id,
    name: "BasicExtinct",
    type: BaseItemKind.movie,
    overview: "Basic Instinct but different",
    startDate: DateTime.now(),
    officialRating: "PG3",
    runTimeTicks: const Duration(hours: 1).inMilliseconds * 10000,
    userData: const UserItemDataDto(
      isFavorite: false,
      played: true,
    ),
  ),
  BaseItemDto(
    parentId: FakeHelper.fakeMoviesView.id,
    name: "HowToView",
    type: BaseItemKind.movie,
    overview: "Simple movie about how to view something",
    startDate: DateTime.now(),
    officialRating: "PG3",
    runTimeTicks: const Duration(hours: 1, minutes: 15).inMilliseconds * 10000,
    userData: const UserItemDataDto(
      isFavorite: false,
      played: false,
      playedPercentage: 20,
    ),
  ),
  BaseItemDto(
    parentId: FakeHelper.fakeSeriesView.id,
    name: "Cappybara Tales",
    id: "CappyShow",
    type: BaseItemKind.series,
    overview: "The mysterious life of cappybara's",
    startDate: DateTime.now(),
    officialRating: "PG3",
  ),
  BaseItemDto(
    parentId: FakeHelper.fakeSeriesView.id,
    name: "Season 1",
    id: "CappySeason1",
    seriesId: "CappyShow",
    seriesName: "Cappybara Tales",
    seasonName: "Season 1",
    indexNumber: 1,
    seriesCount: 1,
    type: BaseItemKind.season,
    overview: "What is this mysterious creature",
    runTimeTicks: const Duration(minutes: 4).inMilliseconds * 10000,
    userData: const UserItemDataDto(
      isFavorite: true,
      played: true,
    ),
  ),
  BaseItemDto(
    parentId: FakeHelper.fakeSeriesView.id,
    name: "Giant rodent",
    seriesId: "CappyShow",
    indexNumber: 0,
    seriesCount: 1,
    seasonId: "CappySeason1",
    seriesName: "Cappybara Tales",
    type: BaseItemKind.episode,
    overview: "What is this mysterious creature",
    runTimeTicks: const Duration(minutes: 4).inMilliseconds * 10000,
    userData: const UserItemDataDto(
      isFavorite: true,
      played: true,
    ),
  ),
  BaseItemDto(
    parentId: FakeHelper.fakeSeriesView.id,
    name: "Live of a cappybara",
    seriesId: "CappyShow",
    indexNumber: 1,
    seriesCount: 1,
    seasonId: "CappySeason1",
    seriesName: "Cappybara Tales",
    type: BaseItemKind.episode,
    overview: "Daily look at cappybara's in the wild",
    runTimeTicks: const Duration(minutes: 4).inMilliseconds * 10000,
    userData: const UserItemDataDto(
      isFavorite: true,
      played: true,
      playedPercentage: 20,
    ),
  ),
].mapIndexed((index, e) => e.id == null ? e.copyWith(id: index.toString()) : e).toList();

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
    if (body?.username == FakeHelper.fakeCorrectUser.name && body?.pw == FakeHelper.fakeCorrectPassword) {
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
  Future<chopper.Response<BaseItemDtoQueryResult>> userItemsResumeGet({
    String? userId,
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<enums.ItemFields>? fields,
    List<enums.MediaType>? mediaTypes,
    bool? enableUserData,
    int? imageTypeLimit,
    List<enums.ImageType>? enableImageTypes,
    List<enums.BaseItemKind>? excludeItemTypes,
    List<enums.BaseItemKind>? includeItemTypes,
    bool? enableTotalRecordCount,
    bool? enableImages,
    bool? excludeActiveSessions,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      BaseItemDtoQueryResult(
        items: _baseItems
            .where((e) => {BaseItemKind.movie, BaseItemKind.episode}.contains(e.type))
            .where((e) => e.userData?.played != true && e.userData?.playedPercentage != 0)
            .fold<Map<String?, BaseItemDto>>(
              {},
              (map, item) {
                if (!map.containsKey(item.seriesId)) {
                  map[item.seriesId] = item;
                }
                return map;
              },
            )
            .values
            .toList(),
      ),
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
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      _baseItems.where((e) => e.parentId == parentId).toList(),
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
      const QueryFilters(),
    );
  }

  @override
  Future<chopper.Response<BaseItemDto>> itemsItemIdGet({
    String? userId,
    required String? itemId,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      _baseItems.firstWhere((item) => item.id == itemId),
    );
  }

  @override
  Future<chopper.Response<BaseItemDtoQueryResult>> itemsItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<enums.ItemFields>? fields,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      const BaseItemDtoQueryResult(items: []),
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
      BaseItemDtoQueryResult(
        items: _baseItems
            .where((e) => e.parentId == parentId)
            .where((e) => includeItemTypes?.contains(e.type) ?? true)
            .where((e) => recursive == false ? {BaseItemKind.movie, BaseItemKind.series}.contains(e.type) : true)
            .where((e) => filters?.contains(ItemFilter.isplayed) == true ? e.userData?.played == true : true)
            .where((e) => filters?.contains(ItemFilter.isunplayed) == true ? e.userData?.played == false : true)
            .where(
              (e) => isFavorite == true || filters?.contains(ItemFilter.isfavorite) == true
                  ? e.userData?.isFavorite == true
                  : true,
            )
            .toList(),
      ),
    );
  }

  @override
  Future<chopper.Response<BaseItemDtoQueryResult>> showsSeriesIdSeasonsGet({
    required String? seriesId,
    String? userId,
    List<enums.ItemFields>? fields,
    bool? isSpecialSeason,
    bool? isMissing,
    String? adjacentTo,
    bool? enableImages,
    int? imageTypeLimit,
    List<enums.ImageType>? enableImageTypes,
    bool? enableUserData,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      BaseItemDtoQueryResult(
          items: _baseItems.where((e) => e.type == BaseItemKind.season && e.seriesId == seriesId).toList()),
    );
  }

  @override
  Future<chopper.Response<BaseItemDtoQueryResult>> showsSeriesIdEpisodesGet({
    required String? seriesId,
    String? userId,
    List<enums.ItemFields>? fields,
    int? season,
    String? seasonId,
    bool? isMissing,
    String? adjacentTo,
    String? startItemId,
    int? startIndex,
    int? limit,
    bool? enableImages,
    int? imageTypeLimit,
    List<enums.ImageType>? enableImageTypes,
    bool? enableUserData,
    enums.ShowsSeriesIdEpisodesGetSortBy? sortBy,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      BaseItemDtoQueryResult(
          items: _baseItems.where((e) => e.type == BaseItemKind.episode && e.seriesId == seriesId).toList()),
    );
  }

  @override
  Future<chopper.Response<BaseItemDtoQueryResult>> showsNextUpGet({
    String? userId,
    int? startIndex,
    int? limit,
    List<enums.ItemFields>? fields,
    String? seriesId,
    String? parentId,
    bool? enableImages,
    int? imageTypeLimit,
    List<enums.ImageType>? enableImageTypes,
    bool? enableUserData,
    DateTime? nextUpDateCutoff,
    bool? enableTotalRecordCount,
    bool? disableFirstEpisode,
    bool? enableResumable,
    bool? enableRewatching,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      BaseItemDtoQueryResult(
        items: _baseItems
            .where((e) => e.type == BaseItemKind.episode)
            .where((e) => (e.userData?.playedPercentage != null && e.userData?.played == false))
            .toList(),
      ),
    );
  }

  @override
  Future<chopper.Response<UserItemDataDto>> userPlayedItemsItemIdPost({
    String? userId,
    required String? itemId,
    DateTime? datePlayed,
  }) async {
    final item = await _updateUserData(
      itemId,
      (data) => UserItemDataDto(
        played: true,
        isFavorite: data?.isFavorite,
      ),
    );
    if (item.type == BaseItemKind.series) {
      for (var element in _baseItems.where((e) => e.seriesId == item.id)) {
        await _updateUserData(
          element.id,
          (data) => UserItemDataDto(
            played: true,
            isFavorite: data?.isFavorite,
          ),
        );
      }
    }
    if (item.type == BaseItemKind.season) {
      for (var element in _baseItems.where((e) => e.seasonId == item.id)) {
        await _updateUserData(
          element.id,
          (data) => UserItemDataDto(
            played: true,
            isFavorite: data?.isFavorite,
          ),
        );
      }
    }
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      item.userData,
    );
  }

  @override
  Future<chopper.Response<UserItemDataDto>> userPlayedItemsItemIdDelete({
    String? userId,
    required String? itemId,
  }) async {
    final item = await _updateUserData(
      itemId,
      (data) => UserItemDataDto(played: false, isFavorite: data?.isFavorite),
    );
    if (item.type == BaseItemKind.series) {
      for (var element in _baseItems.where((e) => e.seriesId == item.id)) {
        await _updateUserData(
          element.id,
          (data) => UserItemDataDto(
            played: false,
            isFavorite: data?.isFavorite,
          ),
        );
      }
    }
    if (item.type == BaseItemKind.season) {
      for (var element in _baseItems.where((e) => e.seasonId == item.id)) {
        await _updateUserData(
          element.id,
          (data) => UserItemDataDto(
            played: false,
            isFavorite: data?.isFavorite,
          ),
        );
      }
    }
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      item.userData,
    );
  }

  @override
  Future<chopper.Response<BaseItemDtoQueryResult>> personsGet({
    int? limit,
    String? searchTerm,
    List<enums.ItemFields>? fields,
    List<enums.ItemFilter>? filters,
    bool? isFavorite,
    bool? enableUserData,
    int? imageTypeLimit,
    List<enums.ImageType>? enableImageTypes,
    List<String>? excludePersonTypes,
    List<String>? personTypes,
    String? appearsInItemId,
    String? userId,
    bool? enableImages,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      const BaseItemDtoQueryResult(),
    );
  }

  @override
  Future<chopper.Response<UserItemDataDto>> userFavoriteItemsItemIdDelete({
    String? userId,
    required String? itemId,
  }) async {
    final item = await _updateUserData(
      itemId,
      (data) => data?.copyWith(
        isFavorite: false,
      ),
    );
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      item.userData,
    );
  }

  @override
  Future<chopper.Response<UserItemDataDto>> userFavoriteItemsItemIdPost({
    String? userId,
    required String? itemId,
  }) async {
    final item = await _updateUserData(
      itemId,
      (data) => data?.copyWith(
        isFavorite: true,
      ),
    );
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      item.userData,
    );
  }

  Future<BaseItemDto> _updateUserData(String? id, Function(UserItemDataDto? old) userData) async {
    final currentItem = _baseItems.firstWhere((e) => e.id == id);
    final updatedItem = currentItem.copyWith(
      userData: userData(currentItem.userData),
    );

    _baseItems = _baseItems.map((orig) => orig.id == id ? updatedItem : orig).toList();

    await Future.delayed(const Duration(milliseconds: 250));
    return updatedItem;
  }

  @override
  Future<chopper.Response<BaseItemDtoQueryResult>> studiosGet({
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<enums.ItemFields>? fields,
    List<enums.BaseItemKind>? excludeItemTypes,
    List<enums.BaseItemKind>? includeItemTypes,
    bool? isFavorite,
    bool? enableUserData,
    int? imageTypeLimit,
    List<enums.ImageType>? enableImageTypes,
    String? userId,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    bool? enableImages,
    bool? enableTotalRecordCount,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      const BaseItemDtoQueryResult(),
    );
  }

  @override
  Future<chopper.Response<PlaybackInfoResponse>> itemsItemIdPlaybackInfoPost({
    required String? itemId,
    String? userId,
    int? maxStreamingBitrate,
    int? startTimeTicks,
    int? audioStreamIndex,
    int? subtitleStreamIndex,
    int? maxAudioChannels,
    String? mediaSourceId,
    String? liveStreamId,
    bool? autoOpenLiveStream,
    bool? enableDirectPlay,
    bool? enableDirectStream,
    bool? enableTranscoding,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    required PlaybackInfoDto? body,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      FakeHelper.bigBuckBunny,
    );
  }

  @override
  Future<chopper.Response<MediaSegmentDtoQueryResult>> mediaSegmentsItemIdGet({
    required String? itemId,
    List<enums.MediaSegmentType>? includeSegmentTypes,
  }) async {
    return chopper.Response(
      FakeHelper.fakeCorrectResponse,
      const MediaSegmentDtoQueryResult(
        items: [],
      ),
    );
  }

  @override
  Future<chopper.Response<BrandingOptionsDto>> brandingConfigurationGet() async => chopper.Response(
        FakeHelper.fakeCorrectResponse,
        const BrandingOptionsDto(loginDisclaimer: "Test server"),
      );
}

class FakeHelper {
  static http.BaseResponse fakeCorrectResponse = http.Response('', 200);

  static String fakeTestServerUrl = "http://22b469df.fladder.nl";

  static UserDto fakeCorrectUser = const UserDto(id: '1', name: 'User 1', configuration: UserConfiguration());
  static String fakeCorrectPassword = "Txnw6RWYb8yEtD";

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
    const UserDto(id: '2', name: 'User 2'),
  ];

  static AuthenticationResult fakeAuthResult = AuthenticationResult(
    user: fakeCorrectUser,
    accessToken: 'A_TOTALLY_REAL_TOKEN',
    serverId: "1",
  );

  static PlaybackInfoResponse bigBuckBunny = PlaybackInfoResponse.fromJson({
    "MediaSources": [
      {
        "Protocol": "File",
        "Id": "234sdfsdf234",
        "Path": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "Type": "Default",
        "Container": "mkv",
        "Size": 513949601,
        "Name": "Big Buck Bunny",
        "IsRemote": false,
        "ETag": "sdfsdfsd",
        "RunTimeTicks": 26540060000,
        "SupportsTranscoding": false,
        "SupportsDirectStream": true,
        "SupportsDirectPlay": true,
        "VideoType": "VideoFile",
        "MediaAttachments": [],
        "Formats": [],
        "Bitrate": 1741204,
        "HasSegments": true
      }
    ],
    "PlaySessionId": "asdf234qwafsdfsdf"
  });
}
