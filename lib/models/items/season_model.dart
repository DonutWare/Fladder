// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/util/localization_helper.dart';

part 'season_model.mapper.dart';

@MappableClass()
class SeasonModel extends ItemBaseModel with SeasonModelMappable {
  final ImagesData? parentImages;
  final String seasonName;
  final List<EpisodeModel> episodes;
  final int episodeCount;
  final String seriesId;
  final int season;
  final String seriesName;
  const SeasonModel({
    required this.parentImages,
    required this.seasonName,
    this.episodes = const [],
    required this.episodeCount,
    required this.seriesId,
    required this.season,
    required this.seriesName,
    required super.name,
    required super.id,
    required super.overview,
    required super.parentId,
    required super.playlistId,
    required super.images,
    required super.childCount,
    required super.primaryRatio,
    required super.userData,
    required super.canDelete,
    required super.canDownload,
    super.jellyType,
  });
  factory SeasonModel.fromBaseDto(dto.BaseItemDto item, Ref ref) {
    return SeasonModel(
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      season: item.indexNumber ?? 0,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.seasonId ?? item.parentId,
      playlistId: item.playlistItemId,
      images: ImagesData.fromBaseItem(item, ref),
      primaryRatio: item.primaryImageAspectRatio,
      seasonName: item.seasonName ?? "",
      episodeCount: item.episodeCount ?? 0,
      parentImages: ImagesData.fromBaseItemParent(item, ref, primary: const Size(2000, 2000)),
      seriesId: item.seriesId ?? item.parentId ?? item.id ?? "",
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      seriesName: item.seriesName ?? "",
    );
  }

  EpisodeModel? get nextUp {
    return episodes.lastWhereOrNull((element) => element.userData.progress > 0) ??
        episodes.firstWhereOrNull((element) => element.userData.played == false);
  }

  @override
  ImagesData? get getPosters => images ?? parentImages;

  String localizedName(BuildContext context) => name.replaceFirst("Season", context.localized.season(1));

  @override
  SeriesModel get parentBaseModel => SeriesModel(
        originalTitle: '',
        sortName: '',
        status: "",
        name: seriesName,
        id: parentId ?? "",
        playlistId: playlistId,
        overview: overview,
        parentId: parentId,
        images: images,
        childCount: childCount,
        primaryRatio: primaryRatio,
        userData: const UserData(),
      );

  static List<SeasonModel> seasonsFromDto(List<dto.BaseItemDto>? dto, Ref ref) {
    return dto?.map((e) => SeasonModel.fromBaseDto(e, ref)).toList() ?? [];
  }
}
