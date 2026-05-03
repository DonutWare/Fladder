import 'dart:async';
import 'dart:developer';
import 'dart:math' show Random;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart' as mpv;
import 'package:media_kit_video/media_kit_video.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/subtitle_settings_provider.dart';
import 'package:fladder/screens/video_player/video_player.dart' as video_screen;
import 'package:fladder/util/subtitle_position_calculator.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class LibMPV extends BasePlayer {
  LibMPV({this.onCurrentIndexChanged});

  bool get isAudioQueueActive => _queue.isNotEmpty;

  mpv.Player? _player;
  VideoController? _controller;
  String _currentSubtitleCodec = '';

  final StreamController<PlayerState> _stateController = StreamController.broadcast();
  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

  StreamSubscription<bool>? _onCompleted;
  StreamSubscription<bool>? _audioQueueOnCompleted;

  final Random _random = Random();
  List<ItemBaseModel> _queue = <ItemBaseModel>[];
  List<Uri> _queueUris = <Uri>[];
  List<int> _playOrder = <int>[];
  int _orderCursor = -1;
  bool _shuffleEnabled = false;
  AudioRepeatMode _repeatMode = AudioRepeatMode.off;
  bool _manualTrackTransition = false;
  bool _replayGainFallbackLogged = false;
  VideoPlayerSettingsModel _settings = VideoPlayerSettingsModel();
  void Function(int index, ItemBaseModel item)? onCurrentIndexChanged;

  RestartableTimer? _retryTimer;
  DateTime _firstLoadAttempt = DateTime.now();
  final Duration _maxRetryDuration = const Duration(minutes: 1);
  final Duration _currentRetryDuration = const Duration(seconds: 5);
  Completer<void>? _loadCompleter;

  int get _currentQueueIndex {
    if (_playOrder.isEmpty || _orderCursor < 0 || _orderCursor >= _playOrder.length) {
      return -1;
    }
    return _playOrder[_orderCursor];
  }

  @override
  Future<void> init(VideoPlayerSettingsModel settings) async {
    _settings = settings;
    dispose();

    mpv.MediaKit.ensureInitialized();

    _player = mpv.Player(
      configuration: mpv.PlayerConfiguration(
        title: "nl.jknaapen.fladder",
        libassAndroidFont: libassFallbackFont,
        libass: !kIsWeb && settings.useLibass,
        bufferSize: settings.bufferSize * 1024 * 1024, // MPV uses buffer size in bytes
      ),
    );

    if (_player != null) {
      _controller = VideoController(
        _player!,
        configuration: VideoControllerConfiguration(
          enableHardwareAcceleration: settings.hardwareAccel,
        ),
      );

      _player!.stream.playing.listen((value) => setState(lastState.update(playing: value)));
      _player!.stream.buffering.listen((value) => setState(lastState.update(buffering: value)));
      _player!.stream.position.listen((value) => setState(lastState.update(position: value)));
      _player!.stream.duration.listen((value) => setState(lastState.update(duration: value)));
      _player!.stream.volume.listen((value) => setState(lastState.update(volume: value)));
      _player!.stream.rate.listen((value) => setState(lastState.update(rate: value)));
      _player!.stream.buffer.listen((value) => setState(lastState.update(buffer: value)));
      _audioQueueOnCompleted = _player!.stream.completed.listen(_onAudioQueueCompleted);
    }

    if (_player?.platform is mpv.NativePlayer) {
      final nativePlayer = _player!.platform as dynamic;
      await nativePlayer.setProperty('force-seekable', 'yes');

      if (defaultTargetPlatform == TargetPlatform.android) {
        // Use audiotrack as it is generally more stable on modern Android
        await nativePlayer.setProperty('ao', 'audiotrack');
      }
    }

    await _applyReplayGainSettings();
  }

  @override
  Future<void> dispose() async {
    _onCompleted?.cancel();
    _onCompleted = null;
    _audioQueueOnCompleted?.cancel();
    _audioQueueOnCompleted = null;
    _player?.stop();
    _player?.dispose();
    _player = null;
    _retryTimer?.cancel();
    _retryTimer = null;
    _queue = <ItemBaseModel>[];
    _queueUris = <Uri>[];
    _playOrder = <int>[];
    _orderCursor = -1;
    _shuffleEnabled = false;
    _repeatMode = AudioRepeatMode.off;
    _manualTrackTransition = false;
  }

  void setState(PlayerState state) {
    lastState = state;
    _stateController.add(state);
  }

  @override
  Future<void> loadVideo(String url, bool play, {Duration startPosition = Duration.zero}) async {
    _loadCompleter = Completer<void>();
    _firstLoadAttempt = DateTime.now();

    await setStartPosition(startPosition);

    await _player?.open(mpv.Media(url), play: play);

    _retryTimer?.cancel();
    _retryTimer = null;

    _retryTimer = RestartableTimer(
      _currentRetryDuration,
      () async {
        await Future.delayed(const Duration(milliseconds: 150));
        if (DateTime.now().isAfter(_firstLoadAttempt.add(_maxRetryDuration))) {
          log("Max retry duration reached, stopping retries.");
          _retryTimer?.cancel();
          _retryTimer = null;
        } else {
          log("Retrying to load video $url");
          await setStartPosition(startPosition);
          await _player?.open(mpv.Media(url), play: play);
          _retryTimer?.reset();
        }
      },
    );

    // Wait for the player to be ready
    if (_loadCompleter?.isCompleted == false) {
      StreamSubscription? subBuffering;
      StreamSubscription? subDuration;

      void onReady() {
        if (_loadCompleter?.isCompleted == true) return;
        _finishedLoading();
        subBuffering?.cancel();
        subDuration?.cancel();
      }

      subBuffering = _player?.stream.buffering.listen((event) {
        if (event == false && (_player?.state.duration ?? Duration.zero) > Duration.zero) {
          onReady();
        }
      });
      subDuration = _player?.stream.duration.listen((event) {
        if (event > Duration.zero) onReady();
      });
    }

    _loadCompleter?.future.then(
      (value) async {
        // Backup seek in case property didn't work
        if (startPosition != Duration.zero && (_player?.state.position.inSeconds ?? 0) < startPosition.inSeconds - 5) {
          await _player?.seek(startPosition);
        }
      },
    );
    return setState(lastState.update(buffering: true));
  }

  @override
  Future<void> loadAudioQueue(
    List<ItemBaseModel> queue,
    int initialIndex,
    Duration startPosition,
    Uri Function(ItemBaseModel item) urlBuilder,
  ) async {
    _queue = List<ItemBaseModel>.from(queue);
    _queueUris = _queue.map(urlBuilder).toList(growable: false);

    if (_queue.isEmpty) {
      await stop();
      return;
    }

    final selectedIndex = initialIndex.clamp(0, _queue.length - 1);
    _rebuildPlayOrder(aroundIndex: selectedIndex);
    await _openCurrentQueueTrack(startPosition: startPosition, play: false, notifyIndex: true);
  }

  void _rebuildPlayOrder({required int aroundIndex}) {
    final clampedIndex = aroundIndex.clamp(0, _queue.length - 1);
    if (!_shuffleEnabled) {
      _playOrder = List<int>.generate(_queue.length, (index) => index);
      _orderCursor = clampedIndex;
      return;
    }

    final others = List<int>.generate(_queue.length, (index) => index)..remove(clampedIndex);
    others.shuffle(_random);
    _playOrder = <int>[clampedIndex, ...others];
    _orderCursor = 0;
  }

  Future<void> _openCurrentQueueTrack({
    Duration startPosition = Duration.zero,
    required bool play,
    required bool notifyIndex,
  }) async {
    final index = _currentQueueIndex;
    if (index < 0 || index >= _queueUris.length) return;

    final trackGainDb = _trackNormalizationGainDb(index);
    _manualTrackTransition = true;
    try {
      await _applyReplayGainSettings(trackGainDb: trackGainDb);
      await loadVideo(_queueUris[index].toString(), play, startPosition: startPosition);
      if (notifyIndex) {
        onCurrentIndexChanged?.call(index, _queue[index]);
      }
      setState(lastState.update(completed: false));
    } finally {
      _manualTrackTransition = false;
    }
  }

  double? _trackNormalizationGainDb(int queueIndex) {
    if (queueIndex < 0 || queueIndex >= _queue.length) {
      return null;
    }

    final item = _queue[queueIndex];
    if (item is! AudioModel) {
      return null;
    }

    final gain = item.normalizationGain;
    if (gain == null || gain.isNaN || gain.isInfinite) {
      return null;
    }

    return gain.clamp(-60.0, 20.0).toDouble();
  }

  Future<void> _onAudioQueueCompleted(bool completed) async {
    if (!completed || _manualTrackTransition || _queue.isEmpty) {
      return;
    }

    if (_repeatMode == AudioRepeatMode.one) {
      await _openCurrentQueueTrack(play: true, notifyIndex: false);
      return;
    }

    if (_advanceQueueCursor()) {
      await _openCurrentQueueTrack(play: true, notifyIndex: true);
    }
  }

  bool _advanceQueueCursor() {
    if (_playOrder.isEmpty) return false;

    if (_orderCursor + 1 < _playOrder.length) {
      _orderCursor += 1;
      return true;
    }

    if (_repeatMode == AudioRepeatMode.all) {
      _orderCursor = 0;
      return true;
    }

    return false;
  }

  bool _retreatQueueCursor() {
    if (_playOrder.isEmpty) return false;

    if (_orderCursor > 0) {
      _orderCursor -= 1;
      return true;
    }

    if (_repeatMode == AudioRepeatMode.all) {
      _orderCursor = _playOrder.length - 1;
      return true;
    }

    return false;
  }

  double get _replayGainVolumeOffsetDb {
    return _settings.replayGainVolumeLevel.replayGainOffsetDb;
  }

  Future<void> _applyReplayGainSettings({double? trackGainDb}) async {
    if (_player?.platform is! mpv.NativePlayer) {
      return;
    }

    final nativePlayer = _player!.platform as dynamic;

    if (!_settings.enableReplayGain) {
      try {
        await nativePlayer.setProperty('af', '');
      } catch (_) {
        // Best effort clear.
      }
      return;
    }

    final replayGainMode = switch (_settings.replayGainMode) {
      ReplayGainMode.automatic => 'track',
      ReplayGainMode.track => 'track',
      ReplayGainMode.album => 'album',
    };
    final replayGainOffsetDb = clampReplayGainDb(_replayGainVolumeOffsetDb);
    final replayGainFallbackDb = _settings.replayGainVolumeLevel.adjustedReplayGainDb(trackGainDb);

    try {
      await nativePlayer.setProperty('replaygain', replayGainMode);
      await nativePlayer.setProperty('replaygain-clip', 'yes');
      await nativePlayer.setProperty('replaygain-fallback', '$replayGainFallbackDb');
      await nativePlayer.setProperty('replaygain-preamp', '$replayGainOffsetDb');
      await nativePlayer.setProperty('af', '');
      _replayGainFallbackLogged = false;
    } catch (error, stackTrace) {
      if (!_replayGainFallbackLogged) {
        log('ReplayGain unsupported by current mpv backend, falling back to loudnorm. $error\n$stackTrace');
      }
      _replayGainFallbackLogged = true;

      try {
        final gainFilter = ',volume=${replayGainFallbackDb}dB';
        await nativePlayer.setProperty('af', 'format=stereo,loudnorm$gainFilter');
      } catch (fallbackError, fallbackStackTrace) {
        log('Unable to set loudnorm fallback filter. $fallbackError\n$fallbackStackTrace');
      }
    }
  }

  Future<void> setStartPosition(Duration position) async {
    if (_player?.platform is mpv.NativePlayer) {
      await (_player?.platform as dynamic).setProperty(
        'start',
        '${position.inMilliseconds / 1000}',
      );
    }
  }

  void _finishedLoading() {
    _loadCompleter?.complete();
    _retryTimer?.cancel();
    _retryTimer = null;
  }

  @override
  Future<void> open(BuildContext context) async => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => const video_screen.VideoPlayer(),
        ),
      );

  List<mpv.SubtitleTrack> get subTracks => _player?.state.tracks.subtitle ?? [];
  mpv.SubtitleTrack get subtitleTrack => _player?.state.track.subtitle ?? mpv.SubtitleTrack.no();

  List<mpv.AudioTrack> get audioTracks => _player?.state.tracks.audio ?? [];
  mpv.AudioTrack get audioTrack => _player?.state.track.audio ?? mpv.AudioTrack.no();

  @override
  Future<void> pause() async => _player?.pause();

  @override
  Future<void> play() async => _player?.play();

  @override
  Future<void> playOrPause() async => _player?.playOrPause();

  @override
  Future<void> seek(Duration position) async => _player?.seek(position);

  @override
  Future<void> setShuffleModeEnabled(bool enabled) async {
    if (_shuffleEnabled == enabled || _queue.isEmpty) {
      _shuffleEnabled = enabled;
      return;
    }

    final currentIndex = _currentQueueIndex.clamp(0, _queue.length - 1);
    _shuffleEnabled = enabled;
    _rebuildPlayOrder(aroundIndex: currentIndex);
  }

  @override
  Future<void> setAudioRepeatMode(AudioRepeatMode mode) async {
    _repeatMode = mode;
  }

  List<ItemBaseModel> queueForDisplay({required bool wrapAround}) {
    if (_queue.isEmpty) {
      return const <ItemBaseModel>[];
    }

    if (_shuffleEnabled && _playOrder.isNotEmpty) {
      final cursor = _orderCursor.clamp(0, _playOrder.length - 1);
      final orderedIndices = <int>[
        ..._playOrder.sublist(cursor),
        if (wrapAround) ..._playOrder.sublist(0, cursor),
      ];

      return orderedIndices
          .where((index) => index >= 0 && index < _queue.length)
          .map((index) => _queue[index])
          .toList(growable: false);
    }

    final currentIndex = _currentQueueIndex;
    if (currentIndex < 0 || currentIndex >= _queue.length) {
      return List<ItemBaseModel>.from(_queue);
    }

    return <ItemBaseModel>[
      ..._queue.sublist(currentIndex),
      if (wrapAround) ..._queue.sublist(0, currentIndex),
    ];
  }

  @override
  Future<void> reorderAudioQueue(List<ItemBaseModel> queue) async {
    if (queue.isEmpty || _queue.isEmpty) return;

    final oldQueue = List<ItemBaseModel>.from(_queue);
    final oldQueueUris = List<Uri>.from(_queueUris);
    final currentIndex = _currentQueueIndex;
    if (currentIndex < 0 || currentIndex >= oldQueue.length) {
      return;
    }

    final currentItemId = oldQueue[currentIndex].id;

    _queue = List<ItemBaseModel>.from(queue);
    _queueUris = _queue
        .map((item) {
          final oldIndex = oldQueue.indexWhere((oldItem) => oldItem.id == item.id);
          if (oldIndex < 0 || oldIndex >= oldQueueUris.length) {
            return null;
          }
          return oldQueueUris[oldIndex];
        })
        .whereType<Uri>()
        .toList(growable: false);

    final newCurrentIndex = _queue.indexWhere((item) => item.id == currentItemId);
    if (newCurrentIndex < 0 || _queueUris.length != _queue.length) {
      _queue = oldQueue;
      _queueUris = oldQueueUris;
      return;
    }

    if (!_shuffleEnabled) {
      _playOrder = List<int>.generate(_queue.length, (index) => index);
      _orderCursor = newCurrentIndex;
      return;
    }

    final newIndexById = {
      for (var i = 0; i < _queue.length; i++) _queue[i].id: i,
    };

    final reordered = <int>[newCurrentIndex];
    for (final oldIndex in _playOrder) {
      if (oldIndex < 0 || oldIndex >= oldQueue.length) continue;
      final id = oldQueue[oldIndex].id;
      final mapped = newIndexById[id];
      if (mapped != null && mapped != newCurrentIndex && !reordered.contains(mapped)) {
        reordered.add(mapped);
      }
    }

    for (var i = 0; i < _queue.length; i++) {
      if (!reordered.contains(i)) {
        reordered.add(i);
      }
    }

    _playOrder = reordered;
    _orderCursor = 0;
  }

  @override
  Future<void> skipToNext() async {
    if (_queue.isEmpty) return;
    if (!_advanceQueueCursor()) return;
    await _openCurrentQueueTrack(play: true, notifyIndex: true);
  }

  @override
  Future<void> skipToPrevious() async {
    if (_queue.isEmpty) return;

    if (lastState.position >= const Duration(seconds: 3)) {
      await seek(Duration.zero);
      return;
    }

    if (!_retreatQueueCursor()) {
      await seek(Duration.zero);
      return;
    }

    await _openCurrentQueueTrack(play: true, notifyIndex: true);
  }

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async {
    final wantedAudioStream = model ?? playbackModel.defaultAudioStream;
    if (wantedAudioStream == null) return -1;
    if (wantedAudioStream.index == AudioStreamModel.no().index) {
      await _player?.setAudioTrack(mpv.AudioTrack.no());
    } else {
      final internalTracks = audioTracks.getRange(2, audioTracks.length).toList();
      final audioTrack =
          internalTracks.elementAtOrNull((playbackModel.audioStreams?.indexOf(wantedAudioStream) ?? -1) - 1);
      if (audioTrack != null) {
        await _player?.setAudioTrack(audioTrack);
      }
    }
    return wantedAudioStream.index;
  }

  @override
  Future<void> setSpeed(double speed) async => _player?.setRate(speed);

  @override
  Future<int> setSubtitleTrack(SubStreamModel? model, PlaybackModel playbackModel) async {
    if (_player == null) return -1;
    final wantedSubtitle = model ?? playbackModel.defaultSubStream;
    if (wantedSubtitle == null || wantedSubtitle.index == SubStreamModel.no().index) {
      await _player?.setSubtitleTrack(mpv.SubtitleTrack.no());
      return -1;
    }
    _currentSubtitleCodec = wantedSubtitle.codec;
    final internalTrack = subTracks.getRange(2, subTracks.length).toList();
    final index = playbackModel.subStreams?.sublist(1).indexWhere((element) => element.id == wantedSubtitle.id);
    final subTrack = internalTrack.elementAtOrNull(index ?? -1);
    if (wantedSubtitle.isExternal && wantedSubtitle.url != null && subTrack == null) {
      await _player?.setSubtitleTrack(mpv.SubtitleTrack.uri(wantedSubtitle.url!));
    } else if (subTrack != null) {
      await _player?.setSubtitleTrack(subTrack);
    }
    return wantedSubtitle.index;
  }

  @override
  Future<void> stop() async => _player?.stop();

  @override
  Future<Uint8List?> takeScreenshot() async {
    return _player?.screenshot(format: "image/png", includeLibassSubtitles: true);
  }

  @override
  Widget? videoWidget(
    Key key,
    BoxFit fit,
  ) =>
      _controller == null
          ? null
          : Video(
              key: key,
              controller: _controller!,
              wakelock: false,
              fill: Colors.transparent,
              fit: fit,
              subtitleViewConfiguration: const SubtitleViewConfiguration(visible: false),
              controls: NoVideoControls,
            );

  @override
  Widget? subtitles(
    bool showOverlay, {
    GlobalKey? controlsKey,
  }) =>
      _controller != null
          ? _VideoSubtitles(
              controller: _controller!,
              showOverlay: showOverlay,
              controlsKey: controlsKey,
              currentSubtitleCodec: _currentSubtitleCodec,
            )
          : null;

  @override
  Future<void> setVolume(double volume) async => _player?.setVolume(volume);

  @override
  Future<void> loop(bool loop) async {
    if (loop && _onCompleted == null) {
      _onCompleted = _player?.stream.completed.listen((completed) {
        if (completed) {
          _player?.play();
        }
      });
    } else {
      _onCompleted?.cancel();
    }
  }
}

