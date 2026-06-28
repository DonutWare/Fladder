import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/websocket/jellyfin_websocket.dart';

part 'jellyfin_websocket_provider.g.dart';

/// Phone-only lifecycle observer: forces a clean WebSocket reconnect when
/// the app returns to the foreground. Registered only on phones (see
/// [isPhonePlatform]); desktop / web / Android-TV stay always-alive.
class _WebSocketLifecycleObserver with WidgetsBindingObserver {
  _WebSocketLifecycleObserver(this._controller);

  final JellyfinWebSocketController _controller;
  bool _wasConnected = false;

  void register() => WidgetsBinding.instance.addObserver(this);
  void unregister() => WidgetsBinding.instance.removeObserver(this);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _wasConnected = _controller.currentState == WebSocketConnectionState.connected;
        log('JellyfinWebSocket: app paused, wasConnected=$_wasConnected');
        break;
      case AppLifecycleState.resumed:
        if (_wasConnected) {
          log('JellyfinWebSocket: app resumed, forcing reconnect');
          unawaited(_controller.forceReconnectSocket());
        }
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }
}

/// App-level shared Jellyfin WebSocket.
///
/// Owns a single [JellyfinWebSocket], connects when a user is
/// authenticated, and re-broadcasts the socket's streams through
/// long-lived controllers so consumers stay subscribed transparently
/// across account switches / socket rebuilds.
@Riverpod(keepAlive: true)
class JellyfinWebSocketController extends _$JellyfinWebSocketController {
  JellyfinWebSocket? _socket;
  StreamSubscription<WebSocketConnectionState>? _socketStateSub;
  StreamSubscription<Map<String, dynamic>>? _socketMessageSub;
  _WebSocketLifecycleObserver? _observer;

  // Serializes socket teardown/rebuild so two quick auth changes
  // (e.g. token refresh then account switch) can't run concurrently
  // and leak or duplicate a socket.
  Future<void> _socketOps = Future<void>.value();

  // Long-lived re-broadcast controllers. Consumers subscribe to these,
  // never to a JellyfinWebSocket instance directly, so a socket rebuild
  // (e.g. account switch) is invisible to them.
  final _stateController = StreamController<WebSocketConnectionState>.broadcast();
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  /// Connection-state transitions (re-broadcast).
  Stream<WebSocketConnectionState> get connectionState => _stateController.stream;

  /// Raw inbound messages (re-broadcast). Consumers filter by
  /// `MessageType` themselves.
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  /// Current connection state (disconnected if no socket).
  WebSocketConnectionState get currentState => _socket?.currentState ?? WebSocketConnectionState.disconnected;

  /// Send a message through the shared socket (no-op if not connected).
  void send(Map<String, dynamic> message) => _socket?.send(message);

  /// Force a clean reconnect of the underlying socket.
  Future<void> forceReconnectSocket() async => _socket?.forceReconnect();

  bool get _isPhone => isPhonePlatform(
        isWeb: kIsWeb,
        platform: defaultTargetPlatform,
        leanBackMode: ref.read(argumentsStateProvider).leanBackMode,
      );

  @override
  WebSocketConnectionState build() {
    // Drive connect/disconnect off auth. fireImmediately handles the
    // case where a user is already logged in when this provider is
    // first activated (e.g. by base_app_wrapper after a relaunch).
    ref.listen<AccountModel?>(
      userProvider,
      (previous, next) => _handleUserChange(previous, next),
      fireImmediately: true,
    );

    if (_isPhone) {
      _observer = _WebSocketLifecycleObserver(this)..register();
    }

    ref.onDispose(_disposeAll);
    return WebSocketConnectionState.disconnected;
  }

  /// Chain a socket mutation onto the serial queue so teardown/rebuild
  /// never overlap. Failures are logged, not propagated, so one bad op
  /// doesn't wedge the queue.
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
      // Re-evaluate against the live socket at execution time (a prior
      // queued op may have changed it).
      final existing = _socket;
      if (existing != null &&
          existing.serverUrl == serverUrl &&
          existing.token == token &&
          existing.deviceId == deviceId) {
        // Same credentials/server — just ensure it is up (connect() is a
        // no-op when already connected/connecting).
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
