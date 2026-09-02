import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart' as connectivity;
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/websocket/jellyfin_websocket.dart';

part 'jellyfin_websocket_provider.g.dart';

/// Phone-only: on foreground it reconnects only if the socket died in the background. `inactive` is
/// ignored because Android raises it for the notification shade, dialogs, PiP and call banners.
class _WebSocketLifecycleObserver with WidgetsBindingObserver {
  _WebSocketLifecycleObserver(this._controller);

  final JellyfinWebSocketController _controller;

  void register() => WidgetsBinding.instance.addObserver(this);
  void unregister() => WidgetsBinding.instance.removeObserver(this);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        unawaited(_controller.ensureConnected(reason: 'app resumed'));
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }
}

/// Owns a single [JellyfinWebSocket], connects when a user is authenticated, and re-broadcasts its
/// streams through long-lived controllers so consumers survive account switches / socket rebuilds.
@Riverpod(keepAlive: true)
class JellyfinWebSocketController extends _$JellyfinWebSocketController {
  JellyfinWebSocket? _socket;
  StreamSubscription<WebSocketConnectionState>? _socketStateSub;
  StreamSubscription<Map<String, dynamic>>? _socketMessageSub;
  _WebSocketLifecycleObserver? _observer;

  // Serializes socket teardown/rebuild so two quick auth changes cannot leak or duplicate a socket.
  Future<void> _socketOps = Future<void>.value();

  // Long-lived re-broadcast controllers; consumers never subscribe to a JellyfinWebSocket directly.
  final _stateController = StreamController<WebSocketConnectionState>.broadcast();
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<WebSocketConnectionState> get connectionState => _stateController.stream;

  /// Consumers filter by `MessageType` themselves.
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  WebSocketConnectionState get currentState => _socket?.currentState ?? WebSocketConnectionState.disconnected;

  void send(Map<String, dynamic> message) => _socket?.send(message);

  Future<void> forceReconnectSocket() async => _socket?.forceReconnect();

  /// A healthy socket only gets a KeepAlive so the server refreshes its liveness timer; a dead one is
  /// rebuilt immediately instead of waiting for the backoff timer.
  Future<void> ensureConnected({required String reason}) async {
    final socket = _socket;
    if (socket == null) {
      return;
    }
    if (socket.currentState == WebSocketConnectionState.connected) {
      log('JellyfinWebSocket: $reason, socket healthy, sending KeepAlive');
      socket.send({'MessageType': 'KeepAlive'});
      return;
    }
    log('JellyfinWebSocket: $reason, socket ${socket.currentState.name}, reconnecting now');
    await socket.forceReconnect();
  }

  bool get _isPhone => isPhonePlatform(
        isWeb: kIsWeb,
        platform: defaultTargetPlatform,
        leanBackMode: ref.read(argumentsStateProvider).leanBackMode,
      );

  @override
  WebSocketConnectionState build() {
    // fireImmediately covers a user already logged in when this provider is first activated.
    ref.listen<AccountModel?>(
      userProvider,
      (previous, next) => _handleUserChange(previous, next),
      fireImmediately: true,
    );

    if (_isPhone) {
      _observer = _WebSocketLifecycleObserver(this)..register();
    }

    // Coming back online is worth an immediate attempt; do not wait for the backoff timer.
    ref.listen<connectivity.ConnectionState>(
      connectivity.connectivityStatusProvider,
      (previous, next) {
        final wasOffline = previous == connectivity.ConnectionState.offline;
        final isOnline = next != connectivity.ConnectionState.offline;
        if (wasOffline && isOnline) {
          unawaited(ensureConnected(reason: 'connectivity restored'));
        }
      },
    );

    ref.onDispose(_disposeAll);
    return WebSocketConnectionState.disconnected;
  }

  /// Failures are logged, not propagated, so one bad op doesn't wedge the serial queue.
  void _enqueueSocketOp(Future<void> Function() op) {
    _socketOps = _socketOps.then((_) => op()).catchError((Object e, StackTrace s) {
      log('JellyfinWebSocket: socket op failed: $e');
    });
  }

  void _handleUserChange(AccountModel? previous, AccountModel? next) {
    if (next == null) {
      log('JellyfinWebSocket: user signed out, tearing down socket');
      _enqueueSocketOp(_teardownSocket);
      return;
    }

    final serverUrl = ref.read(serverUrlProvider);
    if (serverUrl == null || serverUrl.isEmpty) {
      log('JellyfinWebSocket: no server URL yet, deferring connect');
      return;
    }

    final token = next.credentials.token;
    final deviceId = next.credentials.deviceId;

    _enqueueSocketOp(() async {
      // Re-evaluate against the live socket: a prior queued op may have changed it.
      final existing = _socket;
      if (existing != null &&
          existing.serverUrl == serverUrl &&
          existing.token == token &&
          existing.deviceId == deviceId) {
        // Same credentials/server: connect() is a no-op when already connected/connecting.
        await existing.connect();
        return;
      }

      log('JellyfinWebSocket: (re)building socket for $serverUrl');
      await _rebuildSocket(serverUrl, token, deviceId);
    });
  }

  Future<void> _rebuildSocket(String serverUrl, String token, String deviceId) async {
    await _teardownSocket();
    final socket = JellyfinWebSocket(
      serverUrl: serverUrl,
      token: token,
      deviceId: deviceId,
    );
    _socket = socket;
    _socketStateSub = socket.connectionState.listen((s) {
      if (!_stateController.isClosed) {
        _stateController.add(s);
      }
      state = s;
    });
    _socketMessageSub = socket.messages.listen((m) {
      if (!_messageController.isClosed) {
        _messageController.add(m);
      }
    });
    await socket.connect();
  }

  Future<void> _teardownSocket() async {
    await _socketStateSub?.cancel();
    await _socketMessageSub?.cancel();
    _socketStateSub = null;
    _socketMessageSub = null;
    await _socket?.dispose();
    _socket = null;
    if (!_stateController.isClosed) {
      _stateController.add(WebSocketConnectionState.disconnected);
    }
    state = WebSocketConnectionState.disconnected;
  }

  Future<void> _disposeAll() async {
    _observer?.unregister();
    _observer = null;
    await _teardownSocket();
    await _stateController.close();
    await _messageController.close();
  }
}
