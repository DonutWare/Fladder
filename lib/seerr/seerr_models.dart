import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/util/localization_helper.dart';

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

enum SeerrSearchMode {
  search,
  trending,
  discoverMovies,
  discoverTv;

  String label(BuildContext context) {
    switch (this) {
      case SeerrSearchMode.search:
        return context.localized.search;
      case SeerrSearchMode.trending:
        return context.localized.trending;
      case SeerrSearchMode.discoverMovies:
        return context.localized.mediaTypeMovie(2);
      case SeerrSearchMode.discoverTv:
        return context.localized.mediaTypeSeries(2);
    }
  }

  IconData get icon => switch (this) {
        SeerrSearchMode.search => IconsaxPlusBold.search_normal,
        SeerrSearchMode.trending => IconsaxPlusBold.trend_up,
        SeerrSearchMode.discoverMovies => FladderItemType.movie.selectedicon,
        SeerrSearchMode.discoverTv => FladderItemType.series.selectedicon,
      };
}

typedef _SortValues = ({String movie, String tv});

const String _tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/original';
const String _tmdbPosterBaseUrl = 'https://image.tmdb.org/t/p/w500';
const String _tmdbProfileBaseUrl = 'https://image.tmdb.org/t/p/w185';

enum SeerrSortBy {
  popularityDesc,
  popularityAsc,
  releaseDateDesc,
  releaseDateAsc,
  voteAverageDesc,
  voteAverageAsc,
  titleDesc,
  titleAsc;

  static const Map<SeerrSortBy, _SortValues> _sortValues = {
    SeerrSortBy.popularityAsc: (movie: 'popularity.asc', tv: 'popularity.asc'),
    SeerrSortBy.popularityDesc: (movie: 'popularity.desc', tv: 'popularity.desc'),
    SeerrSortBy.releaseDateAsc: (movie: 'primary_release_date.asc', tv: 'first_air_date.asc'),
    SeerrSortBy.releaseDateDesc: (movie: 'primary_release_date.desc', tv: 'first_air_date.desc'),
    SeerrSortBy.voteAverageAsc: (movie: 'vote_average.asc', tv: 'vote_average.asc'),
    SeerrSortBy.voteAverageDesc: (movie: 'vote_average.desc', tv: 'vote_average.desc'),
    SeerrSortBy.titleAsc: (movie: 'original_title.asc', tv: 'original_name.asc'),
    SeerrSortBy.titleDesc: (movie: 'original_title.desc', tv: 'original_name.desc'),
  };

  /// Map to TMDB sort values; some keys differ for movies vs TV.
  String valueForMode(SeerrSearchMode mode) {
    final values = _sortValues[this]!;
    return mode == SeerrSearchMode.discoverTv ? values.tv : values.movie;
  }

