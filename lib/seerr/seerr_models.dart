import 'package:freezed_annotation/freezed_annotation.dart';

part 'seerr_models.freezed.dart';
part 'seerr_models.g.dart';

enum MediaFilter {
  all,
  available,
  partial,
  allavailable,
  processing,
}

extension MediaFilterExtension on MediaFilter {
  String get value {
    switch (this) {
      case MediaFilter.all:
        return 'all';
      case MediaFilter.available:
        return 'available';
      case MediaFilter.partial:
        return 'partial';
      case MediaFilter.allavailable:
        return 'allavailable';
      case MediaFilter.processing:
        return 'processing';
    }
  }
}

enum MediaSort {
  mediaadded,
  modified,
}

extension MediaSortExtension on MediaSort {
  String get value {
    switch (this) {
      case MediaSort.mediaadded:
        return 'mediaAdded';
      case MediaSort.modified:
        return 'modified';
    }
  }
}

enum RequestFilter {
  all,
  approved,
  available,
  pending,
  processing,
  unavailable,
}

extension RequestFilterExtension on RequestFilter {
  String get value => name;
}

enum RequestSort {
  added,
  modified,
}

extension RequestSortExtension on RequestSort {
  String get value => name;
}

enum SortDirection {
  asc,
  desc,
}

extension SortDirectionExtension on SortDirection {
  String get value => name;
}

enum DiscoverSortBy {
  popularityAsc,
  popularityDesc,
  releaseDateAsc,
  releaseDateDesc,
}

extension DiscoverSortByExtension on DiscoverSortBy {
  String get value {
    switch (this) {
      case DiscoverSortBy.popularityAsc:
        return 'popularity.asc';
      case DiscoverSortBy.popularityDesc:
        return 'popularity.desc';
      case DiscoverSortBy.releaseDateAsc:
        return 'release_date.asc';
      case DiscoverSortBy.releaseDateDesc:
        return 'release_date.desc';
    }
  }
}

@JsonSerializable()
class SeerrStatus {
  final String? version;
  final String? commitTag;
  final bool? updateAvailable;
  final int? commitsBehind;

  SeerrStatus({
    this.version,
    this.commitTag,
    this.updateAvailable,
    this.commitsBehind,
  });

  factory SeerrStatus.fromJson(Map<String, dynamic> json) => _$SeerrStatusFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrStatusToJson(this);
}

@JsonSerializable()
class SeerrUserModel {
  final int? id;
  final String? email;
  final String? username;
  final String? displayName;
  final String? plexToken;
  final String? plexUsername;
  final int? permissions;
  final String? avatar;
  final SeerrUserSettings? settings;
  final int? movieQuotaLimit;
  final int? movieQuotaDays;
  final int? tvQuotaLimit;
  final int? tvQuotaDays;

  SeerrUserModel({
    this.id,
    this.email,
    this.username,
    this.displayName,
    this.plexToken,
    this.plexUsername,
    this.permissions,
    this.avatar,
    this.settings,
    this.movieQuotaLimit,
    this.movieQuotaDays,
    this.tvQuotaLimit,
    this.tvQuotaDays,
  });

  factory SeerrUserModel.fromJson(Map<String, dynamic> json) => _$SeerrUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrUserModelToJson(this);
}

@JsonSerializable()
class SeerrUserQuota {
  final SeerrQuotaEntry? movie;
  final SeerrQuotaEntry? tv;

  SeerrUserQuota({this.movie, this.tv});

  factory SeerrUserQuota.fromJson(Map<String, dynamic> json) => _$SeerrUserQuotaFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrUserQuotaToJson(this);
}

@JsonSerializable()
class SeerrQuotaEntry {
  final int? days;
  final int? limit;
  final int? used;
  final int? remaining;
  final bool? restricted;

  bool get hasRestrictions => restricted == true || limit != 0;

  SeerrQuotaEntry({this.days, this.limit, this.used, this.remaining, this.restricted});

  factory SeerrQuotaEntry.fromJson(Map<String, dynamic> json) => _$SeerrQuotaEntryFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrQuotaEntryToJson(this);
}

