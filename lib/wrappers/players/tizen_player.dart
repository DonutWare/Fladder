import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player_videohole/video_player.dart';
import 'package:subtitle/subtitle.dart';

import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/providers/settings/subtitle_settings_provider.dart';
import 'package:fladder/util/subtitle_position_calculator.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/screens/video_player/video_player.dart' as video_screen;
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class TizenPlayer extends BasePlayer {
  VideoPlayerController? _controller;
  final StreamController<PlayerState> _stateController = StreamController.broadcast();

  SubtitleController? _externalSubtitleController; 
  bool _externalSubEnabled = false;  

  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

  @override
  Future<void> init(VideoPlayerSettingsModel settings) async => await dispose();

  @override
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }

  @override
  Future<void> loadVideo(String url, bool play) async {
    await _controller?.dispose();
    _controller = null;

    final validUrl = Uri.tryParse(url)?.isAbsolute ?? false;
    _controller = validUrl
        ? VideoPlayerController.network(url)
        : VideoPlayerController.file(File(url));

    _controller!.addListener(_updateState);
    await _controller!.initialize();

    if (play) await _controller!.play();

    _updateState();
  }

  void _updateState() {
    if (_controller == null) return;

    final value = _controller!.value;

    _stateController.add(
      lastState.update(
        playing: value.isPlaying,
        completed: value.position >= value.duration.end,
        position: value.position,
        duration: value.duration.end,
        volume: (value.volume) * 100,
        rate: value.playbackSpeed,
        buffering: value.isBuffering,
        buffer: Duration(milliseconds: value.buffered),
      ),
    );
  }

  @override
  Future<void> open(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(builder: (_) => const video_screen.VideoPlayer()),
    );
  }

  @override
  Future<void> pause() async => _controller?.pause();
  @override
  Future<void> play() async => _controller?.play();
  @override
  Future<void> playOrPause() async => lastState.playing ? _controller?.pause() : _controller?.play();
  @override
  Future<void> seek(Duration position) async => _controller?.seekTo(position);
  @override
  Future<void> stop() async => _controller?.pause();
  @override
  Future<void> setVolume(double volume) async => _controller?.setVolume(volume / 100);
  @override
  Future<void> loop(bool loop) async => _controller?.setLooping(loop);

  @override
  Future<int> setAudioTrack(AudioStreamModel? model, PlaybackModel playbackModel) async {
    final wantedAudioStream = model ?? playbackModel.defaultAudioStream;
    if (wantedAudioStream == AudioStreamModel.no() || wantedAudioStream == null) {
      return -1;
    } else {
      final indexOf = playbackModel.audioStreams?.indexOf(wantedAudioStream);
      final tracks = await _controller?.audioTracks;
      if (tracks != null && tracks.isNotEmpty) {
        if (indexOf != null) {
          final track = tracks.elementAt((indexOf - 1));
          _controller?.setTrackSelection(track);
          _controller?.play(); // refresh captions
        }
        return wantedAudioStream.index;
      }
    }
    return -1;
  }

  @override
  Future<int> setSubtitleTrack(
    SubStreamModel? model,
    PlaybackModel playbackModel,
  ) async {
    final wanted = model ?? playbackModel.defaultSubStream;

    if (wanted == null || wanted == SubStreamModel.no()) {
      _externalSubEnabled = true;
      _externalSubtitleController = null;
      return -1;
    }

    if (wanted.isExternal && wanted.url != null) {
      loadExternalSubtitle(wanted.url!);
      _controller?.play(); // refresh captions
      return wanted.index;
    }
    
    // Internal subtitle
    _externalSubEnabled = false;

    final tracks = await _controller?.textTracks;
    if (tracks != null && tracks.isNotEmpty) {
      final indexOf = playbackModel.subStreams?.indexOf(wanted);
      if (indexOf != null) {
          if (indexOf - 1 >= 0) {
            final track = tracks.elementAt(indexOf - 1);
            _controller?.setTrackSelection(track);
            _controller?.play(); // refresh captions 
          } else {
          //No subtitles
          _externalSubEnabled = true;
          _externalSubtitleController = null;
          _controller!.play();
          
        }
      }
    }
    return wanted.index;
  }


  Future<void> loadExternalSubtitle(
    String data,
  ) async {
    _externalSubEnabled = true;
    _controller!.play();
    final provider = SubtitleProvider.fromNetwork(
      Uri.tryParse(data) ?? Uri.parse('')
    );

    final controller = SubtitleController(provider: provider);
    controller.initial();
    _externalSubtitleController = controller;
  }

  @override
  Future<void> setSpeed(double speed) async => _controller?.setPlaybackSpeed(speed);

  @override
  Future<Uint8List?> takeScreenshot() async => null;


  @override
  Widget? videoWidget(
    Key key,
    BoxFit fit,
  ) =>
      _controller == null
          ? null
          : Container(
              key: key,
              color: Colors.transparent,
              child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                      fit: fit,
                      alignment: Alignment.center,
                      child: ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: _controller!,
                        builder: (context, value, child) {
                          final aspectRatio = value.isInitialized ? value.aspectRatio : 1.77;
                          final scale = View.of(context).devicePixelRatio / MediaQuery.devicePixelRatioOf(context);
                          return SizedBox(
                            width: constraints.maxWidth * scale,
                            child: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: VideoPlayer(_controller!),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );

  @override
  Widget? subtitles(bool showOverlay, {GlobalKey? controlsKey}) {
    if (_controller == null) return null;

    return _TizenSubtitles(
      controller: _controller!,
      showOverlay: showOverlay,
      controlsKey: controlsKey,
      externalSubtitleController: _externalSubtitleController,
      useExternal: _externalSubEnabled,
    );
  }
}

class _TizenSubtitles extends ConsumerStatefulWidget {
  final VideoPlayerController controller;
  final bool showOverlay;
  final GlobalKey? controlsKey;

  final SubtitleController? externalSubtitleController;
  final bool useExternal;

  const _TizenSubtitles({
    required this.controller,
    this.showOverlay = false,
    this.controlsKey,
    this.externalSubtitleController,
    required this.useExternal,
  });

  @override
  _TizenSubtitlesState createState() => _TizenSubtitlesState();
}

class _TizenSubtitlesState extends ConsumerState<_TizenSubtitles> {
  String _cachedSubtitleText = '';
  String? _lastCaption;
  double? _cachedMenuHeight;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    if (!mounted) return;
    if (widget.controller.value.isInitialized == false) return;
    
    final position = widget.controller.value.position;

    String subtitle = '';

    if (widget.useExternal && widget.externalSubtitleController != null && widget.externalSubtitleController!.initialized) {
      subtitle = widget.externalSubtitleController?.durationSearch(position)?.data.trim() ?? '';
    } else if (!widget.useExternal) {
      subtitle = widget.controller.value.caption.text.trim();
    }

    subtitle = _sanitizeSubtitle(subtitle);

    if (subtitle != _lastCaption) {
      setState(() {
        _lastCaption = subtitle;
        _cachedSubtitleText = subtitle;
      });
    }
  }

  String _sanitizeSubtitle(String subtitle) {
    if (subtitle.isEmpty) return subtitle;

    final fontTagRegex = RegExp(r'</?font[^>]*>', caseSensitive: false);
    final sanitized = subtitle.replaceAll(fontTagRegex, '');

    return sanitized.trim();
  }

  @override
  Widget build(BuildContext context) {
    _measureMenuHeight();

    final settings = ref.watch(subtitleSettingsProvider);
    final padding = MediaQuery.paddingOf(context);

    final text = _cachedSubtitleText;

    if (text.isEmpty) return const SizedBox.shrink();

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
