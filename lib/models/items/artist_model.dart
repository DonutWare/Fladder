import 'package:flutter/material.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/screens/details_screens/artist_detail_screen.dart';

part 'artist_model.mapper.dart';

@MappableClass()
class ArtistModel extends ItemBaseModel with ArtistModelMappable {
  final List<AlbumModel> albums;
  final List<AudioModel> tracks;
  final List<ArtistModel> similarArtists;
  final Map<String, dynamic>? providerIds;

  const ArtistModel({
    this.albums = const [],
    this.tracks = const [],
    this.similarArtists = const [],
    this.providerIds,
    required super.name,
    required super.id,
    required super.overview,
    required super.parentId,
    required super.playlistId,
    required super.images,
    required super.childCount,
    required super.primaryRatio,
    required super.userData,
    super.canDelete,
    super.canDownload,
    super.jellyType,
  });

  @override
  Widget get detailScreenWidget => ArtistDetailScreen(item: this);

  @override
  bool get playAble => false;

  @override
  bool get syncAble => true;

  @override
  String get title => name;

  @override
  String? get subText => overview.summary.isNotEmpty ? overview.summary : null;

  factory ArtistModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    return ArtistModel(
      name: item.name ?? '',
      id: item.id ?? '',
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      primaryRatio: item.primaryImageAspectRatio,
      albums: const [],
      tracks: const [],
      similarArtists: const [],
      providerIds: item.providerIds,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      jellyType: item.type,
    );
  }
}
