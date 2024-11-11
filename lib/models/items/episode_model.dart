import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/enum_models.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';

part 'episode_model.mapper.dart';

enum EpisodeStatus { available, unaired, missing }

@MappableClass()
class EpisodeModel extends ItemStreamModel with EpisodeModelMappable {
  final String? seriesName;
  final int season;
  final int episode;
  final List<Chapter> chapters;
  final ItemLocation? location;
  final DateTime? dateAired;
  const EpisodeModel({
    required this.seriesName,
    required this.season,
    required this.episode,
    this.chapters = const [],
    this.location,
    this.dateAired,
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
    super.canDelete,
    super.canDownload,
    super.jellyType,
  });
  EpisodeStatus get status {
    return switch (location) {
      ItemLocation.filesystem => EpisodeStatus.available,
      ItemLocation.virtual =>
        (dateAired?.isBefore(DateTime.now()) == true) ? EpisodeStatus.missing : EpisodeStatus.unaired,
      _ => EpisodeStatus.missing
    };
  }

  @override
  String? detailedName(BuildContext context) => "${subTextShort(context)} - $name";

  @override
  SeriesModel get parentBaseModel => SeriesModel(
        originalTitle: '',
        sortName: '',
        status: "",
        name: seriesName ?? "",
        id: parentId ?? "",
        playlistId: playlistId,
        overview: overview,
        parentId: parentId,
        images: images,
        childCount: childCount,
        primaryRatio: primaryRatio,
        userData: const UserData(),
      );

  @override
  String get streamId => parentId ?? "";

  @override
  String get title => seriesName ?? name;

  @override
  MediaStreamsModel? get streamModel => mediaStreams;

  @override
  ImagesData? get getPosters => parentImages;

  @override
  String? get subText => name.isEmpty ? "TBA" : name;

  @override
  String? subTextShort(BuildContext context) => seasonEpisodeLabel(context);

  @override
  String? label(BuildContext context) => "${subTextShort(context)} - $name";

  @override
  bool get playAble => switch (status) {
        EpisodeStatus.available => true,
        _ => false,
      };

  @override
  String playButtonLabel(BuildContext context) {
    final string = seasonEpisodeLabel(context).maxLength();
    return progress != 0 ? context.localized.resume(string) : context.localized.play(string);
  }

  String seasonAnnotation(BuildContext context) => context.localized.season(1)[0];
  String episodeAnnotation(BuildContext context) => context.localized.episode(1)[0];

  String seasonEpisodeLabel(BuildContext context) {
    return "${seasonAnnotation(context)}$season - ${episodeAnnotation(context)}$episode";
  }

  String seasonEpisodeLabelFull(BuildContext context) {
    return "${context.localized.season(1)} $season - ${context.localized.episode(1)} $episode";
  }

  String episodeLabel(BuildContext context) {
    return "${seasonEpisodeLabel(context)} - $subText";
  }

  String get fullName {
    return "$episode. $subText";
  }

  @override
  bool get syncAble => playAble;

  @override
  factory EpisodeModel.fromBaseDto(dto.BaseItemDto item, Ref ref) => EpisodeModel(
        seriesName: item.seriesName,
        name: item.name ?? "",
        id: item.id ?? "",
        childCount: item.childCount,
        overview: OverviewModel.fromBaseItemDto(item, ref),
        userData: UserData.fromDto(item.userData),
        parentId: item.seriesId,
        playlistId: item.playlistItemId,
        dateAired: item.premiereDate,
        chapters: Chapter.chaptersFromInfo(item.id ?? "", item.chapters ?? [], ref),
        images: ImagesData.fromBaseItem(item, ref, getOriginalSize: true),
        primaryRatio: item.primaryImageAspectRatio,
        season: item.parentIndexNumber ?? 0,
        episode: item.indexNumber ?? 0,
        location: ItemLocation.fromDto(item.locationType),
        parentImages: ImagesData.fromBaseItemParent(item, ref),
        canDelete: item.canDelete,
        canDownload: item.canDownload,
        mediaStreams:
            MediaStreamsModel.fromMediaStreamsList(item.mediaSources?.firstOrNull, item.mediaStreams ?? [], ref),
        jellyType: item.type,
      );

  static List<EpisodeModel> episodesFromDto(List<dto.BaseItemDto>? dto, Ref ref) {
    return dto?.map((e) => EpisodeModel.fromBaseDto(e, ref)).toList() ?? [];
  }
}

extension EpisodeListExtensions on List<EpisodeModel> {
  Map<int, List<EpisodeModel>> get episodesBySeason {
    final Map<int, List<EpisodeModel>> groupedItems = {};
    for (int i = 0; i < length; i++) {
      final int seasonIndex = this[i].season;
      groupedItems.putIfAbsent(seasonIndex, () => []).add(this[i]);
    }

    String addPadding(int value) => value.toString().padLeft(6, '0');

    return SplayTreeMap<int, List<EpisodeModel>>.from(
      groupedItems,
      (a, b) => addPadding(a).compareTo(addPadding(b)),
    );
  }

  EpisodeModel? get nextUp {
    final lastProgress =
        lastIndexWhere((element) => element.userData.progress != 0 && element.status == EpisodeStatus.available);
    final lastPlayed =
        lastIndexWhere((element) => element.userData.played && element.status == EpisodeStatus.available);

    if (lastProgress == -1 && lastPlayed == -1) {
      return firstWhereOrNull((element) => element.status == EpisodeStatus.available);
    } else {
      return getRange(lastProgress > lastPlayed ? lastProgress : lastPlayed + 1, length)
          .firstWhereOrNull((element) => element.status == EpisodeStatus.available);
    }
  }

  bool get allPlayed {
    for (var element in this) {
      if (!element.userData.played) {
        return false;
      }
    }
    return true;
  }
}
