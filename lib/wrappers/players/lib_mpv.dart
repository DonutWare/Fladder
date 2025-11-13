import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart' as mpv;
import 'package:media_kit_video/media_kit_video.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/subtitle_settings_provider.dart';
import 'package:fladder/screens/video_player/video_player.dart' as video_screen;
import 'package:fladder/util/subtitle_position_calculator.dart';
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class LibMPV extends BasePlayer {
  mpv.Player? _player;
  VideoController? _controller;
  double _currentSubtitleOffset = 0.0;

  final StreamController<PlayerState> _stateController = StreamController.broadcast();
  
  @override
  Stream<PlayerState> get stateStream => _stateController.stream;
  
  @override
  bool get supportsSubtitleOffset => true;

  StreamSubscription<bool>? _onCompleted;

  @override
  Future<void> init(VideoPlayerSettingsModel settings) async {
    dispose();

    mpv.MediaKit.ensureInitialized();

    _player = mpv.Player(
      configuration: mpv.PlayerConfiguration(
        title: "nl.jknaapen.fladder",
        libassAndroidFont: libassFallbackFont,
        libass: !kIsWeb && settings.useLibass,
        bufferSize: settings.bufferSize * 1024 * 1024,
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
    }

    if (_player?.platform is mpv.NativePlayer) {
      await (_player?.platform as dynamic).setProperty(
        'force-seekable',
        'yes',
      );
    }
  }

  @override
  Future<void> dispose() async {
    _onCompleted?.cancel();
    _onCompleted = null;
    _player?.stop();
    _player?.dispose();
    _player = null;
  }

  void setState(PlayerState state) {
    lastState = state;
    _stateController.add(state);
  }

  @override
  Future<void> loadVideo(String url, bool play) async {
    await _player?.open(mpv.Media(url), play: play);
    return setState(lastState.update(buffering: true));
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
    if (wantedSubtitle == null) return -1;
    if (wantedSubtitle.index == SubStreamModel.no().index) {
      await _player?.setSubtitleTrack(mpv.SubtitleTrack.no());
    } else {
      final internalTrack = subTracks.getRange(2, subTracks.length).toList();
      final index = playbackModel.subStreams?.sublist(1).indexWhere((element) => element.id == wantedSubtitle.id);
      final subTrack = internalTrack.elementAtOrNull(index ?? -1);
      if (wantedSubtitle.isExternal && wantedSubtitle.url != null && subTrack == null) {
        await _player?.setSubtitleTrack(mpv.SubtitleTrack.uri(wantedSubtitle.url!));
      } else if (subTrack != null) {
        await _player?.setSubtitleTrack(subTrack);
      }
    }
    return wantedSubtitle.index;
  }

  @override
  Future<void> stop() async => _player?.stop();

  @override
  Future<void> adjustSubtitleOffset(double offsetSeconds) async {
    if (_player?.platform is mpv.NativePlayer) {
      try {
        _currentSubtitleOffset = offsetSeconds;
        print('Setting subtitle delay to: $offsetSeconds seconds');
        
        await (_player?.platform as dynamic).command(['set', 'sub-delay', offsetSeconds.toString()]);
        print('Successfully set subtitle delay via command');
      } catch (e) {
        print('Error with command approach: $e');
        try {
          await (_player?.platform as dynamic).setProperty('sub-delay', offsetSeconds);
          print('Successfully set subtitle delay via property');
        } catch (e2) {
          print('Error setting subtitle offset via property: $e2');
        }
      }
    } else {
      print('Player platform is not MPV native player');
    }
  }

  @override
  Future<double> getSubtitleOffset() async {
    if (_player?.platform is mpv.NativePlayer) {
      return _currentSubtitleOffset;
    }
    return 0.0;
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

  const _VideoSubtitles({
    required this.controller,
    this.showOverlay = false,
    this.controlsKey,
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

    if (isLibassEnabled || text.isEmpty) {
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
