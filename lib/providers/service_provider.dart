import 'dart:developer';
import 'dart:typed_data';

import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:fladder/fake/fake_jellyfin_open_api.dart';
import 'package:fladder/jellyfin/enum_models.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/util/jellyfin_extension.dart';

const _userSettings = "usersettings";
const _client = "fladder";

class ServerQueryResult {
  final List<BaseItemDto> original;
  final List<ItemBaseModel> items;
  final int? totalRecordCount;
  final int? startIndex;
  ServerQueryResult({
    required this.original,
    required this.items,
    this.totalRecordCount,
    this.startIndex,
  });

  factory ServerQueryResult.fromBaseQuery(
    BaseItemDtoQueryResult baseQuery,
    Ref ref,
  ) {
    return ServerQueryResult(
      original: baseQuery.items ?? [],
      items: baseQuery.items
              ?.map(
                (e) => ItemBaseModel.fromBaseDto(e, ref),
              )
              .toList() ??
          [],
      totalRecordCount: baseQuery.totalRecordCount,
      startIndex: baseQuery.startIndex,
    );
  }

  ServerQueryResult copyWith({
    List<BaseItemDto>? original,
    List<ItemBaseModel>? items,
    int? totalRecordCount,
    int? startIndex,
  }) {
    return ServerQueryResult(
      original: original ?? this.original,
      items: items ?? this.items,
      totalRecordCount: totalRecordCount ?? this.totalRecordCount,
      startIndex: startIndex ?? this.startIndex,
    );
  }
}

class JellyService {
  JellyService(this.ref, this._api);

  final JellyfinOpenApi _api;

  JellyfinOpenApi get api {
    var authServer = ref.read(authProvider).serverLoginModel?.tempCredentials.url ?? "";
    var currentServer = ref.read(userProvider)?.credentials.url;
    if ((authServer.isNotEmpty ? authServer : currentServer) == FakeHelper.fakeTestServerUrl) {
      return FakeJellyfinOpenApi();
    } else {
      return _api;
    }
  }

  final Ref ref;
  AccountModel? get account => ref.read(userProvider);

  Future<Response<ItemBaseModel>> usersUserIdItemsItemIdGet({
    String? itemId,
  }) async {
    try {
      final response = await api.itemsItemIdGet(
        userId: account?.id,
        itemId: itemId,
      );
      return response.copyWith(body: ItemBaseModel.fromBaseDto(response.bodyOrThrow, ref));
    } catch (e) {
      final item = (await ref.read(syncProvider.notifier).getSyncedItem(itemId))?.itemModel;
      return Response<ItemBaseModel>(
        http.Response("", 202),
        item,
      );
    }
  }

  Future<Response<BaseItemDto>> usersUserIdItemsItemIdGetBaseItem({
    String? itemId,
  }) async {
    try {
      return await api.itemsItemIdGet(
        userId: account?.id,
        itemId: itemId,
      );
    } catch (e) {
      return ref.read(syncProvider.notifier).getSyncedItem(itemId).then(
            (value) => value?.data != null
                ? Response<BaseItemDto>(
                    http.Response("", 202),
                    value?.data,
                  )
                : Response<BaseItemDto>(
                    http.Response("", 404),
                    null,
                  ),
          );
    }
  }

  Future<Response<UserData>> userItemsItemIdUserDataGet({
    String? itemId,
  }) async {
    final response = await api.userItemsItemIdUserDataGet(
      userId: account?.id,
      itemId: itemId,
    );
    return response.copyWith(
      body: UserData.fromDto(response.bodyOrThrow),
    );
  }

  Future<Response<UserData>?> userItemsItemIdUserDataPost({
    String? itemId,
    required UserData? body,
  }) async {
    if (body == null) {
      return null;
    }
    final response = await api.userItemsItemIdUserDataPost(
      userId: account?.id,
      itemId: itemId,
      body: UpdateUserItemDataDto(
        playCount: body.playCount,
        playbackPositionTicks: body.playbackPositionTicks,
        isFavorite: body.isFavourite,
        played: body.played,
        lastPlayedDate: body.lastPlayed,
        itemId: itemId,
      ),
    );
    return response.copyWith(
      body: UserData.fromDto(response.bodyOrThrow),
    );
  }

