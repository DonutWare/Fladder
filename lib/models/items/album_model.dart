import 'package:flutter/material.dart';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/artist_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/screens/details_screens/album_detail_screen.dart';

part 'album_model.mapper.dart';

@MappableClass()
class AlbumModel extends ItemBaseModel with AlbumModelMappable {
  final List<String> artistIds;
  final String albumArtist;
  final List<String> albumArtistIds;
  final List<AudioModel> tracks;
  final List<AlbumModel> relatedAlbums;
  final List<AudioModel> relatedTracks;
  final Map<String, dynamic>? providerIds;

  const AlbumModel({
    this.artistIds = const [],
    required this.albumArtist,
    this.albumArtistIds = const [],
    this.tracks = const [],
    this.relatedAlbums = const [],
    this.relatedTracks = const [],
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
  ItemBaseModel get parentBaseModel {
    return ArtistModel(
      name: artistLabel,
      id: parentId ?? '',
      overview: OverviewModel(
        summary: overview.summary,
        genres: overview.genres,
        people: overview.people,
      ),
      parentId: parentId,
      playlistId: playlistId,
      images: images,
      childCount: 0,
      primaryRatio: primaryRatio,
      userData: userData,
      albums: const [],
      tracks: const [],
      providerIds: providerIds,
      jellyType: dto.BaseItemKind.musicartist,
    );
  }

  @override
  Widget get detailScreenWidget => AlbumDetailScreen(item: this);

  @override
  bool get playAble => true;

  @override
  bool get syncAble => true;

  String get artistLabel {
    if (albumArtist.isNotEmpty) return albumArtist;
    if (artistIds.isEmpty && albumArtistIds.isEmpty) {
      return overview.people.map((person) => person.name).where((value) => value.isNotEmpty).join(', ');
    }
    final labels = <String>[];
    if (albumArtistIds.isNotEmpty) albumArtistIds;
    if (artistIds.isNotEmpty) labels.addAll(artistIds);
    return labels.join(', ');
  }

  @override
  String? get subText => artistLabel.isNotEmpty ? artistLabel : null;

  @override
  ImagesData? get getPosters => images?.copyWith(
        logo: () => images?.primary,
      );

  @override
  String? subTextShort(AppLocalizations l10n) => overview.yearAired?.toString();

  @override
  String? label(AppLocalizations l10n) => artistLabel;

  factory AlbumModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    return AlbumModel(
      name: item.name ?? '',
      id: item.id ?? '',
      albumArtist: item.albumArtist ?? '',
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      primaryRatio: item.primaryImageAspectRatio,
      artistIds: item.artists?.whereType<String>().toList() ?? const [],
      albumArtistIds: item.albumArtists?.whereType<String>().toList() ?? const [],
      tracks: const [],
      relatedAlbums: const [],
      relatedTracks: const [],
      providerIds: item.providerIds,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      jellyType: item.type,
    );
  }
}
