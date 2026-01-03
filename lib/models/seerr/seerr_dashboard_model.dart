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

enum SeerrRequestStatus {
  unknown,
  pending,
  processing,
  partiallyAvailable,
  available,
  deleted;

  static SeerrRequestStatus fromRaw(int? raw) {
    return switch (raw) {
      2 => SeerrRequestStatus.pending,
      3 => SeerrRequestStatus.processing,
      4 => SeerrRequestStatus.partiallyAvailable,
      5 => SeerrRequestStatus.available,
      6 || 7 => SeerrRequestStatus.deleted,
      _ => SeerrRequestStatus.unknown,
    };
  }

  String get label {
    return switch (this) {
      SeerrRequestStatus.unknown => "",
      SeerrRequestStatus.pending => "Pending",
      SeerrRequestStatus.processing => "Requested",
      SeerrRequestStatus.partiallyAvailable => "Partially Available",
      SeerrRequestStatus.available => "Available",
      SeerrRequestStatus.deleted => "Deleted",
    };
  }

  Color get color {
    return switch (this) {
      SeerrRequestStatus.unknown => Colors.grey,
      SeerrRequestStatus.pending => Colors.orange,
      SeerrRequestStatus.processing => Colors.blue,
      SeerrRequestStatus.partiallyAvailable => Colors.amber,
      SeerrRequestStatus.available => Colors.green,
      SeerrRequestStatus.deleted => Colors.red,
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

enum SeerrDashboardMediaType {
  movie,
  tv,
}

class SeerrDashboardPosterModel {
  final String id;
  final SeerrDashboardMediaType type;
  final int tmdbId;
  final String? jellyfinItemId;
  final String title;
  final String overview;
  final ImagesData images;
  final SeerrRequestStatus status;
  final List<SeerrSeason>? seasons;
  final Map<int, SeerrRequestStatus>? seasonStatuses;
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
    required this.status,
    required this.jellyfinItemId,
    this.seasons,
    this.seasonStatuses,
    this.mediaInfo,
    this.releaseYear,
    this.requestedBy,
    this.requestedSeasons,
  });

  SeerrDashboardPosterModel copyWith({
    String? id,
    SeerrDashboardMediaType? type,
    int? tmdbId,
    String? jellyfinItemId,
    String? title,
    String? overview,
    ImagesData? images,
    SeerrRequestStatus? status,
    List<SeerrSeason>? seasons,
    Map<int, SeerrRequestStatus>? seasonStatuses,
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
      status: status ?? this.status,
      seasons: seasons ?? this.seasons,
      seasonStatuses: seasonStatuses ?? this.seasonStatuses,
      mediaInfo: mediaInfo ?? this.mediaInfo,
      releaseYear: releaseYear ?? this.releaseYear,
      requestedBy: requestedBy ?? this.requestedBy,
      requestedSeasons: requestedSeasons ?? this.requestedSeasons,
    );
  }

  ItemBaseModel? get itemBaseModel {
    if (jellyfinItemId == null) {
      return null;
    }
    switch (type) {
      case SeerrDashboardMediaType.tv:
        return SeriesModel(
          name: title,
          id: jellyfinItemId ?? '',
          images: null,
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
      case SeerrDashboardMediaType.movie:
        return MovieModel(
          name: title,
          id: jellyfinItemId ?? '',
          images: null,
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
          jellyType: type == SeerrDashboardMediaType.movie ? BaseItemKind.movie : BaseItemKind.series,
        );
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
