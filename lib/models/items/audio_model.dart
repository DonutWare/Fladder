import 'package:auto_route/auto_route.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/details_screens/empty_item.dart';

part 'audio_model.mapper.dart';

@MappableClass()
class AudioModel extends ItemStreamModel with AudioModelMappable {
  final String? album;
  final String? albumId;
  final List<String> artistNames;
  final List<String> albumArtists;
  final int? trackNumber;
  final Map<String, dynamic>? providerIds;

  const AudioModel({
    this.album,
    this.albumId,
    this.artistNames = const [],
    this.albumArtists = const [],
    this.trackNumber,
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
    required super.parentImages,
    required super.mediaStreams,
    super.canDelete,
    super.canDownload,
    super.jellyType,
  });

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

  @override
  String? get subText {
    final artistText = artistNames.isNotEmpty ? artistNames.join(', ') : null;
    final albumText = album;
    if (artistText != null && albumText != null && albumText.isNotEmpty) {
      return '$artistText • $albumText';
    }
    return artistText ?? albumText;
  }

  @override
  String? subTextShort(AppLocalizations l10n) => album;

  @override
  String? label(AppLocalizations l10n) => subText;

  factory AudioModel.fromBaseDto(dto.BaseItemDto item, Ref? ref) {
    return AudioModel(
      name: item.name ?? '',
      id: item.id ?? '',
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      parentImages: ref != null ? ImagesData.fromBaseItemParent(item, ref) : null,
      primaryRatio: item.primaryImageAspectRatio,
      mediaStreams: ref != null
          ? MediaStreamsModel.fromMediaStreamsList(item.mediaSources, ref)
          : MediaStreamsModel(versionStreams: []),
      album: item.album,
      albumId: item.albumId,
      artistNames: item.artists?.whereType<String>().toList() ?? const [],
      albumArtists: item.albumArtists?.whereType<String>().toList() ?? const [],
      trackNumber: item.indexNumber,
      providerIds: item.providerIds,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      jellyType: item.type,
    );
  }
}
