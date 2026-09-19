import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/home_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/library_filters_provider.dart';
import 'package:fladder/providers/service_provider.dart';

final musicDashboardProvider = StateNotifierProvider<MusicDashboardNotifier, MusicDashboardModel>((ref) {
  return MusicDashboardNotifier(ref);
});

enum MusicTrackSection {
  recentlyAdded,
  recentlyPlayed,
  recentlyFavorited,
}

class MusicDashboardModel {
  final bool loading;
  final List<PlaylistModel> playlists;
  final List<ItemBaseModel> recentlyAddedAlbums;
  final List<AudioModel> recentlyAddedSongs;
  final List<AudioModel> recentlyPlayedSongs;
  final List<ItemBaseModel> recentlyAddedArtists;
  final List<ItemBaseModel> mostPlayed;
  final List<AudioModel> recentlyFavoritedSongs;
  final List<DashboardFilterModel> dashboardFilters;

  const MusicDashboardModel({
    this.loading = false,
    this.playlists = const [],
    this.recentlyAddedAlbums = const [],
    this.recentlyAddedSongs = const [],
    this.recentlyPlayedSongs = const [],
    this.recentlyAddedArtists = const [],
    this.mostPlayed = const [],
    this.recentlyFavoritedSongs = const [],
    this.dashboardFilters = const [],
  });

  MusicDashboardModel copyWith({
    bool? loading,
    List<PlaylistModel>? playlists,
    List<ItemBaseModel>? recentlyAddedAlbums,
    List<AudioModel>? recentlyAddedSongs,
    List<AudioModel>? recentlyPlayedSongs,
    List<ItemBaseModel>? recentlyAddedArtists,
    List<ItemBaseModel>? mostPlayed,
    List<AudioModel>? recentlyFavoritedSongs,
    List<DashboardFilterModel>? dashboardFilters,
  }) {
    return MusicDashboardModel(
      loading: loading ?? this.loading,
      playlists: playlists ?? this.playlists,
      recentlyAddedAlbums: recentlyAddedAlbums ?? this.recentlyAddedAlbums,
      recentlyAddedSongs: recentlyAddedSongs ?? this.recentlyAddedSongs,
      recentlyPlayedSongs: recentlyPlayedSongs ?? this.recentlyPlayedSongs,
      recentlyAddedArtists: recentlyAddedArtists ?? this.recentlyAddedArtists,
      mostPlayed: mostPlayed ?? this.mostPlayed,
      recentlyFavoritedSongs: recentlyFavoritedSongs ?? this.recentlyFavoritedSongs,
      dashboardFilters: dashboardFilters ?? this.dashboardFilters,
    );
  }
}

class MusicDashboardNotifier extends StateNotifier<MusicDashboardModel> {
  MusicDashboardNotifier(this.ref) : super(const MusicDashboardModel()) {
    ref.listen(
      libraryFiltersByKeyProvider(FilterSortKey.musicDashboard),
      (previous, next) {
        const listEquality = ListEquality<LibraryFiltersModel>();
        if (!listEquality.equals(previous, next)) {
          fetchMusicHome();
        }
      },
      fireImmediately: false,
    );
  }

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<List<ItemBaseModel>> fetchTrackQueue({required MusicTrackSection section, int limit = 200}) async {
    final isFavorite = section == MusicTrackSection.recentlyFavorited;
    final isRecentlyAdded = section == MusicTrackSection.recentlyAdded;

    final response = await api.itemsGet(
      includeItemTypes: [BaseItemKind.audio],
      sortBy: isRecentlyAdded ? [ItemSortBy.datecreated] : [ItemSortBy.dateplayed, ItemSortBy.datecreated],
      sortOrder: [SortOrder.descending],
      recursive: true,
      isPlayed: isRecentlyAdded ? null : true,
      isFavorite: isFavorite ? true : null,
      enableUserData: true,
      enableImages: true,
      imageTypeLimit: 1,
      fields: [
        ItemFields.primaryimageaspectratio,
        ItemFields.mediasources,
        ItemFields.mediastreams,
        ItemFields.parentid,
        ItemFields.overview,
      ],
      limit: limit,
    );

    return response.body?.items.whereType<AudioModel>().toList() ?? const <ItemBaseModel>[];
  }

  static const _dashboardFilterLimit = 15;

  Future<List<DashboardFilterModel>> _fetchDashboardFilters() async {
    final filters = ref.read(libraryFiltersByKeyProvider(FilterSortKey.musicDashboard));
    return Future.wait(
      filters.map(
        (e) => e.fetchDashboardFilter(ref, limit: _dashboardFilterLimit),
      ),
    );
  }

