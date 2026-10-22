import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/util/string_extensions.dart';

part 'video_part_model.mapper.dart';

/// A single additional part of a multi-part movie or episode.
///
/// Parts are separate Jellyfin items that are grouped under the main item.
/// The main item itself is always Part 1 and is represented by the regular
/// [MovieModel] or [EpisodeModel]; this model only covers Part 2..N.
@MappableClass()
class VideoPartModel extends ItemStreamModel with VideoPartModelMappable {
  /// Logical parent movie/episode ID (the item Part 1 belongs to).
  final String parentItemId;

  /// Part number within the logical item, starting at 2 for the first
  /// additional part.
  final int partNumber;

  /// Total number of parts in the logical item, including Part 1.
  final int totalParts;

  const VideoPartModel({
    required this.parentItemId,
    required this.partNumber,
    required this.totalParts,
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
    super.partCount,
  });

  @override
  bool get playAble => mediaStreams.versionStreams.isNotEmpty;

  @override
  MediaStreamsModel? get streamModel => mediaStreams;

  @override
  FladderItemType get type => FladderItemType.video;

  @override
  bool get syncAble => false;

  @override
  ItemBaseModel get parentBaseModel => copyWith(id: parentItemId);

  @override
  String get title => name;

  @override
  String? subTextShort(AppLocalizations l10n) => l10n.part(partNumber);

  @override
  String? detailedName(AppLocalizations l10n) => "${l10n.part(partNumber)} - $name";

  @override
  String? label(AppLocalizations l10n) => "${l10n.part(partNumber)} - $name";

  @override
  String playButtonLabel(AppLocalizations l10n) {
    final string = l10n.part(partNumber).maxLength();
    return progress != 0 ? l10n.resume(string) : l10n.play(string);
  }

  factory VideoPartModel.fromBaseDto(
    dto.BaseItemDto item,
    Ref? ref, {
    required String parentItemId,
    required int partNumber,
    required int totalParts,
  }) {
    return VideoPartModel(
      name: item.name ?? "",
      id: item.id ?? "",
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      primaryRatio: item.primaryImageAspectRatio,
      parentImages: ref != null ? ImagesData.fromBaseItemParent(item, ref) : null,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      mediaStreams: ref != null
          ? MediaStreamsModel.fromMediaStreamsList(item.mediaSources, ref)
          : MediaStreamsModel(versionStreams: []),
      parentItemId: parentItemId,
      partNumber: partNumber,
      totalParts: totalParts,
      jellyType: item.type,
      partCount: totalParts,
    );
  }

  /// Maps the additional parts returned by
  /// `GET /Videos/{itemId}/AdditionalParts`.
  ///
  /// The server already sorts the parts, so the response order is preserved.
  /// The first additional part is Part 2.
  static List<VideoPartModel> fromDtos(
    List<dto.BaseItemDto>? dtos,
    Ref ref, {
    required String parentItemId,
    required int totalParts,
  }) {
    return dtos
            ?.mapIndexed(
              (index, item) => VideoPartModel.fromBaseDto(
                item,
                ref,
                parentItemId: parentItemId,
                partNumber: index + 2,
                totalParts: totalParts,
              ),
            )
            .toList() ??
        [];
  }
}
