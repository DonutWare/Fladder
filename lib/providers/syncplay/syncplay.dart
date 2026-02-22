/// SyncPlay - Synchronized playback for Jellyfin
///
/// This module provides synchronized playback functionality allowing multiple
/// clients to watch media together in perfect synchronization.
///
/// Main components:
/// - [SyncPlayController] - Core controller for SyncPlay operations
/// - [SyncPlayState] - Current state of the SyncPlay session
/// - [TimeSyncService] - NTP-like clock synchronization with server
/// - [WebSocketManager] - WebSocket connection management
///
/// Usage:
/// ```dart
/// final syncPlay = ref.read(syncPlayProvider.notifier);
/// await syncPlay.connect();
/// await syncPlay.createGroup('Movie Night');
/// ```
library;

export 'package:fladder/models/syncplay/syncplay_models.dart';

export 'handlers/syncplay_command_handler.dart'
    show SyncPlayPlayerCallback, SyncPlaySeekCallback, SyncPlayPositionCallback;
export 'syncplay_controller.dart';
export 'syncplay_provider.dart';
export 'time_sync_service.dart';
export 'websocket_manager.dart';
