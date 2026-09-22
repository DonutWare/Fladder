import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/util/map_bool_helper.dart';

final playlistStateProvider = StateProvider<List<PlaylistModel>>((ref) => []);

class _PlaylistProviderModel {
  final bool isLoading;
  final List<ItemBaseModel> items;
  final Map<PlaylistModel, bool?> collections;
  _PlaylistProviderModel({
    this.isLoading = false,
    required this.items,
    required this.collections,
  });

  _PlaylistProviderModel copyWith({
    bool? isLoading,
    List<ItemBaseModel>? items,
    Map<PlaylistModel, bool?>? collections,
  }) {
    return _PlaylistProviderModel(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      collections: collections ?? this.collections,
    );
  }
}

final playlistProvider = StateNotifierProvider.autoDispose<PlaylistNotifier, _PlaylistProviderModel>((ref) {
  final notifier = PlaylistNotifier(ref)..setItems([]);
  return notifier;
});

class PlaylistNotifier extends StateNotifier<_PlaylistProviderModel> {
  PlaylistNotifier(this.ref) : super(_PlaylistProviderModel(items: [], collections: {}));
  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<void> setItems(List<ItemBaseModel> items) async {
    final playlists = ref.read(playlistStateProvider);
    state = state.copyWith(
      collections: Map.fromIterables(playlists, List.generate(playlists.length, (index) => null)),
      items: items,
      isLoading: true,
    );
    return _init();
  }

  Future<void> _init() async {
    final serverPlaylists = await api.usersUserIdItemsGet(
      recursive: true,
      includeItemTypes: [
        BaseItemKind.playlist,
      ],
    );

    final playlists = serverPlaylists.body?.items?.map((e) => PlaylistModel.fromBaseDto(e, ref)).toList();

    ref.read(playlistStateProvider.notifier).state = playlists ?? [];

    state = state.copyWith(
      collections: Map.fromIterables(playlists ?? [], List.generate(playlists?.length ?? 0, (index) => null)),
    );

    playlists?.forEach(
      (playlist) async {
        final itemList = await api.playlistsPlaylistIdItemsGet(
          playlistId: playlist.id,
          enableImages: false,
          enableUserData: false,
          fields: [],
        );
        final List<String?> items = (itemList.body?.items ?? []).map((e) => e.id).toList();
        state = state.copyWith(
          collections: state.collections.setKey(playlist, items.contains(state.items.firstOrNull?.id)),
        );
      },
    );

    state = state.copyWith(isLoading: false);
  }

  Future<Response> addToPlaylist({required PlaylistModel playlist}) async {
    final response =
        await api.playlistsPlaylistIdItemsPost(playlistId: playlist.id, ids: state.items.map((e) => e.id).toList());
    if (response.isSuccessful) {
      await _init();
    }
    return response;
  }

  Future<Response> removeFromPlaylist({required PlaylistModel playlist}) async {
    final response = await api.playlistsPlaylistIdItemsDelete(
        playlistId: playlist.id, entryIds: state.items.map((e) => e.id).toList());
    if (response.isSuccessful) {
      await _init();
    }
    return response;
  }

  Future<Response> addToNewPlaylist({required String name}) async {
    final result = await api.playlistsPost(name: name, ids: state.items.map((e) => e.id).toList(), body: null);
    if (result.isSuccessful) {
      await _init();
    }
    return result;
  }
}
