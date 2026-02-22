import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/overview_model.dart';

part 'item_stream_model.mapper.dart';

@MappableClass()
class ItemStreamModel extends ItemBaseModel with ItemStreamModelMappable {
  final ImagesData? parentImages;
  final MediaStreamsModel mediaStreams;
  const ItemStreamModel({
    required this.parentImages,
    required this.mediaStreams,
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
  factory ItemStreamModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    return switch (item.type) {
      BaseItemKind.episode => EpisodeModel.fromBaseDto(item, ref),
      BaseItemKind.movie => MovieModel.fromBaseDto(item, ref),
      _ => ItemStreamModel._fromBaseDto(item, ref)
    };
  }

  factory ItemStreamModel._fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    return ItemStreamModel(
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
    );
  }

  String? get videoPropertiesLabel {
    if (mediaStreams.displayProfile == null && mediaStreams.resolution == null) return null;
    return "${mediaStreams.displayProfile?.value}";
  }
}
