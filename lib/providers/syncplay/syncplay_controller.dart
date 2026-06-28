import 'dart:async';
import 'dart:developer' as developer;

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/router_provider.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_command_handler.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_message_handler.dart';
import 'package:fladder/providers/syncplay/time_sync_service.dart';
import 'package:fladder/providers/websocket/jellyfin_websocket.dart';
import 'package:fladder/providers/websocket/jellyfin_websocket_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:flutter/material.dart';
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controller for SyncPlay synchronized playback
class SyncPlayController {
  static const bool _verboseSyncPlayLogs = false;

  SyncPlayController(this._ref) {
    _commandHandler = SyncPlayCommandHandler(
      timeSync: () => _timeSync,
      onStateUpdate: _updateStateWith,
    );
    _messageHandler = SyncPlayMessageHandler(
      onStateUpdate: _updateStateWith,
      reportReady: ({bool isPlaying = true}) => reportReady(isPlaying: isPlaying),
      // Wrap _startPlayback so the loader-UX completer resolves as soon
      // as the server's PlayQueue is received (i.e. our queue request
      // was accepted and broadcast). The actual local load
      // (loadPlaybackItem → media-kit) can then take its time without
      // gating the dialog: media-kit on web sometimes leaves
      // `state.loadVideo()` hanging which would otherwise let the
      // 20s timeout fire and surface a misleading "unable to play
      // media format" snack while playback is in fact already running.
      startPlayback: (itemId, ticks) async {
        final completer = _startPlaybackCompleter;
        if (completer != null && !completer.isCompleted) {
          log('SyncPlay: PlayQueue accepted - resolving loader '
              'completer eagerly for item=$itemId');
          completer.complete(true);
        }
        await _startPlayback(itemId, ticks);
      },
      isBuffering: () => _commandHandler.isBuffering?.call() ?? false,
      getContext: () => getNavigatorKey(_ref)?.currentContext,
      onGroupJoined: _onGroupJoined,
      onGroupJoinFailed: _onGroupJoinFailed,
      onGroupLeftOrKicked: _onGroupLeftOrKicked,
      onStateUpdateToPlaying: _onStateUpdateToPlaying,
      onGroupGone: ({required wasKicked}) => notifyGroupGone(wasKicked: wasKicked),
      onLocalPauseForBuffer: () async {
        final pause = _commandHandler.onPause;
        if (pause != null && _commandHandler.isPlaying?.call() == true) {
          log('SyncPlay: Pausing locally because another client is buffering');
          await pause();
        }
      },
    );
  }

  final Ref _ref;

  TimeSyncService? _timeSync;
  StreamSubscription? _wsMessageSubscription;
  StreamSubscription? _wsStateSubscription;
  Timer? _syncCorrectionTimer;

  late final SyncPlayCommandHandler _commandHandler;
  late final SyncPlayMessageHandler _messageHandler;

  SyncPlayState _state = SyncPlayState();
  final _stateController = StreamController<SyncPlayState>.broadcast();

  Stream<SyncPlayState> get stateStream => _stateController.stream;

  SyncPlayState get state => _state;

  // Lifecycle state for reconnection
  String? _lastGroupId;

  // Previous WebSocket state — used to detect reconnect transitions in
  // `_handleConnectionState` so we can silently rejoin the last group.
  // The very first connect is naturally skipped because `_lastGroupId`
  // is null until the user joins a group for the first time.
  WebSocketConnectionState? _previousWsState;

  // Completer for waiting on group join confirmation
  Completer<bool>? _joinGroupCompleter;

  // Completer that resolves the next time `_startPlayback` finishes
  // (success or failure). Used by the loader UX for both initiator
  // and receivers.
  Completer<bool>? _startPlaybackCompleter;

  // PlaylistItemId currently being started (dedup against concurrent
  // PlayQueue updates issued by simultaneous initiators).
  String? _currentlyStartingPlaylistItemId;
  Completer<void>? _inFlightStartCompleter;

  // Debounce: timestamp of the last `setNewQueue` API call so two
  // initiators don't fire two requests in the same second.
  DateTime? _lastSetNewQueueAt;

  // Player callbacks (delegated to command handler)
  set onPlay(SyncPlayPlayerCallback? callback) => _commandHandler.onPlay = callback;

  set onPause(SyncPlayPlayerCallback? callback) => _commandHandler.onPause = callback;

  set onSeek(SyncPlaySeekCallback? callback) => _commandHandler.onSeek = callback;

  set onStop(SyncPlayPlayerCallback? callback) => _commandHandler.onStop = callback;

  set getPositionTicks(SyncPlayPositionCallback? callback) => _commandHandler.getPositionTicks = callback;

  set isPlaying(bool Function()? callback) => _commandHandler.isPlaying = callback;

  set isBuffering(bool Function()? callback) => _commandHandler.isBuffering = callback;

  set onSeekRequested(SyncPlaySeekCallback? callback) => _commandHandler.onSeekRequested = callback;

  set onReportReady(SyncPlayReportReadyCallback? callback) => _commandHandler.onReportReady = callback;

  set onSetSpeed(SyncPlaySetSpeedCallback? callback) => _commandHandler.onSetSpeed = callback;

  set hasPlaybackRate(bool Function()? callback) => _commandHandler.hasPlaybackRate = callback;

  void log(String message) {
    final isImportant = message.contains('Failed') || message.contains('Error') || message.contains('Cannot');
    if (_verboseSyncPlayLogs || isImportant) {
      developer.log(message);
    }
  }

  /// Mark that a SyncPlay command was executed locally.
  /// Used by player-side cooldown logic to avoid feedback loops.
  void markCommandExecuted([DateTime? at]) {
    _updateStateWith((state) => state.copyWith(
          lastCommandTime: at ?? DateTime.now().toUtc(),
        ));
  }

