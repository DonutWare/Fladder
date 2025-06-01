import 'package:flutter/material.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/util/localization_helper.dart';

enum SortingOptions {
  name([ItemSortBy.name]),
  communityRating([ItemSortBy.communityrating]),
  // criticsRating([ItemSortBy.criticrating]),
  parentalRating([ItemSortBy.officialrating]),
  dateAdded([ItemSortBy.datecreated]),
  dateLastContentAdded([ItemSortBy.datelastcontentadded]),
  favorite([ItemSortBy.isfavoriteorliked]),
  datePlayed([ItemSortBy.dateplayed]),
  folders([ItemSortBy.isfolder]),
  playCount([ItemSortBy.playcount]),
  releaseDate([ItemSortBy.productionyear, ItemSortBy.premieredate]),
  runTime([ItemSortBy.runtime]),
  random([ItemSortBy.random]);

  const SortingOptions(this.value);
  final List<ItemSortBy> value;

  List<ItemSortBy> get toSortBy => [...value, ItemSortBy.name];

  String label(BuildContext context) => switch (this) {
        name => context.localized.name,
        communityRating => context.localized.communityRating,
        parentalRating => context.localized.parentalRating,
        dateAdded => context.localized.dateAdded,
        dateLastContentAdded => context.localized.dateLastContentAdded,
        favorite => context.localized.favorite,
        datePlayed => context.localized.datePlayed,
        folders => context.localized.folders,
        playCount => context.localized.playCount,
        releaseDate => context.localized.releaseDate,
        runTime => context.localized.runTime,
        random => context.localized.random,
      };
}

enum GroupBy {
  none,
  name,
  genres,
  dateAdded,
  tags,
  releaseDate,
  rating,
  type;

  String value(BuildContext context) => switch (this) {
        GroupBy.none => context.localized.none,
        GroupBy.name => context.localized.name,
        GroupBy.genres => context.localized.genre(1),
        GroupBy.dateAdded => context.localized.dateAdded,
        GroupBy.tags => context.localized.tag(1),
        GroupBy.releaseDate => context.localized.releaseDate,
        GroupBy.rating => context.localized.rating(1),
        GroupBy.type => context.localized.type(1),
      };
}

enum SortingOrder {
  ascending,
  descending;

  SortOrder get sortOrder => switch (this) {
        ascending => SortOrder.ascending,
        descending => SortOrder.descending,
      };

  String label(BuildContext context) => switch (this) {
        ascending => context.localized.ascending,
        descending => context.localized.descending,
      };
}

extension ItemFilterExtension on ItemFilter {
  String label(BuildContext context) {
    return switch (this) {
      ItemFilter.isplayed => context.localized.played,
      ItemFilter.isunplayed => context.localized.unPlayed,
      ItemFilter.isresumable => context.localized.resumable,
      _ => "",
    };
  }
}

int sortItems(ItemBaseModel a, ItemBaseModel b, SortingOptions sortingOption, SortingOrder sortingOrder) {
  for (var sortBy in sortingOption.toSortBy) {
    int comparison = 0;
    switch (sortBy) {
      case ItemSortBy.communityrating:
        comparison = (a.overview.communityRating ?? 0).compareTo(b.overview.communityRating ?? 0);
        break;
      case ItemSortBy.isfavoriteorliked:
        comparison = a.userData.isFavourite == b.userData.isFavourite
            ? 0
            : a.userData.isFavourite
                ? 1
                : -1;
        break;
      case ItemSortBy.dateplayed:
        comparison = (a.userData.lastPlayed ?? DateTime(0)).compareTo(b.userData.lastPlayed ?? DateTime(0));
        break;
      case ItemSortBy.playcount:
        comparison = a.userData.playCount.compareTo(b.userData.playCount);
        break;
      case ItemSortBy.premieredate:
      case ItemSortBy.productionyear:
        comparison = (a.overview.productionYear ?? 0).compareTo(b.overview.productionYear ?? 0);
        break;
      case ItemSortBy.runtime:
        comparison = (a.overview.runTime ?? Duration.zero).compareTo(b.overview.runTime ?? Duration.zero);
        break;
      default:
        comparison = a.name.compareTo(b.name);
    }
    if (comparison != 0) {
      return sortingOrder == SortingOrder.ascending ? comparison : -comparison;
    }
  }
  return 0;
}
