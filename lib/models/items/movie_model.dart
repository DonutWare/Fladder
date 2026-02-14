// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fladder/models/items/special_feature_model.dart';
import 'package:flutter/material.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/screens/details_screens/movie_detail_screen.dart';
import 'package:fladder/util/humanize_duration.dart';

part 'movie_model.mapper.dart';

@MappableClass()
class MovieModel extends ItemStreamModel with MovieModelMappable {
  final String originalTitle;
  final String? path;
  final DateTime premiereDate;
  final String sortName;
  final String status;
  final List<ItemBaseModel> related;
  final List<SpecialFeatureModel> specialFeatures;
  final List<SeerrDashboardPosterModel> seerrRelated;
  final List<SeerrDashboardPosterModel> seerrRecommended;
  final Map<String, dynamic>? providerIds;
  final List<Chapter> chapters;
  const MovieModel({
    required this.originalTitle,
    this.path,
    this.chapters = const [],
    this.specialFeatures = const [],
    required this.premiereDate,
    required this.sortName,
    required this.status,
    this.related = const [],
    this.seerrRelated = const [],
    this.seerrRecommended = const [],
    this.providerIds,
    required super.name,
    required super.id,
    required super.overview,
    required super.parentId,
    required super.playlistId,
    required super.images,
    required super.childCount,
    required super.primaryRatio,
    required super.userData,
    required super.parentImages,
    required super.mediaStreams,
    required super.canDownload,
    required super.canDelete,
    super.jellyType,
  });
  @override
  String? detailedName(BuildContext context) => "$name${overview.yearAired != null ? " (${overview.yearAired})" : ""}";

  @override
  Widget get detailScreenWidget => MovieDetailScreen(item: this);

  @override
  ItemBaseModel get parentBaseModel => this;

  @override
  String? get subText => overview.yearAired?.toString() ?? overview.runTime.humanize;

  @override
  bool get playAble => true;

  @override
  bool get identifiable => true;

  @override
  ImageData? get bannerImage => images?.backDrop?.firstOrNull ?? images?.primary ?? getPosters?.primary;

  @override
  MediaStreamsModel? get streamModel => mediaStreams;

  @override
  String? label(BuildContext context) {
    return name;
  }

  @override
  bool get syncAble => true;

  factory MovieModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    if (ref == null) {
      return MovieModel(
        name: item.name ?? "",
        id: item.id ?? "",
        childCount: item.childCount,
        overview: OverviewModel(
          summary: item.overview ?? "",
          yearAired: item.productionYear,
          productionYear: item.productionYear,
          dateAdded: item.dateCreated,
          genres: item.genres ?? [],
        ),
        userData: UserData.fromDto(item.userData),
        parentId: item.parentId,
        playlistId: item.playlistItemId,
        sortName: item.sortName ?? "",
        status: item.status ?? "",
        originalTitle: item.originalTitle ?? "",
        images: null,
        primaryRatio: item.primaryImageAspectRatio,
        chapters: const [],
        premiereDate: item.premiereDate ?? DateTime.now(),
        parentImages: null,
        canDelete: item.canDelete,
        canDownload: item.canDownload,
        mediaStreams: MediaStreamsModel(versionStreams: []),
        seerrRelated: const [],
        seerrRecommended: const [],
        providerIds: item.providerIds,
      );
    }

    return MovieModel(
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      sortName: item.sortName ?? "",
      status: item.status ?? "",
      originalTitle: item.originalTitle ?? "",
      images: ImagesData.fromBaseItem(item, ref),
      primaryRatio: item.primaryImageAspectRatio,
      chapters: Chapter.chaptersFromInfo(item.id ?? "", item.chapters ?? [], ref),
      premiereDate: item.premiereDate ?? DateTime.now(),
      parentImages: ImagesData.fromBaseItemParent(item, ref),
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      mediaStreams: MediaStreamsModel.fromMediaStreamsList(item.mediaSources, ref),
      seerrRelated: const [],
      seerrRecommended: const [],
      providerIds: item.providerIds,
    );
  }
}
