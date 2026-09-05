import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random, min, pow;

import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:web_socket_channel/web_socket_channel.dart';

enum WebSocketConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
}

/// Only a phone (Android/iOS handheld, not leanback) gets the resume check; desktop, web and TV stay
/// always-alive. Free of Flutter bindings so it is unit-testable.
bool isPhonePlatform({
  required bool isWeb,
  required TargetPlatform platform,
  required bool leanBackMode,
}) {
  if (isWeb) {
    return false;
  }
  final isAndroidOrIos = platform == TargetPlatform.android || platform == TargetPlatform.iOS;
  return isAndroidOrIos && !leanBackMode;
}

/// First reconnect delay; doubles on every failed attempt.
const Duration reconnectBaseDelay = Duration(seconds: 2);

/// Backoff ceiling; a SyncPlay session dying while the socket is down needs a short one.
const Duration reconnectMaxDelay = Duration(seconds: 30);

/// Random spread so many clients behind the same router do not reconnect in lockstep.
const double reconnectJitterFraction = 0.2;

/// Exponential with a hard cap and jitter; never gives up.
Duration reconnectDelay(int attempt, {Random? random}) {
  final exponent = attempt.clamp(0, 30);
  final rawMs = reconnectBaseDelay.inMilliseconds * pow(2, exponent);
  final cappedMs = min(rawMs, reconnectMaxDelay.inMilliseconds.toDouble());
  final jitter = ((random ?? Random()).nextDouble() * 2 - 1) * reconnectJitterFraction;
  return Duration(milliseconds: (cappedMs * (1 + jitter)).round());
}

/// The `/socket` URI, carrying the token under both query-parameter names the server may bind.
///
/// `api_key` is only read when `EnableLegacyAuthorization` is on, and that defaults to true on 10.11 but
/// false on 12, where the handshake is then refused outright and SyncPlay never sees a group frame.
/// `ApiKey` is read unconditionally since 10.8; sending both leaves one build working against either.
Uri buildWebSocketUri({
  required String serverUrl,
  required String token,
  required String deviceId,
}) {
  final baseUri = Uri.parse(serverUrl);
  final scheme = baseUri.scheme == 'https' ? 'wss' : 'ws';
  final basePath = baseUri.path.replaceAll(RegExp(r'/+$'), '');
  return Uri(
    scheme: scheme,
    host: baseUri.host,
    port: baseUri.port,
    path: '$basePath/socket',
    queryParameters: {
      'ApiKey': token,
      'api_key': token,
      'deviceId': deviceId,
    },
  );
}

/// [uri] with every token-bearing query parameter masked, for logging.
String redactSocketUri(Uri uri) =>
    uri.toString().replaceAllMapped(RegExp(r'(ApiKey|api_key)=[^&]+'), (match) => '${match[1]}=***');

/// App-level shared connection; reconnects forever with capped backoff until [disconnect].
class JellyfinWebSocket {
  JellyfinWebSocket({
    required this.serverUrl,
    required this.token,
    required this.deviceId,
  });

  final String serverUrl;
  final String token;
  final String deviceId;

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  Timer? _keepAliveTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;

  /// Set by [disconnect] until the next [connect]; suppresses automatic reconnects.
  bool _manuallyClosed = false;

  final _connectionStateController = StreamController<WebSocketConnectionState>.broadcast();
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<WebSocketConnectionState> get connectionState => _connectionStateController.stream;
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  WebSocketConnectionState _currentState = WebSocketConnectionState.disconnected;
  WebSocketConnectionState get currentState => _currentState;

  Uri get _webSocketUri => buildWebSocketUri(serverUrl: serverUrl, token: token, deviceId: deviceId);

  /// The socket URI with every token-bearing parameter masked, for logging.
  String get _redactedUri => redactSocketUri(_webSocketUri);