  Future<void> fetchMusicHome() async {
    if (state.loading) return;
    state = state.copyWith(loading: true);

    final enableImageTypes = [
      ImageType.primary,
      ImageType.backdrop,
      ImageType.thumb,
      ImageType.logo,
    ];

    final fields = {
      ItemFields.parentid,
      ItemFields.mediastreams,
      ItemFields.mediasources,
      ItemFields.candelete,
      ItemFields.candownload,
      ItemFields.primaryimageaspectratio,
      ItemFields.overview,
      ItemFields.datecreated,
      ItemFields.tags,
    }.toList();

    try {
      const posterLimit = 16;
      const trackLimit = 20;

      final playlistsFuture = api.itemsGet(
        includeItemTypes: [BaseItemKind.playlist],
        sortBy: [ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        enableImageTypes: enableImageTypes,
        fields: fields,
        limit: posterLimit,
      );

      final recentlyAddedAlbumsFuture = api.itemsGet(
        includeItemTypes: [BaseItemKind.musicalbum],
        sortBy: [ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        enableImageTypes: enableImageTypes,
        fields: fields,
        limit: posterLimit,
      );

      final recentlyAddedSongsFuture = api.itemsGet(
        includeItemTypes: [BaseItemKind.audio],
        sortBy: [ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        enableImageTypes: enableImageTypes,
        fields: fields,
        limit: trackLimit,
      );

      final recentlyAddedArtistsFuture = api.itemsGet(
        includeItemTypes: [BaseItemKind.musicartist],
        sortBy: [ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        enableImageTypes: enableImageTypes,
        fields: fields,
        limit: posterLimit,
      );

      final mostPlayedFuture = api.itemsGet(
        includeItemTypes: [BaseItemKind.musicalbum],
        sortBy: [ItemSortBy.playcount],
        sortOrder: [SortOrder.descending],
        recursive: true,
        enableImageTypes: enableImageTypes,
        fields: fields,
        limit: posterLimit,
      );

      final recentlyPlayedSongsFuture = api.itemsGet(
        includeItemTypes: [BaseItemKind.audio],
        sortBy: [ItemSortBy.dateplayed, ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        isPlayed: true,
        enableImageTypes: enableImageTypes,
        fields: fields,
        limit: trackLimit,
      );

      final recentlyFavoritedSongsFuture = api.itemsGet(
        includeItemTypes: [BaseItemKind.audio],
        sortBy: [ItemSortBy.dateplayed, ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        isFavorite: true,
        enableImageTypes: enableImageTypes,
        fields: fields,
        limit: trackLimit,
      );

      final [
        playlistsResponse,
        recentlyAddedAlbumsResponse,
        recentlyAddedSongsResponse,
        recentlyAddedArtistsResponse,
        mostPlayedResponse,
        recentlyPlayedSongsResponse,
        recentlyFavoritedSongsResponse,
      ] = await Future.wait([
        playlistsFuture,
        recentlyAddedAlbumsFuture,
        recentlyAddedSongsFuture,
        recentlyAddedArtistsFuture,
        mostPlayedFuture,
        recentlyPlayedSongsFuture,
        recentlyFavoritedSongsFuture,
      ]);

      final playlists = playlistsResponse.body?.items.whereType<PlaylistModel>().toList() ?? const <PlaylistModel>[];
      final recentlyAddedAlbums = recentlyAddedAlbumsResponse.body?.items ?? const <ItemBaseModel>[];
      final recentlyAddedSongs =
          recentlyAddedSongsResponse.body?.items.whereType<AudioModel>().toList() ?? const <AudioModel>[];
      final recentlyAddedArtists = recentlyAddedArtistsResponse.body?.items ?? const <ItemBaseModel>[];
      final mostPlayed = mostPlayedResponse.body?.items ?? const <ItemBaseModel>[];
      final recentlyPlayedSongs =
          recentlyPlayedSongsResponse.body?.items.whereType<AudioModel>().toList() ?? const <AudioModel>[];
      final recentlyFavoritedSongs =
          recentlyFavoritedSongsResponse.body?.items.whereType<AudioModel>().toList() ?? const <AudioModel>[];

      final dashboardFilters = await _fetchDashboardFilters();

      state = state.copyWith(
        playlists: playlists,
        recentlyAddedAlbums: recentlyAddedAlbums,
        recentlyAddedSongs: recentlyAddedSongs,
        recentlyPlayedSongs: recentlyPlayedSongs,
        recentlyAddedArtists: recentlyAddedArtists,
        mostPlayed: mostPlayed,
        recentlyFavoritedSongs: recentlyFavoritedSongs,
        loading: false,
        dashboardFilters: dashboardFilters,
      );
    } catch (_) {
      state = state.copyWith(loading: false);
    }
  }

  void clear() {
    state = const MusicDashboardModel();
  }
}