//Taken from https://github.com/seerr-team/seerr/blob/develop/server/lib/permissions.ts
enum SeerrPermission {
  none(0),
  admin(2),
  manageSettings(4),
  manageUsers(8),
  manageRequests(16),
  request(32),
  vote(64),
  autoApprove(128),
  autoApproveMovie(256),
  autoApproveTv(512),
  request4k(1024),
  request4kMovie(2048),
  request4kTv(4096),
  requestAdvanced(8192),
  requestView(16384),
  autoApprove4k(32768),
  autoApprove4kMovie(65536),
  autoApprove4kTv(131072),
  requestMovie(262144),
  requestTv(524288),
  manageIssues(1048576),
  viewIssues(2097152),
  createIssues(4194304),
  autoRequest(8388608),
  autoRequestMovie(16777216),
  autoRequestTv(33554432),
  recentView(67108864),
  watchlistView(134217728),
  manageBlacklist(268435456),
  viewBlacklist(1073741824);

  const SeerrPermission(this.bit);

  final int bit;
}

extension SeerrUserLabelExtension on SeerrUserModel {
  String get label => displayName ?? username ?? email ?? 'Unknown';
}

extension SeerrUserPermissions on SeerrUserModel {
  int get _permissionValue => permissions ?? 0;

  bool get isAdmin => (_permissionValue & SeerrPermission.admin.bit) == SeerrPermission.admin.bit;

  bool hasPermission(SeerrPermission permission) =>
      isAdmin ? true : (_permissionValue & permission.bit) == permission.bit;

  bool get canManageRequests =>
      isAdmin || hasPermission(SeerrPermission.manageRequests) || hasPermission(SeerrPermission.requestAdvanced);

  bool canRequestMedia({required bool isTv}) {
    final baseRequest = hasPermission(SeerrPermission.request);
    if (isTv) return baseRequest || hasPermission(SeerrPermission.requestTv);
    return baseRequest || hasPermission(SeerrPermission.requestMovie);
  }
}

@JsonSerializable()
class SeerrUserSettings {
  final String? locale;
  final String? region;
  final String? originalLanguage;

  SeerrUserSettings({
    this.locale,
    this.region,
    this.originalLanguage,
  });

  factory SeerrUserSettings.fromJson(Map<String, dynamic> json) => _$SeerrUserSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrUserSettingsToJson(this);
}

@JsonSerializable()
class SeerrUsersResponse {
  final List<SeerrUserModel>? results;
  final SeerrPageInfo? pageInfo;

  SeerrUsersResponse({
    this.results,
    this.pageInfo,
  });

  factory SeerrUsersResponse.fromJson(Map<String, dynamic> json) => _$SeerrUsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrUsersResponseToJson(this);
}

abstract class SeerrServer {
  int? get id;
  String? get name;
  String? get hostname;
  int? get port;
  String? get apiKey;
  bool? get useSsl;
  String? get baseUrl;
  int? get activeProfileId;
  String? get activeProfileName;
  int? get activeLanguageProfileId;
  String? get activeDirectory;
  int? get activeAnimeProfileId;
  int? get activeAnimeLanguageProfileId;
  String? get activeAnimeProfileName;
  String? get activeAnimeDirectory;
  bool? get is4k;
  bool? get isDefault;
  String? get externalUrl;
  bool? get syncEnabled;
  bool? get preventSearch;
  List<SeerrServiceProfile>? get profiles;
  List<SeerrServiceTag>? get tags;
  List<SeerrRootFolder>? get rootFolders;
  List<int>? get activeTags;
}

@Freezed(copyWith: true, makeCollectionsUnmodifiable: false)
abstract class SeerrSonarrServer with _$SeerrSonarrServer implements SeerrServer {
  const factory SeerrSonarrServer({
    int? id,
    String? name,
    String? hostname,
    int? port,
    String? apiKey,
    bool? useSsl,
    String? baseUrl,
    int? activeProfileId,
    String? activeProfileName,
    int? activeLanguageProfileId,
    String? activeDirectory,
    int? activeAnimeProfileId,
    int? activeAnimeLanguageProfileId,
    String? activeAnimeProfileName,
    String? activeAnimeDirectory,
    bool? is4k,
    bool? isDefault,
    String? externalUrl,
    bool? syncEnabled,
    bool? preventSearch,
    List<SeerrServiceProfile>? profiles,
    List<SeerrServiceTag>? tags,
    List<SeerrRootFolder>? rootFolders,
    List<int>? activeTags,
  }) = _SeerrSonarrServer;