  /// Update buffering/reloading status used by SyncPlay integration.
  void setPlayerBufferingState(bool isBuffering) {
    if (isBuffering) {
      _syncCorrectionTimer?.cancel();
      _syncCorrectionTimer = null;
      final setSpeed = _commandHandler.onSetSpeed;
      if (setSpeed != null) {
        unawaited(
          setSpeed(1.0).catchError((Object error, StackTrace stackTrace) {
            log('SyncPlay: Failed to reset speed while buffering: $error');
          }),
        );
      }
      _updateStateWith((state) => state.copyWith(
            correctionState: state.correctionState.copyWith(
              playerIsBuffering: true,
              syncEnabled: false,
              activeStrategy: SyncCorrectionStrategy.none,
            ),
          ));
      return;
    }

    _updateStateWith((state) => state.copyWith(
          correctionState: state.correctionState.copyWith(
            playerIsBuffering: false,
            syncEnabled: true,
          ),
        ));
  }

  /// Reset correction strategy/state when commands are cleared, on stop,
  /// or around rejoin flows.
  void resetCorrectionState({
    String reason = 'reset',
    bool syncEnabled = true,
  }) {
    _syncCorrectionTimer?.cancel();
    _syncCorrectionTimer = null;

    final setSpeed = _commandHandler.onSetSpeed;
    if (setSpeed != null) {
      unawaited(
        setSpeed(1.0).catchError((Object error, StackTrace stackTrace) {
          log('SyncPlay: Failed to reset speed during correction reset: $error');
        }),
      );
    }
    _commandHandler.clearLastCommand();

    log('SyncPlay: Reset correction state ($reason)');
    _updateStateWith((state) => state.copyWith(
          correctionState: state.correctionState.copyWith(
            activeStrategy: SyncCorrectionStrategy.none,
            syncEnabled: syncEnabled,
            playbackDiffMillis: 0,
            syncAttempts: 0,
          ),
        ));
  }

  /// Update current playback drift against estimated SyncPlay server time.
  ///
  /// Drift is computed as:
  /// `estimatedServerPositionTicks - currentLocalPositionTicks`.
  /// Positive means local player is behind, negative means ahead.
  void updatePlaybackDrift({
    required int currentPositionTicks,
    DateTime? at,
  }) {
    if (!_commandHandler.canAttemptSyncCorrection(_state)) {
      return;
    }

    final lastCommand = _commandHandler.lastCommand;
    if (lastCommand == null) {
      return;
    }

    final when = DateTime.tryParse(lastCommand.when);
    if (when == null) {
      return;
    }

    final now = (at ?? DateTime.now().toUtc());
    final remoteNow = _timeSync?.localDateToRemote(now) ?? now;
    final elapsedMs = remoteNow.difference(when).inMilliseconds;

    final estimatedServerTicks = lastCommand.positionTicks + millisecondsToTicks(elapsedMs);
    final diffTicks = estimatedServerTicks - currentPositionTicks;
    final diffMillis = ticksToMilliseconds(diffTicks).toDouble();
    final correctionConfig = _state.correctionConfig;
    final correctionState = _state.correctionState;
    final strategy = selectSyncCorrectionStrategy(
      config: correctionConfig,
      state: correctionState,
      diffMillis: diffMillis,
      hasPlaybackRate: _commandHandler.hasPlaybackRate?.call() == true,
    );

    if (strategy == SyncCorrectionStrategy.speedToSync) {
      _applySpeedToSync(
        diffMillis: diffMillis,
        config: correctionConfig,
        now: now,
      );
      return;
    }

    if (strategy == SyncCorrectionStrategy.skipToSync) {
      _applySkipToSync(
        diffMillis: diffMillis,
        targetPositionTicks: estimatedServerTicks,
        config: correctionConfig,
        now: now,
      );
      return;
    }

    _updateStateWith((state) => state.copyWith(
          correctionState: state.correctionState.copyWith(
            playbackDiffMillis: diffMillis,
            lastSyncAt: now,
          ),
        ));
  }

  /// Estimate where the group's playhead is right now by extrapolating from
  /// the last `Unpause`/`Seek` command timestamp. Falls back to
  /// `state.positionTicks` if no command context is available — that value
  /// is the position from the most recent state update, which may be tens
  /// of seconds stale during continuous playback.
  int estimateCurrentGroupPositionTicks() {
    final lastCommand = _commandHandler.lastCommand;
    final timeSyncService = _timeSync;
    if (lastCommand == null || timeSyncService == null) {
      return _state.positionTicks;
    }
    final when = DateTime.tryParse(lastCommand.when);
    if (when == null) {
      return _state.positionTicks;
    }
    // Only extrapolate from Unpause-style commands; Pause leaves the playhead
    // frozen at the command's positionTicks.
    if (lastCommand.command != SyncPlayCommand.unpause) {
      return lastCommand.positionTicks;
    }
    final remoteNow = timeSyncService.localDateToRemote(DateTime.now().toUtc());
    final elapsedMs = remoteNow.difference(when).inMilliseconds;
    return lastCommand.positionTicks + millisecondsToTicks(elapsedMs);
  }

  void _applySpeedToSync({
    required double diffMillis,
    required SyncCorrectionConfig config,
    required DateTime now,
  }) {
    final setSpeed = _commandHandler.onSetSpeed;
    if (setSpeed == null) {
      return;
    }

    var speedToSyncTimeMs = config.speedToSyncDurationMs;
    const minSpeed = 0.2;
    if (diffMillis <= -speedToSyncTimeMs * minSpeed) {
      speedToSyncTimeMs = diffMillis.abs() / (1.0 - minSpeed);
    }

    final rawSpeed = 1.0 + (diffMillis / speedToSyncTimeMs);
    final speed = rawSpeed < minSpeed ? minSpeed : rawSpeed;
    final resetDuration = Duration(
      milliseconds: speedToSyncTimeMs.round(),
    );

    _syncCorrectionTimer?.cancel();
    unawaited(
      setSpeed(speed).catchError((Object error, StackTrace stackTrace) {
        log('SyncPlay: Failed to apply SpeedToSync rate: $error');
      }),
    );
    log(
      'SyncPlay: SpeedToSync applied '
      '(speed=${speed.toStringAsFixed(2)}, '
      'diffMs=${diffMillis.toStringAsFixed(1)})',
    );

    _updateStateWith((state) => state.copyWith(
          correctionState: state.correctionState.copyWith(
            playbackDiffMillis: diffMillis,
            lastSyncAt: now,
            activeStrategy: SyncCorrectionStrategy.speedToSync,
            syncEnabled: false,
            syncAttempts: state.correctionState.syncAttempts + 1,
          ),
        ));

    _syncCorrectionTimer = Timer(resetDuration, () {
      final resetSpeed = _commandHandler.onSetSpeed;
      if (resetSpeed != null) {
        unawaited(
          resetSpeed(1.0).catchError((Object error, StackTrace stackTrace) {
            log('SyncPlay: Failed to reset speed after SpeedToSync: $error');
          }),
        );
      }
      _updateStateWith((state) => state.copyWith(
            correctionState: state.correctionState.copyWith(
              activeStrategy: SyncCorrectionStrategy.none,
              syncEnabled: true,
            ),
          ));
    });
  }

