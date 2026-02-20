import 'package:flutter/material.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/localization_helper.dart';

enum SeerrRequestStatus {
  unknown,
  pending,
  approved,
  declined,
  failed,
  completed;

  static SeerrRequestStatus fromRaw(int? raw) {
    return switch (raw) {
      1 => SeerrRequestStatus.pending,
      2 => SeerrRequestStatus.approved,
      3 => SeerrRequestStatus.declined,
      4 => SeerrRequestStatus.failed,
      5 => SeerrRequestStatus.completed,
      _ => SeerrRequestStatus.unknown,
    };
  }

  bool get isKnown => this != SeerrRequestStatus.unknown;

  String label(BuildContext context) {
    return switch (this) {
      SeerrRequestStatus.unknown => "",
      SeerrRequestStatus.pending => context.localized.seerrRequestStatusPending,
      SeerrRequestStatus.approved => context.localized.seerrRequestStatusApproved,
      SeerrRequestStatus.declined => context.localized.seerrRequestStatusDeclined,
      SeerrRequestStatus.failed => context.localized.seerrRequestStatusFailed,
      SeerrRequestStatus.completed => context.localized.seerrRequestStatusCompleted,
    };
  }

  Color get color {
    return switch (this) {
      SeerrRequestStatus.unknown => Colors.grey,
      SeerrRequestStatus.pending => Colors.orange,
      SeerrRequestStatus.approved => Colors.blue,
      SeerrRequestStatus.declined => Colors.red,
      SeerrRequestStatus.failed => Colors.deepOrange,
      SeerrRequestStatus.completed => Colors.green,
    };
  }
}

enum SeerrMediaStatus {
  unknown,
  pending,
  processing,
  partiallyAvailable,
  available,
  blacklisted,
  deleted;

  static SeerrMediaStatus fromRaw(int? raw) {
    return switch (raw) {
      1 => SeerrMediaStatus.unknown,
      2 => SeerrMediaStatus.pending,
      3 => SeerrMediaStatus.processing,
      4 => SeerrMediaStatus.partiallyAvailable,
      5 => SeerrMediaStatus.available,
      6 => SeerrMediaStatus.blacklisted,
      7 => SeerrMediaStatus.deleted,
      _ => SeerrMediaStatus.unknown,
    };
  }

  bool get isKnown => this != SeerrMediaStatus.unknown;

  String label(BuildContext context) {
    return switch (this) {
      SeerrMediaStatus.unknown => "",
      SeerrMediaStatus.pending => context.localized.seerrRequestStatusPending,
      SeerrMediaStatus.processing => context.localized.seerrMediaStatusProcessing,
      SeerrMediaStatus.partiallyAvailable => context.localized.seerrMediaStatusPartiallyAvailable,
      SeerrMediaStatus.available => context.localized.seerrMediaStatusAvailable,
      SeerrMediaStatus.blacklisted => context.localized.seerrMediaStatusBlacklisted,
      SeerrMediaStatus.deleted => context.localized.seerrMediaStatusDeleted,
    };
  }

  Color get color {
    return switch (this) {
      SeerrMediaStatus.unknown => Colors.grey,
      SeerrMediaStatus.pending => Colors.orange,
      SeerrMediaStatus.processing => Colors.blue,
      SeerrMediaStatus.partiallyAvailable => Colors.amber,
      SeerrMediaStatus.available => Colors.green,
      SeerrMediaStatus.blacklisted => Colors.purple,
      SeerrMediaStatus.deleted => Colors.red,
    };
  }
}

class SeerrDashboardRequestMeta {
  final SeerrRequestStatus status;
  final bool is4k;

  const SeerrDashboardRequestMeta({
    required this.status,
    required this.is4k,
  });
}

class SeerrDashboardPosterModel {
  final String id;
  final SeerrMediaType type;
  final int tmdbId;
  final String? jellyfinItemId;
  final String title;
  final String overview;
  final ImagesData images;
  final SeerrMediaStatus mediaStatus;
  final SeerrRequestStatus? requestStatus;
  final List<SeerrSeason>? seasons;
  final Map<int, SeerrMediaStatus>? seasonStatuses;
  final SeerrMediaInfo? mediaInfo;
  final String? releaseYear;
  final dynamic requestedBy;
  final List<int>? requestedSeasons;

  const SeerrDashboardPosterModel({
    required this.id,
    required this.type,
    required this.tmdbId,
    required this.title,
    required this.overview,
    required this.images,
    required this.mediaStatus,
    required this.jellyfinItemId,
    this.requestStatus,
    this.seasons,
    this.seasonStatuses,
    this.mediaInfo,
    this.releaseYear,
    this.requestedBy,
    this.requestedSeasons,
  });