  factory SeerrSonarrServer.fromJson(Map<String, dynamic> json) => _$SeerrSonarrServerFromJson(json);
}

@Freezed(copyWith: true, makeCollectionsUnmodifiable: false)
abstract class SeerrSonarrServerResponse with _$SeerrSonarrServerResponse {
  const factory SeerrSonarrServerResponse({
    SeerrSonarrServer? server,
    List<SeerrServiceProfile>? profiles,
    List<SeerrRootFolder>? rootFolders,
    List<SeerrServiceTag>? tags,
  }) = _SeerrSonarrServerResponse;

  factory SeerrSonarrServerResponse.fromJson(Map<String, dynamic> json) => _$SeerrSonarrServerResponseFromJson(json);
}

@Freezed(copyWith: true, makeCollectionsUnmodifiable: false)
abstract class SeerrRadarrServer with _$SeerrRadarrServer implements SeerrServer {
  const factory SeerrRadarrServer({
    int? id,
    String? name,
    String? hostname,
    int? port,
    String? apiKey,
    bool? useSsl,
    String? baseUrl,
    int? activeProfileId,
    String? activeProfileName,
    int? activeLanguageProfileId,
    String? activeDirectory,
    int? activeAnimeProfileId,
    int? activeAnimeLanguageProfileId,
    String? activeAnimeProfileName,
    String? activeAnimeDirectory,
    bool? is4k,
    bool? isDefault,
    String? externalUrl,
    bool? syncEnabled,
    bool? preventSearch,
    List<SeerrServiceProfile>? profiles,
    List<SeerrServiceTag>? tags,
    List<SeerrRootFolder>? rootFolders,
    List<int>? activeTags,
  }) = _SeerrRadarrServer;

  factory SeerrRadarrServer.fromJson(Map<String, dynamic> json) => _$SeerrRadarrServerFromJson(json);
}

extension SeerrSonarrServerDefaults on SeerrSonarrServer {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get defaultSeriesPath => activeDirectory;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get defaultAnimePath => activeAnimeDirectory;
}

@Freezed(copyWith: true, makeCollectionsUnmodifiable: false)
abstract class SeerrRadarrServerResponse with _$SeerrRadarrServerResponse {
  const factory SeerrRadarrServerResponse({
    SeerrRadarrServer? server,
    List<SeerrServiceProfile>? profiles,
    List<SeerrRootFolder>? rootFolders,
    List<SeerrServiceTag>? tags,
  }) = _SeerrRadarrServerResponse;

  factory SeerrRadarrServerResponse.fromJson(Map<String, dynamic> json) => _$SeerrRadarrServerResponseFromJson(json);
}

@Freezed(copyWith: true, makeCollectionsUnmodifiable: false)
abstract class SeerrServiceProfile with _$SeerrServiceProfile {
  const factory SeerrServiceProfile({
    int? id,
    String? name,
  }) = _SeerrServiceProfile;

  factory SeerrServiceProfile.fromJson(Map<String, dynamic> json) => _$SeerrServiceProfileFromJson(json);
}

@Freezed(copyWith: true, makeCollectionsUnmodifiable: false)
abstract class SeerrServiceTag with _$SeerrServiceTag {
  const factory SeerrServiceTag({
    int? id,
    String? label,
  }) = _SeerrServiceTag;

  factory SeerrServiceTag.fromJson(Map<String, dynamic> json) => _$SeerrServiceTagFromJson(json);
}

@Freezed(copyWith: true, makeCollectionsUnmodifiable: false)
abstract class SeerrRootFolder with _$SeerrRootFolder {
  const factory SeerrRootFolder({
    int? id,
    int? freeSpace,
    String? path,
  }) = _SeerrRootFolder;

  factory SeerrRootFolder.fromJson(Map<String, dynamic> json) => _$SeerrRootFolderFromJson(json);
}