class _VideoSubtitles extends ConsumerStatefulWidget {
  final VideoController controller;
  final bool showOverlay;
  final GlobalKey? controlsKey;
  final String currentSubtitleCodec;

  const _VideoSubtitles({
    required this.controller,
    this.showOverlay = false,
    this.controlsKey,
    this.currentSubtitleCodec = '',
  });

  @override
  _VideoSubtitlesState createState() => _VideoSubtitlesState();
}

class _VideoSubtitlesState extends ConsumerState<_VideoSubtitles> {
  late List<String> subtitle;
  String _cachedSubtitleText = '';
  List<String>? _lastSubtitleList;
  StreamSubscription<List<String>>? subscription;

  double? _cachedMenuHeight;

  @override
  void initState() {
    super.initState();
    subtitle = widget.controller.player.state.subtitle;
    subscription = widget.controller.player.stream.subtitle.listen((value) {
      if (mounted) {
        setState(() {
          subtitle = value;
          _lastSubtitleList = null;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _measureMenuHeight();

    final settings = ref.watch(subtitleSettingsProvider);
    final padding = MediaQuery.paddingOf(context);

    if (!const ListEquality().equals(subtitle, _lastSubtitleList)) {
      _lastSubtitleList = List<String>.from(subtitle);
      _cachedSubtitleText = subtitle.where((line) => line.trim().isNotEmpty).map((line) => line.trim()).join('\n');
    }

    final text = _cachedSubtitleText;

    final bool isLibassEnabled = widget.controller.player.platform?.configuration.libass ?? false;

    if (isLibassEnabled) {
      // On desktop (Linux/Windows/macOS), mpv burns ALL subtitle formats into the video when libass is enabled.
      // On mobile (Android/iOS), only ASS/SSA subs are burned in by libass; other formats need the Flutter overlay.
      final bool isDesktop = defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.macOS;
      if (isDesktop) {
        return const SizedBox.shrink();
      }
      final currentSubCodec = widget.currentSubtitleCodec.toLowerCase();
      final bool isAssSubtitle = currentSubCodec.contains('ass') || currentSubCodec.contains('ssa');
      if (isAssSubtitle || text.isEmpty) {
        return const SizedBox.shrink();
      }
    } else if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    final offset = SubtitlePositionCalculator.calculateOffset(
      settings: settings,
      showOverlay: widget.showOverlay,
      screenHeight: MediaQuery.sizeOf(context).height,
      menuHeight: _cachedMenuHeight,
    );

    return SubtitleText(
      subModel: settings,
      padding: padding,
      offset: offset,
      text: text,
    );
  }

  void _measureMenuHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || widget.controlsKey == null) return;

      final RenderBox? renderBox = widget.controlsKey?.currentContext?.findRenderObject() as RenderBox?;
      final newHeight = renderBox?.size.height;

      if (newHeight != _cachedMenuHeight && newHeight != null) {
        setState(() {
          _cachedMenuHeight = newHeight;
        });
      }
    });
  }
}
