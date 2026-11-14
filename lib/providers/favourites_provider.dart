import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/favourites_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/jellyfin_websocket_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';

final favouritesProvider = StateNotifierProvider<FavouritesNotifier, FavouritesModel>((ref) {
  return FavouritesNotifier(ref);
});

class FavouritesNotifier extends StateNotifier<FavouritesModel> {
  FavouritesNotifier(this.ref) : super(FavouritesModel()) {
    ref.listen(jellyfinWebSocketProvider, (previous, next) {
      next.whenData(_handleWebSocketEvent);
    });
  }

  final Ref ref;

  late final api = ref.read(jellyApiProvider);

  bool _fetched = false;
  Timer? _refreshTimer;

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _handleWebSocketEvent(JellyfinWebSocketEvent event) {
    if (!_fetched) return;
    final favouriteIds = [...state.favourites.values.expand((items) => items), ...state.people].map((item) => item.id);
    final affected = switch (event) {
      JellyfinUserDataChanged() => event.isForUser(ref.read(userProvider)?.id) &&
          event.userDataByItemId.entries.any((entry) => entry.value.isFavourite != favouriteIds.contains(entry.key)),
      JellyfinLibraryChanged() => favouriteIds.any({...event.updatedIds, ...event.removedIds}.contains),
      JellyfinWebSocketReconnected() => true,
    };
    if (!affected) return;
    _refreshTimer?.cancel();
    _refreshTimer = Timer(const Duration(milliseconds: 750), () => unawaited(fetchFavourites()));
  }

  Future<void> fetchFavourites() async {
    try {
      if (state.loading) return;

      _fetched = true;
      state = state.copyWith(loading: true);
      await _fetchMoviesAndSeries();
      await _fetchPeople();
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> _fetchMoviesAndSeries() async {
    final views = ref.read(viewsProvider);

    final mappedList = await Future.wait(views.dashboardViews.map((viewModel) => _loadLibrary(viewModel: viewModel)));

    state = state.copyWith(
        favourites: (mappedList
                .expand((innerList) => innerList ?? [])
                .where((item) => item != null)
                .cast<ItemBaseModel>()
                .toList())
            .groupedItems);
  }

  Future<List<ItemBaseModel>?> _loadLibrary({ViewModel? viewModel}) async {
    final kinds = [
      BaseItemKind.movie,
      BaseItemKind.episode,
      BaseItemKind.series,
      BaseItemKind.video,
      BaseItemKind.photo,
      BaseItemKind.book,
      BaseItemKind.photoalbum,
      BaseItemKind.musicalbum,
      BaseItemKind.audio,
    ];
    final futures = kinds.map((kind) => fetchTypes(viewModel?.id, [kind])).toList();
    final results = await Future.wait(futures);
    return results.expand((list) => list).toList();
  }

  Future<List<ItemBaseModel>> fetchTypes(String? id, List<BaseItemKind>? includeItemTypes) async {
    return (await api.itemsGet(
          parentId: id,
          isFavorite: true,
          recursive: true,
          limit: 15,
          fields: [
            ItemFields.overview,
            ItemFields.genres,
            ItemFields.parentid,
          ],
          includeItemTypes: includeItemTypes,
          sortOrder: [SortOrder.ascending],
          sortBy: [ItemSortBy.seriessortname, ItemSortBy.sortname, ItemSortBy.datelastcontentadded],
        ))
            .body
            ?.items ??
        [];
  }

  Future<Response<List<ItemBaseModel>>?> _fetchPeople() async {
    final response = await api.personsGet(
      limit: 20,
      isFavorite: true,
    );
    state = state.copyWith(people: response.body ?? []);
    return response;
  }

  void setSearch(String value) {
    state = state.copyWith(searchQuery: value);
  }

  void clear() {
    _fetched = false;
    state = FavouritesModel();
  }
}