  SeerrDashboardPosterModel copyWith({
    String? id,
    SeerrMediaType? type,
    int? tmdbId,
    String? jellyfinItemId,
    String? title,
    String? overview,
    ImagesData? images,
    SeerrMediaStatus? mediaStatus,
    SeerrRequestStatus? requestStatus,
    List<SeerrSeason>? seasons,
    Map<int, SeerrMediaStatus>? seasonStatuses,
    SeerrMediaInfo? mediaInfo,
    String? releaseYear,
    dynamic requestedBy,
    List<int>? requestedSeasons,
  }) {
    return SeerrDashboardPosterModel(
      id: id ?? this.id,
      type: type ?? this.type,
      tmdbId: tmdbId ?? this.tmdbId,
      jellyfinItemId: jellyfinItemId ?? this.jellyfinItemId,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      images: images ?? this.images,
      mediaStatus: mediaStatus ?? this.mediaStatus,
      requestStatus: requestStatus ?? this.requestStatus,
      seasons: seasons ?? this.seasons,
      seasonStatuses: seasonStatuses ?? this.seasonStatuses,
      mediaInfo: mediaInfo ?? this.mediaInfo,
      releaseYear: releaseYear ?? this.releaseYear,
      requestedBy: requestedBy ?? this.requestedBy,
      requestedSeasons: requestedSeasons ?? this.requestedSeasons,
    );
  }

  bool get hasDisplayStatus => (requestStatus?.isKnown ?? false) || mediaStatus.isKnown;

  String displayStatusLabel(BuildContext context) => requestStatus?.label(context) ?? mediaStatus.label(context);

  Color get displayStatusColor => requestStatus?.color ?? mediaStatus.color;

  ItemBaseModel? get itemBaseModel {
    if (jellyfinItemId == null) {
      return null;
    }
    switch (type) {
      case SeerrMediaType.tvshow:
        return SeriesModel(
          name: title,
          id: jellyfinItemId ?? '',
          images: images,
          originalTitle: "",
          sortName: "",
          status: "Ongoing",
          overview: const OverviewModel(),
          parentId: null,
          playlistId: null,
          childCount: 0,
          primaryRatio: 0.7,
          userData: const UserData(),
          canDelete: false,
          canDownload: false,
          jellyType: BaseItemKind.series,
        );
      case SeerrMediaType.movie:
        return MovieModel(
          name: title,
          id: jellyfinItemId ?? '',
          images: images,
          originalTitle: title,
          premiereDate: DateTime.now(),
          sortName: title,
          status: "Released",
          parentImages: null,
          mediaStreams: MediaStreamsModel(versionStreams: []),
          overview: const OverviewModel(),
          parentId: null,
          playlistId: null,
          childCount: 0,
          primaryRatio: 0.7,
          userData: const UserData(),
          canDelete: false,
          canDownload: false,
          jellyType: type == SeerrMediaType.movie ? BaseItemKind.movie : BaseItemKind.series,
        );
      default:
        return null;
    }
  }
}

class SeerrDashboardRequestItem {
  final SeerrDashboardPosterModel poster;
  final SeerrDashboardRequestMeta meta;

  const SeerrDashboardRequestItem({
    required this.poster,
    required this.meta,
  });
}

class SeerrDashboardModel {
  final List<SeerrDashboardPosterModel> recentlyAdded;
  final List<SeerrDashboardPosterModel> recentRequests;
  final List<SeerrDashboardPosterModel> trending;
  final List<SeerrDashboardPosterModel> popularMovies;
  final List<SeerrDashboardPosterModel> popularSeries;
  final List<SeerrDashboardPosterModel> expectedMovies;
  final List<SeerrDashboardPosterModel> expectedSeries;

  const SeerrDashboardModel({
    this.recentlyAdded = const [],
    this.recentRequests = const [],
    this.trending = const [],
    this.popularMovies = const [],
    this.popularSeries = const [],
    this.expectedMovies = const [],
    this.expectedSeries = const [],
  });

  SeerrDashboardModel copyWith({
    List<SeerrDashboardPosterModel>? recentlyAdded,
    List<SeerrDashboardPosterModel>? recentRequests,
    List<SeerrDashboardPosterModel>? trending,
    List<SeerrDashboardPosterModel>? popularMovies,
    List<SeerrDashboardPosterModel>? popularSeries,
    List<SeerrDashboardPosterModel>? expectedMovies,
    List<SeerrDashboardPosterModel>? expectedSeries,
  }) {
    return SeerrDashboardModel(
      recentlyAdded: recentlyAdded ?? this.recentlyAdded,
      recentRequests: recentRequests ?? this.recentRequests,
      trending: trending ?? this.trending,
      popularMovies: popularMovies ?? this.popularMovies,
      popularSeries: popularSeries ?? this.popularSeries,
      expectedMovies: expectedMovies ?? this.expectedMovies,
      expectedSeries: expectedSeries ?? this.expectedSeries,
    );
  }
}