  Future<Response<ServerQueryResult>> itemsGet({
    String? maxOfficialRating,
    bool? hasThemeSong,
    bool? hasThemeVideo,
    bool? hasSubtitles,
    bool? hasSpecialFeature,
    bool? hasTrailer,
    String? adjacentTo,
    int? parentIndexNumber,
    bool? hasParentalRating,
    bool? isHd,
    bool? is4K,
    List<LocationType>? locationTypes,
    List<LocationType>? excludeLocationTypes,
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
    List<SortOrder>? sortOrder,
    String? parentId,
    List<ItemFields>? fields,
    List<BaseItemKind>? excludeItemTypes,
    List<BaseItemKind>? includeItemTypes,
    List<ItemFilter>? filters,
    bool? isFavorite,
    List<MediaType>? mediaTypes,
    List<ImageType>? imageTypes,
    List<ItemSortBy>? sortBy,
    bool? isPlayed,
    List<String>? genres,
    List<String>? officialRatings,
    List<String>? tags,
    List<int>? years,
    bool? enableUserData,
    int? imageTypeLimit,
    List<ImageType>? enableImageTypes,
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
    List<VideoType>? videoTypes,
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
    List<SeriesStatus>? seriesStatus,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    List<String>? studioIds,
    List<String>? genreIds,
    bool? enableTotalRecordCount,
    bool? enableImages,
  }) async {
    final response = await api.usersUserIdItemsGet(
      userId: account?.id,
      maxOfficialRating: maxOfficialRating,
      hasThemeSong: hasThemeSong,
      hasThemeVideo: hasThemeVideo,
      hasSubtitles: hasSubtitles,
      hasSpecialFeature: hasSpecialFeature,
      hasTrailer: hasTrailer,
      adjacentTo: adjacentTo,
      parentIndexNumber: parentIndexNumber,
      hasParentalRating: hasParentalRating,
      isHd: isHd,
      is4K: is4K,
      locationTypes: locationTypes,
      excludeLocationTypes: excludeLocationTypes,
      isMissing: isMissing,
      isUnaired: isUnaired,
      minCommunityRating: minCommunityRating,
      minCriticRating: minCriticRating,
      minPremiereDate: minPremiereDate,
      minDateLastSaved: minDateLastSaved,
      minDateLastSavedForUser: minDateLastSavedForUser,
      maxPremiereDate: maxPremiereDate,
      hasOverview: hasOverview,
      hasImdbId: hasImdbId,
      hasTmdbId: hasTmdbId,
      hasTvdbId: hasTvdbId,
      isMovie: isMovie,
      isSeries: isSeries,
      isNews: isNews,
      isKids: isKids,
      isSports: isSports,
      excludeItemIds: excludeItemIds,
      startIndex: startIndex,
      limit: limit,
      recursive: recursive,
      searchTerm: searchTerm,
      sortOrder: sortOrder,
      sortBy: sortBy,
      parentId: parentId,
      fields: {...?fields, ItemFields.candelete, ItemFields.candownload}.toList(),
      excludeItemTypes: excludeItemTypes,
      includeItemTypes: includeItemTypes,
      filters: filters,
      isFavorite: isFavorite,
      mediaTypes: mediaTypes,
      imageTypes: imageTypes,
      isPlayed: isPlayed,
      genres: genres,
      officialRatings: officialRatings,
      tags: tags,
      years: years,
      enableUserData: enableUserData,
      imageTypeLimit: imageTypeLimit,
      enableImageTypes: enableImageTypes,
      person: person,
      personIds: personIds,
      personTypes: personTypes,
      studios: studios,
      artists: artists,
      excludeArtistIds: excludeArtistIds,
      artistIds: artistIds,
      albumArtistIds: albumArtistIds,
      contributingArtistIds: contributingArtistIds,
      albums: albums,
      albumIds: albumIds,
      ids: ids,
      videoTypes: videoTypes,
      minOfficialRating: minOfficialRating,
      isLocked: isLocked,
      isPlaceHolder: isPlaceHolder,
      hasOfficialRating: hasOfficialRating,
      collapseBoxSetItems: collapseBoxSetItems,
      minWidth: minWidth,
      minHeight: minHeight,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      is3D: is3D,
      seriesStatus: seriesStatus,
      nameStartsWithOrGreater: nameStartsWithOrGreater,
      nameStartsWith: nameStartsWith,
      nameLessThan: nameLessThan,
      studioIds: studioIds,
      genreIds: genreIds,
      enableTotalRecordCount: enableTotalRecordCount,
      enableImages: enableImages,
    );

    return response.copyWith(
      body: ServerQueryResult.fromBaseQuery(response.bodyOrThrow, ref),
    );
  }

  Future<List<PhotoModel>> itemsGetAlbumPhotos({
    String? albumId,
  }) async {
    final response = await itemsGet(
      parentId: albumId,
      enableUserData: true,
      fields: [
        ItemFields.parentid,
        ItemFields.datecreated,
      ],
    );
    return response.body?.items.whereType<PhotoModel>().toList() ?? [];
  }

  Future<Response<List<ItemBaseModel>>> personsGet({
    String? searchTerm,
    int? limit,
    bool? isFavorite,
  }) async {
    final response = await api.personsGet(
      userId: account?.id,
      limit: limit,
      isFavorite: isFavorite,
    );
    return response.copyWith(
      body: response.body?.items
              ?.map(
                (e) => ItemBaseModel.fromBaseDto(e, ref),
              )
              .toList() ??
          [],
    );
  }

  Future<Response<List<ImageInfo>>> itemsItemIdImagesGet({
    String? itemId,
    bool? isFavorite,
  }) async {
    final response = await api.itemsItemIdImagesGet(itemId: itemId);
    return response;
  }

