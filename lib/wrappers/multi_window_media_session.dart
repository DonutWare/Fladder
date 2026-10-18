import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:audio_service/audio_service.dart';
import 'package:collection/collection.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:smtc_windows/smtc_windows.dart' if (dart.library.html) 'package:fladder/stubs/web/smtc_web.dart';

//Manager every windows media player and forward the active window state to the OS (audio_service + SMTC).
class MultiWindowMediaSession {
  MultiWindowMediaSession._();

  static final instance = MultiWindowMediaSession._();

  static bool get supported => !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  static const _hubChannel = WindowMethodChannel('fladder/media_session/hub', mode: ChannelMode.unidirectional);

  static WindowMethodChannel _windowChannel(String windowId) =>
      WindowMethodChannel('fladder/media_session/$windowId', mode: ChannelMode.unidirectional);

  final Completer<void> _ready = Completer();
  bool _initStarted = false;
  String? _windowId;
  bool _isHub = false;

  AudioHandler? _local;
  final List<StreamSubscription> _localSubscriptions = [];
  bool _lastReportedEmpty = true;

  _OsMediaSession? _os;
  final Map<String, _WindowSession> _sessions = {};
  int _order = 0;
  String? _activeWindowId;

  Future<void> init({required bool isHub}) async {
    if (_initStarted) return _ready.future;
    _initStarted = true;
    try {
      final windowId = (await WindowController.fromCurrentEngine()).windowId;
      _windowId = windowId;
      _isHub = isHub;
      await _windowChannel(windowId).setMethodCallHandler((call) => _handleCommand(call.method, call.arguments));
      if (isHub) {
        _os = await AudioService.init(builder: () => _OsMediaSession(this), config: _audioServiceConfig);
        await _hubChannel.setMethodCallHandler(_handleHubCall);
        onWindowsChanged.listen((_) => _pruneClosedWindows());
      }
    } catch (e, stackTrace) {
      log('Failed to initialize multi window media session: $e\n$stackTrace');
    }
    _ready.complete();
    _reportLocal(force: true);
  }

  void attach(AudioHandler handler) {
    if (identical(_local, handler)) return;
    for (final subscription in _localSubscriptions) {
      subscription.cancel();
    }
    _local = handler;
    _localSubscriptions
      ..clear()
      ..add(handler.mediaItem.listen((_) => _reportLocal()))
      ..add(handler.playbackState.listen((_) => _reportLocal()));
  }

  void _reportLocal({bool force = false}) {
    final windowId = _windowId;
    final local = _local;
    if (!_ready.isCompleted || windowId == null || local == null) return;

    final item = local.mediaItem.valueOrNull;
    if (item == null && _lastReportedEmpty && !force) return;
    _lastReportedEmpty = item == null;

    final arguments = {
      'windowId': windowId,
      'item': item != null ? _encodeMediaItem(item) : null,
      'state': _encodePlaybackState(local.playbackState.value),
    };

    if (_isHub) {
      _updateSession(arguments);
    } else {
      _hubChannel.invokeMethod('update', arguments).catchError((Object e) {
        log('Failed to report media session to main window: $e');
      });
    }
  }

  Future<dynamic> _handleCommand(String method, dynamic arguments) async {
    final local = _local;
    if (local == null) return;
    switch (method) {
      case 'play':
        return local.play();
      case 'pause':
        return local.pause();
      case 'stop':
        return local.stop();
      case 'seek':
        return local.seek(Duration(milliseconds: arguments as int));
      case 'setSpeed':
        return local.setSpeed(arguments as double);
      case 'skipToNext':
        return local.skipToNext();
      case 'skipToPrevious':
        return local.skipToPrevious();
      case 'fastForward':
        return local.fastForward();
      case 'rewind':
        return local.rewind();
    }
  }

  Future<dynamic> _handleHubCall(MethodCall call) async {
    if (call.method == 'update') {
      _updateSession(Map<String, dynamic>.from(call.arguments as Map));
    }
  }

