import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart' as logging;

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

final albumDetailsProvider =
    StateNotifierProvider.autoDispose.family<AlbumDetailsNotifier, AlbumModel?, String>((ref, id) {
  return AlbumDetailsNotifier(ref);
});

class AlbumDetailsNotifier extends StateNotifier<AlbumModel?> {
  AlbumDetailsNotifier(this.ref) : super(null);

  final Ref ref;
  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response?> fetchDetails(ItemBaseModel item) async {
    if (item is AlbumModel) {
      state = state ?? item;
    }

    final response = await api.usersUserIdItemsItemIdGet(itemId: item.id);
    if (!response.isSuccessful || response.body == null) {
      return response;
    }

    final newState = response.bodyOrThrow as AlbumModel;
    state = newState.copyWith(
      tracks: state?.tracks ?? const [],
      relatedAlbums: state?.relatedAlbums ?? const [],
      relatedTracks: state?.relatedTracks ?? const [],
    );
    await fetchTracks();
    await fetchArtistRelated();
    return response;
  }

  Future<void> fetchTracks() async {
    if (state == null) return;
    try {
      final response = await api.itemsGet(
        parentId: state!.id,
        includeItemTypes: [BaseItemKind.audio],
        enableUserData: true,
        enableImages: true,
        imageTypeLimit: 1,
        fields: [ItemFields.primaryimageaspectratio],
        sortBy: [ItemSortBy.sortname],
        sortOrder: [SortOrder.ascending],
        limit: 100,
      );

      final tracks = response.body?.items.whereType<AudioModel>().toList();
      if (tracks != null) {
        state = state?.copyWith(tracks: tracks);
      }
    } catch (error, stack) {
      log('Failed to fetch album tracks for ${state?.id} due to $error',
          level: logging.Level.WARNING.value, error: error, stackTrace: stack);
    }
  }

  Future<void> fetchArtistRelated() async {
    if (state == null) return;
    try {
      final artistIds = state!.artistIds.isNotEmpty ? state!.artistIds : state!.albumArtistIds;
      if (artistIds.isEmpty) return;

      final albumsResponse = await api.itemsGet(
        parentId: state!.parentId,
        includeItemTypes: [BaseItemKind.musicalbum],
        enableUserData: true,
        enableImages: true,
        imageTypeLimit: 1,
        fields: [ItemFields.primaryimageaspectratio],
        sortBy: [ItemSortBy.sortname],
        sortOrder: [SortOrder.ascending],
        limit: 25,
      );

      final relatedAlbums =
          albumsResponse.body?.items.whereType<AlbumModel>().where((album) => album.id != state!.id).toList();

      final songsResponse = await api.itemsGet(
        artistIds: artistIds,
        parentId: state!.id,
        includeItemTypes: [BaseItemKind.audio],
        enableUserData: true,
        enableImages: true,
        imageTypeLimit: 1,
        fields: [ItemFields.primaryimageaspectratio],
        sortBy: [ItemSortBy.sortname],
        sortOrder: [SortOrder.ascending],
        limit: 25,
      );

      final relatedTracks =
          songsResponse.body?.items.whereType<AudioModel>().where((track) => track.albumId != state!.id).toList();

      if (relatedAlbums != null || relatedTracks != null) {
        state = state?.copyWith(
          relatedAlbums: relatedAlbums ?? state!.relatedAlbums,
          relatedTracks: relatedTracks ?? state!.relatedTracks,
        );
      }
    } catch (error, stack) {
      log('Failed to fetch related album items for ${state?.id} due to $error',
          level: logging.Level.WARNING.value, error: error, stackTrace: stack);
    }
  }
}