  Future<Response<MetadataEditorInfo>> itemsItemIdMetadataEditorGet({
    String? itemId,
  }) async {
    return api.itemsItemIdMetadataEditorGet(itemId: itemId);
  }

  Future<Response<RemoteImageResult>> itemsItemIdRemoteImagesGet({
    String? itemId,
    ImageType? type,
    bool? includeAllLanguages,
  }) async {
    return api.itemsItemIdRemoteImagesGet(
      itemId: itemId,
      type: ItemsItemIdRemoteImagesGetType.values.firstWhereOrNull(
        (element) => element.value == type?.value,
      ),
      includeAllLanguages: includeAllLanguages,
    );
  }

  Future<Response> itemsItemIdPost({
    String? itemId,
    required BaseItemDto? body,
  }) async {
    return api.itemsItemIdPost(
      itemId: itemId,
      body: body,
    );
  }

  Future<Response<dynamic>?> itemIdImagesImageTypePost(
    ImageType type,
    String itemId,
    Uint8List data,
  ) async {
    return api.itemIdImagesImageTypePost(
      type,
      itemId,
      data,
    );
  }

  Future<Response> itemsItemIdRemoteImagesDownloadPost({
    required String? itemId,
    required ImageType? type,
    String? imageUrl,
  }) async {
    return api.itemsItemIdRemoteImagesDownloadPost(
      itemId: itemId,
      type: ItemsItemIdRemoteImagesDownloadPostType.values.firstWhereOrNull(
        (element) => element.value == type?.value,
      ),
      imageUrl: imageUrl,
    );
  }

  Future<Response> itemsItemIdImagesImageTypeDelete({
    required String? itemId,
    required ImageType? imageType,
    int? imageIndex,
  }) async {
    return api.itemsItemIdImagesImageTypeDelete(
      itemId: itemId,
      imageType: ItemsItemIdImagesImageTypeDeleteImageType.values.firstWhereOrNull(
        (element) => element.value == imageType?.value,
      ),
      imageIndex: imageIndex,
    );
  }

  Future<Response<BaseItemDtoQueryResult>> usersUserIdItemsResumeGet({
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<ItemFields>? fields,
    List<MediaType>? mediaTypes,
    bool? enableUserData,
    bool? enableTotalRecordCount,
    List<ImageType>? enableImageTypes,
    List<BaseItemKind>? excludeItemTypes,
    List<BaseItemKind>? includeItemTypes,
  }) async {
    return api.userItemsResumeGet(
      userId: account?.id,
      searchTerm: searchTerm,
      parentId: parentId,
      limit: limit,
      fields: fields,
      mediaTypes: mediaTypes,
      enableTotalRecordCount: enableTotalRecordCount,
      enableImageTypes: enableImageTypes,
      enableUserData: enableUserData,
      includeItemTypes: includeItemTypes,
      excludeItemTypes: excludeItemTypes,
    );
  }

  Future<Response<List<BaseItemDto>>> usersUserIdItemsLatestGet({
    String? parentId,
    List<ItemFields>? fields,
    List<BaseItemKind>? includeItemTypes,
    bool? isPlayed,
    bool? enableImages,
    int? imageTypeLimit,
    List<ImageType>? enableImageTypes,
    bool? enableUserData,
    int? limit,
    bool? groupItems,
  }) async {
    return api.usersUserIdItemsLatestGet(
      parentId: parentId,
      userId: account?.id,
      fields: fields,
      includeItemTypes: includeItemTypes,
      isPlayed: isPlayed,
      enableImages: enableImages,
      imageTypeLimit: imageTypeLimit,
      enableImageTypes: enableImageTypes,
      enableUserData: enableUserData,
      limit: limit,
      groupItems: groupItems,
    );
  }

  Future<Response<List<RecommendationDto>>> moviesRecommendationsGet({
    String? parentId,
    List<ItemFields>? fields,
    int? categoryLimit,
    int? itemLimit,
  }) async {
    return api.moviesRecommendationsGet(
      userId: account?.id,
      parentId: parentId,
      fields: fields,
      categoryLimit: categoryLimit,
      itemLimit: itemLimit,
    );
  }

  Future<Response<BaseItemDtoQueryResult>> showsNextUpGet({
    int? startIndex,
    int? limit,
    String? parentId,
    DateTime? nextUpDateCutoff,
    List<ItemFields>? fields,
    bool? enableUserData,
    List<ImageType>? enableImageTypes,
    int? imageTypeLimit,
  }) async {
    return api.showsNextUpGet(
      userId: account?.id,
      parentId: parentId,
      limit: limit,
      fields: fields,
      enableResumable: false,
      enableRewatching: false,
      disableFirstEpisode: false,
      nextUpDateCutoff: nextUpDateCutoff,
      enableImageTypes: enableImageTypes,
      enableUserData: enableUserData,
      imageTypeLimit: imageTypeLimit,
    );
  }

