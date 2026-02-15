import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/enum_models.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/util/string_extensions.dart';

part 'episode_model.mapper.dart';

enum EpisodeStatus {
  available,
  unaired,
  missing;

  const EpisodeStatus();

  Color get color => switch (this) {
        EpisodeStatus.available => Colors.lightGreenAccent,
        EpisodeStatus.unaired => Colors.indigoAccent,
        EpisodeStatus.missing => Colors.redAccent,
      };

  String label(AppLocalizations l10n) => switch (this) {
        EpisodeStatus.available => l10n.episodeAvailable,
        EpisodeStatus.unaired => l10n.episodeUnaired,
        EpisodeStatus.missing => l10n.episodeMissing,
      };
}

@MappableClass()
class EpisodeModel extends ItemStreamModel with EpisodeModelMappable {
  final String? seriesName;
  final int season;
  final int episode;
  final int? episodeEnd;
  final List<Chapter> chapters;
  final ItemLocation? location;
  final DateTime? dateAired;
  const EpisodeModel({
    required this.seriesName,
    required this.season,
    required this.episode,
    required this.episodeEnd,
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
  String? detailedName(AppLocalizations l10n) => "${subTextShort(l10n)} - $name";

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
  String? subTextShort(AppLocalizations l10n) => seasonEpisodeLabel(l10n);

  @override
  String? label(AppLocalizations l10n) => "${subTextShort(l10n)} - $name";

  @override
  bool get playAble => switch (status) {
        EpisodeStatus.available => true,
        _ => false,
      };

  @override
  String playButtonLabel(AppLocalizations l10n) {
    final string = seasonEpisodeLabel(l10n).maxLength();
    return progress != 0 ? l10n.resume(string) : l10n.play(string);
  }

  String seasonAnnotation(AppLocalizations l10n) => l10n.season(1)[0];
  String episodeAnnotation(AppLocalizations l10n) => l10n.episode(1)[0];

  String seasonEpisodeLabel(AppLocalizations l10n) {
    final seasonStr = season.toString();
    final episodeRangeStr = episodeRange;
    return "${seasonAnnotation(l10n)}$seasonStr - ${episodeAnnotation(l10n)}$episodeRangeStr";
  }

  int get episodeCount {
    if (episodeEnd != null && episodeEnd! > episode) {
      return episodeEnd! - episode + 1;
    }
    return 1;
  }

  String get episodeRange {
    if (episodeEnd != null && episodeEnd! > episode) {
      return "$episode-${episodeEnd!}";
    }
    return episode.toString();
  }

  String seasonEpisodeLabelFull(AppLocalizations l10n) {
    return "${l10n.season(1)} $season - ${l10n.episode(episodeCount)} $episodeRange";
  }

  String episodeLabel(AppLocalizations l10n) {
    return "${seasonEpisodeLabel(l10n)} - $subText";
  }

  String get fullName {
    return "$episodeRange. $subText";
  }

  @override
  bool get syncAble => playAble;

  @override
  factory EpisodeModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    if (ref == null) {
      return EpisodeModel(
        seriesName: item.seriesName,
        season: item.parentIndexNumber ?? 0,
        episode: item.indexNumber ?? 0,
        episodeEnd: item.indexNumberEnd,
        chapters: const [],
        location: ItemLocation.fromDto(item.locationType),
        dateAired: item.premiereDate,
        name: item.name ?? "",
        id: item.id ?? "",
        overview: OverviewModel(
          summary: item.overview ?? "",
          yearAired: item.productionYear,
          productionYear: item.productionYear,
          dateAdded: item.dateCreated,
          genres: item.genres ?? [],
        ),
        parentId: item.seriesId,
        playlistId: item.playlistItemId,
        images: null,
        childCount: item.childCount,
        primaryRatio: item.primaryImageAspectRatio,
        userData: UserData.fromDto(item.userData),
        parentImages: null,
        mediaStreams: MediaStreamsModel(versionStreams: []),
        canDelete: item.canDelete,
        canDownload: item.canDownload,
        jellyType: item.type,
      );
    }

    return EpisodeModel(
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
      images: ImagesData.fromBaseItem(item, ref),
      primaryRatio: item.primaryImageAspectRatio,
      season: item.parentIndexNumber ?? 0,
      episode: item.indexNumber ?? 0,
      episodeEnd: item.indexNumberEnd,
      location: ItemLocation.fromDto(item.locationType),
      parentImages: ImagesData.fromBaseItemParent(item, ref),
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      mediaStreams: MediaStreamsModel.fromMediaStreamsList(item.mediaSources, ref),
      jellyType: item.type,
    );
  }

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
    final episodes = where((e) => e.season > 0 && e.status == EpisodeStatus.available).toList();
    if (episodes.isEmpty) return null;

    final lastProgressIndex = episodes.lastIndexWhere((e) => e.userData.progress != 0);
    final lastPlayedIndex = episodes.lastIndexWhere((e) => e.userData.played);
    final lastWatchedIndex = [lastProgressIndex, lastPlayedIndex].reduce((a, b) => a > b ? a : b);

    if (lastWatchedIndex >= 0) {
      final current = episodes[lastWatchedIndex];
      if (!current.userData.played && current.userData.progress != 0) {
        return current;
      }

      final nextIndex = lastWatchedIndex + 1;
      if (nextIndex < episodes.length) {
        final next = episodes[nextIndex];
        if (!next.userData.played && next.userData.progress != 0) {
          return next;
        }

        final nextUnplayed = episodes.sublist(nextIndex).firstWhereOrNull(
              (e) => e.status == EpisodeStatus.available && !e.userData.played,
            );
        if (nextUnplayed != null) return nextUnplayed;
      }
    }

    return episodes.firstOrNull;
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
