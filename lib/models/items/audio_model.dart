import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/artist_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/details_screens/empty_item.dart';
import 'package:fladder/util/localization_helper.dart';

part 'audio_model.mapper.dart';

@MappableClass()
class MusicArtistModel with MusicArtistModelMappable {
  final String name;
  final String id;

  MusicArtistModel({
    required this.name,
    required this.id,
  });
}

@MappableClass()
class AudioModel extends ItemStreamModel with AudioModelMappable {
  final String? album;
  final String? albumId;
  final List<MusicArtistModel> artists;
  final List<MusicArtistModel> albumArtists;
  final int? trackNumber;
  final Map<String, dynamic>? providerIds;
  final double? normalizationGain;

  const AudioModel({
    this.album,
    this.albumId,
    this.artists = const [],
    this.albumArtists = const [],
    this.trackNumber,
    this.providerIds,
    this.normalizationGain,
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
  ItemBaseModel get parentBaseModel => copyWith(id: albumId ?? parentId);

  ArtistModel? get artistModel {
    final artistId = albumArtists.firstOrNull?.id;
    if (artistId == null) {
      return null;
    }
    return ArtistModel(
      name: albumArtists.firstOrNull?.name ?? '',
      id: artistId,
      overview: const OverviewModel(),
      parentId: artistId,
      playlistId: '',
      images: null,
      childCount: null,
      primaryRatio: null,
      userData: const UserData(),
    );
  }

  @override
  ImagesData? get getPosters => images ?? parentImages;

  @override
  Widget get detailScreenWidget => EmptyItem(item: this);

  @override
  Future<void> navigateTo(BuildContext context, {WidgetRef? ref, Object? tag}) async {
    final targetId = albumId ?? parentId;
    if (targetId?.isNotEmpty == true) {
      context.router.push(DetailsRoute(id: targetId!, tag: tag));
      return;
    }
    return super.navigateTo(context, ref: ref, tag: tag);
  }

  @override
  bool get playAble => true;

  @override
  bool get syncAble => true;

  String get artistsLabel => artists.isNotEmpty ? artists.map((e) => e.name).join(', ') : '';

  String trackLabel(BuildContext context, int? trackNumber) {
    if (trackNumber == null || trackNumber <= 0) {
      return '';
    }
    return '${context.localized.track(1)}: $trackNumber';
  }

  String albumLabel() {
    final directAlbum = album ?? '';
    if (directAlbum.isNotEmpty) {
      return directAlbum;
    }
    final parentAlbumName = parentBaseModel.name;
    return parentAlbumName;
  }

  @override
  String? get subText {
    final artistText = artists.isNotEmpty ? artists.map((e) => e.name).join(', ') : null;
    final albumText = album;
    if (artistText != null && albumText != null && albumText.isNotEmpty) {
      return '$artistText • $albumText';
    }
    return artistText ?? albumText;
  }

  @override
  String? detailedName(AppLocalizations l10n) {
    if (artists.isNotEmpty) {
      return artists.map((e) => e.name).join(', ');
    }
    return album;
  }

  @override
  String? subTextShort(AppLocalizations l10n) => album;

  @override
  String? label(AppLocalizations l10n) => subText;

  factory AudioModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    final images = ref != null ? ImagesData.fromBaseItem(item, ref) : null;
    final parentImages = ref != null
        ? ImagesData.fromBaseItemParent(
            item.copyWith(
              seriesPrimaryImageTag: item.albumPrimaryImageTag,
              parentPrimaryImageTag: item.albumPrimaryImageTag,
              seriesId: item.albumId ?? item.parentId,
              parentId: item.albumId ?? item.parentId,
            ),
            ref)
        : null;

    return AudioModel(
      name: item.name ?? '',
      id: item.id ?? '',
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.albumId ?? item.parentId,
      playlistId: item.playlistItemId,
      images: images?.copyWith(
        primary: () => images.primary ?? parentImages?.primary,
      ),
      parentImages: parentImages,
      primaryRatio: item.primaryImageAspectRatio,
      mediaStreams: ref != null
          ? MediaStreamsModel.fromMediaStreamsList(item.mediaSources, ref)
          : MediaStreamsModel(versionStreams: []),
      album: item.album,
      albumId: item.albumId ?? item.parentId,
      artists:
          item.artistItems?.map((artist) => MusicArtistModel(name: artist.name ?? '', id: artist.id ?? '')).toList() ??
              const [],
      albumArtists:
          item.albumArtists?.map((artist) => MusicArtistModel(name: artist.name ?? '', id: artist.id ?? '')).toList() ??
              const [],
      trackNumber: item.indexNumber,
      providerIds: item.providerIds,
      normalizationGain: item.normalizationGain,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      jellyType: item.type,
    );
  }
}