  Future<void> connect() async {
    if (_currentState == WebSocketConnectionState.connected || _currentState == WebSocketConnectionState.connecting) {
      return;
    }

    _manuallyClosed = false;
    _updateState(WebSocketConnectionState.connecting);

    WebSocketChannel? opened;
    try {
      log('WebSocket: Connecting to $_redactedUri');
      final channel = WebSocketChannel.connect(_webSocketUri);
      opened = channel;
      _channel = channel;
      await channel.ready;

      if (!identical(_channel, channel)) {
        // `disconnect()` ran while the handshake was in flight.
        await channel.sink.close();
        return;
      }

      _updateState(WebSocketConnectionState.connected);
      _reconnectAttempts = 0;

      _subscription = channel.stream.listen(
        _handleMessage,
        onError: (Object error) => _handleError(channel, error),
        onDone: () => _handleDone(channel),
      );
    } catch (e) {
      log('WebSocket connection failed: $e');
      if (opened != null) {
        if (identical(_channel, opened)) {
          _onSocketClosed(opened);
        }
      } else if (!_manuallyClosed) {
        // Channel never created (sync constructor failure); staying `connecting` would make later connect() a no-op.
        _updateState(WebSocketConnectionState.disconnected);
        _scheduleReconnect();
      }
    }
  }

  /// Disconnect from WebSocket and stop reconnecting.
  Future<void> disconnect() async {
    _manuallyClosed = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _keepAliveTimer?.cancel();
    _keepAliveTimer = null;

    // Detach first so the old channel's onDone/onError can never reach _onSocketClosed after a rebuild.
    final channel = _channel;
    _channel = null;
    await _subscription?.cancel();
    _subscription = null;
    await channel?.sink.close();
    _updateState(WebSocketConnectionState.disconnected);
  }

  /// Resets the attempt counter and reconnects immediately (e.g. after app resume with a dead socket).
  Future<void> forceReconnect() async {
    await disconnect();
    _reconnectAttempts = 0;
    await connect();
  }

  void send(Map<String, dynamic> message) {
    if (_currentState != WebSocketConnectionState.connected) {
      log('Cannot send message: WebSocket not connected');
      return;
    }

    try {
      _channel?.sink.add(json.encode(message));
    } catch (e) {
      log('Failed to send WebSocket message: $e');
    }
  }

  void _sendKeepAlive() {
    send({'MessageType': 'KeepAlive'});
  }

  void _handleMessage(dynamic data) {
    try {
      final message = json.decode(data as String) as Map<String, dynamic>;
      final messageType = message['MessageType'] as String?;

      if (messageType != 'KeepAlive') {
        log('WebSocket: Received message: $message');
      }

      if (messageType == 'ForceKeepAlive') {
        final timeoutSeconds = message['Data'] as int? ?? 60;
        _setupKeepAlive(timeoutSeconds);
      }

      _messageController.add(message);
    } catch (e) {
      log('Failed to parse WebSocket message: $e\nRaw data: $data');
    }
  }

  void _handleError(WebSocketChannel channel, Object error) {
    log('WebSocket error: $error');
    // onDone follows an error on the channel stream; scheduling is idempotent so handling both is harmless.
    _onSocketClosed(channel);
  }

  void _handleDone(WebSocketChannel channel) {
    log('WebSocket connection closed');
    _onSocketClosed(channel);
  }

  /// Common exit path for errors, remote closes and failed connects. Events from a channel that is no
  /// longer current are ignored, or they would null out the live channel and arm a third socket.
  void _onSocketClosed(WebSocketChannel channel) {
    if (!identical(_channel, channel)) {
      return;
    }
    _keepAliveTimer?.cancel();
    _keepAliveTimer = null;
    _channel = null;
    _subscription = null;
    if (_manuallyClosed) {
      _updateState(WebSocketConnectionState.disconnected);
      return;
    }
    _scheduleReconnect();
  }

  void _setupKeepAlive(int timeoutSeconds) {
    _keepAliveTimer?.cancel();
    final interval = Duration(seconds: (timeoutSeconds * 0.5).round());
    _keepAliveTimer = Timer.periodic(interval, (_) => _sendKeepAlive());
  }

  /// Arms a reconnect timer unless one is already pending; never gives up.
  void _scheduleReconnect() {
    if (_manuallyClosed) {
      return;
    }
    if (_reconnectTimer?.isActive == true) {
      return;
    }

    if (_currentState != WebSocketConnectionState.reconnecting) {
      _updateState(WebSocketConnectionState.reconnecting);
    }

    final delay = reconnectDelay(_reconnectAttempts);
    _reconnectAttempts++;

    log('Scheduling reconnect in ${delay.inMilliseconds}ms (attempt $_reconnectAttempts)');
    _reconnectTimer = Timer(delay, () {
      _reconnectTimer = null;
      unawaited(connect());
    });
  }

  void _updateState(WebSocketConnectionState state) {
    _currentState = state;
    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(state);
    }
  }

  Future<void> dispose() async {
    await disconnect();
    await _connectionStateController.close();
    await _messageController.close();
  }
}
