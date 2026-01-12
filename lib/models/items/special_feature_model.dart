import 'package:flutter/material.dart';

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

part 'special_feature_model.mapper.dart';

@MappableClass()
class SpecialFeatureModel extends ItemStreamModel with SpecialFeatureModelMappable {
  final List<Chapter> chapters;
  final ItemLocation? location;
  final DateTime? dateAired;
  const SpecialFeatureModel({
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

  @override
  String? detailedName(BuildContext context) => "${subTextShort(context)} - $name";

  @override
  SeriesModel get parentBaseModel => SeriesModel(
        originalTitle: '',
        sortName: '',
        status: "",
        name: "",
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
  String get title => name;

  @override
  MediaStreamsModel? get streamModel => mediaStreams;

  @override
  ImagesData? get getPosters => parentImages;

  @override
  String? get subText => name.isEmpty ? "TBA" : name;

  @override
  String? subTextShort(BuildContext context) => name;

  @override
  String label(BuildContext context) => name;

  @override
  String playButtonLabel(BuildContext context) {
    final string = name.maxLength();
    return progress != 0 ? context.localized.resume(string) : context.localized.play(string);
  }

  @override
  bool get syncAble => playAble;

  @override
  bool get playAble => true;

  @override
  factory SpecialFeatureModel.fromBaseDto(dto.BaseItemDto item, Ref ref) => SpecialFeatureModel(
        name: item.name ?? "",
        id: item.id ?? "",
        childCount: 0,
        overview: OverviewModel.fromBaseItemDto(item, ref),
        userData: UserData.fromDto(item.userData),
        parentId: item.parentId ?? "",
        playlistId: item.playlistItemId,
        dateAired: item.premiereDate,
        chapters: Chapter.chaptersFromInfo(item.id ?? "", item.chapters ?? [], ref),
        images: ImagesData.fromBaseItem(item, ref),
        primaryRatio: item.primaryImageAspectRatio,
        location: ItemLocation.fromDto(item.locationType),
        parentImages: ImagesData.fromBaseItemParent(item, ref),
        canDelete: item.canDelete,
        canDownload: item.canDownload,
        mediaStreams: MediaStreamsModel.fromMediaStreamsList(item.mediaSources, ref),
        jellyType: item.type,
      );

  static List<SpecialFeatureModel> specialFeaturesFromDto(List<dto.BaseItemDto>? dto, Ref ref) {
    return dto?.map((e) => SpecialFeatureModel.fromBaseDto(e, ref)).toList() ?? [];
  }
}