  void _updateSession(Map<String, dynamic> arguments) {
    final windowId = arguments['windowId'] as String;
    final itemMap = arguments['item'] as Map?;
    if (itemMap == null) {
      _sessions.remove(windowId);
    } else {
      final item = _decodeMediaItem(itemMap);
      final state = _decodePlaybackState(arguments['state'] as Map);
      final existing = _sessions[windowId];
      final takesPriority =
          existing == null || existing.item.id != item.id || (state.playing && !existing.state.playing);
      _sessions[windowId] = _WindowSession(
        order: takesPriority ? ++_order : existing.order,
        item: item,
        state: state,
      );
    }
    _applyActiveSession();
  }

  Future<void> _pruneClosedWindows() async {
    final openWindows = (await WindowController.getAll()).map((window) => window.windowId).toSet();
    final closed = _sessions.keys.where((windowId) => !openWindows.contains(windowId)).toList();
    if (closed.isEmpty) return;
    closed.forEach(_sessions.remove);
    _applyActiveSession();
  }

  void _applyActiveSession() {
    final active = maxBy(_sessions.entries, (entry) => entry.value.order);
    final hadSession = _activeWindowId != null;
    _activeWindowId = active?.key;
    if (active == null && !hadSession) return;
    _os?.show(active?.value.item, active?.value.state);
  }

  Future<void> _sendToActive(String method, [dynamic arguments]) async {
    final windowId = _activeWindowId;
    if (windowId == null) return;
    if (windowId == _windowId) {
      return _handleCommand(method, arguments);
    }
    try {
      await _windowChannel(windowId).invokeMethod(method, arguments);
    } catch (e) {
      log('Failed to send media command "$method" to window $windowId: $e');
    }
  }
}

class _WindowSession {
  const _WindowSession({required this.order, required this.item, required this.state});

  final int order;
  final MediaItem item;
  final PlaybackState state;
}

class _OsMediaSession extends BaseAudioHandler {
  _OsMediaSession(this.session) {
    if (Platform.isWindows) _initSmtc();
  }

  final MultiWindowMediaSession session;

  SMTCWindows? _smtc;
  String? _smtcItemId;

  void show(MediaItem? item, PlaybackState? state) {
    mediaItem.add(item);
    playbackState.add(state ?? PlaybackState(processingState: AudioProcessingState.completed));
    _updateSmtc(item, state);
  }

  @override
  Future<void> play() => session._sendToActive('play');

  @override
  Future<void> pause() => session._sendToActive('pause');

  @override
  Future<void> stop() => session._sendToActive('stop');

  @override
  Future<void> seek(Duration position) => session._sendToActive('seek', position.inMilliseconds);

  @override
  Future<void> setSpeed(double speed) => session._sendToActive('setSpeed', speed);

  @override
  Future<void> skipToNext() => session._sendToActive('skipToNext');

  @override
  Future<void> skipToPrevious() => session._sendToActive('skipToPrevious');

  @override
  Future<void> fastForward() => session._sendToActive('fastForward');

  @override
  Future<void> rewind() => session._sendToActive('rewind');

  void _initSmtc() {
    final smtc = SMTCWindows(
      config: const SMTCConfig(
        fastForwardEnabled: true,
        nextEnabled: false,
        pauseEnabled: true,
        playEnabled: true,
        rewindEnabled: true,
        prevEnabled: false,
        stopEnabled: true,
      ),
    );
    _smtc = smtc;
    smtc.buttonPressStream.listen((event) {
      switch (event) {
        case PressedButton.play:
          play();
        case PressedButton.pause:
          pause();
        case PressedButton.fastForward:
          fastForward();
        case PressedButton.rewind:
          rewind();
        case PressedButton.stop:
          stop();
        case PressedButton.previous:
          skipToPrevious();
        case PressedButton.next:
          skipToNext();
        case PressedButton.record:
        case PressedButton.channelUp:
        case PressedButton.channelDown:
          break;
      }
    });
  }