  String label(BuildContext context) {
    switch (this) {
      case SeerrSortBy.popularityAsc:
        return '${context.localized.popularity} ${context.localized.ascending}';
      case SeerrSortBy.popularityDesc:
        return '${context.localized.popularity} ${context.localized.descending}';
      case SeerrSortBy.releaseDateAsc:
        return '${context.localized.releaseDate} ${context.localized.ascending}';
      case SeerrSortBy.releaseDateDesc:
        return '${context.localized.releaseDate} ${context.localized.descending}';
      case SeerrSortBy.voteAverageAsc:
        return '${context.localized.rating(1)} ${context.localized.ascending}';
      case SeerrSortBy.voteAverageDesc:
        return '${context.localized.rating(1)} ${context.localized.descending}';
      case SeerrSortBy.titleAsc:
        return '${context.localized.name} ${context.localized.ascending}';
      case SeerrSortBy.titleDesc:
        return '${context.localized.name} ${context.localized.descending}';
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

@Freezed(copyWith: true)
abstract class SeerrUserModel with _$SeerrUserModel {
  const factory SeerrUserModel({
    int? id,
    String? email,
    String? username,
    String? displayName,
    String? plexToken,
    String? plexUsername,
    int? permissions,
    String? avatar,
    SeerrUserSettings? settings,
    int? movieQuotaLimit,
    int? movieQuotaDays,
    int? tvQuotaLimit,
    int? tvQuotaDays,
  }) = _SeerrUserModel;

  factory SeerrUserModel.fromJson(Map<String, dynamic> json) => _$SeerrUserModelFromJson(json);
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
      hasPermission(SeerrPermission.manageRequests) || hasPermission(SeerrPermission.requestAdvanced);

  bool get canManageUsers => hasPermission(SeerrPermission.manageUsers);

  bool get canViewRecent => hasPermission(SeerrPermission.recentView);

  bool canRequestMedia({required bool isTv}) {
    final baseRequest = hasPermission(SeerrPermission.request);
    if (isTv) return baseRequest || hasPermission(SeerrPermission.requestTv);
    return baseRequest || hasPermission(SeerrPermission.requestMovie);
  }
}

@JsonSerializable()
class SeerrUserSettings {
  final String? locale;
  final String? discoverRegion;
  final String? originalLanguage;

  SeerrUserSettings({
    this.locale,
    this.discoverRegion,
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
class SeerrContentRating {
  @JsonKey(name: 'iso_3166_1')
  final String? countryCode;
  final String? rating;
  final List<dynamic>? descriptors;

  SeerrContentRating({
    this.countryCode,
    this.rating,
    this.descriptors,
  });

  factory SeerrContentRating.fromJson(Map<String, dynamic> json) => _$SeerrContentRatingFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrContentRatingToJson(this);
}

@JsonSerializable()
class SeerrCredits {
  final List<SeerrCast>? cast;
  final List<SeerrCrew>? crew;

  SeerrCredits({
    this.cast,
    this.crew,
  });

  factory SeerrCredits.fromJson(Map<String, dynamic> json) => _$SeerrCreditsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrCreditsToJson(this);
}

@JsonSerializable()
class SeerrCast {
  final int? id;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? gender;
  final String? name;
  final int? order;
  @JsonKey(name: 'profilePath')
  final String? internalProfilePath;

  SeerrCast({
    this.id,
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.name,
    this.order,
    this.internalProfilePath,
  });

  factory SeerrCast.fromJson(Map<String, dynamic> json) => _$SeerrCastFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrCastToJson(this);
}

@JsonSerializable()
class SeerrCrew {
  final int? id;
  final String? creditId;
  final int? gender;
  final String? name;
  final String? job;
  final String? department;
  @JsonKey(name: 'profilePath')
  final String? internalProfilePath;

  SeerrCrew({
    this.id,
    this.creditId,
    this.gender,
    this.name,
    this.job,
    this.department,
    this.internalProfilePath,
  });

  factory SeerrCrew.fromJson(Map<String, dynamic> json) => _$SeerrCrewFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrCrewToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: true)
class SeerrMovieDetails {
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  @JsonKey(name: 'posterPath')
  final String? internalPosterPath;
  @JsonKey(name: 'backdropPath')
  final String? internalBackdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;
  final int? runtime;
  final List<SeerrGenre>? genres;
  final SeerrMediaInfo? mediaInfo;
  final SeerrExternalIds? externalIds;
  final SeerrCredits? credits;
  @JsonKey(readValue: _readJellyfinMediaId)
  final String? mediaId;
  @JsonKey(readValue: _readContentRatings)
  final List<SeerrContentRating>? contentRatings;

  SeerrMovieDetails({
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.internalPosterPath,
    this.internalBackdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.runtime,
    this.genres,
    this.mediaInfo,
    this.externalIds,
    this.credits,
    this.mediaId,
    this.contentRatings,
  });

  factory SeerrMovieDetails.fromJson(Map<String, dynamic> json) => _$SeerrMovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMovieDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: true)
class SeerrTvDetails {
  final int? id;
  final String? name;
  final String? originalName;
  final String? overview;
  @JsonKey(name: 'posterPath')
  final String? internalPosterPath;
  @JsonKey(name: 'backdropPath')
  final String? internalBackdropPath;
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
  final SeerrCredits? credits;
  @JsonKey(readValue: _readJellyfinMediaId)
  final String? mediaId;
  @JsonKey(readValue: _readContentRatings)
  final List<SeerrContentRating>? contentRatings;

  SeerrTvDetails({
    this.id,
    this.name,
    this.originalName,
    this.overview,
    this.internalPosterPath,
    this.internalBackdropPath,
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
    this.credits,
    this.mediaId,
    this.contentRatings,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SeerrGenre && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
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

@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: true)
class SeerrSeason {
  final int? id;
  final String? name;
  final String? overview;
  final int? seasonNumber;
  @JsonKey(name: 'posterPath')
  final String? internalPosterPath;
  final int? episodeCount;
  @JsonKey(readValue: _readJellyfinMediaId)
  final String? mediaId;

  SeerrSeason({
    this.id,
    this.name,
    this.overview,
    this.seasonNumber,
    this.internalPosterPath,
    this.episodeCount,
    this.mediaId,
  });

  factory SeerrSeason.fromJson(Map<String, dynamic> json) => _$SeerrSeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrSeasonToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: true)
class SeerrSeasonDetails {
  final int? id;
  final String? name;
  final String? overview;
  final int? seasonNumber;
  @JsonKey(name: 'posterPath')
  final String? internalPosterPath;
  final List<SeerrEpisode>? episodes;

  SeerrSeasonDetails({
    this.id,
    this.name,
    this.overview,
    this.seasonNumber,
    this.internalPosterPath,
    this.episodes,
  });

  factory SeerrSeasonDetails.fromJson(Map<String, dynamic> json) => _$SeerrSeasonDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrSeasonDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: true)
class SeerrEpisode {
  final int? id;
  final String? name;
  final String? overview;
  final int? episodeNumber;
  final int? seasonNumber;
  final String? airDate;
  @JsonKey(name: 'stillPath')
  final String? internalStillPath;
  final double? voteAverage;
  final int? voteCount;

  SeerrEpisode({
    this.id,
    this.name,
    this.overview,
    this.episodeNumber,
    this.seasonNumber,
    this.airDate,
    this.internalStillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory SeerrEpisode.fromJson(Map<String, dynamic> json) => _$SeerrEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrEpisodeToJson(this);
}

Object? _readJellyfinMediaId(Map json, String key) {
  return json['jellyfinMediaId'] ?? json['jellyfinMediaId4k'];
}

Object? _readContentRatings(Map json, String key) {
  // For TV shows: contentRatings.results
  var value = json['contentRatings'];
  if (value != null) {
    if (value is List) return value;
    if (value is Map) {
      final results = value['results'];
      if (results is List) return results;
    }
  }

  // For movies: releases.results - needs flattening
  value = json['releases'];
  if (value != null && value is Map) {
    final results = value['results'];
    if (results is List) {
      // Flatten movie releases to match TV structure
      return results
          .map((release) {
            if (release is! Map) return null;
            final countryCode = release['iso_3166_1'];
            final releaseDates = release['release_dates'];

            // Get the first certification from release_dates
            String? certification;
            if (releaseDates is List && releaseDates.isNotEmpty) {
              for (final dateInfo in releaseDates) {
                if (dateInfo is Map) {
                  final certValue = dateInfo['certification'];
                  if ((certValue as String?)?.isNotEmpty ?? false) {
                    certification = certValue as String;
                    break;
                  }
                }
              }
            }

            return {
              'iso_3166_1': countryCode,
              'rating': certification,
            };
          })
          .where((item) => item != null && item['rating'] != null)
          .toList();
    }
  }

  return null;
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

@Freezed(copyWith: true)
abstract class SeerrMediaInfo with _$SeerrMediaInfo {
  const SeerrMediaInfo._();

  factory SeerrMediaInfo({
    int? id,
    int? tmdbId,
    int? tvdbId,
    int? status,
    String? jellyfinMediaId,
    String? jellyfinMediaId4k,
    String? serviceUrl,
    List<SeerrMediaRequest>? requests,
    List<SeerrMediaInfoSeason>? seasons,
    List<SeerrDownloadStatus>? downloadStatus,
    List<SeerrDownloadStatus>? downloadStatus4k,
  }) = _SeerrMediaInfo;

  String? get primaryJellyfinMediaId => jellyfinMediaId4k ?? jellyfinMediaId;

  SeerrMediaStatus? get mediaStatus => status != null ? SeerrMediaStatus.fromRaw(status) : null;

  factory SeerrMediaInfo.fromJson(Map<String, dynamic> json) => _$SeerrMediaInfoFromJson(json);
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
class SeerrRatingsResponse {
  final SeerrRtRating? rt;
  final SeerrImdbRating? imdb;

  SeerrRatingsResponse({
    this.rt,
    this.imdb,
  });

  factory SeerrRatingsResponse.fromJson(Map<String, dynamic> json) => _$SeerrRatingsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrRatingsResponseToJson(this);
}

@JsonSerializable()
class SeerrRtRating {
  final String? title;
  final int? year;
  final int? criticsScore;
  final String? criticsRating;
  final int? audienceScore;
  final String? audienceRating;
  final String? url;

  SeerrRtRating({
    this.title,
    this.year,
    this.criticsScore,
    this.criticsRating,
    this.audienceScore,
    this.audienceRating,
    this.url,
  });

  factory SeerrRtRating.fromJson(Map<String, dynamic> json) => _$SeerrRtRatingFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrRtRatingToJson(this);
}

@JsonSerializable()
class SeerrImdbRating {
  final String? title;
  final String? url;
  final double? criticsScore;

  SeerrImdbRating({
    this.title,
    this.url,
    this.criticsScore,
  });

  factory SeerrImdbRating.fromJson(Map<String, dynamic> json) => _$SeerrImdbRatingFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrImdbRatingToJson(this);
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
  @JsonKey(fromJson: _parseRequestSeasons)
  final List<int>? seasons;
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
    this.seasons,
    this.serverId,
    this.profileId,
    this.rootFolder,
  });

  SeerrRequestStatus get requestStatus => SeerrRequestStatus.fromRaw(status);

  factory SeerrMediaRequest.fromJson(Map<String, dynamic> json) => _$SeerrMediaRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrMediaRequestToJson(this);
}

// Helper to parse seasons which can be a list of ints or a list of objects
List<int>? _parseRequestSeasons(List<dynamic>? seasons) {
  if (seasons == null) return null;

  return seasons
      .map<int?>((season) {
        if (season is num) return season.toInt();
        if (season is Map<String, dynamic>) {
          final value = season['seasonNumber'] ?? season['season'] ?? season['id'];
          if (value is num) return value.toInt();
          if (value is String) return int.tryParse(value);
        }
        return null;
      })
      .whereType<int>()
      .toList();
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
  tvshow,
  @JsonValue('person')
  person;

  const SeerrMediaType();

  static SeerrMediaType fromString(String mediaType) => switch (mediaType.toLowerCase()) {
        'movie' => SeerrMediaType.movie,
        'tvshow' || 'tv' => SeerrMediaType.tvshow,
        'person' => SeerrMediaType.person,
        _ => throw ArgumentError('Unknown media type: $mediaType'),
      };
}

@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: true)
class SeerrDiscoverItem {
  final int? id;
  final SeerrMediaType? mediaType;
  final String? title;
  final String? name;
  final String? originalTitle;
  final String? originalName;
  final String? overview;
  @JsonKey(name: 'posterPath')
  final String? internalPosterPath;
  @JsonKey(name: 'backdropPath')
  final String? internalBackdropPath;
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
    this.internalPosterPath,
    this.internalBackdropPath,
    this.releaseDate,
    this.firstAirDate,
    this.mediaInfo,
    this.mediaId,
  });

  factory SeerrDiscoverItem.fromJson(Map<String, dynamic> json) => _$SeerrDiscoverItemFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrDiscoverItemToJson(this);
}

/// Shared paginated result used for both discover and search endpoints.
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
class SeerrGenreResponse {
  final List<SeerrGenre>? genres;

  SeerrGenreResponse({this.genres});

  factory SeerrGenreResponse.fromJson(Map<String, dynamic> json) => _$SeerrGenreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrGenreResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: true)
class SeerrWatchProvider {
  @JsonKey(name: 'id')
  final int? providerId;
  @JsonKey(name: 'name')
  final String? providerName;
  @JsonKey(name: 'logoPath')
  final String? internalLogoPath;
  @JsonKey(name: 'displayPriority')
  final int? displayPriority;

  SeerrWatchProvider({
    this.providerId,
    this.providerName,
    this.internalLogoPath,
    this.displayPriority,
  });

  factory SeerrWatchProvider.fromJson(Map<String, dynamic> json) => _$SeerrWatchProviderFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrWatchProviderToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeerrWatchProvider && runtimeType == other.runtimeType && providerId == other.providerId;

  @override
  int get hashCode => providerId.hashCode;
}

@JsonSerializable()
class SeerrWatchProviderRegion {
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  @JsonKey(name: 'english_name')
  final String? englishName;
  @JsonKey(name: 'native_name')
  final String? nativeName;

  SeerrWatchProviderRegion({this.iso31661, this.englishName, this.nativeName});

  factory SeerrWatchProviderRegion.fromJson(Map<String, dynamic> json) => _$SeerrWatchProviderRegionFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrWatchProviderRegionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeerrWatchProviderRegion && runtimeType == other.runtimeType && iso31661 == other.iso31661;

  @override
  int get hashCode => iso31661.hashCode;
}

@JsonSerializable()
class SeerrCertification {
  final String? certification;
  final String? meaning;
  final int? order;

  SeerrCertification({
    this.certification,
    this.meaning,
    this.order,
  });

  factory SeerrCertification.fromJson(Map<String, dynamic> json) => _$SeerrCertificationFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrCertificationToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeerrCertification && runtimeType == other.runtimeType && certification == other.certification;

  @override
  int get hashCode => certification.hashCode;
}

@JsonSerializable()
class SeerrCertificationsResponse {
  final Map<String, List<SeerrCertification>>? certifications;

  SeerrCertificationsResponse({this.certifications});

  factory SeerrCertificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$SeerrCertificationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrCertificationsResponseToJson(this);
}

@Freezed(copyWith: true)
abstract class SeerrFilterModel with _$SeerrFilterModel {
  const factory SeerrFilterModel({
    @Default({}) Map<SeerrGenre, bool> genres,
    int? yearGte,
    int? yearLte,
    @Default({}) Map<SeerrWatchProvider, bool> watchProviders,
    @Default({}) Map<SeerrCertification, bool> certifications,
    double? voteAverageGte,
    double? voteAverageLte,
    int? runtimeGte,
    int? runtimeLte,
    String? certificationGte,
    String? certificationLte,
    @Default(SeerrSortBy.popularityDesc) SeerrSortBy sortBy,
    @Default('US') String? watchRegion,
    SeerrCompany? studio,
  }) = _SeerrFilterModel;
}

extension SeerrFilterModelExtension on SeerrFilterModel {
  bool get hasActiveFilters =>
      genres.values.any((v) => v) ||
      yearGte != null ||
      yearLte != null ||
      watchProviders.values.any((v) => v) ||
      certifications.values.any((v) => v) ||
      voteAverageGte != null ||
      voteAverageLte != null ||
      runtimeGte != null ||
      runtimeLte != null ||
      certificationGte != null ||
      certificationLte != null ||
      studio != null;
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
  final Map<String, String>? customHeaders;
  @JsonKey(includeIfNull: false)
  final String? hostname;

  SeerrAuthJellyfinBody({
    required this.username,
    required this.password,
    this.customHeaders,
    this.hostname,
  });

  factory SeerrAuthJellyfinBody.fromJson(Map<String, dynamic> json) => _$SeerrAuthJellyfinBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SeerrAuthJellyfinBodyToJson(this);
}

class SeerrCompany {
  final int id;
  final String name;
  final String? _logoPath;

  SeerrCompany({
    required this.id,
    required this.name,
    String? logoPath,
  }) : _logoPath = logoPath;

  String? get logoUrl {
    if (_logoPath == null || _logoPath!.isEmpty) return null;
    return '$_tmdbImageBaseUrl$_logoPath';
  }

  factory SeerrCompany.fromJson(Map<String, dynamic> json) {
    return SeerrCompany(
      id: json['id'] as int,
      name: json['name'] as String,
      logoPath: json['logo_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo_path': _logoPath,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SeerrCompany && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'SeerrCompany(id: $id, name: $name)';
}

class SeerrSearchCompanyResponse {
  final int? page;
  final List<SeerrCompany> results;
  final int? totalPages;
  final int? totalResults;

  SeerrSearchCompanyResponse({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory SeerrSearchCompanyResponse.fromJson(Map<String, dynamic> json) {
    return SeerrSearchCompanyResponse(
      page: json['page'] as int?,
      results:
          (json['results'] as List<dynamic>?)?.map((e) => SeerrCompany.fromJson(e as Map<String, dynamic>)).toList() ??
              [],
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'results': results.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}

extension SeerrMovieDetailsExtension on SeerrMovieDetails {
  String? get posterUrl {
    if (internalPosterPath == null || internalPosterPath!.isEmpty) return null;
    return '$_tmdbPosterBaseUrl$internalPosterPath';
  }

  String? get backdropUrl {
    if (internalBackdropPath == null || internalBackdropPath!.isEmpty) return null;
    return '$_tmdbImageBaseUrl$internalBackdropPath';
  }
}

extension SeerrCastExtension on SeerrCast {
  String? get profileUrl {
    if (internalProfilePath == null || internalProfilePath!.isEmpty) return null;
    return '$_tmdbProfileBaseUrl$internalProfilePath';
  }
}

extension SeerrCrewExtension on SeerrCrew {
  String? get profileUrl {
    if (internalProfilePath == null || internalProfilePath!.isEmpty) return null;
    return '$_tmdbProfileBaseUrl$internalProfilePath';
  }
}

extension SeerrTvDetailsExtension on SeerrTvDetails {
  String? get posterUrl {
    if (internalPosterPath == null || internalPosterPath!.isEmpty) return null;
    return '$_tmdbPosterBaseUrl$internalPosterPath';
  }

  String? get backdropUrl {
    if (internalBackdropPath == null || internalBackdropPath!.isEmpty) return null;
    return '$_tmdbImageBaseUrl$internalBackdropPath';
  }
}

extension SeerrSeasonExtension on SeerrSeason {
  String? get posterUrl {
    if (internalPosterPath == null || internalPosterPath!.isEmpty) return null;
    return '$_tmdbPosterBaseUrl$internalPosterPath';
  }
}

extension SeerrEpisodeExtension on SeerrEpisode {
  String? get stillUrl {
    if (internalStillPath == null || internalStillPath!.isEmpty) return null;
    return '$_tmdbImageBaseUrl$internalStillPath';
  }
}

extension SeerrDiscoverItemExtension on SeerrDiscoverItem {
  String? get posterUrl {
    if (internalPosterPath == null || internalPosterPath!.isEmpty) return null;
    return '$_tmdbPosterBaseUrl$internalPosterPath';
  }

  String? get backdropUrl {
    if (internalBackdropPath == null || internalBackdropPath!.isEmpty) return null;
    return '$_tmdbImageBaseUrl$internalBackdropPath';
  }
}

extension SeerrWatchProviderExtension on SeerrWatchProvider {
  String? get logoUrl {
    if (internalLogoPath == null || internalLogoPath!.isEmpty) return null;
    return '$_tmdbImageBaseUrl$internalLogoPath';
  }
}
