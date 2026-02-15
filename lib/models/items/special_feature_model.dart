import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/util/string_extensions.dart';

part 'special_feature_model.mapper.dart';

@MappableClass()
class SpecialFeatureModel extends ItemStreamModel with SpecialFeatureModelMappable {
  final DateTime? dateAired;
  const SpecialFeatureModel({
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
  String? detailedName(AppLocalizations l10n) => "${subTextShort(l10n)} - $name";

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
  String? subTextShort(AppLocalizations l10n) => name;

  @override
  String label(AppLocalizations l10n) => name;

  @override
  String playButtonLabel(AppLocalizations l10n) {
    final string = name.maxLength();
    return progress != 0 ? l10n.resume(string) : l10n.play(string);
  }

  @override
  bool get syncAble => playAble;

  @override
  bool get playAble => true;

  @override
  factory SpecialFeatureModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) => SpecialFeatureModel(
        name: item.name ?? "",
        id: item.id ?? "",
        childCount: 0,
        overview: OverviewModel.fromBaseItemDto(item, ref),
        userData: UserData.fromDto(item.userData),
        parentId: item.parentId ?? "",
        playlistId: item.playlistItemId,
        dateAired: item.premiereDate,
        images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
        primaryRatio: item.primaryImageAspectRatio,
        parentImages: ref != null ? ImagesData.fromBaseItemParent(item, ref) : null,
        canDelete: item.canDelete,
        canDownload: item.canDownload,
        mediaStreams: ref != null
            ? MediaStreamsModel.fromMediaStreamsList(item.mediaSources, ref)
            : MediaStreamsModel(versionStreams: []),
        jellyType: item.type,
      );

  static List<SpecialFeatureModel> specialFeaturesFromDto(List<dto.BaseItemDto>? dto, Ref? ref) {
    return dto?.map((e) => SpecialFeatureModel.fromBaseDto(e, ref)).toList() ?? [];
  }
}