  void _applySkipToSync({
    required double diffMillis,
    required int targetPositionTicks,
    required SyncCorrectionConfig config,
    required DateTime now,
  }) {
    final seek = _commandHandler.onSeek;
    if (seek == null) {
      return;
    }

    _syncCorrectionTimer?.cancel();
    unawaited(
      seek(targetPositionTicks).catchError((Object error, StackTrace stackTrace) {
        log('SyncPlay: Failed to apply SkipToSync seek: $error');
      }),
    );
    log(
      'SyncPlay: SkipToSync applied '
      '(targetTicks=$targetPositionTicks, '
      'diffMs=${diffMillis.toStringAsFixed(1)})',
    );

    _updateStateWith((state) => state.copyWith(
          correctionState: state.correctionState.copyWith(
            playbackDiffMillis: diffMillis,
            lastSyncAt: now,
            activeStrategy: SyncCorrectionStrategy.skipToSync,
            syncEnabled: false,
            syncAttempts: state.correctionState.syncAttempts + 1,
          ),
        ));

    final cooldownDuration = Duration(
      milliseconds: (config.maxDelaySpeedToSyncMs / 2.0).round(),
    );
    _syncCorrectionTimer = Timer(cooldownDuration, () {
      _updateStateWith((state) => state.copyWith(
            correctionState: state.correctionState.copyWith(
              activeStrategy: SyncCorrectionStrategy.none,
              syncEnabled: true,
            ),
          ));
    });
  }

  JellyfinOpenApi get _api => _ref.read(jellyApiProvider).api;

  /// Subscribe SyncPlay to the shared app-level WebSocket.
  ///
  /// The socket itself is owned by [JellyfinWebSocketController] and is
  /// connected/disconnected off `userProvider`; SyncPlay only attaches
  /// its message/state listeners and starts time-sync.
  Future<void> connect() async {
    final user = _ref.read(userProvider);
    if (user == null) {
      log('SyncPlay: Cannot connect without user');
      return;
    }

    // Activate the shared socket provider and grab its notifier.
    final ws = _ref.read(jellyfinWebSocketControllerProvider.notifier);

    // Idempotent: if we are already subscribed, do nothing. (This path
    // is hit every time the SyncPlay sheet re-opens via loadGroups().)
    if (_wsStateSubscription != null) {
      log('SyncPlay: connect() called but already subscribed; reusing shared socket');
      return;
    }

    // Initialize time sync (SyncPlay-owned, not part of the socket).
    _timeSync = TimeSyncService(_api);
    _timeSync!.start();

    _wsStateSubscription = ws.connectionState.listen(_handleConnectionState);
    _wsMessageSubscription = ws.messages.listen(_handleMessage);

    // The shared socket is app-owned and is usually already connected by
    // the time the user opens SyncPlay. The re-broadcast stream does not
    // replay, so seed from the current state — otherwise `isConnected`
    // would stay false and `joinGroup` would be blocked.
    _handleConnectionState(ws.currentState);
  }

  /// Detach SyncPlay from the shared WebSocket.
  ///
  /// Does NOT close the socket — it is app-owned and shared. Leaving a
  /// SyncPlay group no longer tears down the connection.
  Future<void> disconnect() async {
    resetCorrectionState(
      reason: 'disconnect',
      syncEnabled: false,
    );
    await leaveGroup();
    _resetGroupLifecycleState();
    _commandHandler.cancelPendingCommands();
    await _wsMessageSubscription?.cancel();
    await _wsStateSubscription?.cancel();
    _wsMessageSubscription = null;
    _wsStateSubscription = null;
    _timeSync?.dispose();
    _timeSync = null;
    _updateState(SyncPlayState());
  }

  /// List available SyncPlay groups
  Future<List<GroupInfoDto>> listGroups() async {
    try {
      final response = await _api.syncPlayListGet();
      return response.body ?? [];
    } catch (e) {
      log('SyncPlay: Failed to list groups: $e');
      return [];
    }
  }

  /// Create a new SyncPlay group
  Future<GroupInfoDto?> createGroup(String groupName) async {
    try {
      final response = await _api.syncPlayNewPost(
        body: NewGroupRequestDto(groupName: groupName),
      );
      return response.body;
    } catch (e) {
      log('SyncPlay: Failed to create group: $e');
      return null;
    }
  }

  /// Join an existing SyncPlay group
  /// Returns true only after receiving GroupJoined confirmation from WebSocket
  Future<bool> joinGroup(String groupId) async {
    // Check if already in a group
    if (_state.isInGroup) {
      log('SyncPlay: Already in a group, leaving first...');
      await leaveGroup();
    }

    // Check if WebSocket is connected
    if (!_state.isConnected) {
      log('SyncPlay: WebSocket not connected, cannot join group');
      return false;
    }

    log('SyncPlay: Joining group: $groupId');
    final confirmed = await _sendJoinRequest(groupId);
    // `_lastGroupId` is stamped in `_onGroupJoined` from the server
    // frame (source of truth), so it is correct even if a slow socket
    // makes this call reconcile/return before `GroupJoined` lands.
    log(confirmed ? 'SyncPlay: Group join confirmed' : 'SyncPlay: Group join not confirmed');
    return confirmed;
  }