@JsonSerializable()
class SeerrMovieDetails {
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;
  final int? runtime;
  final List<SeerrGenre>? genres;
  final SeerrMediaInfo? mediaInfo;
  final SeerrExternalIds? externalIds;
  @JsonKey(readValue: _readJellyfinMediaId)
  final String? mediaId;

  SeerrMovieDetails({
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.runtime,
    this.genres,
    this.mediaInfo,
    this.externalIds,
    this.mediaId,
  });

  factory SeerrMovieDetails.fromJson(Map<String, dynamic> json) => _$SeerrMovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMovieDetailsToJson(this);
}

@JsonSerializable()
class SeerrTvDetails {
  final int? id;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? firstAirDate;
  final String? lastAirDate;
  final double? voteAverage;
  final int? voteCount;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final List<SeerrGenre>? genres;
  final List<SeerrSeason>? seasons;
  final SeerrMediaInfo? mediaInfo;
  final SeerrExternalIds? externalIds;
  final List<SeerrKeyword>? keywords;
  @JsonKey(readValue: _readJellyfinMediaId)
  final String? mediaId;

  SeerrTvDetails({
    this.id,
    this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.firstAirDate,
    this.lastAirDate,
    this.voteAverage,
    this.voteCount,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.genres,
    this.seasons,
    this.mediaInfo,
    this.externalIds,
    this.keywords,
    this.mediaId,
  });

  factory SeerrTvDetails.fromJson(Map<String, dynamic> json) => _$SeerrTvDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrTvDetailsToJson(this);
}

@JsonSerializable()
class SeerrGenre {
  final int? id;
  final String? name;

  SeerrGenre({
    this.id,
    this.name,
  });

  factory SeerrGenre.fromJson(Map<String, dynamic> json) => _$SeerrGenreFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrGenreToJson(this);
}

@JsonSerializable()
class SeerrKeyword {
  final int? id;
  final String? name;

  SeerrKeyword({
    this.id,
    this.name,
  });

  factory SeerrKeyword.fromJson(Map<String, dynamic> json) => _$SeerrKeywordFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrKeywordToJson(this);
}

@JsonSerializable()
class SeerrSeason {
  final int? id;
  final String? name;
  final String? overview;
  final int? seasonNumber;
  final String? posterPath;
  final int? episodeCount;
  @JsonKey(readValue: _readJellyfinMediaId)
  final String? mediaId;

  SeerrSeason({
    this.id,
    this.name,
    this.overview,
    this.seasonNumber,
    this.posterPath,
    this.episodeCount,
    this.mediaId,
  });

  factory SeerrSeason.fromJson(Map<String, dynamic> json) => _$SeerrSeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrSeasonToJson(this);
}

Object? _readJellyfinMediaId(Map json, String key) {
  return json['jellyfinMediaId'] ?? json['jellyfinMediaId4k'];
}

@JsonSerializable()
class SeerrDownloadStatusEpisode {
  final int? seriesId;
  final int? tvdbId;
  final int? episodeFileId;
  final int? seasonNumber;
  final int? episodeNumber;
  final String? title;
  final String? airDate;
  final String? airDateUtc;
  final String? lastSearchTime;
  final int? runtime;
  final String? overview;
  final bool? hasFile;
  final bool? monitored;
  final int? absoluteEpisodeNumber;
  final bool? unverifiedSceneNumbering;
  final int? id;

  SeerrDownloadStatusEpisode({
    this.seriesId,
    this.tvdbId,
    this.episodeFileId,
    this.seasonNumber,
    this.episodeNumber,
    this.title,
    this.airDate,
    this.airDateUtc,
    this.lastSearchTime,
    this.runtime,
    this.overview,
    this.hasFile,
    this.monitored,
    this.absoluteEpisodeNumber,
    this.unverifiedSceneNumbering,
    this.id,
  });

  factory SeerrDownloadStatusEpisode.fromJson(Map<String, dynamic> json) => _$SeerrDownloadStatusEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrDownloadStatusEpisodeToJson(this);
}

