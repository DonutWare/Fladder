// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerr_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeerrStatus _$SeerrStatusFromJson(Map<String, dynamic> json) => SeerrStatus(
      version: json['version'] as String?,
      commitTag: json['commitTag'] as String?,
      updateAvailable: json['updateAvailable'] as bool?,
      commitsBehind: (json['commitsBehind'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeerrStatusToJson(SeerrStatus instance) =>
    <String, dynamic>{
      'version': instance.version,
      'commitTag': instance.commitTag,
      'updateAvailable': instance.updateAvailable,
      'commitsBehind': instance.commitsBehind,
    };

SeerrUserQuota _$SeerrUserQuotaFromJson(Map<String, dynamic> json) =>
    SeerrUserQuota(
      movie: json['movie'] == null
          ? null
          : SeerrQuotaEntry.fromJson(json['movie'] as Map<String, dynamic>),
      tv: json['tv'] == null
          ? null
          : SeerrQuotaEntry.fromJson(json['tv'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeerrUserQuotaToJson(SeerrUserQuota instance) =>
    <String, dynamic>{
      'movie': instance.movie,
      'tv': instance.tv,
    };

SeerrQuotaEntry _$SeerrQuotaEntryFromJson(Map<String, dynamic> json) =>
    SeerrQuotaEntry(
      days: (json['days'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      used: (json['used'] as num?)?.toInt(),
      remaining: (json['remaining'] as num?)?.toInt(),
      restricted: json['restricted'] as bool?,
    );

Map<String, dynamic> _$SeerrQuotaEntryToJson(SeerrQuotaEntry instance) =>
    <String, dynamic>{
      'days': instance.days,
      'limit': instance.limit,
      'used': instance.used,
      'remaining': instance.remaining,
      'restricted': instance.restricted,
    };

SeerrUserSettings _$SeerrUserSettingsFromJson(Map<String, dynamic> json) =>
    SeerrUserSettings(
      locale: json['locale'] as String?,
      region: json['region'] as String?,
      originalLanguage: json['originalLanguage'] as String?,
    );

Map<String, dynamic> _$SeerrUserSettingsToJson(SeerrUserSettings instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'region': instance.region,
      'originalLanguage': instance.originalLanguage,
    };

SeerrUsersResponse _$SeerrUsersResponseFromJson(Map<String, dynamic> json) =>
    SeerrUsersResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => SeerrUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageInfo: json['pageInfo'] == null
          ? null
          : SeerrPageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeerrUsersResponseToJson(SeerrUsersResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'pageInfo': instance.pageInfo,
    };

SeerrMovieDetails _$SeerrMovieDetailsFromJson(Map<String, dynamic> json) =>
    SeerrMovieDetails(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      originalTitle: json['originalTitle'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
      releaseDate: json['releaseDate'] as String?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: (json['voteCount'] as num?)?.toInt(),
      runtime: (json['runtime'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => SeerrGenre.fromJson(e as Map<String, dynamic>))
          .toList(),
      mediaInfo: json['mediaInfo'] == null
          ? null
          : SeerrMediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
      externalIds: json['externalIds'] == null
          ? null
          : SeerrExternalIds.fromJson(
              json['externalIds'] as Map<String, dynamic>),
      mediaId: _readJellyfinMediaId(json, 'mediaId') as String?,
    );

Map<String, dynamic> _$SeerrMovieDetailsToJson(SeerrMovieDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'originalTitle': instance.originalTitle,
      'overview': instance.overview,
      'posterPath': instance.posterPath,
      'backdropPath': instance.backdropPath,
      'releaseDate': instance.releaseDate,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'mediaInfo': instance.mediaInfo,
      'externalIds': instance.externalIds,
      'mediaId': instance.mediaId,
    };

SeerrTvDetails _$SeerrTvDetailsFromJson(Map<String, dynamic> json) =>
    SeerrTvDetails(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      originalName: json['originalName'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
      firstAirDate: json['firstAirDate'] as String?,
      lastAirDate: json['lastAirDate'] as String?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: (json['voteCount'] as num?)?.toInt(),
      numberOfSeasons: (json['numberOfSeasons'] as num?)?.toInt(),
      numberOfEpisodes: (json['numberOfEpisodes'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => SeerrGenre.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeerrSeason.fromJson(e as Map<String, dynamic>))
          .toList(),
      mediaInfo: json['mediaInfo'] == null
          ? null
          : SeerrMediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
      externalIds: json['externalIds'] == null
          ? null
          : SeerrExternalIds.fromJson(
              json['externalIds'] as Map<String, dynamic>),
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => SeerrKeyword.fromJson(e as Map<String, dynamic>))
          .toList(),
      mediaId: _readJellyfinMediaId(json, 'mediaId') as String?,
    );

Map<String, dynamic> _$SeerrTvDetailsToJson(SeerrTvDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'originalName': instance.originalName,
      'overview': instance.overview,
      'posterPath': instance.posterPath,
      'backdropPath': instance.backdropPath,
      'firstAirDate': instance.firstAirDate,
      'lastAirDate': instance.lastAirDate,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
      'numberOfSeasons': instance.numberOfSeasons,
      'numberOfEpisodes': instance.numberOfEpisodes,
      'genres': instance.genres,
      'seasons': instance.seasons,
      'mediaInfo': instance.mediaInfo,
      'externalIds': instance.externalIds,
      'keywords': instance.keywords,
      'mediaId': instance.mediaId,
    };

SeerrGenre _$SeerrGenreFromJson(Map<String, dynamic> json) => SeerrGenre(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SeerrGenreToJson(SeerrGenre instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SeerrKeyword _$SeerrKeywordFromJson(Map<String, dynamic> json) => SeerrKeyword(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SeerrKeywordToJson(SeerrKeyword instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SeerrSeason _$SeerrSeasonFromJson(Map<String, dynamic> json) => SeerrSeason(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
      posterPath: json['posterPath'] as String?,
      episodeCount: (json['episodeCount'] as num?)?.toInt(),
      mediaId: _readJellyfinMediaId(json, 'mediaId') as String?,
    );

Map<String, dynamic> _$SeerrSeasonToJson(SeerrSeason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'seasonNumber': instance.seasonNumber,
      'posterPath': instance.posterPath,
      'episodeCount': instance.episodeCount,
      'mediaId': instance.mediaId,
    };

SeerrDownloadStatusEpisode _$SeerrDownloadStatusEpisodeFromJson(
        Map<String, dynamic> json) =>
    SeerrDownloadStatusEpisode(
      seriesId: (json['seriesId'] as num?)?.toInt(),
      tvdbId: (json['tvdbId'] as num?)?.toInt(),
      episodeFileId: (json['episodeFileId'] as num?)?.toInt(),
      seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
      episodeNumber: (json['episodeNumber'] as num?)?.toInt(),
      title: json['title'] as String?,
      airDate: json['airDate'] as String?,
      airDateUtc: json['airDateUtc'] as String?,
      lastSearchTime: json['lastSearchTime'] as String?,
      runtime: (json['runtime'] as num?)?.toInt(),
      overview: json['overview'] as String?,
      hasFile: json['hasFile'] as bool?,
      monitored: json['monitored'] as bool?,
      absoluteEpisodeNumber: (json['absoluteEpisodeNumber'] as num?)?.toInt(),
      unverifiedSceneNumbering: json['unverifiedSceneNumbering'] as bool?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeerrDownloadStatusEpisodeToJson(
        SeerrDownloadStatusEpisode instance) =>
    <String, dynamic>{
      'seriesId': instance.seriesId,
      'tvdbId': instance.tvdbId,
      'episodeFileId': instance.episodeFileId,
      'seasonNumber': instance.seasonNumber,
      'episodeNumber': instance.episodeNumber,
      'title': instance.title,
      'airDate': instance.airDate,
      'airDateUtc': instance.airDateUtc,
      'lastSearchTime': instance.lastSearchTime,
      'runtime': instance.runtime,
      'overview': instance.overview,
      'hasFile': instance.hasFile,
      'monitored': instance.monitored,
      'absoluteEpisodeNumber': instance.absoluteEpisodeNumber,
      'unverifiedSceneNumbering': instance.unverifiedSceneNumbering,
      'id': instance.id,
    };

SeerrDownloadStatus _$SeerrDownloadStatusFromJson(Map<String, dynamic> json) =>
    SeerrDownloadStatus(
      externalId: (json['externalId'] as num?)?.toInt(),
      estimatedCompletionTime: json['estimatedCompletionTime'] as String?,
      mediaType: json['mediaType'] as String?,
      size: (json['size'] as num?)?.toInt(),
      sizeLeft: (json['sizeLeft'] as num?)?.toInt(),
      status: json['status'] as String?,
      timeLeft: json['timeLeft'] as String?,
      title: json['title'] as String?,
      episode: json['episode'] == null
          ? null
          : SeerrDownloadStatusEpisode.fromJson(
              json['episode'] as Map<String, dynamic>),
      downloadId: json['downloadId'] as String?,
    );

Map<String, dynamic> _$SeerrDownloadStatusToJson(
        SeerrDownloadStatus instance) =>
    <String, dynamic>{
      'externalId': instance.externalId,
      'estimatedCompletionTime': instance.estimatedCompletionTime,
      'mediaType': instance.mediaType,
      'size': instance.size,
      'sizeLeft': instance.sizeLeft,
      'status': instance.status,
      'timeLeft': instance.timeLeft,
      'title': instance.title,
      'episode': instance.episode,
      'downloadId': instance.downloadId,
    };

SeerrMediaInfo _$SeerrMediaInfoFromJson(Map<String, dynamic> json) =>
    SeerrMediaInfo(
      id: (json['id'] as num?)?.toInt(),
      tmdbId: (json['tmdbId'] as num?)?.toInt(),
      tvdbId: (json['tvdbId'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      jellyfinMediaId: json['jellyfinMediaId'] as String?,
      jellyfinMediaId4k: json['jellyfinMediaId4k'] as String?,
      requests: (json['requests'] as List<dynamic>?)
          ?.map((e) => SeerrMediaRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeerrMediaInfoSeason.fromJson(e as Map<String, dynamic>))
          .toList(),
      downloadStatus: (json['downloadStatus'] as List<dynamic>?)
          ?.map((e) => SeerrDownloadStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      downloadStatus4k: (json['downloadStatus4k'] as List<dynamic>?)
          ?.map((e) => SeerrDownloadStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeerrMediaInfoToJson(SeerrMediaInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tmdbId': instance.tmdbId,
      'tvdbId': instance.tvdbId,
      'status': instance.status,
      'jellyfinMediaId': instance.jellyfinMediaId,
      'jellyfinMediaId4k': instance.jellyfinMediaId4k,
      'requests': instance.requests,
      'seasons': instance.seasons,
      'downloadStatus': instance.downloadStatus,
      'downloadStatus4k': instance.downloadStatus4k,
    };

SeerrMediaInfoSeason _$SeerrMediaInfoSeasonFromJson(
        Map<String, dynamic> json) =>
    SeerrMediaInfoSeason(
      id: (json['id'] as num?)?.toInt(),
      seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SeerrMediaInfoSeasonToJson(
        SeerrMediaInfoSeason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seasonNumber': instance.seasonNumber,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

SeerrExternalIds _$SeerrExternalIdsFromJson(Map<String, dynamic> json) =>
    SeerrExternalIds(
      imdbId: json['imdbId'] as String?,
      facebookId: json['facebookId'] as String?,
      instagramId: json['instagramId'] as String?,
      twitterId: json['twitterId'] as String?,
    );

Map<String, dynamic> _$SeerrExternalIdsToJson(SeerrExternalIds instance) =>
    <String, dynamic>{
      'imdbId': instance.imdbId,
      'facebookId': instance.facebookId,
      'instagramId': instance.instagramId,
      'twitterId': instance.twitterId,
    };

SeerrRequestsResponse _$SeerrRequestsResponseFromJson(
        Map<String, dynamic> json) =>
    SeerrRequestsResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => SeerrMediaRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageInfo: json['pageInfo'] == null
          ? null
          : SeerrPageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeerrRequestsResponseToJson(
        SeerrRequestsResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'pageInfo': instance.pageInfo,
    };

SeerrMediaRequest _$SeerrMediaRequestFromJson(Map<String, dynamic> json) =>
    SeerrMediaRequest(
      id: (json['id'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      media: json['media'] == null
          ? null
          : SeerrMedia.fromJson(json['media'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      requestedBy: json['requestedBy'] == null
          ? null
          : SeerrUserModel.fromJson(
              json['requestedBy'] as Map<String, dynamic>),
      modifiedBy: json['modifiedBy'] == null
          ? null
          : SeerrUserModel.fromJson(json['modifiedBy'] as Map<String, dynamic>),
      is4k: json['is4k'] as bool?,
      seasons: _parseRequestSeasons(json['seasons'] as List?),
      serverId: (json['serverId'] as num?)?.toInt(),
      profileId: (json['profileId'] as num?)?.toInt(),
      rootFolder: json['rootFolder'] as String?,
    );

Map<String, dynamic> _$SeerrMediaRequestToJson(SeerrMediaRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'media': instance.media,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'requestedBy': instance.requestedBy,
      'modifiedBy': instance.modifiedBy,
      'is4k': instance.is4k,
      'seasons': instance.seasons,
      'serverId': instance.serverId,
      'profileId': instance.profileId,
      'rootFolder': instance.rootFolder,
    };

SeerrPageInfo _$SeerrPageInfoFromJson(Map<String, dynamic> json) =>
    SeerrPageInfo(
      pages: (json['pages'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      results: (json['results'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeerrPageInfoToJson(SeerrPageInfo instance) =>
    <String, dynamic>{
      'pages': instance.pages,
      'pageSize': instance.pageSize,
      'results': instance.results,
      'page': instance.page,
    };

SeerrCreateRequestBody _$SeerrCreateRequestBodyFromJson(
        Map<String, dynamic> json) =>
    SeerrCreateRequestBody(
      mediaType: json['mediaType'] as String?,
      mediaId: (json['mediaId'] as num?)?.toInt(),
      is4k: json['is4k'] as bool?,
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      serverId: (json['serverId'] as num?)?.toInt(),
      profileId: (json['profileId'] as num?)?.toInt(),
      rootFolder: json['rootFolder'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeerrCreateRequestBodyToJson(
        SeerrCreateRequestBody instance) =>
    <String, dynamic>{
      'mediaType': instance.mediaType,
      'mediaId': instance.mediaId,
      'is4k': instance.is4k,
      if (instance.seasons case final value?) 'seasons': value,
      'serverId': instance.serverId,
      'profileId': instance.profileId,
      'rootFolder': instance.rootFolder,
      'tags': instance.tags,
      'userId': instance.userId,
    };

SeerrMedia _$SeerrMediaFromJson(Map<String, dynamic> json) => SeerrMedia(
      id: (json['id'] as num?)?.toInt(),
      tmdbId: (json['tmdbId'] as num?)?.toInt(),
      tvdbId: (json['tvdbId'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      mediaType: json['mediaType'] as String?,
      requests: (json['requests'] as List<dynamic>?)
          ?.map((e) => SeerrMediaRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeerrMediaToJson(SeerrMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tmdbId': instance.tmdbId,
      'tvdbId': instance.tvdbId,
      'status': instance.status,
      'mediaType': instance.mediaType,
      'requests': instance.requests,
    };

SeerrMediaResponse _$SeerrMediaResponseFromJson(Map<String, dynamic> json) =>
    SeerrMediaResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => SeerrMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageInfo: json['pageInfo'] == null
          ? null
          : SeerrPageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeerrMediaResponseToJson(SeerrMediaResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'pageInfo': instance.pageInfo,
    };

SeerrDiscoverItem _$SeerrDiscoverItemFromJson(Map<String, dynamic> json) =>
    SeerrDiscoverItem(
      id: (json['id'] as num?)?.toInt(),
      mediaType:
          $enumDecodeNullable(_$SeerrMediaTypeEnumMap, json['mediaType']),
      title: json['title'] as String?,
      name: json['name'] as String?,
      originalTitle: json['originalTitle'] as String?,
      originalName: json['originalName'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
      releaseDate: json['releaseDate'] as String?,
      firstAirDate: json['firstAirDate'] as String?,
      mediaInfo: json['mediaInfo'] == null
          ? null
          : SeerrMediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
      mediaId: _readJellyfinMediaId(json, 'mediaId') as String?,
    );

Map<String, dynamic> _$SeerrDiscoverItemToJson(SeerrDiscoverItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mediaType': _$SeerrMediaTypeEnumMap[instance.mediaType],
      'title': instance.title,
      'name': instance.name,
      'originalTitle': instance.originalTitle,
      'originalName': instance.originalName,
      'overview': instance.overview,
      'posterPath': instance.posterPath,
      'backdropPath': instance.backdropPath,
      'releaseDate': instance.releaseDate,
      'firstAirDate': instance.firstAirDate,
      'mediaInfo': instance.mediaInfo,
      'mediaId': instance.mediaId,
    };

const _$SeerrMediaTypeEnumMap = {
  SeerrMediaType.movie: 'movie',
  SeerrMediaType.tv: 'tv',
  SeerrMediaType.series: 'series',
  SeerrMediaType.person: 'person',
};

SeerrDiscoverResponse _$SeerrDiscoverResponseFromJson(
        Map<String, dynamic> json) =>
    SeerrDiscoverResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => SeerrDiscoverItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalResults: (json['totalResults'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeerrDiscoverResponseToJson(
        SeerrDiscoverResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
    };

SeerrSearchResponse _$SeerrSearchResponseFromJson(Map<String, dynamic> json) =>
    SeerrSearchResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => SeerrDiscoverItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalResults: (json['totalResults'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeerrSearchResponseToJson(
        SeerrSearchResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
    };

SeerrAuthLocalBody _$SeerrAuthLocalBodyFromJson(Map<String, dynamic> json) =>
    SeerrAuthLocalBody(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SeerrAuthLocalBodyToJson(SeerrAuthLocalBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

SeerrAuthJellyfinBody _$SeerrAuthJellyfinBodyFromJson(
        Map<String, dynamic> json) =>
    SeerrAuthJellyfinBody(
      username: json['username'] as String,
      password: json['password'] as String,
      hostname: json['hostname'] as String?,
    );

Map<String, dynamic> _$SeerrAuthJellyfinBodyToJson(
        SeerrAuthJellyfinBody instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      if (instance.hostname case final value?) 'hostname': value,
    };

_SeerrUserModel _$SeerrUserModelFromJson(Map<String, dynamic> json) =>
    _SeerrUserModel(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      username: json['username'] as String?,
      displayName: json['displayName'] as String?,
      plexToken: json['plexToken'] as String?,
      plexUsername: json['plexUsername'] as String?,
      permissions: (json['permissions'] as num?)?.toInt(),
      avatar: json['avatar'] as String?,
      settings: json['settings'] == null
          ? null
          : SeerrUserSettings.fromJson(
              json['settings'] as Map<String, dynamic>),
      movieQuotaLimit: (json['movieQuotaLimit'] as num?)?.toInt(),
      movieQuotaDays: (json['movieQuotaDays'] as num?)?.toInt(),
      tvQuotaLimit: (json['tvQuotaLimit'] as num?)?.toInt(),
      tvQuotaDays: (json['tvQuotaDays'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeerrUserModelToJson(_SeerrUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'displayName': instance.displayName,
      'plexToken': instance.plexToken,
      'plexUsername': instance.plexUsername,
      'permissions': instance.permissions,
      'avatar': instance.avatar,
      'settings': instance.settings,
      'movieQuotaLimit': instance.movieQuotaLimit,
      'movieQuotaDays': instance.movieQuotaDays,
      'tvQuotaLimit': instance.tvQuotaLimit,
      'tvQuotaDays': instance.tvQuotaDays,
    };

_SeerrSonarrServer _$SeerrSonarrServerFromJson(Map<String, dynamic> json) =>
    _SeerrSonarrServer(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hostname: json['hostname'] as String?,
      port: (json['port'] as num?)?.toInt(),
      apiKey: json['apiKey'] as String?,
      useSsl: json['useSsl'] as bool?,
      baseUrl: json['baseUrl'] as String?,
      activeProfileId: (json['activeProfileId'] as num?)?.toInt(),
      activeProfileName: json['activeProfileName'] as String?,
      activeLanguageProfileId:
          (json['activeLanguageProfileId'] as num?)?.toInt(),
      activeDirectory: json['activeDirectory'] as String?,
      activeAnimeProfileId: (json['activeAnimeProfileId'] as num?)?.toInt(),
      activeAnimeLanguageProfileId:
          (json['activeAnimeLanguageProfileId'] as num?)?.toInt(),
      activeAnimeProfileName: json['activeAnimeProfileName'] as String?,
      activeAnimeDirectory: json['activeAnimeDirectory'] as String?,
      is4k: json['is4k'] as bool?,
      isDefault: json['isDefault'] as bool?,
      externalUrl: json['externalUrl'] as String?,
      syncEnabled: json['syncEnabled'] as bool?,
      preventSearch: json['preventSearch'] as bool?,
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((e) => SeerrServiceProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => SeerrServiceTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      rootFolders: (json['rootFolders'] as List<dynamic>?)
          ?.map((e) => SeerrRootFolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeTags: (json['activeTags'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$SeerrSonarrServerToJson(_SeerrSonarrServer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hostname': instance.hostname,
      'port': instance.port,
      'apiKey': instance.apiKey,
      'useSsl': instance.useSsl,
      'baseUrl': instance.baseUrl,
      'activeProfileId': instance.activeProfileId,
      'activeProfileName': instance.activeProfileName,
      'activeLanguageProfileId': instance.activeLanguageProfileId,
      'activeDirectory': instance.activeDirectory,
      'activeAnimeProfileId': instance.activeAnimeProfileId,
      'activeAnimeLanguageProfileId': instance.activeAnimeLanguageProfileId,
      'activeAnimeProfileName': instance.activeAnimeProfileName,
      'activeAnimeDirectory': instance.activeAnimeDirectory,
      'is4k': instance.is4k,
      'isDefault': instance.isDefault,
      'externalUrl': instance.externalUrl,
      'syncEnabled': instance.syncEnabled,
      'preventSearch': instance.preventSearch,
      'profiles': instance.profiles,
      'tags': instance.tags,
      'rootFolders': instance.rootFolders,
      'activeTags': instance.activeTags,
    };

_SeerrSonarrServerResponse _$SeerrSonarrServerResponseFromJson(
        Map<String, dynamic> json) =>
    _SeerrSonarrServerResponse(
      server: json['server'] == null
          ? null
          : SeerrSonarrServer.fromJson(json['server'] as Map<String, dynamic>),
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((e) => SeerrServiceProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      rootFolders: (json['rootFolders'] as List<dynamic>?)
          ?.map((e) => SeerrRootFolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => SeerrServiceTag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeerrSonarrServerResponseToJson(
        _SeerrSonarrServerResponse instance) =>
    <String, dynamic>{
      'server': instance.server,
      'profiles': instance.profiles,
      'rootFolders': instance.rootFolders,
      'tags': instance.tags,
    };

_SeerrRadarrServer _$SeerrRadarrServerFromJson(Map<String, dynamic> json) =>
    _SeerrRadarrServer(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hostname: json['hostname'] as String?,
      port: (json['port'] as num?)?.toInt(),
      apiKey: json['apiKey'] as String?,
      useSsl: json['useSsl'] as bool?,
      baseUrl: json['baseUrl'] as String?,
      activeProfileId: (json['activeProfileId'] as num?)?.toInt(),
      activeProfileName: json['activeProfileName'] as String?,
      activeLanguageProfileId:
          (json['activeLanguageProfileId'] as num?)?.toInt(),
      activeDirectory: json['activeDirectory'] as String?,
      activeAnimeProfileId: (json['activeAnimeProfileId'] as num?)?.toInt(),
      activeAnimeLanguageProfileId:
          (json['activeAnimeLanguageProfileId'] as num?)?.toInt(),
      activeAnimeProfileName: json['activeAnimeProfileName'] as String?,
      activeAnimeDirectory: json['activeAnimeDirectory'] as String?,
      is4k: json['is4k'] as bool?,
      isDefault: json['isDefault'] as bool?,
      externalUrl: json['externalUrl'] as String?,
      syncEnabled: json['syncEnabled'] as bool?,
      preventSearch: json['preventSearch'] as bool?,
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((e) => SeerrServiceProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => SeerrServiceTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      rootFolders: (json['rootFolders'] as List<dynamic>?)
          ?.map((e) => SeerrRootFolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeTags: (json['activeTags'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$SeerrRadarrServerToJson(_SeerrRadarrServer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hostname': instance.hostname,
      'port': instance.port,
      'apiKey': instance.apiKey,
      'useSsl': instance.useSsl,
      'baseUrl': instance.baseUrl,
      'activeProfileId': instance.activeProfileId,
      'activeProfileName': instance.activeProfileName,
      'activeLanguageProfileId': instance.activeLanguageProfileId,
      'activeDirectory': instance.activeDirectory,
      'activeAnimeProfileId': instance.activeAnimeProfileId,
      'activeAnimeLanguageProfileId': instance.activeAnimeLanguageProfileId,
      'activeAnimeProfileName': instance.activeAnimeProfileName,
      'activeAnimeDirectory': instance.activeAnimeDirectory,
      'is4k': instance.is4k,
      'isDefault': instance.isDefault,
      'externalUrl': instance.externalUrl,
      'syncEnabled': instance.syncEnabled,
      'preventSearch': instance.preventSearch,
      'profiles': instance.profiles,
      'tags': instance.tags,
      'rootFolders': instance.rootFolders,
      'activeTags': instance.activeTags,
    };

_SeerrRadarrServerResponse _$SeerrRadarrServerResponseFromJson(
        Map<String, dynamic> json) =>
    _SeerrRadarrServerResponse(
      server: json['server'] == null
          ? null
          : SeerrRadarrServer.fromJson(json['server'] as Map<String, dynamic>),
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((e) => SeerrServiceProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      rootFolders: (json['rootFolders'] as List<dynamic>?)
          ?.map((e) => SeerrRootFolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => SeerrServiceTag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeerrRadarrServerResponseToJson(
        _SeerrRadarrServerResponse instance) =>
    <String, dynamic>{
      'server': instance.server,
      'profiles': instance.profiles,
      'rootFolders': instance.rootFolders,
      'tags': instance.tags,
    };

_SeerrServiceProfile _$SeerrServiceProfileFromJson(Map<String, dynamic> json) =>
    _SeerrServiceProfile(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SeerrServiceProfileToJson(
        _SeerrServiceProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_SeerrServiceTag _$SeerrServiceTagFromJson(Map<String, dynamic> json) =>
    _SeerrServiceTag(
      id: (json['id'] as num?)?.toInt(),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$SeerrServiceTagToJson(_SeerrServiceTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
    };

_SeerrRootFolder _$SeerrRootFolderFromJson(Map<String, dynamic> json) =>
    _SeerrRootFolder(
      id: (json['id'] as num?)?.toInt(),
      freeSpace: (json['freeSpace'] as num?)?.toInt(),
      path: json['path'] as String?,
    );

Map<String, dynamic> _$SeerrRootFolderToJson(_SeerrRootFolder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'freeSpace': instance.freeSpace,
      'path': instance.path,
    };
