import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/home_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/dashboard_filters_mixin.dart';
import 'package:fladder/providers/jellyfin_websocket_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/views_provider.dart';

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

enum _MusicRows { playlists, recentlyAdded, played, favourites }

class MusicDashboardNotifier extends StateNotifier<MusicDashboardModel>
    with DashboardFiltersMixin<MusicDashboardModel> {
  MusicDashboardNotifier(this.ref) : super(const MusicDashboardModel()) {
    ref.listen(jellyfinWebSocketProvider, (previous, next) {
      next.whenData(_handleWebSocketEvent);
    });
  }

  @override
  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  @override
  FilterSortKey get filterSortKey => FilterSortKey.musicDashboard;

  @override
  List<DashboardFilterModel> get dashboardFilters => state.dashboardFilters;

  @override
  set dashboardFilters(List<DashboardFilterModel> filters) => state = state.copyWith(dashboardFilters: filters);

  Timer? _userDataTimer;
  bool _playedChanged = false;
  bool _favouritesChanged = false;

  void _handleWebSocketEvent(JellyfinWebSocketEvent event) {
    switch (event) {
      case JellyfinUserDataChanged():
        if (!event.isForUser(ref.read(userProvider)?.id)) return;
        final userData = event.userDataByItemId;
        requests.invalidate(userData.keys);
        if (_musicItems().isNotEmpty) _scheduleUserDataRefresh(userData);
        _updateMusicItems(
          (item) => userData[item.id] == null ? item : item.copyWith(userData: userData[item.id]!),
        );
      case JellyfinLibraryChanged():
        _removeMusicItems(event.removedIds);
        final loadedIds = _musicItems().map((item) => item.id).toSet();
        for (final id in event.updatedIds.intersection(loadedIds)) {
          unawaited(_fetchChangedItem(id));
        }
        if (event.addedIds.isNotEmpty && loadedIds.isNotEmpty) {
          unawaited(_fetchRows([
            if (_affects(event.libraryIds, CollectionType.music)) _MusicRows.recentlyAdded,
            if (_affects(event.libraryIds, CollectionType.playlists)) _MusicRows.playlists,
          ]));
          final libraryIds = {...event.libraryIds, ...event.folderIds};
          unawaited(refreshDashboardFilters((filter) => filter.includesLibrary(libraryIds)));
        }
      case JellyfinWebSocketReconnected():
        if (_musicItems().isNotEmpty) unawaited(fetchMusicHome(silent: true));
    }
  }

  bool _affects(Set<String> libraryIds, CollectionType type) =>
      libraryIds.isEmpty ||
      ref.read(viewsProvider).views.any((view) => view.collectionType == type && libraryIds.contains(view.id));

  void _scheduleUserDataRefresh(Map<String, UserData> userData) {
    final played = {
      for (final item in [...state.recentlyPlayedSongs, ...state.mostPlayed]) item.id: item.userData
    };
    final favouriteIds = state.recentlyFavoritedSongs.map((item) => item.id).toSet();
    _playedChanged |= userData.entries.any((entry) => entry.value.played
        ? !played.containsKey(entry.key) || played[entry.key]!.lastPlayed != entry.value.lastPlayed
        : played.containsKey(entry.key));
    _favouritesChanged |= userData.entries.any((entry) => entry.value.isFavourite != favouriteIds.contains(entry.key));
    _userDataTimer?.cancel();
    _userDataTimer = Timer(const Duration(seconds: 1), _refreshUserDataRows);
  }

  Future<void> _refreshUserDataRows() async {
    final played = _playedChanged;
    final favourites = _favouritesChanged;
    _playedChanged = _favouritesChanged = false;
    await Future.wait([
      _fetchRows([if (played) _MusicRows.played, if (favourites) _MusicRows.favourites]),
      refreshDashboardFilters((filter) => filter.usesUserData),
    ]);
  }

  List<ItemBaseModel> _musicItems() => [
        ...state.playlists,
        ...state.recentlyAddedAlbums,
        ...state.recentlyAddedSongs,
        ...state.recentlyPlayedSongs,
        ...state.recentlyAddedArtists,
        ...state.mostPlayed,
        ...state.recentlyFavoritedSongs,
        ...state.dashboardFilters.expand((filter) => filter.items),
      ];

  void _updateMusicItems(ItemBaseModel Function(ItemBaseModel) update) {
    List<T> updateTyped<T extends ItemBaseModel>(List<T> items) => items.map((item) {
          final updated = update(item);
          return updated is T ? updated : item;
        }).toList();

    state = state.copyWith(
      playlists: updateTyped(state.playlists),
      recentlyAddedAlbums: updateTyped(state.recentlyAddedAlbums),
      recentlyAddedSongs: updateTyped(state.recentlyAddedSongs),
      recentlyPlayedSongs: updateTyped(state.recentlyPlayedSongs),
      recentlyAddedArtists: updateTyped(state.recentlyAddedArtists),
      mostPlayed: updateTyped(state.mostPlayed),
      recentlyFavoritedSongs: updateTyped(state.recentlyFavoritedSongs),
      dashboardFilters: state.dashboardFilters
          .map((filter) => DashboardFilterModel(filter: filter.filter, items: updateTyped(filter.items)))
          .toList(),
    );
  }

  void _removeMusicItems(Set<String> ids) {
    if (ids.isEmpty) return;
    requests.invalidate(ids);
    List<T> removeFrom<T extends ItemBaseModel>(List<T> items) =>
        items.where((item) => !ids.contains(item.id)).toList();

    state = state.copyWith(
      playlists: removeFrom(state.playlists),
      recentlyAddedAlbums: removeFrom(state.recentlyAddedAlbums),
      recentlyAddedSongs: removeFrom(state.recentlyAddedSongs),
      recentlyPlayedSongs: removeFrom(state.recentlyPlayedSongs),
      recentlyAddedArtists: removeFrom(state.recentlyAddedArtists),
      mostPlayed: removeFrom(state.mostPlayed),
      recentlyFavoritedSongs: removeFrom(state.recentlyFavoritedSongs),
      dashboardFilters: state.dashboardFilters
          .map((filter) => DashboardFilterModel(filter: filter.filter, items: removeFrom(filter.items)))
          .toList(),
    );
  }

  Future<void> refreshItem(String id) async {
    if (_musicItems().any((item) => item.id == id)) await _fetchChangedItem(id);
  }

  Future<void> _fetchChangedItem(String id) async {
    final item = await requests.fetchItem(ref, id);
    if (item != null) _updateMusicItems((current) => current.id == id ? item : current);
  }

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

  static const _enableImageTypes = [
    ImageType.primary,
    ImageType.backdrop,
    ImageType.thumb,
    ImageType.logo,
  ];

  static const _fields = [
    ItemFields.parentid,
    ItemFields.mediastreams,
    ItemFields.mediasources,
    ItemFields.candelete,
    ItemFields.candownload,
    ItemFields.primaryimageaspectratio,
    ItemFields.overview,
    ItemFields.datecreated,
    ItemFields.tags,
  ];

  static const _posterLimit = 16;
  static const _trackLimit = 20;

  Future<Response<ServerQueryResult>> _recentlyAdded(BaseItemKind kind, int limit) => api.itemsGet(
        includeItemTypes: [kind],
        sortBy: [ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        enableImageTypes: _enableImageTypes,
        fields: _fields,
        limit: limit,
      );

  Future<Response<ServerQueryResult>> _playlists() => api.itemsGet(
        includeItemTypes: [BaseItemKind.playlist],
        sortBy: [ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        enableImageTypes: _enableImageTypes,
        fields: _fields,
        limit: _posterLimit,
      );

  Future<Response<ServerQueryResult>> _mostPlayed() => api.itemsGet(
        includeItemTypes: [BaseItemKind.musicalbum],
        sortBy: [ItemSortBy.playcount],
        sortOrder: [SortOrder.descending],
        recursive: true,
        enableImageTypes: _enableImageTypes,
        fields: _fields,
        limit: _posterLimit,
      );

  Future<Response<ServerQueryResult>> _playedSongs({bool? isFavorite}) => api.itemsGet(
        includeItemTypes: [BaseItemKind.audio],
        sortBy: [ItemSortBy.dateplayed, ItemSortBy.datecreated],
        sortOrder: [SortOrder.descending],
        recursive: true,
        isPlayed: isFavorite == true ? null : true,
        isFavorite: isFavorite,
        enableImageTypes: _enableImageTypes,
        fields: _fields,
        limit: _trackLimit,
      );

  List<ItemBaseModel> _items(Response<ServerQueryResult> response) => response.body?.items ?? const <ItemBaseModel>[];

  List<AudioModel> _songs(Response<ServerQueryResult> response) =>
      response.body?.items.whereType<AudioModel>().toList() ?? const <AudioModel>[];

  Future<MusicDashboardModel Function(MusicDashboardModel)> _load(_MusicRows rows) async {
    switch (rows) {
      case _MusicRows.playlists:
        final playlists = await _playlists();
        return (MusicDashboardModel model) => model.copyWith(
              playlists: playlists.body?.items.whereType<PlaylistModel>().toList() ?? const <PlaylistModel>[],
            );
      case _MusicRows.recentlyAdded:
        final [albums, songs, artists] = await Future.wait([
          _recentlyAdded(BaseItemKind.musicalbum, _posterLimit),
          _recentlyAdded(BaseItemKind.audio, _trackLimit),
          _recentlyAdded(BaseItemKind.musicartist, _posterLimit),
        ]);
        return (MusicDashboardModel model) => model.copyWith(
              recentlyAddedAlbums: _items(albums),
              recentlyAddedSongs: _songs(songs),
              recentlyAddedArtists: _items(artists),
            );
      case _MusicRows.played:
        final [mostPlayed, recentlyPlayed] = await Future.wait([_mostPlayed(), _playedSongs()]);
        return (MusicDashboardModel model) =>
            model.copyWith(mostPlayed: _items(mostPlayed), recentlyPlayedSongs: _songs(recentlyPlayed));
      case _MusicRows.favourites:
        final favourites = await _playedSongs(isFavorite: true);
        return (MusicDashboardModel model) => model.copyWith(recentlyFavoritedSongs: _songs(favourites));
    }
  }

  Future<void> _fetchRows(List<_MusicRows> rows) async {
    if (rows.isEmpty) return;
    final revision = requests.startAll(rows);
    try {
      final updates = await Future.wait(rows.map(_load));
      var next = state;
      for (final (index, update) in updates.indexed) {
        if (requests.isLatest(rows[index], revision)) next = update(next);
      }
      state = next;
    } catch (_) {}
  }

  Future<void> fetchMusicHome({bool silent = false}) async {
    if (state.loading) return;
    if (!silent) state = state.copyWith(loading: true);
    try {
      await Future.wait([_fetchRows(_MusicRows.values), fetchDashboardFilters()]);
    } catch (_) {
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void clear() {
    _userDataTimer?.cancel();
    _playedChanged = _favouritesChanged = false;
    requests.clear();
    state = const MusicDashboardModel();
  }

  @override
  void dispose() {
    _userDataTimer?.cancel();
    super.dispose();
  }
}
