import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/pending_items_provider.dart';
import 'package:fladder/providers/websocket/jellyfin_websocket.dart';
import 'package:fladder/providers/websocket/jellyfin_websocket_provider.dart';

sealed class JellyfinWebSocketEvent {}

class JellyfinLibraryChanged extends JellyfinWebSocketEvent {
  JellyfinLibraryChanged({
    required this.addedIds,
    required this.updatedIds,
    required this.removedIds,
    this.folderIds = const {},
    this.libraryIds = const {},
  });

  final Set<String> addedIds;
  final Set<String> updatedIds;
  final Set<String> removedIds;
  final Set<String> folderIds;
  final Set<String> libraryIds;

  Set<String> get changedIds => {...addedIds, ...updatedIds};

  Set<String> get affectedIds => {...changedIds, ...removedIds, ...folderIds};
}

class JellyfinUserDataChanged extends JellyfinWebSocketEvent {
  JellyfinUserDataChanged({required this.userId, required this.items});

  final String? userId;
  final List<UserItemDataDto> items;

  Map<String, UserData> get userDataByItemId => {
        for (final item in items)
          if (item.itemId?.isNotEmpty == true) item.itemId!: UserData.fromDto(item),
      };

  bool isForUser(String? currentUserId) => userId == null || _normalizeId(userId!) == _normalizeId(currentUserId ?? '');
}

class JellyfinWebSocketReconnected extends JellyfinWebSocketEvent {}

String _normalizeId(String id) => id.replaceAll('-', '').toLowerCase();

final jellyfinWebSocketConnectedProvider = Provider<bool>(
  (ref) => ref.watch(jellyfinWebSocketControllerProvider) == WebSocketConnectionState.connected,
);

/// Typed events from the app-wide socket owned by [JellyfinWebSocketController], so the client keeps a
/// single connection to the server.
final jellyfinWebSocketProvider = StreamProvider<JellyfinWebSocketEvent>((ref) {
  if (ref.watch(offlineStateProvider)) return const Stream.empty();
  final socket = ref.watch(jellyfinWebSocketControllerProvider.notifier);
  final events = StreamController<JellyfinWebSocketEvent>();
  var wasConnected = socket.currentState == WebSocketConnectionState.connected;
  final subscriptions = [
    socket.connectionState.listen((state) {
      if (state != WebSocketConnectionState.connected) return;
      if (wasConnected) events.add(JellyfinWebSocketReconnected());
      wasConnected = true;
    }),
    socket.messages.listen((message) {
      final event = _parseEvent(message);
      if (event != null) events.add(event);
    }),
  ];
  ref.onDispose(() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    events.close();
  });
  return events.stream;
});

JellyfinWebSocketEvent? _parseEvent(Map<String, dynamic> json) {
  try {
    switch (sessionMessageTypeNullableFromJson(json['MessageType'])) {
      case SessionMessageType.librarychanged:
        final data = LibraryChangedMessage.fromJson(json).data;
        return data != null ? _libraryChanged(data) : null;
      case SessionMessageType.userdatachanged:
        final data = UserDataChangedMessage.fromJson(json).data;
        return data != null ? _userDataChanged(data) : null;
      default:
        return null;
    }
  } catch (error) {
    developer.log('Jellyfin websocket: unreadable ${json['MessageType']} message: ${error.runtimeType}');
    return null;
  }
}

class LatestRequests {
  final Map<Object, int> _revisions = {};
  int _revision = 0;

  int start(Object key) => startAll([key]);

  int startAll(Iterable<Object> keys) {
    final revision = ++_revision;
    for (final key in keys) {
      _revisions[key] = revision;
    }
    return revision;
  }

  bool isLatest(Object key, int revision) => _revisions[key] == revision;

  void invalidate(Iterable<Object> keys) => keys.forEach(_revisions.remove);

  void clear() => _revisions.clear();

  Future<ItemBaseModel?> fetchItem(Ref ref, String id) async {
    final revision = start(id);
    final pendingItems = ref.read(pendingItemsProvider.notifier)..add(id);
    try {
      final api = ref.read(jellyApiProvider);
      final response = await api.api.itemsItemIdGet(userId: api.account?.id, itemId: id);
      final dto = response.body;
      if (!response.isSuccessful || dto == null || !isLatest(id, revision)) return null;
      return ItemBaseModel.fromBaseDto(dto, ref);
    } catch (_) {
      return null;
    } finally {
      pendingItems.remove(id);
    }
  }
}

JellyfinLibraryChanged _libraryChanged(LibraryUpdateInfo data) {
  Set<String> ids(List<String>? values) => {...?values}.where((id) => id.isNotEmpty).toSet();
  return JellyfinLibraryChanged(
    addedIds: ids(data.itemsAdded),
    updatedIds: ids(data.itemsUpdated),
    removedIds: ids(data.itemsRemoved),
    folderIds: ids([...?data.foldersAddedTo, ...?data.foldersRemovedFrom]),
    libraryIds: ids(data.collectionFolders),
  );
}

JellyfinUserDataChanged _userDataChanged(UserDataChangeInfo data) {
  return JellyfinUserDataChanged(
    userId: data.userId,
    items: data.userDataList ?? const [],
  );
}
