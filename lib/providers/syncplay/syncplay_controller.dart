import 'dart:async';
import 'dart:developer' as developer;

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/router_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_command_handler.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_message_handler.dart';
import 'package:fladder/providers/syncplay/time_sync_service.dart';
import 'package:fladder/providers/websocket/jellyfin_websocket.dart';
import 'package:fladder/providers/websocket/jellyfin_websocket_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncPlayController {
  static const bool _verboseSyncPlayLogs = false;

  /// Position ticks arrive far more often than corrections should be attempted.
  static const Duration _driftCheckInterval = Duration(milliseconds: 1500);

  /// Position window inside which an already-loaded item is attached without a seek.
  static const int _attachSeekToleranceTicks = SyncPlayCommandHandler.positionToleranceTicks;

  SyncPlayController(this._ref) {
    _commandHandler = SyncPlayCommandHandler(
      timeSync: () => _timeSync,
      onStateUpdate: _updateStateWith,
    );
    _messageHandler = SyncPlayMessageHandler(
      onStateUpdate: _updateStateWith,
      startPlayback: _onQueueStartPlayback,
      getContext: () => getNavigatorKey(_ref)?.currentContext,
      onGroupJoined: _onGroupJoined,
      onGroupJoinFailed: _onGroupJoinFailed,
      onGroupLeftOrKicked: _onGroupLeftOrKicked,
      onStateUpdateToPlaying: _onStateUpdateToPlaying,
      onGroupGone: ({required wasKicked}) => notifyGroupGone(wasKicked: wasKicked),
    );
  }

  final Ref _ref;

  TimeSyncService? _timeSync;
  StreamSubscription? _wsMessageSubscription;
  StreamSubscription? _wsStateSubscription;
  Timer? _syncCorrectionTimer;
  DateTime? _lastDriftCheckAt;

  late final SyncPlayCommandHandler _commandHandler;
  late final SyncPlayMessageHandler _messageHandler;

  SyncPlayState _state = SyncPlayState();
  final _stateController = StreamController<SyncPlayState>.broadcast();

  Stream<SyncPlayState> get stateStream => _stateController.stream;

  SyncPlayState get state => _state;

  String? _lastGroupId;

  /// Set while a transparent rejoin after a socket drop is in flight; the `PlayQueue` frame that follows
  /// its `GroupJoined` must not be mistaken for a user-initiated join on a halted device.
  bool _silentRejoinInFlight = false;
  DateTime? _silentJoinedAt;
  bool _queueFrameFromSilentRejoin = false;

  /// The server replays the queue right after `GroupJoined`; a later frame is a participant's action.
  static const Duration _silentRejoinQueueWindow = Duration(seconds: 5);

  // Previous socket state, used to detect reconnects for the silent rejoin.
  WebSocketConnectionState? _previousWsState;

  Completer<bool>? _joinGroupCompleter;

  // Resolves when the next `_startPlayback` finishes; drives the loader UX.
  Completer<bool>? _startPlaybackCompleter;

  // Dedup key against concurrent PlayQueue updates from simultaneous initiators.
  String? _currentlyStartingPlaylistItemId;
  Completer<void>? _inFlightStartCompleter;

  // Debounces `setNewQueue` so a double tap does not send two requests.
  DateTime? _lastSetNewQueueAt;

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

  /// Stamps the last command time; the player-side cooldown uses it to avoid feedback loops.
  void markCommandExecuted([DateTime? at]) {
    _updateStateWith((state) => state.copyWith(
          lastCommandTime: at ?? DateTime.now().toUtc(),
        ));
  }

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

  /// [clearLastCommand] is false around halt/resume so the last command keeps describing the group's
  /// playhead while this device is not following.
  void resetCorrectionState({
    String reason = 'reset',
    bool syncEnabled = true,
    bool clearLastCommand = true,
  }) {
    _syncCorrectionTimer?.cancel();
    _syncCorrectionTimer = null;
    _lastDriftCheckAt = null;

    final setSpeed = _commandHandler.onSetSpeed;
    if (setSpeed != null) {
      unawaited(
        setSpeed(1.0).catchError((Object error, StackTrace stackTrace) {
          log('SyncPlay: Failed to reset speed during correction reset: $error');
        }),
      );
    }
    if (clearLastCommand) {
      _commandHandler.clearLastCommand();
    }

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

  /// Drift = estimated server position - local position (positive: local is behind).
  /// Throttled to [_driftCheckInterval] unless [force] (used right after a local-only reload).
  void updatePlaybackDrift({
    required int currentPositionTicks,
    DateTime? at,
    bool force = false,
  }) {
    if (!_state.isFollowingGroupPlayback) {
      return;
    }
    // Throttle before any other work: this runs on every position tick.
    final now = (at ?? DateTime.now().toUtc());
    final lastCheck = _lastDriftCheckAt;
    if (!force && lastCheck != null && now.difference(lastCheck) < _driftCheckInterval) {
      return;
    }
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
    _lastDriftCheckAt = now;

    final remoteNow = _timeSync?.localDateToRemote(now) ?? now;
    final elapsedMs = remoteNow.difference(when).inMilliseconds;

    final estimatedServerTicks = lastCommand.positionTicks + millisecondsToTicks(elapsedMs);
    final diffTicks = estimatedServerTicks - currentPositionTicks;
    final diffMillis = ticksToMilliseconds(diffTicks).toDouble();
    final correctionEnabled = _ref.read(videoPlayerSettingsProvider).enableSyncPlayCorrection;
    final correctionConfig = _state.correctionConfig.copyWith(enableSyncCorrection: correctionEnabled);
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

  /// Estimates the live group playhead from the last command, then the last `PlayQueue` frame timing;
  /// `state.positionTicks` is only a fallback because it can be tens of seconds stale.
  int estimateCurrentGroupPositionTicks() {
    final now = DateTime.now().toUtc();
    return estimateGroupPositionTicks(
      lastCommand: _commandHandler.lastCommand,
      currentPlaylistItemId: _state.playlistItemId,
      queueTiming: _state.queueTiming,
      fallbackPositionTicks: _state.positionTicks,
      remoteNow: _timeSync?.localDateToRemote(now) ?? now,
    );
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

  /// Attaches SyncPlay to the app-owned WebSocket (connected off `userProvider`) and starts time-sync.
  Future<void> connect() async {
    final user = _ref.read(userProvider);
    if (user == null) {
      log('SyncPlay: Cannot connect without user');
      return;
    }

    final ws = _ref.read(jellyfinWebSocketControllerProvider.notifier);

    // Idempotent: the sheet calls this every time it re-opens.
    if (_wsStateSubscription != null) {
      log('SyncPlay: connect() called but already subscribed; reusing shared socket');
      return;
    }

    final timeSync = TimeSyncService(_api);
    timeSync.onMeasurement = (_, __) {
      // The server sizes the group's unpause delay from our ping; also release a clock-gated command.
      unawaited(reportPing());
      _commandHandler.flushQueuedCommand();
    };
    _timeSync = timeSync;
    timeSync.start();

    _wsStateSubscription = ws.connectionState.listen(_handleConnectionState);
    _wsMessageSubscription = ws.messages.listen(_handleMessage);

    // The state stream does not replay; seed from the current state or `joinGroup` would stay blocked.
    _handleConnectionState(ws.currentState);
  }

  /// Detaches SyncPlay from the shared WebSocket without closing it (the socket is app-owned).
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
    _timeSync?.onMeasurement = null;
    _timeSync?.dispose();
    _timeSync = null;
    _updateState(SyncPlayState());
  }

  Future<List<GroupInfoDto>> listGroups() async {
    try {
      final response = await _api.syncPlayListGet();
      return response.body ?? [];
    } catch (e) {
      log('SyncPlay: Failed to list groups: $e');
      return [];
    }
  }

  /// Creates a group and waits for `GroupJoined`. Local video playback seeds the group through
  /// `SetNewQueue`, since the server cannot seed from a `NowPlayingQueue` this client never reports.
  Future<GroupInfoDto?> createGroup(String groupName) async {
    if (_state.isInGroup) {
      log('SyncPlay: Already in a group, leaving before creating a new one');
      await leaveGroup();
    }

    _updateStateWith((s) => s.copyWith(isFollowingGroupPlayback: true));
    final completer = _joinGroupCompleter = Completer<bool>();
    try {
      final response = await _api.syncPlayNewPost(
        body: NewGroupRequestDto(groupName: groupName),
      );
      final info = response.body;
      if (info == null) {
        _completeJoinRequest(false);
        return null;
      }

      final joined = await completer.future.timeout(
        const Duration(seconds: 12),
        onTimeout: () => _state.isInGroup && _state.groupId == info.groupId,
      );
      if (identical(_joinGroupCompleter, completer)) {
        _joinGroupCompleter = null;
      }
      if (!joined) {
        log('SyncPlay: Group ${info.groupId} created but GroupJoined never arrived');
        return null;
      }
      await _seedQueueFromLocalPlayback();
      return info;
    } catch (e) {
      log('SyncPlay: Failed to create group: $e');
      if (identical(_joinGroupCompleter, completer)) {
        _completeJoinRequest(false);
      }
      return null;
    }
  }

  /// Only an item showing in the video player qualifies: seeding from the audio queue would tear the
  /// audio player down and reload the track through the video path.
  Future<void> _seedQueueFromLocalPlayback() async {
    final model = _ref.read(playBackModel);
    if (model == null) {
      return;
    }
    final videoRouteOpen = _ref.read(isVideoPlayerRouteOpenProvider);
    if (!videoRouteOpen || model.item.type == FladderItemType.audio) {
      log('SyncPlay: Not seeding new group (no video playing locally)');
      return;
    }
    final queueIds = model.queue.map((item) => item.id).toList();
    final itemIds = queueIds.isNotEmpty ? queueIds : [model.item.id];
    final index = itemIds.indexOf(model.item.id).clamp(0, itemIds.length - 1);
    final position = _ref.read(videoPlayerProvider).lastState?.position ?? Duration.zero;
    final positionTicks = secondsToTicks(position.inMilliseconds / 1000);
    log('SyncPlay: Seeding new group with local playback '
        '(item=${model.item.id}, index=$index, ticks=$positionTicks)');
    await setNewQueue(
      itemIds: itemIds,
      playingItemPosition: index,
      startPositionTicks: positionTicks,
    );
  }

  /// Returns true only once the server's `GroupJoined` frame arrived.
  Future<bool> joinGroup(String groupId) async {
    if (_state.isInGroup) {
      log('SyncPlay: Already in a group, leaving first...');
      await leaveGroup();
    }

    if (!_state.isConnected) {
      log('SyncPlay: WebSocket not connected, cannot join group');
      return false;
    }

    log('SyncPlay: Joining group: $groupId');
    _updateStateWith((s) => s.copyWith(isFollowingGroupPlayback: true));
    final confirmed = await _sendJoinRequest(groupId);
    // `_lastGroupId` is stamped in `_onGroupJoined` from the server frame, not from this result.
    log(confirmed ? 'SyncPlay: Group join confirmed' : 'SyncPlay: Group join not confirmed');
    return confirmed;
  }

  /// Sends Join and waits for the matching `GroupJoined`; shared by [joinGroup] and [_attemptSilentRejoin].
  Future<bool> _sendJoinRequest(String groupId) async {
    final completer = _joinGroupCompleter = Completer<bool>();
    try {
      await _api.syncPlayJoinPost(
        body: JoinGroupRequestDto(groupId: groupId),
      );
      final confirmed = await completer.future.timeout(
        const Duration(seconds: 12),
        onTimeout: () {
          // Join is idempotent and real rejections arrive promptly, so a missing GroupJoined is almost
          // always a slow socket: reconcile against the authoritative state instead of reporting failure.
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

  /// Completes and clears the pending join completer exactly once, whichever path reaches it first.
  void _completeJoinRequest(bool joined) {
    final completer = _joinGroupCompleter;
    _joinGroupCompleter = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete(joined);
    }
  }

  /// The `PlayQueue` frame that follows `GroupJoined` drives playback, so nothing is started here.
  void _onGroupJoined() {
    resetCorrectionState(
      reason: 'group_joined',
      syncEnabled: true,
    );
    // Stamp from the server frame, not the awaited `joinGroup` bool: a slow socket can deliver
    // `GroupJoined` after `joinGroup` already timed out, and the silent rejoin depends on this.
    _lastGroupId = _state.groupId ?? _lastGroupId;
    final silentRejoin = _silentRejoinInFlight;
    _silentJoinedAt = silentRejoin ? DateTime.now().toUtc() : null;
    _silentRejoinInFlight = false;
    _completeJoinRequest(true);
    unawaited(_timeSync?.forceUpdate());
    // The server-side IgnoreWait flag died with the evicted session; a halted device must re-set it.
    if (!_state.isFollowingGroupPlayback) {
      unawaited(setIgnoreWait(true));
    }
    // A transparent rejoin after a socket drop is not news to the user.
    final showSnackbar = _state.groupName != null && !silentRejoin;
    if (showSnackbar) {
      _showGroupSnackbar(
        (l) => l.syncPlayJoinedGroup(_state.groupName ?? ''),
      );
    }
  }

  void _onGroupJoinFailed() {
    _completeJoinRequest(false);
  }

  /// Also stops local playback: otherwise the old media stays loaded in the background and a later
  /// `Unpause` from a different group would resume it.
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
          isFollowingGroupPlayback: true,
        ));
    _stopLocalPlayback();
  }

  /// Deferred to a microtask: this can run inside a WebSocket handler still on the stack of a
  /// `syncPlayProvider` listener, and reading `videoPlayerProvider` there throws `CircularDependencyError`.
  void _stopLocalPlayback() {
    Future<void>.microtask(() {
      try {
        unawaited(_ref.read(videoPlayerProvider.notifier).stopAndClosePlayer());
      } catch (e) {
        log('SyncPlay: Failed to stop local playback after leave: $e');
      }
    });
  }

  /// Callers must check this between every `await` so they don't resume media for a group we left.
  bool _shouldAbortStartPlayback() => !_state.isInGroup || !_state.isFollowingGroupPlayback;

  /// Clears in-group bookkeeping so a subsequent rejoin starts from a clean slate.
  void _resetGroupLifecycleState() {
    _lastSetNewQueueAt = null;
    _silentRejoinInFlight = false;
    _silentJoinedAt = null;
    _currentlyStartingPlaylistItemId = null;
    _inFlightStartCompleter = null;
    if (_startPlaybackCompleter != null && !_startPlaybackCompleter!.isCompleted) {
      _startPlaybackCompleter!.complete(false);
    }
    _startPlaybackCompleter = null;
    _completeJoinRequest(false);
  }

  /// Must never pre-empt a scheduled Unpause (the command owns the start time); releases a clock-gated
  /// Unpause, otherwise recovers a paused player when nothing of our own is in flight.
  void _onStateUpdateToPlaying() {
    if (!_state.isFollowingGroupPlayback || _state.startPlaybackInProgress) {
      return;
    }
    if (_commandHandler.hasQueuedCommand) {
      log('SyncPlay: Group is Playing - applying the command queued behind the clock gate');
      _commandHandler.flushQueuedCommand(force: true);
      return;
    }
    final now = DateTime.now().toUtc();
    final remoteNow = _timeSync?.localDateToRemote(now) ?? now;
    if (_commandHandler.shouldRecoverPlayback(remoteNow)) {
      log('SyncPlay: Group is Playing but player is paused with nothing pending - recovering');
      _commandHandler.recoverPlayback();
    }
  }

  SyncPlayState _clearGroupState(SyncPlayState state) {
    return state.copyWith(
      isInGroup: false,
      isFollowingGroupPlayback: true,
      groupId: null,
      groupName: null,
      groupState: SyncPlayGroupState.idle,
      participants: [],
      isProcessingCommand: false,
      processingCommandType: null,
      positionTicks: 0,
      playlistItemId: null,
      playingItemId: null,
      playlist: [],
      playingItemIndex: -1,
      queueTiming: null,
      startPlaybackInProgress: false,
      startingPlaylistItemId: null,
    );
  }

  Future<void> leaveGroup() async {
    if (!_state.isInGroup) {
      return;
    }
    try {
      await _api.syncPlayLeavePost();
      _lastGroupId = null;
      log('SyncPlay: Left group, state reset');
    } catch (e) {
      log('SyncPlay: Failed to leave group: $e');
    } finally {
      _resetGroupLifecycleState();
      _commandHandler.cancelPendingCommands();
      resetCorrectionState(
        reason: 'leave_group',
        syncEnabled: false,
      );
      _updateState(_clearGroupState(_state));
      _stopLocalPlayback();
    }
  }

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

  /// The server moves to Waiting until all clients report Ready, then broadcasts Unpause.
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

  /// Passes the current `playlistItemId` so the server rejects a stale request; that is what
  /// de-duplicates simultaneous requests from every participant.
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

  Future<void> requestSetPlaylistItem(String playlistItemId) async {
    if (!_state.isInGroup) {
      log('SyncPlay: Cannot request SetPlaylistItem - not in group');
      return;
    }
    try {
      await _api.syncPlaySetPlaylistItemPost(
        body: SetPlaylistItemRequestDto(playlistItemId: playlistItemId),
      );
    } catch (e) {
      log('SyncPlay: Failed to request SetPlaylistItem: $e');
    }
  }

  /// `true` while the user halted playback on this device, so group waits skip this session.
  Future<void> setIgnoreWait(bool ignoreWait) async {
    if (!_state.isInGroup) {
      return;
    }
    try {
      await _api.syncPlaySetIgnoreWaitPost(
        body: IgnoreWaitRequestDto(ignoreWait: ignoreWait),
      );
    } catch (e) {
      log('SyncPlay: Failed to set IgnoreWait=$ignoreWait: $e');
    }
  }

  /// Stops following group playback on this device while staying in the group; commands are only
  /// recorded until [rejoinPlayback]. Local state changes first so `userStop` never waits on the network.
  Future<void> haltPlayback({bool stopLocalPlayer = true}) async {
    if (!_state.isInGroup || !_state.isFollowingGroupPlayback) {
      return;
    }
    log('SyncPlay: Halting group playback on this device');
    _commandHandler.cancelPendingCommands();
    resetCorrectionState(
      reason: 'halt_playback',
      syncEnabled: false,
      clearLastCommand: false,
    );
    _updateStateWith((s) => s.copyWith(
          isFollowingGroupPlayback: false,
          isProcessingCommand: false,
          processingCommandType: null,
          startPlaybackInProgress: false,
          startingPlaylistItemId: null,
        ));
    if (stopLocalPlayer) {
      _stopLocalPlayback();
    }
    await setIgnoreWait(true);
  }

  Future<void> _followGroupPlayback() async {
    if (_state.isFollowingGroupPlayback) {
      return;
    }
    log('SyncPlay: Following group playback again');
    _updateStateWith((s) => s.copyWith(isFollowingGroupPlayback: true));
    resetCorrectionState(
      reason: 'follow_playback',
      syncEnabled: true,
      clearLastCommand: false,
    );
    await setIgnoreWait(false);
  }

  /// Pass [positionTicks] during a rejoin/initial load: reporting the local 0 would become the group
  /// position and reset every other client. No-op in local-only mode or while halted.
  Future<void> reportBuffering({int? positionTicks}) async {
    if (!_state.isInGroup || !_state.isFollowingGroupPlayback) {
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

  /// [isPlaying] must be the real player state: the server adds elapsed time only for a playing client.
  /// [positionTicks] overrides the reported position (see [reportBuffering]).
  Future<void> reportReady({required bool isPlaying, int? positionTicks}) async {
    if (!_state.isInGroup || !_state.isFollowingGroupPlayback) {
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

  /// Suppresses Buffering/Ready reports while [body] runs (track switch), then forces a drift check.
  /// Resumes explicitly if the group is Playing: media-kit on web does not reliably auto-play after a reload.
  Future<T> runLocalOnly<T>(Future<T> Function() body) async {
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

      final shouldResume = _state.groupState == SyncPlayGroupState.playing && _state.isFollowingGroupPlayback;
      if (shouldResume && _state.localOnlyOperationCount == 0 && _commandHandler.isPlaying?.call() == false) {
        log('SyncPlay: Resuming local playback after local-only switch');
        try {
          await _commandHandler.onPlay?.call();
        } catch (e) {
          log('SyncPlay: Failed to resume after local-only switch: $e');
        }
      }

      final ticks = _commandHandler.getPositionTicks?.call() ?? 0;
      updatePlaybackDrift(currentPositionTicks: ticks, force: true);
    }
  }

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

  /// Debounced to 1s per device. Returns `true` only when the request was sent, so callers awaiting
  /// the next `_startPlayback` do not wait for a `PlayQueue` broadcast that will never arrive.
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

  /// Completes with the outcome of the next `_startPlayback` (`false` on error or timeout).
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

  /// "Resume playback" from outside the player: follows the group again, then restarts at the live position.
  Future<bool> rejoinPlayback() async {
    final itemId = _state.playingItemId;
    if (!_state.isInGroup || itemId == null) {
      log('SyncPlay: rejoinPlayback called but no active item in group');
      return false;
    }
    // Loading at the stale `_state.positionTicks` costs a corrective Seek and a transcode at the wrong offset.
    final positionTicks = estimateCurrentGroupPositionTicks();
    await _followGroupPlayback();
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

    // The initial connect lands here too; the `_lastGroupId` guard makes it a no-op until a group was joined.
    final wasConnected = _previousWsState == WebSocketConnectionState.connected;
    final isReconnect = isConnected && !wasConnected;
    _previousWsState = wsState;

    if (isReconnect) {
      // A fresh socket may carry a stale clock offset.
      if (_timeSync != null) {
        _timeSync!.start();
        unawaited(_timeSync!.forceUpdate());
      }

      if (_lastGroupId != null) {
        // The server drops group membership with the socket; rejoin transparently and let it answer.
        log('SyncPlay: WS reconnected, attempting silent rejoin of $_lastGroupId');
        unawaited(_attemptSilentRejoin());
      }
    }
  }

  /// Rejoins the last group after a socket reconnect without `joinGroup`'s leave-first path: the local
  /// `isInGroup` may still be true although the server already evicted us.
  Future<void> _attemptSilentRejoin() async {
    final groupId = _lastGroupId;
    if (groupId == null) {
      return;
    }
    if (!_state.isConnected) {
      log('SyncPlay: WS not connected, skipping silent rejoin');
      return;
    }
    _silentRejoinInFlight = true;
    final confirmed = await _sendJoinRequest(groupId);
    if (confirmed) {
      log('SyncPlay: Silent rejoin confirmed');
    } else {
      log('SyncPlay: Silent rejoin not confirmed; clearing _lastGroupId');
      _silentRejoinInFlight = false;
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
        if (!_state.isInGroup) {
          log('SyncPlay: Ignoring $cmd - not in a group');
          break;
        }
        if (!_state.isFollowingGroupPlayback) {
          // Not applied, but recorded: a later resume needs the group's live position.
          _commandHandler.recordCommand(data);
          break;
        }
        _commandHandler.handleCommand(data, _state);
        break;
      case 'SyncPlayGroupUpdate':
        log('SyncPlay: GroupUpdate data: $data');
        final update = data as Map<String, dynamic>;
        // The first queue frame after a transparent rejoin is a replay; see [_onQueueStartPlayback].
        if (update['Type'] == 'PlayQueue') {
          final joinedAt = _silentJoinedAt;
          _silentJoinedAt = null;
          _queueFrameFromSilentRejoin =
              joinedAt != null && DateTime.now().toUtc().difference(joinedAt) < _silentRejoinQueueWindow;
        }
        _messageHandler.handleGroupUpdate(update, _state);
        _queueFrameFromSilentRejoin = false;
        break;
      default:
        if (messageType?.startsWith('SyncPlay') == true) {
          log('SyncPlay: Unhandled SyncPlay message type: $messageType');
        }
    }
  }

  /// Resolves the loader completer as soon as the frame arrives: media-kit on web can leave `loadVideo()`
  /// hanging although playback runs. A halted device only follows again on a brand-new playlist.
  Future<void> _onQueueStartPlayback(String itemId, int startPositionTicks, String? reason) async {
    final fromSilentRejoin = _queueFrameFromSilentRejoin;
    if (!_state.isFollowingGroupPlayback) {
      // The replayed queue after a transparent rejoin is not a participant starting a new playlist.
      if (reason != 'NewPlaylist' || fromSilentRejoin) {
        log('SyncPlay: Ignoring $reason queue update while not following group playback');
        return;
      }
      await _followGroupPlayback();
    }
    final completer = _startPlaybackCompleter;
    if (completer != null && !completer.isCompleted) {
      log('SyncPlay: PlayQueue accepted - resolving loader completer eagerly for item=$itemId');
      completer.complete(true);
    }
    await _startPlayback(itemId, startPositionTicks);
  }

  /// True when the group's item is already loaded in an open player, so a seek can replace a full reload.
  bool _isItemAttachable(String itemId) {
    final routeOpen = _ref.read(isVideoPlayerRouteOpenProvider);
    if (!routeOpen) {
      return false;
    }
    final player = _ref.read(videoPlayerProvider);
    if (!player.hasPlayer) {
      return false;
    }
    final currentModel = _ref.read(playBackModel);
    return currentModel != null && currentModel.item.id == itemId;
  }

  /// The server flagged us as buffering when it sent the queue frame, so a Ready is owed either way.
  Future<void> _attachLoadedItem(int startPositionTicks) async {
    final currentTicks = _commandHandler.getPositionTicks?.call() ?? 0;
    await _commandHandler.onPause?.call();
    if ((currentTicks - startPositionTicks).abs() > _attachSeekToleranceTicks) {
      log('SyncPlay: Attaching loaded item - seeking from $currentTicks to $startPositionTicks');
      await _commandHandler.onSeek?.call(startPositionTicks);
    } else {
      log('SyncPlay: Attaching loaded item in place (within tolerance)');
    }
    setPlayerBufferingState(false);
    await reportReady(isPlaying: false, positionTicks: startPositionTicks);
  }

  /// Re-entrancy guard: a duplicate start for the same playlist item is ignored (two participants pressing
  /// play produce two back-to-back PlayQueue frames); a different item waits for the in-flight start.
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
    var loadAttempted = false;
    try {
      if (_isItemAttachable(itemId)) {
        log('SyncPlay: Item $itemId already loaded - attaching without reload');
        await _attachLoadedItem(startPositionTicks);
        success = true;
        return;
      }

      final playerRouteAlreadyOpen = _ref.read(isVideoPlayerRouteOpenProvider);
      log('SyncPlay: Player route already open: $playerRouteAlreadyOpen');

      // Clear the playback model before re-initializing so the fire-and-forget stop() inside init() is a
      // no-op instead of racing the new loadPlaybackItem through the delayed playbackStopped flow.
      if (!playerRouteAlreadyOpen) {
        _ref.read(playBackModel.notifier).update((state) => null);
        await _ref.read(videoPlayerProvider.notifier).init();
      }
      if (_shouldAbortStartPlayback()) {
        log('SyncPlay: _startPlayback aborted after init (left group)');
        return;
      }

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

      // From here on the player reports its own Ready on failure, so the finally block must not send one.
      loadAttempted = true;
      log('SyncPlay: Loading playback item...');
      final loadedCorrectly = await _ref.read(videoPlayerProvider.notifier).loadPlaybackItem(
            playbackModel,
            startPosition,
          );
      if (_shouldAbortStartPlayback()) {
        log('SyncPlay: _startPlayback aborted after loadPlaybackItem (left group)');
        // Tear down media loaded for a group we no longer belong to.
        _stopLocalPlayback();
        return;
      }

      if (!loadedCorrectly) {
        log('SyncPlay: Failed to load playback item $itemId');
        return;
      }
      success = true;
      log('SyncPlay: Playback item loaded successfully');

      _ref.read(mediaPlaybackProvider.notifier).update(
            (state) => state.copyWith(state: VideoPlayerState.fullScreen),
          );
      log('SyncPlay: Set state to fullScreen');

      // When the route is already open, loadPlaybackItem swapped the content in place; pushing would stack routes.
      if (!playerRouteAlreadyOpen) {
        final navigatorKey = getNavigatorKey(_ref);
        final context = navigatorKey?.currentContext;
        log('SyncPlay: Navigator context: ${context != null ? "exists" : "null"}');

        if (context != null && !_shouldAbortStartPlayback()) {
          // openPlayer's Future only completes when the route is popped; awaiting it would keep
          // startPlaybackInProgress (and the "Switching item…" overlay) up while the player is visible.
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
        // Clear the buffering flag so the rest of the group is not stranded waiting on us.
        setPlayerBufferingState(false);
        if (_state.isInGroup && !loadAttempted) {
          unawaited(reportReady(isPlaying: false, positionTicks: startPositionTicks));
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

  /// Never pass the navigator-key context to `FladderSnack`: it is not under an `Overlay`. The
  /// notification manager resolves the root overlay from its own stored context.
  void _showGroupSnackbar(String Function(AppLocalizations l) message) {
    try {
      final context = _ref.read(localizationContextProvider);
      final loc = context != null ? context.localized : lookupAppLocalizations(const Locale('en'));
      FladderSnack.show(message(loc));
    } catch (_) {
      // Best effort - ignore if localizations are unavailable.
    }
  }

  /// Shown when the server evicted us from a group we still believed we belonged to.
  void notifyGroupGone({bool wasKicked = false}) {
    _showGroupSnackbar(
      (l) => wasKicked ? l.syncPlayKickedFromGroup : l.syncPlayGroupNoLongerExists,
    );
  }

  Future<void> dispose() async {
    _commandHandler.dispose();
    await disconnect();
    await _stateController.close();
  }
}