@JsonSerializable()
class SeerrDownloadStatus {
  final int? externalId;
  final String? estimatedCompletionTime;
  final String? mediaType;
  final int? size;
  final int? sizeLeft;
  final String? status;
  final String? timeLeft;
  final String? title;
  final SeerrDownloadStatusEpisode? episode;
  final String? downloadId;

  SeerrDownloadStatus({
    this.externalId,
    this.estimatedCompletionTime,
    this.mediaType,
    this.size,
    this.sizeLeft,
    this.status,
    this.timeLeft,
    this.title,
    this.episode,
    this.downloadId,
  });

  // Calculate download progress percentage
  double? get progressPercentage {
    if (size == null || size == 0) return null;
    return ((size! - (sizeLeft ?? 0)) / size!) * 100;
  }

  factory SeerrDownloadStatus.fromJson(Map<String, dynamic> json) => _$SeerrDownloadStatusFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrDownloadStatusToJson(this);
}

@JsonSerializable()
class SeerrMediaInfo {
  final int? id;
  final int? tmdbId;
  final int? tvdbId;
  final int? status;
  final String? jellyfinMediaId;
  final String? jellyfinMediaId4k;
  final List<SeerrMediaRequest>? requests;
  final List<SeerrMediaInfoSeason>? seasons;
  final List<SeerrDownloadStatus>? downloadStatus;
  final List<SeerrDownloadStatus>? downloadStatus4k;

  SeerrMediaInfo({
    this.id,
    this.tmdbId,
    this.tvdbId,
    this.status,
    this.jellyfinMediaId,
    this.jellyfinMediaId4k,
    this.requests,
    this.seasons,
    this.downloadStatus,
    this.downloadStatus4k,
  });

  String? get primaryJellyfinMediaId => jellyfinMediaId4k ?? jellyfinMediaId;

  factory SeerrMediaInfo.fromJson(Map<String, dynamic> json) => _$SeerrMediaInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMediaInfoToJson(this);
}