  /// Send a Join request and wait for the matching `GroupJoined`
  /// message via the completer. Caller is responsible for any pre/post
  /// state management (e.g. `leaveGroup` first, `_lastGroupId` updates).
  /// Used by both [joinGroup] and [_attemptSilentRejoin].
  Future<bool> _sendJoinRequest(String groupId) async {
    final completer = _joinGroupCompleter = Completer<bool>();
    try {
      await _api.syncPlayJoinPost(
        body: JoinGroupRequestDto(groupId: groupId),
      );
      final confirmed = await completer.future.timeout(
        const Duration(seconds: 12),
        onTimeout: () {
          // The POST itself succeeded (no exception). Jellyfin keys
          // SyncPlay membership by session and `Join` is idempotent, so
          // a missing `GroupJoined` inside the window is almost always a
          // slow/stalled WebSocket — not a real rejection. Genuine
          // rejections arrive promptly as NotInGroup/GroupDoesNotExist
          // and complete the completer `false` long before this fires.
          // `_handleGroupJoined` also flips `isInGroup` whenever the
          // frame eventually lands (or after a silent rejoin), so
          // reconcile against the authoritative state instead of
          // reporting a false "Failed to join group".
          final joined = _state.isInGroup && _state.groupId == groupId;
          log('SyncPlay: GroupJoined not received within timeout; '
              'reconciled isInGroup=$joined for $groupId');
          return joined;
        },
      );
      if (identical(_joinGroupCompleter, completer)) {
        _joinGroupCompleter = null;
      }
      return confirmed;
    } catch (e) {
      log('SyncPlay: Failed to send join request: $e');
      if (identical(_joinGroupCompleter, completer)) {
        _completeJoinRequest(false);
      }
      return false;
    }
  }