  void _updateSmtc(MediaItem? item, PlaybackState? state) {
    final smtc = _smtc;
    if (smtc == null) return;

    if (item == null) {
      _smtcItemId = null;
      smtc.setPlaybackStatus(PlaybackStatus.stopped);
      smtc.clearMetadata();
      smtc.disableSmtc();
      return;
    }

    if (_smtcItemId != item.id) {
      _smtcItemId = item.id;
      final durationMs = (item.duration ?? Duration.zero).inMilliseconds;
      smtc.updateMetadata(MusicMetadata(
        title: item.title,
        artist: item.extras?['subtitle'] as String? ?? item.artist,
        thumbnail: item.artUri?.toString(),
      ));
      smtc.updateTimeline(PlaybackTimeline(
        startTimeMs: 0,
        endTimeMs: durationMs,
        positionMs: state?.updatePosition.inMilliseconds ?? 0,
        minSeekTimeMs: 0,
        maxSeekTimeMs: durationMs,
      ));
      smtc.enableSmtc();
    }

    if (state != null) {
      smtc.setPosition(state.updatePosition);
      smtc.setPlaybackStatus(state.playing ? PlaybackStatus.playing : PlaybackStatus.paused);
    }
  }
}

const _audioServiceConfig = AudioServiceConfig(
  androidNotificationChannelId: 'nl.jknaapen.fladder.channel.playback',
  androidNotificationChannelName: 'Media playback',
  rewindInterval: Duration(seconds: 10),
  fastForwardInterval: Duration(seconds: 15),
);

final _controlsByAction = {
  for (final control in [
    MediaControl.play,
    MediaControl.pause,
    MediaControl.stop,
    MediaControl.skipToNext,
    MediaControl.skipToPrevious,
    MediaControl.fastForward,
    MediaControl.rewind,
  ])
    control.action: control,
};

Map<String, dynamic> _encodeMediaItem(MediaItem item) => {
      'id': item.id,
      'title': item.title,
      'album': item.album,
      'artist': item.artist,
      'genre': item.genre,
      'duration': item.duration?.inMilliseconds,
      'artUri': item.artUri?.toString(),
      'favourite': item.rating?.hasHeart(),
      'subtitle': item.extras?['subtitle'],
    };

MediaItem _decodeMediaItem(Map map) {
  final duration = map['duration'] as int?;
  final artUri = map['artUri'] as String?;
  final favourite = map['favourite'] as bool?;
  final subtitle = map['subtitle'] as String?;
  return MediaItem(
    id: map['id'] as String,
    title: map['title'] as String,
    album: map['album'] as String?,
    artist: map['artist'] as String?,
    genre: map['genre'] as String?,
    duration: duration != null ? Duration(milliseconds: duration) : null,
    artUri: artUri != null ? Uri.parse(artUri) : null,
    rating: favourite != null ? Rating.newHeartRating(favourite) : null,
    extras: subtitle != null ? {'subtitle': subtitle} : null,
  );
}

Map<String, dynamic> _encodePlaybackState(PlaybackState state) => {
      'playing': state.playing,
      'processingState': state.processingState.index,
      'controls': state.controls.map((control) => control.action.index).toList(),
      'systemActions': state.systemActions.map((action) => action.index).toList(),
      'updatePosition': state.updatePosition.inMilliseconds,
      'bufferedPosition': state.bufferedPosition.inMilliseconds,
      'speed': state.speed,
      'updateTime': state.updateTime.millisecondsSinceEpoch,
    };

PlaybackState _decodePlaybackState(Map map) => PlaybackState(
      playing: map['playing'] as bool,
      processingState: AudioProcessingState.values[map['processingState'] as int],
      controls: (map['controls'] as List)
          .map((index) => _controlsByAction[MediaAction.values[index as int]])
          .nonNulls
          .toList(),
      systemActions: (map['systemActions'] as List).map((index) => MediaAction.values[index as int]).toSet(),
      updatePosition: Duration(milliseconds: map['updatePosition'] as int),
      bufferedPosition: Duration(milliseconds: map['bufferedPosition'] as int),
      speed: (map['speed'] as num).toDouble(),
      updateTime: DateTime.fromMillisecondsSinceEpoch(map['updateTime'] as int),
    );
