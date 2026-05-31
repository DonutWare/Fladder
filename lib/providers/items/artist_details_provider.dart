import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart' as logging;

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/artist_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

Future<List<AudioModel>> fetchArtistLatestTracks(
  JellyService api,
  String artistId, {
  int limit = 10,
}) async {
  final response = await api.itemsGet(
    parentId: artistId,
    includeItemTypes: [BaseItemKind.audio],
    enableUserData: true,
    enableImages: true,
    recursive: true,
    imageTypeLimit: 1,
    fields: [ItemFields.primaryimageaspectratio],
    sortBy: [
      ItemSortBy.playcount,
      ItemSortBy.productionyear,
      ItemSortBy.premieredate,
      ItemSortBy.datecreated,
      ItemSortBy.sortname,
    ],
    sortOrder: [SortOrder.descending],
    limit: limit,
  );

  return response.body?.items.whereType<AudioModel>().toList() ?? [];
}

final artistDetailsProvider =
    StateNotifierProvider.autoDispose.family<ArtistDetailsNotifier, ArtistModel?, String>((ref, id) {
  return ArtistDetailsNotifier(ref);
});

class ArtistDetailsNotifier extends StateNotifier<ArtistModel?> {
  ArtistDetailsNotifier(this.ref) : super(null);

  final Ref ref;
  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response?> fetchDetails(ItemBaseModel item) async {
    if (item is ArtistModel) {
      state = state ?? item;
    }

    final response = await api.usersUserIdItemsItemIdGet(itemId: item.id);
    if (!response.isSuccessful || response.body == null) {
      return response;
    }

    final current = state;
    final apiState = response.bodyOrThrow as ArtistModel;
    final newState = ArtistModel(
      name: apiState.name,
      id: apiState.id,
      overview: apiState.overview,
      parentId: apiState.parentId,
      playlistId: apiState.playlistId,
      images: apiState.images,
      childCount: apiState.childCount,
      primaryRatio: apiState.primaryRatio,
      userData: apiState.userData,
      albums: current?.albums ?? apiState.albums,
      tracks: current?.tracks ?? apiState.tracks,
      similarArtists: current?.similarArtists ?? apiState.similarArtists,
      providerIds: apiState.providerIds,
      canDelete: apiState.canDelete,
      canDownload: apiState.canDownload,
      jellyType: apiState.jellyType,
    );
    state = newState;
    await fetchTracks();
    await fetchAlbums();
    await fetchSimilarArtists();
    return response;
  }

  Future<void> fetchAlbums() async {
    if (state == null) return;
    try {
      final response = await api.itemsGet(
        parentId: state!.id,
        includeItemTypes: [BaseItemKind.musicalbum],
        enableUserData: true,
        enableImages: true,
        imageTypeLimit: 1,
        fields: [ItemFields.primaryimageaspectratio],
        sortBy: [ItemSortBy.sortname],
        sortOrder: [SortOrder.ascending],
        limit: 100,
      );

      final albums = response.body?.items.whereType<AlbumModel>().toList();
      if (albums != null) {
        final tracksResponse = await api.itemsGet(
          parentId: state!.id,
          includeItemTypes: [BaseItemKind.audio],
          enableUserData: false,
          recursive: true,
          fields: [ItemFields.candownload],
          limit: 5000,
        );

        final downloadableAlbumIds = tracksResponse.body?.items
                .whereType<AudioModel>()
                .where((track) => track.canDownload == true)
                .map((track) => track.albumId ?? track.parentId)
                .toSet() ??
            {};

        state = state?.copyWith(
          albums: albums
              .map(
                (album) => album.copyWith(
                  canDownload: album.canDownload == true || downloadableAlbumIds.contains(album.id),
                ),
              )
              .toList(),
        );
      }
    } catch (error, stack) {
      log('Failed to fetch albums for artist ${state?.id} due to $error',
          level: logging.Level.WARNING.value, error: error, stackTrace: stack);
    }
  }

  Future<void> fetchTracks({int limit = 10}) async {
    if (state == null) return;
    try {
      final tracks = await fetchArtistLatestTracks(api, state!.id, limit: limit);
      state = state?.copyWith(tracks: tracks);
    } catch (error, stack) {
      log('Failed to fetch tracks for artist ${state?.id} due to $error',
          level: logging.Level.WARNING.value, error: error, stackTrace: stack);
    }
  }

  Future<void> fetchSimilarArtists() async {
    if (state == null) return;
    try {
      final response = await api.itemsItemIdSimilarGet(itemId: state!.id, limit: 12);
      final related =
          response.body?.items?.map((item) => ItemBaseModel.fromBaseDto(item, ref)).whereType<ArtistModel>().toList();
      if (related != null) {
        final current = state!;
        state = ArtistModel(
          name: current.name,
          id: current.id,
          overview: current.overview,
          parentId: current.parentId,
          playlistId: current.playlistId,
          images: current.images,
          childCount: current.childCount,
          primaryRatio: current.primaryRatio,
          userData: current.userData,
          albums: current.albums,
          tracks: current.tracks,
          similarArtists: related,
          providerIds: current.providerIds,
          canDelete: current.canDelete,
          canDownload: current.canDownload,
          jellyType: current.jellyType,
        );
      }
    } catch (error, stack) {
      log('Failed to fetch similar artists for ${state?.id} due to $error',
          level: logging.Level.WARNING.value, error: error, stackTrace: stack);
    }
  }
}