  /// Complete and clear the pending join completer exactly once. Safe to
  /// call from the success path, the failure path, the leave/kick reset
  /// path, and a late-arriving `GroupJoined` — without ever risking a
  /// "Future already completed" or leaking a stale completer reference.
  void _completeJoinRequest(bool joined) {
    final completer = _joinGroupCompleter;
    _joinGroupCompleter = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete(joined);
    }
  }

  /// Called by message handler when GroupJoined is received.
  ///
  /// If the group is already playing/waiting/paused with an active item,
  /// auto-attach the local player to it. This mirrors `jellyfin-web`'s
  /// behavior — the group should not stall in Waiting because a fresh
  /// joiner forgot to click "Resume Playback".
  void _onGroupJoined() {
    resetCorrectionState(
      reason: 'group_joined',
      syncEnabled: true,
    );
    // Stamp `_lastGroupId` from the authoritative server frame, not the
    // awaited `joinGroup` bool. A slow socket can make `_sendJoinRequest`
    // time out (reconciled false) and only deliver `GroupJoined` after
    // `joinGroup` already returned — without this, the reconnect
    // silent-rejoin invariant (`_handleConnectionState`) would be lost
    // even though we are genuinely in the group. This only fires on a
    // real `GroupJoined`, so it is still "only on confirmation".
    _lastGroupId = _state.groupId ?? _lastGroupId;
    _completeJoinRequest(true);
    final showSnackbar = _state.groupName != null;
    if (showSnackbar) {
      _showGroupSnackbar(
        (l) => l.syncPlayJoinedGroup(_state.groupName ?? ''),
      );
    }

    final hasActiveItem = _state.playingItemId != null &&
        (_state.groupState == SyncPlayGroupState.playing ||
            _state.groupState == SyncPlayGroupState.waiting ||
            _state.groupState == SyncPlayGroupState.paused);

    if (hasActiveItem) {
      // If the local player is already showing this exact item, skip
      // the reload. This is the silent-rejoin path (WS dropped during
      // a brief doze, user is still mid-playback locally): reloading
      // would tear the player back to ticks=0 and the subsequent
      // reportReady(positionTicks: 0) inside loadPlaybackItem would
      // be broadcast by the server as the new group position,
      // resetting every other client. The server's authoritative
      // position is preserved server-side; the next Pause/Unpause/Seek
      // command will resync our local player without a reload.
      final currentPlayback = _ref.read(playBackModel);
      final alreadyLoaded = currentPlayback?.item.id == _state.playingItemId;
      if (alreadyLoaded) {
        log('SyncPlay: Joined group with active item ${_state.playingItemId} '
            'already loaded locally; skipping reload (silent rejoin)');
      } else {
        log('SyncPlay: Joined group with active item ${_state.playingItemId} '
            '(state=${_state.groupState.name}); auto-loading playback');
        unawaited(rejoinPlayback());
      }
    }
  }

  /// Called by message handler when NotInGroup/GroupDoesNotExist is received
  void _onGroupJoinFailed() {
    _completeJoinRequest(false);
  }

  /// Called when we leave or are kicked; cancel pending commands,
  /// clear processing state and stop any local playback that was
  /// driven by the previous group. Without the local stop, the player
  /// keeps the old media loaded in the background and a later
  /// `Unpause` command from a *different* group would resume it.
  void _onGroupLeftOrKicked() {
    _resetGroupLifecycleState();
    _commandHandler.cancelPendingCommands();
    resetCorrectionState(
      reason: 'group_left_or_kicked',
      syncEnabled: false,
    );
    _updateStateWith((s) => s.copyWith(
          isProcessingCommand: false,
          processingCommandType: null,
          playingItemId: null,
          playlistItemId: null,
          startPlaybackInProgress: false,
          startingPlaylistItemId: null,
        ));
    _stopLocalPlayback();
  }

  /// Stop and dispose the local video player & playback model so no
  /// leftover media can resume after the SyncPlay session ended.
  ///
  /// Deferred to a microtask: this method is reached from a synchronous
  /// chain that started inside a WebSocket message handler — the
  /// `_stateController.add(_state)` from `_updateStateWith` fires the
  /// Riverpod-side `state = newState` listener synchronously, which in
  /// turn re-enters every `syncPlayProvider` listener (including
  /// `videoPlayerProvider`). Reading `videoPlayerProvider` /
  /// `playBackModel.notifier` while that re-entrant chain is still on
  /// the stack throws `CircularDependencyError`. Yielding to a microtask
  /// breaks out of that chain without changing observable behaviour:
  /// the player is still stopped, the playback model is still cleared.
  void _stopLocalPlayback() {
    Future<void>.microtask(() {
      try {
        unawaited(_ref.read(videoPlayerProvider).stop());
        _ref.read(playBackModel.notifier).update((_) => null);
        _ref.read(isVideoPlayerRouteOpenProvider.notifier).state = false;
      } catch (e) {
        log('SyncPlay: Failed to stop local playback after leave: $e');
      }
    });
  }

  /// Returns `true` once the user has left or been kicked while a
  /// long-running playback start is in progress. Callers must check this
  /// between every `await` so they don't push a player route or resume
  /// media for a group we no longer belong to.
  bool _shouldAbortStartPlayback() => !_state.isInGroup;

  /// Clear all in-memory bookkeeping that is only meaningful while in a
  /// group. Called from `leaveGroup`, `_onGroupLeftOrKicked`, and
  /// `disconnect` so that a subsequent rejoin starts from a clean slate.
  ///
  /// In particular: `_lastSetNewQueueAt` was previously leaking past
  /// leaveGroup, which silently debounced the first `setNewQueue` after
  /// rejoin within 1s.
  void _resetGroupLifecycleState() {
    _lastSetNewQueueAt = null;
    _currentlyStartingPlaylistItemId = null;
    _inFlightStartCompleter = null;
    if (_startPlaybackCompleter != null && !_startPlaybackCompleter!.isCompleted) {
      _startPlaybackCompleter!.complete(false);
    }
    _startPlaybackCompleter = null;
    _completeJoinRequest(false);
  }

  /// When server reports Playing, ensure player is actually playing (per docs: recover if Unpause command was missed).
  void _onStateUpdateToPlaying() {
    if (_commandHandler.isPlaying?.call() != true) {
      log('SyncPlay: State is Playing but player not playing, triggering play');
      _commandHandler.onPlay?.call();
    }
  }

  /// Leave the current SyncPlay group.
  /// Resets processing state and cancels pending commands so playback is not stuck (per docs).
  Future<void> leaveGroup() async {
    if (!_state.isInGroup) {
      return;
    }
    try {
      await _api.syncPlayLeavePost();
      _lastGroupId = null;
      _resetGroupLifecycleState();
      _commandHandler.cancelPendingCommands();
      resetCorrectionState(
        reason: 'leave_group',
        syncEnabled: false,
      );
      _updateState(_state.copyWith(
        isInGroup: false,
        groupId: null,
        groupName: null,
        groupState: SyncPlayGroupState.idle,
        participants: [],
        isProcessingCommand: false,
        processingCommandType: null,
        positionTicks: 0,
        playlistItemId: null,
        playingItemId: null,
        startPlaybackInProgress: false,
        startingPlaylistItemId: null,
      ));
      _stopLocalPlayback();
      log('SyncPlay: Left group, state reset');
    } catch (e) {
      log('SyncPlay: Failed to leave group: $e');
      _resetGroupLifecycleState();
      _commandHandler.cancelPendingCommands();
      resetCorrectionState(
        reason: 'leave_group_failed_local_reset',
        syncEnabled: false,
      );
      _updateState(_state.copyWith(
        isInGroup: false,
        groupId: null,
        groupName: null,
        groupState: SyncPlayGroupState.idle,
        participants: [],
        isProcessingCommand: false,
        processingCommandType: null,
        playingItemId: null,
        playlistItemId: null,
        startPlaybackInProgress: false,
        startingPlaylistItemId: null,
      ));
      _stopLocalPlayback();
    }
  }

  /// Request pause
  Future<void> requestPause() async {
    if (!_state.isInGroup) {
      return;
    }
    try {
      await _api.syncPlayPausePost();
    } catch (e) {
      log('SyncPlay: Failed to request pause: $e');
    }
  }

  /// Request unpause/play (server will move to Waiting until all clients report Ready, then broadcast Unpause).
  Future<void> requestUnpause() async {
    if (!_state.isInGroup) {
      return;
    }
    try {
      log('SyncPlay: Sending Unpause request');
      await _api.syncPlayUnpausePost();
    } catch (e) {
      log('SyncPlay: Failed to request unpause: $e');
    }
  }

  /// Request seek
  Future<void> requestSeek(int positionTicks) async {
    if (!_state.isInGroup) {
      return;
    }
    try {
      await _api.syncPlaySeekPost(
        body: SeekRequestDto(positionTicks: positionTicks),
      );
    } catch (e) {
      log('SyncPlay: Failed to request seek: $e');
    }
  }

  /// Advance to the next item in the SyncPlay queue.
  ///
  /// Mirrors jellyfin-web's lightweight flow: the server only swaps the
  /// current playlist index and broadcasts a `PlayQueue` update with
  /// reason=`NextItem`. Pass the current `playlistItemId` so the server
  /// can reject the request if our view of the queue is stale.
  Future<void> requestNextItem() async {
    if (!_state.isInGroup) {
      log('SyncPlay: Cannot request NextItem - not in group');
      return;
    }
    final currentPlaylistItemId = _state.playlistItemId;
    if (currentPlaylistItemId == null) {
      log('SyncPlay: Cannot request NextItem - no current playlist item');
      return;
    }
    try {
      await _api.syncPlayNextItemPost(
        body: NextItemRequestDto(playlistItemId: currentPlaylistItemId),
      );
    } catch (e) {
      log('SyncPlay: Failed to request NextItem: $e');
    }
  }

  /// Step back to the previous item in the SyncPlay queue. Symmetric with
  /// [requestNextItem].
  Future<void> requestPreviousItem() async {
    if (!_state.isInGroup) {
      log('SyncPlay: Cannot request PreviousItem - not in group');
      return;
    }
    final currentPlaylistItemId = _state.playlistItemId;
    if (currentPlaylistItemId == null) {
      log('SyncPlay: Cannot request PreviousItem - no current playlist item');
      return;
    }
    try {
      await _api.syncPlayPreviousItemPost(
        body: PreviousItemRequestDto(playlistItemId: currentPlaylistItemId),
      );
    } catch (e) {
      log('SyncPlay: Failed to request PreviousItem: $e');
    }
  }

  /// Report buffering state.
  ///
  /// No-op while a local-only operation is active (track switch) so
  /// changing audio/subtitle locally does not pause the group.
  /// Report Buffering to the server. By default the position reported
  /// is the local player's current position; pass [positionTicks] to
  /// override (e.g. during a rejoin/initial-load where the local player
  /// is at 0 but the group is mid-playback — sending 0 there would
  /// make the server use it as the group's position and reset every
  /// other client to the start).
  Future<void> reportBuffering({int? positionTicks}) async {
    if (!_state.isInGroup) {
      return;
    }
    if (_state.isInLocalOnlyMode) {
      log('SyncPlay: Skipping reportBuffering (local-only mode)');
      return;
    }
    try {
      final when = _timeSync?.localDateToRemote(DateTime.now().toUtc());
      final ticks = positionTicks ?? _commandHandler.getPositionTicks?.call() ?? 0;
      await _api.syncPlayBufferingPost(
        body: BufferRequestDto(
          when: when,
          positionTicks: ticks,
          isPlaying: false,
          playlistItemId: _state.playlistItemId,
        ),
      );
    } catch (e) {
      log('SyncPlay: Failed to report buffering: $e');
    }
  }

  /// Report ready state (required for server to broadcast Unpause when
  /// in Waiting). Suppressed while local-only mode is active. Pass
  /// [positionTicks] to override the position sent — same rationale as
  /// [reportBuffering].
  Future<void> reportReady({bool isPlaying = true, int? positionTicks}) async {
    if (!_state.isInGroup) {
      return;
    }
    if (_state.isInLocalOnlyMode) {
      log('SyncPlay: Skipping reportReady (local-only mode)');
      return;
    }
    try {
      final when = _timeSync?.localDateToRemote(DateTime.now().toUtc());
      final ticks = positionTicks ?? _commandHandler.getPositionTicks?.call() ?? 0;
      log('SyncPlay: Reporting Ready (isPlaying=$isPlaying, positionTicks=$ticks)');
      await _api.syncPlayReadyPost(
        body: ReadyRequestDto(
          when: when,
          positionTicks: ticks,
          isPlaying: isPlaying,
          playlistItemId: _state.playlistItemId,
        ),
      );
    } catch (e) {
      log('SyncPlay: Failed to report ready: $e');
    }
  }

  /// Run [body] as a "local-only" operation. While this runs the
  /// controller will not emit `Buffering`/`Ready` to the server and
  /// will trigger an immediate drift correction on completion so the
  /// local player catches up to the group time after a track reload.
  ///
  /// If the group is in `Playing` state when the operation finishes,
  /// the local player is explicitly resumed: media-kit on web does
  /// not reliably auto-play after `loadVideo` + `setAudioTrack` /
  /// `setSubtitleTrack`, and since we suppress `Buffering`/`Ready`
  /// reports the server never re-issues an `Unpause` command we could
  /// piggy-back on.
  Future<T> runLocalOnly<T>(Future<T> Function() body) async {
    final wasPlaying = _commandHandler.isPlaying?.call() ?? false;
    _updateStateWith(
      (state) => state.copyWith(
        localOnlyOperationCount: state.localOnlyOperationCount + 1,
      ),
    );
    try {
      return await body();
    } finally {
      _updateStateWith(
        (state) => state.copyWith(
          localOnlyOperationCount: (state.localOnlyOperationCount - 1).clamp(0, 1 << 30),
        ),
      );

      final shouldResume = wasPlaying || _state.groupState == SyncPlayGroupState.playing;
      if (shouldResume && _state.localOnlyOperationCount == 0 && _commandHandler.isPlaying?.call() == false) {
        log('SyncPlay: Resuming local playback after local-only switch');
        try {
          await _commandHandler.onPlay?.call();
        } catch (e) {
          log('SyncPlay: Failed to resume after local-only switch: $e');
        }
      }

      final ticks = _commandHandler.getPositionTicks?.call() ?? 0;
      updatePlaybackDrift(currentPositionTicks: ticks);
    }
  }

  /// Report ping to server
  Future<void> reportPing() async {
    if (!_state.isInGroup || _timeSync == null) {
      return;
    }
    try {
      await _api.syncPlayPingPost(
        body: PingRequestDto(ping: _timeSync!.ping.inMilliseconds),
      );
    } catch (e) {
      log('SyncPlay: Failed to report ping: $e');
    }
  }

  /// Set a new queue/playlist.
  ///
  /// Debounced to 1 second so two participants cannot race the same
  /// `setNewQueue` request and crash the player by triggering two
  /// concurrent `_startPlayback` flows.
  /// Returns `true` when the request was actually sent to the server,
  /// `false` when it was suppressed (not in group, or debounced).
  /// Callers awaiting the next `_startPlayback` (e.g. the loader UX in
  /// `_playSyncPlay`) need this to avoid waiting for a `PlayQueue`
  /// broadcast that will never arrive.
  Future<bool> setNewQueue({
    required List<String> itemIds,
    int playingItemPosition = 0,
    int startPositionTicks = 0,
  }) async {
    if (!_state.isInGroup) {
      log('SyncPlay: Cannot set queue - not in group');
      return false;
    }
    final now = DateTime.now().toUtc();
    final lastAt = _lastSetNewQueueAt;
    if (lastAt != null && now.difference(lastAt) < const Duration(seconds: 1)) {
      log('SyncPlay: Ignoring setNewQueue (debounced, last call '
          '${now.difference(lastAt).inMilliseconds}ms ago)');
      return false;
    }
    _lastSetNewQueueAt = now;
    try {
      final body = PlayRequestDto(
        playingQueue: itemIds,
        playingItemPosition: playingItemPosition,
        startPositionTicks: startPositionTicks,
      );
      log('SyncPlay: Setting new queue: ${body.toJson()}');
      final response = await _api.syncPlaySetNewQueuePost(body: body);
      log('SyncPlay: SetNewQueue response: ${response.statusCode} - ${response.body}');
      return true;
    } catch (e) {
      log('SyncPlay: Failed to set new queue: $e');
      _lastSetNewQueueAt = null;
      return false;
    }
  }

  /// Returns a Future that completes the next time `_startPlayback`
  /// finishes. Used by the loader UX (initiator path).
  ///
  /// Resolves to `true` on successful playback start, `false` on
  /// error or timeout.
  Future<bool> awaitNextStartPlayback({
    Duration timeout = const Duration(seconds: 20),
  }) {
    final completer = _startPlaybackCompleter ??= Completer<bool>();
    return completer.future.timeout(
      timeout,
      onTimeout: () {
        log('SyncPlay: awaitNextStartPlayback TIMED OUT after '
            '${timeout.inSeconds}s (no _startPlayback completion)');
        return false;
      },
    ).then((value) {
      log('SyncPlay: awaitNextStartPlayback resolved with success=$value');
      return value;
    });
  }

  /// Re-attach to the currently playing group item from outside the
  /// player route. Re-uses [_startPlayback] with the current group
  /// position so the local player jumps back into the running session.
  Future<bool> rejoinPlayback() async {
    final itemId = _state.playingItemId;
    if (!_state.isInGroup || itemId == null) {
      log('SyncPlay: rejoinPlayback called but no active item in group');
      return false;
    }
    // Extrapolate the live group position from the last Unpause command
    // rather than reading the stale `_state.positionTicks` (which only
    // updates on server-broadcast state changes, not continuous
    // playback). Reporting the stale value to the server triggers a
    // catch-up Unpause that schedules every other client to seek BACK
    // to that stale position — visible as "everyone restarted to the
    // beginning" from the perspective of clients that never paused.
    final positionTicks = estimateCurrentGroupPositionTicks();
    final pending = awaitNextStartPlayback();
    log('SyncPlay: Rejoining playback for item=$itemId, '
        'positionTicks=$positionTicks (estimated live)');
    unawaited(_startPlayback(itemId, positionTicks));
    return pending;
  }

  void _handleConnectionState(WebSocketConnectionState wsState) {
    log('SyncPlay: WebSocket connection state: $wsState');
    final isConnected = wsState == WebSocketConnectionState.connected;
    _updateState(_state.copyWith(isConnected: isConnected));
    log('SyncPlay: isConnected updated to: $isConnected');

    // Detect a reconnect: previous state was not-connected and we are
    // now connected. The initial connect after `connect()` falls into
    // this branch too, but the `_lastGroupId != null` guard below makes
    // it a no-op until the user has actually been in a group.
    final wasConnected = _previousWsState == WebSocketConnectionState.connected;
    final isReconnect = isConnected && !wasConnected;
    _previousWsState = wsState;

    if (isReconnect) {
      // A fresh socket connection (initial or reconnect) may have a
      // stale clock offset. Refresh time-sync on every reconnect — a
      // safe superset of the old resume-only refresh that used to live
      // in the now-deleted _handleAppResume().
      if (_timeSync != null) {
        _timeSync!.start();
        unawaited(_timeSync!.forceUpdate());
      }

      if (_lastGroupId != null) {
        // ColorOS / aggressive Android battery savers can drop the
        // WebSocket during a brief window-focus loss — without a
        // corresponding `AppLifecycleState.paused` — so the lifecycle
        // observer can't catch it. Auto-rejoin here covers that case
        // and runs even when the app stayed in the foreground.
        log('SyncPlay: WS reconnected, attempting silent rejoin of $_lastGroupId');
        unawaited(_attemptSilentRejoin());
      }
    }
  }

  /// Rejoin the last-known group without going through `joinGroup`'s
  /// "leave first" path. Used after a transparent WebSocket reconnect
  /// where the local `isInGroup` flag may still be true (we never got
  /// a NotInGroup signal during the disconnect window) but the server
  /// may have already evicted us. The server is the source of truth:
  /// if it accepts the join, GroupJoined fires normally; if not, the
  /// existing NotInGroup / GroupDoesNotExist handlers run.
  Future<void> _attemptSilentRejoin() async {
    final groupId = _lastGroupId;
    if (groupId == null) {
      return;
    }
    if (!_state.isConnected) {
      log('SyncPlay: WS not connected, skipping silent rejoin');
      return;
    }
    final confirmed = await _sendJoinRequest(groupId);
    if (confirmed) {
      log('SyncPlay: Silent rejoin confirmed');
    } else {
      log('SyncPlay: Silent rejoin not confirmed; clearing _lastGroupId');
      _lastGroupId = null;
    }
  }

  void _handleMessage(Map<String, dynamic> message) {
    final messageType = message['MessageType'] as String?;
    final data = message['Data'];

    log('SyncPlay: Received WebSocket message: $messageType');

    switch (messageType) {
      case 'SyncPlayCommand':
        final cmd = (data as Map<String, dynamic>)['Command'] as String?;
        log('SyncPlay: Received SyncPlayCommand: $cmd');
        _commandHandler.handleCommand(data, _state);
        break;
      case 'SyncPlayGroupUpdate':
        log('SyncPlay: GroupUpdate data: $data');
        _messageHandler.handleGroupUpdate(data as Map<String, dynamic>, _state);
        break;
      default:
        // Log unhandled message types for debugging
        if (messageType?.startsWith('SyncPlay') == true) {
          log('SyncPlay: Unhandled SyncPlay message type: $messageType');
        }
    }
  }

  /// Start playback of an item from SyncPlay.
  ///
  /// Guards against re-entrancy: if a `_startPlayback` is already in
  /// flight for the same playlist item, the duplicate call is ignored
  /// (this is the crash fix when two participants press play at the
  /// same time and the server broadcasts two PlayQueue updates back to
  /// back). If a different item is already starting, we wait for it
  /// to finish before kicking off the new one.
  Future<void> _startPlayback(String itemId, int startPositionTicks) async {
    final dedupKey = _state.playlistItemId ?? itemId;
    if (_state.startPlaybackInProgress) {
      if (_currentlyStartingPlaylistItemId == dedupKey) {
        log('SyncPlay: _startPlayback skipped (already starting $dedupKey)');
        return;
      }
      log('SyncPlay: _startPlayback waiting for previous start to finish');
      try {
        await _inFlightStartCompleter?.future.timeout(const Duration(seconds: 15));
      } catch (_) {
        // Fall through and try our own start anyway.
      }
    }

    final localCompleter = _startPlaybackCompleter ??= Completer<bool>();
    _inFlightStartCompleter = Completer<void>();
    _currentlyStartingPlaylistItemId = dedupKey;
    _updateStateWith((state) => state.copyWith(
          startPlaybackInProgress: true,
          startingPlaylistItemId: dedupKey,
        ));
    log('SyncPlay: _startPlayback called for item: $itemId, ticks: $startPositionTicks');

    var success = false;
    try {
      final playerRouteAlreadyOpen = _ref.read(isVideoPlayerRouteOpenProvider);
      log('SyncPlay: Player route already open: $playerRouteAlreadyOpen');

      // Clear the old playback model BEFORE re-initializing. This prevents
      // the fire-and-forget stop() inside _initPlayer() from entering a
      // 1-second delayed playbackStopped flow that races against the new
      // loadPlaybackItem call (which also calls stop()). With playBackModel
      // null, every stop() becomes a no-op.
      if (!playerRouteAlreadyOpen) {
        _ref.read(playBackModel.notifier).update((state) => null);
        await _ref.read(videoPlayerProvider.notifier).init();
      }
      if (_shouldAbortStartPlayback()) {
        log('SyncPlay: _startPlayback aborted after init (left group)');
        return;
      }

      // Fetch the item from Jellyfin
      log('SyncPlay: Fetching item from API...');
      final api = _ref.read(jellyApiProvider);
      final itemResponse = await api.usersUserIdItemsItemIdGet(itemId: itemId);
      if (_shouldAbortStartPlayback()) {
        log('SyncPlay: _startPlayback aborted after item fetch (left group)');
        return;
      }
      final itemModel = itemResponse.body;

      if (itemModel == null) {
        log('SyncPlay: Failed to fetch item $itemId - response body was null');
        return;
      }
      log('SyncPlay: Fetched item: ${itemModel.name}');

      // Create playback model (context is optional - null for SyncPlay auto-play)
      log('SyncPlay: Creating playback model...');
      final playbackHelper = _ref.read(playbackModelHelper);
      final startPosition = Duration(microseconds: startPositionTicks ~/ 10);

      final playbackModel = await playbackHelper.createPlaybackModel(
        null, // No context needed for SyncPlay
        itemModel,
        startPosition: startPosition,
      );
      if (_shouldAbortStartPlayback()) {
        log('SyncPlay: _startPlayback aborted after playback model (left group)');
        return;
      }

      if (playbackModel == null) {
        log('SyncPlay: Failed to create playback model for $itemId');
        return;
      }
      log('SyncPlay: Playback model created successfully');

      // Load and play
      log('SyncPlay: Loading playback item...');
      final loadedCorrectly = await _ref.read(videoPlayerProvider.notifier).loadPlaybackItem(
            playbackModel,
            startPosition,
          );
      if (_shouldAbortStartPlayback()) {
        log('SyncPlay: _startPlayback aborted after loadPlaybackItem (left group)');
        // The player loaded media for a group we no longer belong to —
        // tear it back down so we don't display the abandoned video.
        _stopLocalPlayback();
        return;
      }

      if (!loadedCorrectly) {
        log('SyncPlay: Failed to load playback item $itemId');
        return;
      }
      success = true;
      log('SyncPlay: Playback item loaded successfully');

      // Set state to fullScreen
      _ref.read(mediaPlaybackProvider.notifier).update(
            (state) => state.copyWith(state: VideoPlayerState.fullScreen),
          );
      log('SyncPlay: Set state to fullScreen');

      // Only push the player route when it isn't already on screen.
      // When the route is already open (e.g. User B whose player stayed
      // open), loadPlaybackItem already swapped the video content in the
      // existing player — pushing again would stack duplicate routes.
      if (!playerRouteAlreadyOpen) {
        final navigatorKey = getNavigatorKey(_ref);
        final context = navigatorKey?.currentContext;
        log('SyncPlay: Navigator context: ${context != null ? "exists" : "null"}');

        if (context != null && !_shouldAbortStartPlayback()) {
          // openPlayer pushes a route via Navigator.push, whose Future
          // does not complete until the route is popped (i.e. the user
          // closes the player). Awaiting it would hold _startPlayback
          // open for as long as the player is visible — and with it
          // startPlaybackInProgress and the "Switching item…" overlay.
          // Fire-and-forget so we exit the load phase immediately.
          unawaited(_ref.read(videoPlayerProvider.notifier).openPlayer(context));
          log('SyncPlay: Pushed player route for $itemId');
        } else {
          log('SyncPlay: No navigator context available, player loaded but not opened fullscreen');
        }
      } else {
        log('SyncPlay: Player route already open, video reloaded in place');
      }
    } catch (e, stackTrace) {
      log('SyncPlay: Error starting playback: $e\n$stackTrace');
    } finally {
      _currentlyStartingPlaylistItemId = null;
      _updateStateWith((state) => state.copyWith(
            startPlaybackInProgress: false,
            startingPlaylistItemId: null,
          ));
      if (!success) {
        // Failure or aborted-on-leave: clear the buffering flag so the rest
        // of the group is not stranded waiting on us.
        setPlayerBufferingState(false);
        if (_state.isInGroup) {
          unawaited(reportReady(isPlaying: false));
        }
      }
      _inFlightStartCompleter?.complete();
      _inFlightStartCompleter = null;
      if (!localCompleter.isCompleted) {
        localCompleter.complete(success);
      }
      _startPlaybackCompleter = null;
    }
  }

  void _updateState(SyncPlayState newState) {
    _state = newState;
    _stateController.add(newState);
  }

  void _updateStateWith(SyncPlayState Function(SyncPlayState) updater) {
    _state = updater(_state);
    _stateController.add(_state);
  }

  /// Display a SyncPlay-related snackbar through the global overlay.
  /// We never pass the navigator-key context to `FladderSnack`: that
  /// context isn't under any `Overlay`. The notification manager keeps
  /// a stored root context (set by `NotificationManagerInitializer`)
  /// that resolves to the root overlay.
  void _showGroupSnackbar(String Function(AppLocalizations l) message) {
    try {
      final loc = lookupAppLocalizations(const Locale('en'));
      FladderSnack.show(message(loc));
    } catch (_) {
      // Best effort - ignore if localizations are unavailable.
    }
  }

  /// Notify listeners (and overlays) that we got kicked out of a group
  /// while still believing we belonged to it.
  void notifyGroupGone({bool wasKicked = false}) {
    _showGroupSnackbar(
      (l) => wasKicked ? l.syncPlayKickedFromGroup : l.syncPlayGroupNoLongerExists,
    );
  }

  /// Dispose resources
  Future<void> dispose() async {
    _commandHandler.dispose();
    await disconnect();
    await _stateController.close();
  }
}
