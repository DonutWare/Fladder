import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:fladder/models/syncplay/syncplay_models.dart';

/// Manages WebSocket connection to Jellyfin server for SyncPlay
class WebSocketManager {
  WebSocketManager({
    required this.serverUrl,
    required this.token,
    required this.deviceId,
  });

  final String serverUrl;
  final String token;
  final String deviceId;

  WebSocketChannel? _channel;
  Timer? _keepAliveTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  static const Duration _baseReconnectDelay = Duration(seconds: 2);

  final _connectionStateController = StreamController<WebSocketConnectionState>.broadcast();
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<WebSocketConnectionState> get connectionState => _connectionStateController.stream;
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  WebSocketConnectionState _currentState = WebSocketConnectionState.disconnected;
  WebSocketConnectionState get currentState => _currentState;

  /// Build WebSocket URL for Jellyfin
  Uri get _webSocketUri {
    final baseUri = Uri.parse(serverUrl);
    final scheme = baseUri.scheme == 'https' ? 'wss' : 'ws';
    return Uri(
      scheme: scheme,
      host: baseUri.host,
      port: baseUri.port,
      path: '${baseUri.path}/socket',
      queryParameters: {
        'api_key': token,
        'deviceId': deviceId,
      },
    );
  }

  /// Connect to WebSocket
  Future<void> connect() async {
    if (_currentState == WebSocketConnectionState.connected ||
        _currentState == WebSocketConnectionState.connecting) {
      return;
    }

    _updateState(WebSocketConnectionState.connecting);

    try {
      log('WebSocket: Connecting to ${_webSocketUri.toString().replaceAll(RegExp(r'api_key=[^&]+'), 'api_key=***')}');
      _channel = WebSocketChannel.connect(_webSocketUri);
      await _channel!.ready;

      _updateState(WebSocketConnectionState.connected);
      _reconnectAttempts = 0;

      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
      );
    } catch (e) {
      log('WebSocket connection failed: $e');
      _updateState(WebSocketConnectionState.disconnected);
      _scheduleReconnect();
    }
  }

  /// Disconnect from WebSocket
  Future<void> disconnect() async {
    _reconnectTimer?.cancel();
    _keepAliveTimer?.cancel();
    _reconnectAttempts = _maxReconnectAttempts; // Prevent auto-reconnect

    await _channel?.sink.close();
    _channel = null;
    _updateState(WebSocketConnectionState.disconnected);
  }

  /// Force reconnect (e.g., after app resume)
  /// Resets attempt counter and immediately reconnects
  Future<void> forceReconnect() async {
    _reconnectTimer?.cancel();
    _keepAliveTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
    _reconnectAttempts = 0;
    _updateState(WebSocketConnectionState.disconnected);
    await connect();
  }

  /// Send a message through WebSocket
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

  /// Send keep-alive message
  void _sendKeepAlive() {
    send({'MessageType': 'KeepAlive'});
  }

  void _handleMessage(dynamic data) {
    try {
      final message = json.decode(data as String) as Map<String, dynamic>;
      final messageType = message['MessageType'] as String?;
      
      // Log all received messages for debugging
      log('WebSocket: Received message type: $messageType');

      // Handle ForceKeepAlive to set up keep-alive interval
      if (messageType == 'ForceKeepAlive') {
        final timeoutSeconds = message['Data'] as int? ?? 60;
        _setupKeepAlive(timeoutSeconds);
      }

      // Forward message to listeners
      _messageController.add(message);
    } catch (e) {
      log('Failed to parse WebSocket message: $e');
    }
  }

  void _handleError(dynamic error) {
    log('WebSocket error: $error');
    _updateState(WebSocketConnectionState.disconnected);
    _scheduleReconnect();
  }

  void _handleDone() {
    log('WebSocket connection closed');
    _keepAliveTimer?.cancel();

    if (_currentState != WebSocketConnectionState.disconnected) {
      _updateState(WebSocketConnectionState.disconnected);
      _scheduleReconnect();
    }
  }

  void _setupKeepAlive(int timeoutSeconds) {
    _keepAliveTimer?.cancel();
    // Send keep-alive at half the timeout interval
    final interval = Duration(seconds: (timeoutSeconds * 0.5).round());
    _keepAliveTimer = Timer.periodic(interval, (_) => _sendKeepAlive());
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      log('Max reconnect attempts reached');
      return;
    }

    _reconnectTimer?.cancel();
    _updateState(WebSocketConnectionState.reconnecting);

    // Exponential backoff
    final delay = _baseReconnectDelay * (1 << _reconnectAttempts);
    _reconnectAttempts++;

    log('Scheduling reconnect in ${delay.inSeconds}s (attempt $_reconnectAttempts)');
    _reconnectTimer = Timer(delay, connect);
  }

  void _updateState(WebSocketConnectionState state) {
    _currentState = state;
    _connectionStateController.add(state);
  }

  /// Dispose resources
  Future<void> dispose() async {
    await disconnect();
    await _connectionStateController.close();
    await _messageController.close();
  }
}