  Future<Response<BaseItemDtoQueryResult>> genresGet({
    String? parentId,
    List<ItemSortBy>? sortBy,
    List<SortOrder>? sortOrder,
    List<BaseItemKind>? includeItemTypes,
  }) async {
    return api.genresGet(
      parentId: parentId,
      userId: account?.id,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  Future<Response> sessionsPlayingPost({required PlaybackStartInfo? body}) async => api.sessionsPlayingPost(body: body);

  Future<Response> sessionsPlayingStoppedPost({
    required PlaybackStopInfo? body,
  }) {
    final positionTicks = body?.positionTicks;
    if (positionTicks != null) {
      ref
          .read(syncProvider.notifier)
          .updatePlaybackPosition(itemId: body?.itemId, position: Duration(milliseconds: positionTicks ~/ 10000));
    }
    return api.sessionsPlayingStoppedPost(body: body);
  }

  Future<Response> sessionsPlayingProgressPost({required PlaybackProgressInfo? body}) async =>
      api.sessionsPlayingProgressPost(body: body);

  Future<Response<PlaybackInfoResponse>> itemsItemIdPlaybackInfoPost({
    required String? itemId,
    required PlaybackInfoDto? body,
  }) async =>
      api.itemsItemIdPlaybackInfoPost(
        itemId: itemId,
        userId: account?.id,
        enableDirectPlay: body?.enableDirectPlay,
        enableDirectStream: body?.enableDirectStream,
        enableTranscoding: body?.enableTranscoding,
        autoOpenLiveStream: body?.autoOpenLiveStream,
        maxStreamingBitrate: body?.maxStreamingBitrate,
        liveStreamId: body?.liveStreamId,
        startTimeTicks: body?.startTimeTicks,
        mediaSourceId: body?.mediaSourceId,
        audioStreamIndex: body?.audioStreamIndex,
        subtitleStreamIndex: body?.subtitleStreamIndex,
        body: body,
      );

  Future<Response<BaseItemDtoQueryResult>> showsSeriesIdEpisodesGet({
    required String? seriesId,
    List<ItemFields>? fields,
    int? season,
    String? seasonId,
    bool? isMissing,
    String? adjacentTo,
    String? startItemId,
    int? startIndex,
    int? limit,
    bool? enableImages,
    int? imageTypeLimit,
    List<ImageType>? enableImageTypes,
    bool? enableUserData,
    ShowsSeriesIdEpisodesGetSortBy? sortBy,
  }) async {
    try {
      var response = await api.showsSeriesIdEpisodesGet(
        seriesId: seriesId,
        userId: account?.id,
        fields: [
          ...?fields,
          ItemFields.parentid,
        ],
        isMissing: isMissing,
        limit: limit,
        sortBy: sortBy,
        enableUserData: enableUserData,
        startIndex: startIndex,
        adjacentTo: adjacentTo,
        startItemId: startItemId,
        season: season,
        seasonId: seasonId,
        enableImages: enableImages,
        enableImageTypes: enableImageTypes,
      );
      return response;
    } catch (e) {
      final seriesItem = await ref.read(syncProvider.notifier).getSyncedItem(seriesId);
      if (seriesItem != null) {
        final episodes = await ref.read(syncProvider.notifier).getNestedChildren(seriesItem)
          ..where((e) => e.itemModel is EpisodeModel);
        return Response<BaseItemDtoQueryResult>(
          http.Response("", 200),
          BaseItemDtoQueryResult(
            items: episodes.map((e) => e.data).nonNulls.toList(),
            totalRecordCount: episodes.length,
            startIndex: 0,
          ),
        );
      } else {
        return Response<BaseItemDtoQueryResult>(
          http.Response("", 400),
          const BaseItemDtoQueryResult(
            items: [],
            totalRecordCount: 0,
            startIndex: 0,
          ),
        );
      }
    }
  }

  Future<List<ItemBaseModel>> fetchEpisodeFromShow({
    required String? seriesId,
    String? seasonId,
  }) async {
    final response = await showsSeriesIdEpisodesGet(seriesId: seriesId, seasonId: seasonId);
    return response.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList() ?? [];
  }

  Future<Response<BaseItemDtoQueryResult>> itemsItemIdSimilarGet({
    String? itemId,
    int? limit,
  }) async {
    try {
      return await api.itemsItemIdSimilarGet(userId: account?.id, itemId: itemId, limit: limit, fields: [
        ItemFields.parentid,
        ItemFields.candelete,
        ItemFields.candownload,
      ]);
    } catch (e) {
      return Response<BaseItemDtoQueryResult>(
        http.Response("", 400),
        const BaseItemDtoQueryResult(
          items: [],
          totalRecordCount: 0,
          startIndex: 0,
        ),
      );
    }
  }

  Future<Response<BaseItemDtoQueryResult>> usersUserIdItemsGet({
    String? parentId,
    List<ItemSortBy>? sortBy,
    List<SortOrder>? sortOrder,
    int? limit,
    bool? recursive,
    List<BaseItemKind>? includeItemTypes,
  }) async {
    return api.usersUserIdItemsGet(
      parentId: parentId,
      userId: account?.id,
      recursive: recursive,
      sortBy: sortBy,
      sortOrder: sortOrder,
      includeItemTypes: includeItemTypes,
      limit: limit,
    );
  }

  Future<Response<dynamic>> playlistsPlaylistIdItemsPost({
    String? playlistId,
    List<String>? ids,
  }) async {
    return api.playlistsPlaylistIdItemsPost(
      playlistId: playlistId,
      ids: ids,
      userId: account?.id,
    );
  }

  Future<Response<dynamic>> playlistsPost({
    String? name,
    List<String>? ids,
    required CreatePlaylistDto? body,
  }) async {
    return api.playlistsPost(
      name: name,
      ids: ids,
      userId: account?.id,
      body: body,
    );
  }

  Future<Response<List<AccountModel>>> usersPublicGet(
    CredentialsModel credentials,
  ) async {
    final response = await api.usersPublicGet();
    return response.copyWith(
      body: response.body?.map(
        (e) {
          var imageUrl = ref.read(imageUtilityProvider).getUserImageUrl(e.id ?? "");
          return AccountModel(
            name: e.name ?? "",
            credentials: credentials,
            id: e.id ?? "",
            avatar: imageUrl,
            lastUsed: DateTime.now(),
          );
        },
      ).toList(),
    );
  }

  Future<Response<List<AccountModel>>> getAllUsers() {
    return api.usersGet().then(
          (response) => response.copyWith(
            body: response.body?.map(
              (e) {
                var imageUrl = ref.read(imageUtilityProvider).getUserImageUrl(e.id ?? "");
                return AccountModel(
                  name: e.name ?? "",
                  credentials: CredentialsModel.createNewCredentials(),
                  id: e.id ?? "",
                  avatar: imageUrl,
                  policy: e.policy,
                  lastUsed: e.lastActivityDate ?? DateTime.now(),
                  hasPassword: e.hasPassword ?? false,
                  hasConfiguredPassword: e.hasConfiguredPassword ?? false,
                );
              },
            ).toList(),
          ),
        );
  }

  Future<List<DeviceInfoDto>?> getAllDevices() async {
    return (await api.devicesGet(
      userId: account?.id,
    ))
        .body
        ?.items;
  }

  Future<List<ParentalRating>?> getParentalRatings() async {
    return (await api.localizationParentalRatingsGet()).body;
  }

  Future<Response<UserDto>> createNewUser(CreateUserByName user) => api.usersNewPost(body: user);

  Future<Response<dynamic>> setUserPolicy({required String id, required UserPolicy? policy}) =>
      api.usersUserIdPolicyPost(
        userId: id,
        body: policy,
      );

  Future<Response<BaseItemDtoQueryResult>> libraryMediaFolders() => api.libraryMediaFoldersGet();

  Future<Response<AuthenticationResult>> usersAuthenticateByNamePost({
    required String userName,
    required String password,
  }) async {
    return api.usersAuthenticateByNamePost(body: AuthenticateUserByName(username: userName, pw: password));
  }

  Future<void> deleteUser(String userId) => api.usersUserIdDelete(userId: userId);

  Future<Response<ServerConfiguration>> systemConfigurationGet() => api.systemConfigurationGet();
  Future<Response<PublicSystemInfo>> systemInfoPublicGet() => api.systemInfoPublicGet();
  Future<Response<SystemInfo>> systemInfoGet() => api.systemInfoGet();

  Future<void> systemConfigurationPost(ServerConfiguration serverConfig) =>
      api.systemConfigurationPost(body: serverConfig);

  Future<Response<List<LocalizationOption>>> localizationOptions() => api.localizationOptionsGet();

  Future<void> libraryRefreshPost() => api.libraryRefreshPost();

  Future<void> systemRestartPost() => api.systemRestartPost();
  Future<void> systemShutdownPost() => api.systemShutdownPost();

  Future<Response<ItemCounts>> systemInfoCounts() => api.itemsCountsGet();

  Future<Response<SystemStorageDto>> getStorage() => api.systemInfoStorageGet();

  Future<Response<List<TaskInfo>>> getActiveTasks() => api.scheduledTasksGet();

  Future<Response<List<SessionInfoDto>>> getActiveSessions({
    int timeoutSeconds = 960,
  }) =>
      api.sessionsGet(
        activeWithinSeconds: timeoutSeconds,
      );

  Future<void> stopActiveTask(String taskId) => api.scheduledTasksRunningTaskIdDelete(taskId: taskId);
  Future<void> startTask(String taskId) => api.scheduledTasksRunningTaskIdPost(taskId: taskId);

  Future<Response<dynamic>> updateTaskTriggers(String taskId, {required List<TaskTriggerInfo> triggers}) =>
      api.scheduledTasksTaskIdTriggersPost(
        taskId: taskId,
        body: triggers,
      );

  Future<Response<UserSettings>> getCustomConfig() async {
    final response = await api.displayPreferencesDisplayPreferencesIdGet(
      displayPreferencesId: _userSettings,
      userId: account?.id ?? "",
      $client: _client,
    );
    final customPrefs = response.body?.customPrefs?.parseValues();
    final userPrefs = customPrefs != null ? UserSettings.fromJson(customPrefs) : UserSettings();
    return response.copyWith(
      body: userPrefs,
    );
  }

  Future<Response<dynamic>> setCustomConfig(UserSettings currentSettings) async {
    final currentDisplayPreferences = await api.displayPreferencesDisplayPreferencesIdGet(
      displayPreferencesId: _userSettings,
      $client: _client,
    );
    return api.displayPreferencesDisplayPreferencesIdPost(
      displayPreferencesId: 'usersettings',
      userId: account?.id ?? "",
      $client: _client,
      body: currentDisplayPreferences.body?.copyWith(
        customPrefs: currentSettings.toJson(),
      ),
    );
  }

  Future<Response> sessionsLogoutPost() => api.sessionsLogoutPost();

  Future<Response<String>> itemsItemIdDownloadGet({
    String? itemId,
  }) =>
      api.itemsItemIdDownloadGet(itemId: itemId);

  Future<Response> collectionsCollectionIdItemsPost({required String? collectionId, required List<String>? ids}) =>
      api.collectionsCollectionIdItemsPost(collectionId: collectionId, ids: ids);
  Future<Response> collectionsCollectionIdItemsDelete({required String? collectionId, required List<String>? ids}) =>
      api.collectionsCollectionIdItemsDelete(collectionId: collectionId, ids: ids);

  Future<Response> collectionsPost({String? name, List<String>? ids, String? parentId, bool? isLocked}) =>
      api.collectionsPost(name: name, ids: ids, parentId: parentId, isLocked: isLocked);

  Future<Response<BaseItemDtoQueryResult>> usersUserIdViewsGet({
    bool? includeExternalContent,
    List<CollectionType>? presetViews,
    bool? includeHidden,
  }) =>
      api.userViewsGet(
          userId: account?.id,
          includeExternalContent: includeExternalContent,
          presetViews: presetViews,
          includeHidden: includeHidden);

  Future<Response<List<ExternalIdInfo>>> itemsItemIdExternalIdInfosGet({required String? itemId}) =>
      api.itemsItemIdExternalIdInfosGet(itemId: itemId);

  Future<Response<List<RemoteSearchResult>>> itemsRemoteSearchSeriesPost(
          {required SeriesInfoRemoteSearchQuery? body}) =>
      api.itemsRemoteSearchSeriesPost(body: body);

  Future<Response<List<RemoteSearchResult>>> itemsRemoteSearchMoviePost({required MovieInfoRemoteSearchQuery? body}) =>
      api.itemsRemoteSearchMoviePost(body: body);

  Future<Response<dynamic>> itemsRemoteSearchApplyItemIdPost({
    required String? itemId,
    bool? replaceAllImages,
    required RemoteSearchResult? body,
  }) =>
      api.itemsRemoteSearchApplyItemIdPost(
        itemId: itemId,
        replaceAllImages: replaceAllImages,
        body: body,
      );

  Future<Response<BaseItemDtoQueryResult>> showsSeriesIdSeasonsGet({
    required String? seriesId,
    bool? enableUserData,
    bool? isMissing,
    List<ItemFields>? fields,
  }) async {
    try {
      final response = await api.showsSeriesIdSeasonsGet(
        seriesId: seriesId,
        isMissing: isMissing,
        enableUserData: enableUserData,
        fields: [
          ...?fields,
          ItemFields.parentid,
        ],
      );
      return response;
    } catch (e) {
      final seriesItem = await ref.read(syncProvider.notifier).getSyncedItem(seriesId);
      if (seriesItem != null) {
        final seasons = await ref.read(syncProvider.notifier).getChildren(seriesItem.id);
        return Response<BaseItemDtoQueryResult>(
          http.Response("", 200),
          BaseItemDtoQueryResult(
            items: seasons.map((e) => e.data).nonNulls.toList(),
            totalRecordCount: seasons.length,
            startIndex: 0,
          ),
        );
      } else {
        return Response<BaseItemDtoQueryResult>(
          http.Response("", 400),
          const BaseItemDtoQueryResult(
            items: [],
            totalRecordCount: 0,
            startIndex: 0,
          ),
        );
      }
    }
  }

  Future<Response<QueryFilters>> itemsFilters2Get({
    String? parentId,
    List<BaseItemKind>? includeItemTypes,
    bool? isAiring,
    bool? isMovie,
    bool? isSports,
    bool? isKids,
    bool? isNews,
    bool? isSeries,
    bool? recursive,
  }) =>
      api.itemsFilters2Get(
        parentId: parentId,
        includeItemTypes: includeItemTypes,
        isAiring: isAiring,
        isMovie: isMovie,
        isSports: isSports,
        isKids: isKids,
        isNews: isNews,
        isSeries: isSeries,
        recursive: recursive,
      );

  Future<Response<BaseItemDtoQueryResult>> studiosGet({
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<ItemFields>? fields,
    List<BaseItemKind>? excludeItemTypes,
    List<BaseItemKind>? includeItemTypes,
    bool? isFavorite,
    bool? enableUserData,
    int? imageTypeLimit,
    List<ImageType>? enableImageTypes,
    String? userId,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    bool? enableImages,
    bool? enableTotalRecordCount,
  }) =>
      api.studiosGet(
        startIndex: startIndex,
        limit: limit,
        searchTerm: searchTerm,
        parentId: parentId,
        fields: fields,
        excludeItemTypes: excludeItemTypes,
        includeItemTypes: includeItemTypes,
        isFavorite: isFavorite,
        enableUserData: enableUserData,
        imageTypeLimit: imageTypeLimit,
        enableImageTypes: enableImageTypes,
        nameStartsWithOrGreater: nameStartsWithOrGreater,
        nameStartsWith: nameStartsWith,
        nameLessThan: nameLessThan,
        enableImages: enableImages,
        enableTotalRecordCount: enableTotalRecordCount,
      );

  Future<Response<ServerQueryResult>> playlistsPlaylistIdItemsGet({
    required String? playlistId,
    int? startIndex,
    int? limit,
    List<ItemFields>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<ImageType>? enableImageTypes,
  }) async {
    final response = await api.playlistsPlaylistIdItemsGet(
      playlistId: playlistId,
      userId: account?.id,
      startIndex: startIndex,
      limit: limit,
      fields: fields,
      enableImages: enableImages,
      enableUserData: enableUserData,
      imageTypeLimit: imageTypeLimit,
      enableImageTypes: enableImageTypes,
    );
    return response.copyWith(
      body: ServerQueryResult.fromBaseQuery(response.bodyOrThrow, ref),
    );
  }

  Future<Response> playlistsPlaylistIdItemsDelete({required String? playlistId, List<String>? entryIds}) =>
      api.playlistsPlaylistIdItemsDelete(
        playlistId: playlistId,
        entryIds: entryIds,
      );

  Future<Response<UserDto>> usersMeGet() => api.usersMeGet();

  Future<Response> configuration() => api.systemConfigurationGet();

  Future<Response> itemsItemIdRefreshPost({
    required String? itemId,
    MetadataRefresh? metadataRefreshMode,
    MetadataRefresh? imageRefreshMode,
    bool? replaceAllMetadata,
    bool? replaceAllImages,
    bool? replaceTrickplayImages,
  }) =>
      api.itemsItemIdRefreshPost(
        itemId: itemId,
        metadataRefreshMode: metadataRefreshMode?.metadataRefreshMode,
        imageRefreshMode: imageRefreshMode?.imageRefreshMode,
        replaceAllMetadata: replaceAllMetadata,
        replaceAllImages: replaceAllImages,
        regenerateTrickplay: replaceTrickplayImages,
      );

  Future<Response<UserItemDataDto>> usersUserIdFavoriteItemsItemIdPost({
    required String? itemId,
  }) async {
    Response<UserItemDataDto>? response;
    try {
      response = await api.userFavoriteItemsItemIdPost(
        itemId: itemId,
        userId: account?.id,
      );
    } finally {
      await ref
          .read(syncProvider.notifier)
          .updateFavoriteItem(itemId, isFavorite: true, responseSuccessful: response?.isSuccessful ?? false);
    }
    return response;
  }

  Future<Response<UserItemDataDto>> usersUserIdFavoriteItemsItemIdDelete({
    required String? itemId,
  }) async {
    Response<UserItemDataDto>? response;
    try {
      response = await api.userFavoriteItemsItemIdDelete(
        itemId: itemId,
        userId: account?.id,
      );
    } finally {
      await ref
          .read(syncProvider.notifier)
          .updateFavoriteItem(itemId, isFavorite: false, responseSuccessful: response?.isSuccessful ?? false);
    }
    return response;
  }

  Future<Response<UserItemDataDto>> usersUserIdPlayedItemsItemIdPost({
    required String? itemId,
    DateTime? datePlayed,
  }) async {
    Response<UserItemDataDto>? response;
    try {
      response = await api.userPlayedItemsItemIdPost(itemId: itemId, userId: account?.id, datePlayed: datePlayed);
    } finally {
      await ref.read(syncProvider.notifier).updatePlayedItem(
            itemId,
            datePlayed: datePlayed,
            played: true,
            responseSuccessful: response?.isSuccessful ?? false,
          );
    }
    return response;
  }

  Future<Response<UserItemDataDto>> usersUserIdPlayedItemsItemIdDelete({
    required String? itemId,
  }) async {
    Response<UserItemDataDto>? response;
    try {
      response = await api.userPlayedItemsItemIdDelete(
        itemId: itemId,
        userId: account?.id,
      );
    } finally {
      await ref.read(syncProvider.notifier).updatePlayedItem(
            itemId,
            played: false,
            responseSuccessful: response?.isSuccessful ?? false,
          );
    }

    return response;
  }

  Future<Response<MediaSegmentsModel>?> mediaSegmentsGet({
    required String id,
  }) async {
    try {
      final response = await api.mediaSegmentsItemIdGet(itemId: id);
      final newSegments = response.body?.items?.map((e) => e.toSegment).toList() ?? [];
      return response.copyWith(
        body: MediaSegmentsModel(segments: newSegments),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<Response<TrickPlayModel>?> getTrickPlay({
    required ItemBaseModel? item,
    int? width,
    required Ref ref,
  }) async {
    try {
      if (item == null) return null;
      if (item.overview.trickPlayInfo?.isEmpty == true) {
        return null;
      }
      final trickPlayModel = item.overview.trickPlayInfo?.values.lastOrNull;
      if (trickPlayModel == null) return null;
      final response = await api.videosItemIdTrickplayWidthTilesM3u8Get(
        itemId: item.id,
        width: trickPlayModel.width,
      );

      final server = ref.read(serverUrlProvider);

      if (server == null) return null;

      final sanitizedUrls = response.bodyString
          .split('\n')
          .where((line) => line.isNotEmpty && !line.startsWith('#'))
          .map((line) => line.trim())
          .map((line) => Uri.parse(line).toString())
          .toList();

      return response.copyWith(
          body: trickPlayModel.copyWith(
              images: sanitizedUrls
                  .map(
                    (e) => joinAll([server, 'Videos/${item.id}/Trickplay/${trickPlayModel.width}', e]),
                  )
                  .toList()));
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<Response<List<SessionInfoDto>>> sessionsInfo(String deviceId) async => api.sessionsGet(deviceId: deviceId);

  Future<Response<bool>> quickConnect(String code) async => api.quickConnectAuthorizePost(code: code);

  Future<Response<bool>> quickConnectEnabled() async => api.quickConnectEnabledGet();

  Future<Response<BrandingOptionsDto>> getBranding() async => api.brandingConfigurationGet();

  Future<Response<dynamic>> deleteItem(String itemId) => api.itemsItemIdDelete(itemId: itemId);

  Future<UserConfiguration?> _updateUserConfiguration(UserConfiguration newUserConfiguration) async {
    if (account?.id == null) return null;

    final response = await api.usersConfigurationPost(
      userId: account!.id,
      body: newUserConfiguration,
    );

    if (response.isSuccessful) {
      return newUserConfiguration;
    }
    return null;
  }

  Future<UserConfiguration?> updateRememberAudioSelections() {
    final currentUserConfiguration = account?.userConfiguration;
    if (currentUserConfiguration == null) return Future.value(null);

    final updated = currentUserConfiguration.copyWith(
      rememberAudioSelections: !(currentUserConfiguration.rememberAudioSelections ?? false),
    );
    return _updateUserConfiguration(updated);
  }

  Future<UserConfiguration?> updateRememberSubtitleSelections() {
    final current = account?.userConfiguration;
    if (current == null) return Future.value(null);

    final updated = current.copyWith(
      rememberSubtitleSelections: !(current.rememberSubtitleSelections ?? false),
    );
    return _updateUserConfiguration(updated);
  }

  Future<Response<QuickConnectResult>> quickConnectInitiate() async {
    return api.quickConnectInitiatePost();
  }

  Future<Response<QuickConnectResult>> quickConnectConnectGet({
    String? secret,
  }) async {
    return api.quickConnectConnectGet(secret: secret);
  }

  Future<Response<AuthenticationResult>> quickConnectAuthenticate(String secret) async {
    return api.usersAuthenticateWithQuickConnectPost(
      body: QuickConnectDto(secret: secret),
    );
  }

  Future<Response<dynamic>> resetPassword({
    required String userId,
  }) {
    return api.usersPasswordPost(
      userId: userId,
      body: const UpdateUserPassword(
        resetPassword: true,
      ),
    );
  }

  Future<Response<dynamic>> setNewPassword({
    String? userId,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return api.usersPasswordPost(
      userId: userId,
      body: UpdateUserPassword(
        currentPassword: currentPassword,
        newPw: newPassword,
        currentPw: confirmPassword,
      ),
    );
  }
}

extension ParsedMap on Map<String, dynamic> {
  Map<String, dynamic> parseValues() {
    Map<String, dynamic> parsedMap = {};

    for (var entry in entries) {
      String key = entry.key;
      dynamic value = entry.value;

      if (value is String) {
        // Try to parse the string to a number or boolean
        if (int.tryParse(value) != null) {
          parsedMap[key] = int.tryParse(value);
        } else if (double.tryParse(value) != null) {
          parsedMap[key] = double.tryParse(value);
        } else if (value.toLowerCase() == 'true' || value.toLowerCase() == 'false') {
          parsedMap[key] = value.toLowerCase() == 'true';
        } else {
          parsedMap[key] = value;
        }
      } else {
        parsedMap[key] = value;
      }
    }

    return parsedMap;
  }
}
