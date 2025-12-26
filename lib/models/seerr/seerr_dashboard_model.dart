import 'package:fladder/models/items/images_models.dart';

enum SeerrRequestStatus {
  pending,
  approved,
  declined,
  available,
  unknown;

  static SeerrRequestStatus fromRaw(int? raw) {
    return switch (raw) {
      1 => SeerrRequestStatus.pending,
      2 => SeerrRequestStatus.approved,
      3 => SeerrRequestStatus.declined,
      4 => SeerrRequestStatus.available,
      _ => SeerrRequestStatus.unknown,
    };
  }

  String get label {
    return switch (this) {
      SeerrRequestStatus.pending => 'Pending',
      SeerrRequestStatus.approved => 'Approved',
      SeerrRequestStatus.declined => 'Declined',
      SeerrRequestStatus.available => 'Available',
      SeerrRequestStatus.unknown => '-',
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

  const SeerrDashboardPosterModel({
    required this.id,
    required this.type,
    required this.tmdbId,
    this.jellyfinItemId,
    required this.title,
    required this.overview,
    required this.images,
  });

  SeerrDashboardPosterModel copyWith({
    String? id,
    SeerrDashboardMediaType? type,
    int? tmdbId,
    String? jellyfinItemId,
    String? title,
    String? overview,
    ImagesData? images,
  }) {
    return SeerrDashboardPosterModel(
      id: id ?? this.id,
      type: type ?? this.type,
      tmdbId: tmdbId ?? this.tmdbId,
      jellyfinItemId: jellyfinItemId ?? this.jellyfinItemId,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      images: images ?? this.images,
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
  final List<SeerrDashboardRequestItem> recentRequests;
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
    List<SeerrDashboardRequestItem>? recentRequests,
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
