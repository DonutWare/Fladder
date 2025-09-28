import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/series_model.dart';

part 'person_model.mapper.dart';

@MappableClass()
class PersonModel extends ItemBaseModel with PersonModelMappable {
  final DateTime? dateOfBirth;
  final List<String> birthPlace;
  final List<MovieModel> movies;
  final List<SeriesModel> series;
  const PersonModel({
    this.dateOfBirth,
    required this.birthPlace,
    required this.movies,
    required this.series,
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

  static PersonModel fromBaseDto(BaseItemDto item, Ref ref) {
    return PersonModel(
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ImagesData.fromBaseItem(item, ref, getOriginalSize: true),
      primaryRatio: item.primaryImageAspectRatio,
      dateOfBirth: item.premiereDate,
      birthPlace: item.productionLocations ?? [],
      movies: [],
      series: [],
    );
  }

  int? get age {
    if (dateOfBirth == null) return null;
    final today = DateTime.now();
    final months = today.month - dateOfBirth!.month;
    if (months < 0) {
      return (dateOfBirth!.year - (DateTime.now().year - 1)).abs();
    } else {
      return (dateOfBirth!.year - DateTime.now().year).abs();
    }
  }
}
