import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/util/duration_extensions.dart';

part 'overview_model.mapper.dart';

@MappableClass()
class OverviewModel with OverviewModelMappable {
  final Duration? runTime;
  final String summary;
  final int? yearAired;
  final DateTime? dateAdded;
  final String? parentalRating;
  final int? productionYear;
  final double? criticRating;
  final double? communityRating;
  final Map<String, TrickPlayModel>? trickPlayInfo;
  final List<Chapter>? chapters;
  final List<ExternalUrls>? externalUrls;
  final List<Studio> studios;
  final List<String> genres;
  final List<GenreItems> genreItems;
  final List<String> tags;
  final List<Person> people;
  const OverviewModel({
    this.runTime,
    this.summary = "",
    this.yearAired,
    this.dateAdded,
    this.parentalRating,
    this.productionYear,
    this.criticRating,
    this.communityRating,
    this.trickPlayInfo,
    this.chapters,
    this.externalUrls,
    this.studios = const [],
    this.genres = const [],
    this.genreItems = const [],
    this.tags = const [],
    this.people = const [],
  });

  List<Person> get directors {
    return people.where((element) => element.type == PersonKind.director).toList();
  }

  List<Person> get writers {
    return people.where((element) => element.type == PersonKind.writer).toList();
  }

  factory OverviewModel.fromBaseItemDto(BaseItemDto item, Ref ref) {
    final trickPlayItem = item.trickplay;
    return OverviewModel(
      runTime: item.runTimeDuration,
      yearAired: item.productionYear,
      parentalRating: item.officialRating,
      summary: item.overview ?? "",
      genres: item.genres ?? [],
      criticRating: item.criticRating,
      communityRating: item.communityRating,
      tags: item.tags ?? [],
      dateAdded: item.dateCreated,
      trickPlayInfo:
          trickPlayItem != null && trickPlayItem.isNotEmpty ? TrickPlayModel.toTrickPlayMap(trickPlayItem) : null,
      chapters: item.id != null ? Chapter.chaptersFromInfo(item.id ?? "", item.chapters ?? [], ref) : null,
      studios: item.studios?.map((e) => Studio(id: e.id ?? "", name: e.name ?? "")).toList() ?? [],
      genreItems: item.genreItems?.map((e) => GenreItems(id: e.id ?? "", name: e.name ?? "")).toList() ?? [],
      externalUrls: ExternalUrls.fromDto(item.externalUrls ?? []),
      people: Person.peopleFromDto(item.people ?? [], ref),
    );
  }
}
