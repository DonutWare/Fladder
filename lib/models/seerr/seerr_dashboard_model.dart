import 'package:flutter/material.dart';

import 'package:fladder/models/items/images_models.dart';

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

  const SeerrDashboardPosterModel({
    required this.id,
    required this.type,
    required this.tmdbId,
    required this.title,
    required this.overview,
    required this.images,
    required this.status,
    this.jellyfinItemId,
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
    );
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
  final List<SeerrDashboardPosterModel> expectedMovies;
  final List<SeerrDashboardPosterModel> expectedSeries;

  const SeerrDashboardModel({
    this.recentlyAdded = const [],
    this.recentRequests = const [],
    this.trending = const [],
    this.popularMovies = const [],
    this.expectedMovies = const [],
    this.expectedSeries = const [],
  });

  SeerrDashboardModel copyWith({
    List<SeerrDashboardPosterModel>? recentlyAdded,
    List<SeerrDashboardPosterModel>? recentRequests,
    List<SeerrDashboardPosterModel>? trending,
    List<SeerrDashboardPosterModel>? popularMovies,
    List<SeerrDashboardPosterModel>? expectedMovies,
    List<SeerrDashboardPosterModel>? expectedSeries,
  }) {
    return SeerrDashboardModel(
      recentlyAdded: recentlyAdded ?? this.recentlyAdded,
      recentRequests: recentRequests ?? this.recentRequests,
      trending: trending ?? this.trending,
      popularMovies: popularMovies ?? this.popularMovies,
      expectedMovies: expectedMovies ?? this.expectedMovies,
      expectedSeries: expectedSeries ?? this.expectedSeries,
    );
  }
}
