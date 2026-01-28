import 'package:fladder/models/items/special_feature_model.dart';
import 'package:flutter/widgets.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/screens/details_screens/series_detail_screen.dart';

part 'series_model.mapper.dart';

@MappableClass()
class SeriesModel extends ItemBaseModel with SeriesModelMappable {
  final List<EpisodeModel>? availableEpisodes;
  final List<SeasonModel>? seasons;
  final List<SpecialFeatureModel>? specialFeatures;
  final String originalTitle;
  final String sortName;
  final String status;
  final List<ItemBaseModel> related;
  final List<SeerrDashboardPosterModel> seerrRelated;
  final List<SeerrDashboardPosterModel> seerrRecommended;
  final Map<String, dynamic>? providerIds;
  const SeriesModel({
    this.availableEpisodes,
    this.seasons,
    this.specialFeatures,
    required this.originalTitle,
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
    super.canDownload,
    super.canDelete,
    super.jellyType,
  });

  EpisodeModel? get nextUp => availableEpisodes?.nextUp ?? availableEpisodes?.firstOrNull;

  @override
  String detailedName(BuildContext context) => name;

  @override
  ItemBaseModel get parentBaseModel => this;

  @override
  Widget get detailScreenWidget => SeriesDetailScreen(item: this);

  @override
  bool get emptyShow => childCount == 0;

  @override
  bool get playAble => userData.unPlayedItemCount != 0;

  @override
  bool get identifiable => true;

  @override
  bool get unWatched =>
      !userData.played && userData.progress <= 0 && userData.unPlayedItemCount == 0 && childCount != 0;

  @override
  String get subText => overview.yearAired?.toString() ?? "";

  List<ItemBaseModel> fetchAllShows() {
    return availableEpisodes?.map((e) => e).toList() ?? [];
  }

  @override
  String? unplayedLabel(BuildContext context) => userData.played ? null : userData.unPlayedItemCount?.toString();

  @override
  bool get syncAble => true;

  factory SeriesModel.fromBaseDto(dto.BaseItemDto item, Ref ref) => SeriesModel(
        name: item.name ?? "",
        id: item.id ?? "",
        childCount: item.childCount,
        overview: OverviewModel.fromBaseItemDto(item, ref),
        userData: UserData.fromDto(item.userData),
        parentId: item.parentId,
        playlistId: item.playlistItemId,
        images: ImagesData.fromBaseItem(item, ref),
        primaryRatio: item.primaryImageAspectRatio,
        originalTitle: item.originalTitle ?? "",
        sortName: item.sortName ?? "",
        canDelete: item.canDelete,
        canDownload: item.canDownload,
        status: item.status ?? "Continuing",
        seerrRelated: const [],
        seerrRecommended: const [],
        providerIds: item.providerIds,
      );
}