@JsonSerializable()
class SeerrMediaInfoSeason {
  final int? id;
  final int? seasonNumber;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  const SeerrMediaInfoSeason({
    this.id,
    this.seasonNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SeerrMediaInfoSeason.fromJson(Map<String, dynamic> json) => _$SeerrMediaInfoSeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMediaInfoSeasonToJson(this);
}

@JsonSerializable()
class SeerrExternalIds {
  final String? imdbId;
  final String? facebookId;
  final String? instagramId;
  final String? twitterId;

  SeerrExternalIds({
    this.imdbId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  factory SeerrExternalIds.fromJson(Map<String, dynamic> json) => _$SeerrExternalIdsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrExternalIdsToJson(this);
}

@JsonSerializable()
class SeerrRequestsResponse {
  final List<SeerrMediaRequest>? results;
  final SeerrPageInfo? pageInfo;

  SeerrRequestsResponse({
    this.results,
    this.pageInfo,
  });

  factory SeerrRequestsResponse.fromJson(Map<String, dynamic> json) => _$SeerrRequestsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrRequestsResponseToJson(this);
}

@JsonSerializable()
class SeerrMediaRequest {
  final int? id;
  final int? status;
  final SeerrMedia? media;
  final String? createdAt;
  final String? updatedAt;
  final SeerrUserModel? requestedBy;
  final SeerrUserModel? modifiedBy;
  final bool? is4k;
  final int? serverId;
  final int? profileId;
  final String? rootFolder;

  SeerrMediaRequest({
    this.id,
    this.status,
    this.media,
    this.createdAt,
    this.updatedAt,
    this.requestedBy,
    this.modifiedBy,
    this.is4k,
    this.serverId,
    this.profileId,
    this.rootFolder,
  });

  factory SeerrMediaRequest.fromJson(Map<String, dynamic> json) => _$SeerrMediaRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMediaRequestToJson(this);
}

@JsonSerializable()
class SeerrPageInfo {
  final int? pages;
  final int? pageSize;
  final int? results;
  final int? page;

  SeerrPageInfo({
    this.pages,
    this.pageSize,
    this.results,
    this.page,
  });

  factory SeerrPageInfo.fromJson(Map<String, dynamic> json) => _$SeerrPageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrPageInfoToJson(this);
}

@JsonSerializable()
class SeerrCreateRequestBody {
  final String? mediaType;
  final int? mediaId;
  final bool? is4k;
  @JsonKey(includeIfNull: false)
  final List<int>? seasons;
  final int? serverId;
  final int? profileId;
  final String? rootFolder;
  final List<int>? tags;
  final int? userId;

  SeerrCreateRequestBody({
    this.mediaType,
    this.mediaId,
    this.is4k,
    this.seasons,
    this.serverId,
    this.profileId,
    this.rootFolder,
    this.tags,
    this.userId,
  });

  factory SeerrCreateRequestBody.fromJson(Map<String, dynamic> json) => _$SeerrCreateRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrCreateRequestBodyToJson(this);
}

@JsonSerializable()
class SeerrMedia {
  final int? id;
  final int? tmdbId;
  final int? tvdbId;
  final int? status;
  final String? mediaType;
  final List<SeerrMediaRequest>? requests;

  SeerrMedia({
    this.id,
    this.tmdbId,
    this.tvdbId,
    this.status,
    this.mediaType,
    this.requests,
  });

  factory SeerrMedia.fromJson(Map<String, dynamic> json) => _$SeerrMediaFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMediaToJson(this);
}

@JsonSerializable()
class SeerrMediaResponse {
  final List<SeerrMedia>? results;
  final SeerrPageInfo? pageInfo;

  SeerrMediaResponse({
    this.results,
    this.pageInfo,
  });

  factory SeerrMediaResponse.fromJson(Map<String, dynamic> json) => _$SeerrMediaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMediaResponseToJson(this);
}

enum SeerrMediaType {
  @JsonValue('movie')
  movie,
  @JsonValue('tv')
  tv,
  @JsonValue('series')
  series,
  @JsonValue('person')
  person,
}

@JsonSerializable()
class SeerrDiscoverItem {
  final int? id;
  final SeerrMediaType? mediaType;
  final String? title;
  final String? name;
  final String? originalTitle;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final String? firstAirDate;
  final SeerrMediaInfo? mediaInfo;
  @JsonKey(readValue: _readJellyfinMediaId)
  final String? mediaId;

  SeerrDiscoverItem({
    this.id,
    this.mediaType,
    this.title,
    this.name,
    this.originalTitle,
    this.originalName,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.firstAirDate,
    this.mediaInfo,
    this.mediaId,
  });

  factory SeerrDiscoverItem.fromJson(Map<String, dynamic> json) => _$SeerrDiscoverItemFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrDiscoverItemToJson(this);
}

@JsonSerializable()
class SeerrDiscoverResponse {
  final List<SeerrDiscoverItem>? results;
  final int? page;
  final int? totalPages;
  final int? totalResults;

  SeerrDiscoverResponse({
    this.results,
    this.page,
    this.totalPages,
    this.totalResults,
  });

  factory SeerrDiscoverResponse.fromJson(Map<String, dynamic> json) => _$SeerrDiscoverResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrDiscoverResponseToJson(this);
}

@JsonSerializable()
class SeerrSearchResponse {
  final List<SeerrDiscoverItem>? results;
  final int? page;
  final int? totalPages;
  final int? totalResults;

  SeerrSearchResponse({
    this.results,
    this.page,
    this.totalPages,
    this.totalResults,
  });

  factory SeerrSearchResponse.fromJson(Map<String, dynamic> json) => _$SeerrSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrSearchResponseToJson(this);
}

@JsonSerializable()
class SeerrAuthLocalBody {
  final String email;
  final String password;

  SeerrAuthLocalBody({
    required this.email,
    required this.password,
  });

  factory SeerrAuthLocalBody.fromJson(Map<String, dynamic> json) => _$SeerrAuthLocalBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrAuthLocalBodyToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SeerrAuthJellyfinBody {
  final String username;
  final String password;
  @JsonKey(includeIfNull: false)
  final String? hostname;

  SeerrAuthJellyfinBody({
    required this.username,
    required this.password,
    this.hostname,
  });

  factory SeerrAuthJellyfinBody.fromJson(Map<String, dynamic> json) => _$SeerrAuthJellyfinBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrAuthJellyfinBodyToJson(this);
}
