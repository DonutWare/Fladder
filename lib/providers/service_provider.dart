import 'dart:developer';
import 'dart:typed_data';

import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

import 'package:fladder/jellyfin/enum_models.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/jellyfin_extension.dart';

final jellyServiceProvider = StateProvider<JellyService>(
  (ref) => JellyService(
    ref,
    JellyfinOpenApi.create(
      interceptors: [
        JellyRequest(ref),
        JellyResponse(ref),
        HttpLoggingInterceptor(level: Level.basic),
      ],
    ),
  ),
);

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
  JellyService(this.ref, this.api);

  final JellyfinOpenApi api;
  final Ref ref;
  AccountModel? get account => ref.read(userProvider);

  Future<Response<ItemBaseModel>> usersUserIdItemsItemIdGet({
    String? itemId,
  }) async {
    final response = await api.itemsItemIdGet(
      userId: account?.id,
      itemId: itemId,
    );
    return response.copyWith(body: ItemBaseModel.fromBaseDto(response.bodyOrThrow, ref));
  }

  Future<Response<BaseItemDto>> usersUserIdItemsItemIdGetBaseItem({
    String? itemId,
  }) async {
    final response = await api.itemsItemIdGet(
      userId: account?.id,
      itemId: itemId,
    );
    return response;
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
    final response = await api.itemsGet(
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
          .toList(),
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
    return api.itemsLatestGet(
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
    Duration? totalDuration,
  }) async {
    final position = body?.positionTicks;
    final totalTime = totalDuration?.toRuntimeTicks;
    final maxTime = ref.read(userProvider.select((value) => value?.serverConfiguration?.maxResumePct ?? 90));

    final response = await api.sessionsPlayingStoppedPost(
      body: body?.copyWith(
        failed: false,
      ),
    );

    //This is a temporary fix
    if (totalTime != null && position != null && position > (totalTime * (maxTime / 100))) {
      await usersUserIdPlayedItemsItemIdPost(itemId: body?.itemId, datePlayed: DateTime.now());
    }

    return response;
  }

  Future<Response> sessionsPlayingProgressPost({required PlaybackProgressInfo? body}) async =>
      api.sessionsPlayingProgressPost(body: body);

  Future<Response<PlaybackInfoResponse>> itemsItemIdPlaybackInfoPost({
    required String? itemId,
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
  }) async =>
      api.itemsItemIdPlaybackInfoPost(
        itemId: itemId,
        userId: account?.id,
        enableDirectPlay: enableDirectPlay,
        enableDirectStream: enableDirectStream,
        enableTranscoding: enableTranscoding,
        autoOpenLiveStream: autoOpenLiveStream,
        maxStreamingBitrate: maxStreamingBitrate,
        liveStreamId: liveStreamId,
        startTimeTicks: startTimeTicks,
        mediaSourceId: mediaSourceId,
        audioStreamIndex: audioStreamIndex,
        subtitleStreamIndex: subtitleStreamIndex,
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
    return api.showsSeriesIdEpisodesGet(
      seriesId: seriesId,
      userId: account?.id,
      fields: fields,
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
    return api.itemsItemIdSimilarGet(
      userId: account?.id,
      itemId: itemId,
      limit: limit,
    );
  }

  Future<Response<BaseItemDtoQueryResult>> usersUserIdItemsGet({
    String? parentId,
    bool? recursive,
    List<BaseItemKind>? includeItemTypes,
  }) async {
    return api.itemsGet(
      parentId: parentId,
      userId: account?.id,
      recursive: recursive,
      includeItemTypes: includeItemTypes,
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

  Future<Response<AuthenticationResult>> usersAuthenticateByNamePost({
    required String userName,
    required String password,
  }) async {
    return api.usersAuthenticateByNamePost(body: AuthenticateUserByName(username: userName, pw: password));
  }

  Future<Response<ServerConfiguration>> systemConfigurationGet() => api.systemConfigurationGet();
  Future<Response<PublicSystemInfo>> systemInfoPublicGet() => api.systemInfoPublicGet();

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
  }) =>
      api.showsSeriesIdSeasonsGet(
        seriesId: seriesId,
        isMissing: isMissing,
        enableUserData: enableUserData,
        fields: fields,
      );

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
  }) =>
      api.itemsItemIdRefreshPost(
        itemId: itemId,
        metadataRefreshMode: metadataRefreshMode?.metadataRefreshMode,
        imageRefreshMode: imageRefreshMode?.imageRefreshMode,
        replaceAllMetadata: replaceAllMetadata,
        replaceAllImages: replaceAllImages,
      );

  Future<Response<UserItemDataDto>> usersUserIdFavoriteItemsItemIdPost({
    required String? itemId,
  }) =>
      api.userFavoriteItemsItemIdPost(
        itemId: itemId,
        userId: account?.id,
      );

  Future<Response<UserItemDataDto>> usersUserIdFavoriteItemsItemIdDelete({
    required String? itemId,
  }) =>
      api.userFavoriteItemsItemIdDelete(
        itemId: itemId,
        userId: account?.id,
      );

  Future<Response<UserItemDataDto>> usersUserIdPlayedItemsItemIdPost({
    required String? itemId,
    DateTime? datePlayed,
  }) =>
      api.userPlayedItemsItemIdPost(itemId: itemId, userId: account?.id, datePlayed: datePlayed);

  Future<Response<UserItemDataDto>> usersUserIdPlayedItemsItemIdDelete({
    required String? itemId,
  }) =>
      api.userPlayedItemsItemIdDelete(
        itemId: itemId,
        userId: account?.id,
      );

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

      final server = ref.read(userProvider)?.server;

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

  Future<Response<dynamic>> deleteItem(String itemId) => api.itemsItemIdDelete(itemId: itemId);
}
