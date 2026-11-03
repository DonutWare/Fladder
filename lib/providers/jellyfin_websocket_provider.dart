import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/pending_items_provider.dart';
import 'package:fladder/providers/user_provider.dart';

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

final jellyfinWebSocketConnectedProvider = StateProvider<bool>((ref) => false);

final jellyfinWebSocketProvider = StreamProvider<JellyfinWebSocketEvent>((ref) {
  if (ref.watch(offlineStateProvider)) return const Stream.empty();
  final serverUrl = ref.watch(serverUrlProvider);
  final credentials = ref.watch(userProvider.select((account) => account?.credentials)) ??
      ref.watch(authProvider.select((state) => state.serverLoginModel?.tempCredentials));
  final uri = _webSocketUri(serverUrl, credentials);
  if (uri == null || credentials == null) return const Stream.empty();
  final connected = ref.read(jellyfinWebSocketConnectedProvider.notifier);
  final socket = _JellyfinWebSocket(uri, credentials.header(ref), (value) => connected.state = value);
  ref.onDispose(socket.close);
  return socket.events;
});

Uri? _webSocketUri(String? serverUrl, CredentialsModel? credentials) {
  if (serverUrl == null || credentials == null || credentials.token.isEmpty) return null;
  final uri = buildServerUriFromBase(
    serverUrl,
    pathSegments: const ['socket'],
    queryParameters: {
      'api_key': credentials.token,
      'deviceId': credentials.deviceId,
    },
  );
  return uri?.replace(scheme: uri.scheme == 'https' ? 'wss' : 'ws');
}

class _JellyfinWebSocket {
  _JellyfinWebSocket(this.uri, this.headers, this.onConnectionChanged) {
    _connect();
  }

  final Uri uri;
  final Map<String, String> headers;
  final void Function(bool connected) onConnectionChanged;
  final _events = StreamController<JellyfinWebSocketEvent>();

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _keepAliveTimer;
  Timer? _reconnectTimer;
  int _retryDelay = 1;
  bool _connected = false;
  bool _closed = false;

  Stream<JellyfinWebSocketEvent> get events => _events.stream;

  Future<void> _connect() async {
    final channel = kIsWeb ? WebSocketChannel.connect(uri) : IOWebSocketChannel.connect(uri, headers: headers);
    _channel = channel;
    try {
      await channel.ready;
    } catch (error) {
      developer.log('Jellyfin websocket failed: ${error.runtimeType}');
      _reconnect();
      return;
    }
    if (_closed) return;
    _retryDelay = 1;
    if (_connected) _events.add(JellyfinWebSocketReconnected());
    _connected = true;
    onConnectionChanged(true);
    _subscription = channel.stream.listen(_handleMessage, onDone: _reconnect, onError: (_) {});
  }

  void _reconnect() {
    _keepAliveTimer?.cancel();
    if (_closed) return;
    onConnectionChanged(false);
    _reconnectTimer = Timer(Duration(seconds: _retryDelay), _connect);
    _retryDelay = (_retryDelay * 2).clamp(1, 30);
  }

  void _handleMessage(dynamic message) {
    try {
      final json = jsonDecode(message is String ? message : utf8.decode(message as List<int>));
      if (json is! Map<String, dynamic>) return;
      switch (sessionMessageTypeNullableFromJson(json['MessageType'])) {
        case SessionMessageType.forcekeepalive:
          _startKeepAlive(ForceKeepAliveMessage.fromJson(json).data);
        case SessionMessageType.librarychanged:
          final data = LibraryChangedMessage.fromJson(json).data;
          if (data != null) _events.add(_libraryChanged(data));
        case SessionMessageType.userdatachanged:
          final data = UserDataChangedMessage.fromJson(json).data;
          if (data != null) _events.add(_userDataChanged(data));
        default:
      }
    } catch (_) {}
  }

  void _startKeepAlive(int? timeout) {
    final seconds = timeout != null && timeout > 0 ? timeout : 60;
    _keepAliveTimer?.cancel();
    _sendKeepAlive();
    _keepAliveTimer = Timer.periodic(Duration(milliseconds: seconds * 500), (_) => _sendKeepAlive());
  }

  void _sendKeepAlive() => _channel?.sink.add(
        jsonEncode(const InboundKeepAliveMessage(messageType: SessionMessageType.keepalive).toJson()),
      );

  void close() {
    _closed = true;
    onConnectionChanged(false);
    _keepAliveTimer?.cancel();
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _channel?.sink.close();
    _events.close();
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
