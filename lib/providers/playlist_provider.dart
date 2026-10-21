import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/util/map_bool_helper.dart';

/// Playlist membership lookups kept in flight at once. Sending them all at
/// once floods the connection on libraries holding hundreds of playlists, and
/// every other request queues up behind them.
const _membershipLookupConcurrency = 5;

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

    final playlists = serverPlaylists.body?.items?.map((e) => PlaylistModel.fromBaseDto(e, ref)).toList() ?? [];

    ref.read(playlistStateProvider.notifier).state = playlists;

    state = state.copyWith(
      collections: Map.fromIterables(playlists, List.generate(playlists.length, (index) => null)),
    );

    await _markPlaylistsHoldingItem(playlists);

    state = state.copyWith(isLoading: false);
  }

  /// Marks the playlists that already hold the item being added.
  ///
  /// Jellyfin has no bulk endpoint for this, so it costs one request per
  /// playlist and they are spread over [_membershipLookupConcurrency] workers.
  Future<void> _markPlaylistsHoldingItem(List<PlaylistModel> playlists) async {
    final itemId = state.items.firstOrNull?.id;

    // The provider is built with an empty item list, so without this the
    // lookups would run on startup with nothing to look for.
    if (itemId == null || playlists.isEmpty) {
      state = state.copyWith(collections: {for (final playlist in playlists) playlist: false});
      return;
    }

    var next = 0;

    Future<void> resolveNext() async {
      while (mounted) {
        final index = next++;
        if (index >= playlists.length) return;

        final playlist = playlists[index];
        final holdsItem = await _playlistHoldsItem(playlist, itemId);
        if (!mounted) return;

        state = state.copyWith(collections: state.collections.setKey(playlist, holdsItem));
      }
    }

    await Future.wait(List.generate(_membershipLookupConcurrency, (_) => resolveNext()));
  }

  /// Whether [playlist] contains [itemId], or null when it could not be read.
  Future<bool?> _playlistHoldsItem(PlaylistModel playlist, String itemId) async {
    try {
      final itemList = await api.playlistsPlaylistIdItemsGet(
        playlistId: playlist.id,
        enableImages: false,
        enableUserData: false,
        fields: [],
      );
      return itemList.body?.items.any((item) => item.id == itemId) ?? false;
    } catch (e) {
      // One unreadable playlist should not take the whole sheet down with it.
      log('Could not read the items of playlist ${playlist.id}: $e');
      return null;
    }
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
