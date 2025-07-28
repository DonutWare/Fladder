import 'dart:async';
import 'dart:math' as math;

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
import 'package:fladder/wrappers/players/base_player.dart';
import 'package:fladder/wrappers/players/player_states.dart';

class LibMPV extends BasePlayer {
  mpv.Player? _player;
  VideoController? _controller;

  final StreamController<PlayerState> _stateController = StreamController.broadcast();
  @override
  Stream<PlayerState> get stateStream => _stateController.stream;

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
  Future<void> open(String url, bool play) async {
    await _player?.open(mpv.Media(url), play: play);
    return setState(lastState.update(buffering: true));
  }

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
    double? menuHeight,
  }) =>
      _controller != null
          ? _VideoSubtitles(
              controller: _controller!,
              showOverlay: showOverlay,
              menuHeight: menuHeight,
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
  final double? menuHeight;

  const _VideoSubtitles({
    required this.controller,
    this.showOverlay = false,
    this.menuHeight,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoSubtitlesState();
}

class _VideoSubtitlesState extends ConsumerState<_VideoSubtitles> {
  // Keep fallback constants for when dynamic height isn't available
  static const double _fallbackMenuHeightPercentage = 0.15; // 15% fallback
  static const double _subtitlePadding = 0.005; // 0.5% padding above menu
  static const double _maxSubtitleOffset = 0.85; // Max 85% up from bottom

  late List<String> subtitle = widget.controller.player.state.subtitle;
  StreamSubscription<List<String>>? subscription;

  @override
  void initState() {
    super.initState(); // Move to very start as per best practices
    subscription = widget.controller.player.stream.subtitle.listen((value) {
      if (mounted) {
        setState(() {
          subtitle = value;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  /// Calculate subtitle offset using actual menu height when available
  double _calculateSubtitleOffset(SubtitleSettingsModel settings) {
    if (!widget.showOverlay) {
      return settings.verticalOffset;
    }

    final screenHeight = MediaQuery.of(context).size.height;
    double menuHeightPercentage;

    if (widget.menuHeight != null && screenHeight > 0) {
      // Convert menu height to percentage (without extra padding here)
      menuHeightPercentage = widget.menuHeight! / screenHeight;
    } else {
      // Fallback to static percentage
      menuHeightPercentage = _fallbackMenuHeightPercentage;
    }

    // Calculate the minimum safe position (menu height + small padding)
    final minSafeOffset = menuHeightPercentage + _subtitlePadding;

    // If subtitles are already positioned above the safe area, leave them alone
    if (settings.verticalOffset >= minSafeOffset) {
      return settings.verticalOffset;
    }

    // Instead of replacing user offset, use the minimum safe position
    // This ensures subtitles are just above the menu, not way up high
    return math.max(minSafeOffset, math.min(settings.verticalOffset, _maxSubtitleOffset));
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(subtitleSettingsProvider);
    final padding = MediaQuery.of(context).padding;

    // Process subtitle text
    final text = subtitle.where((line) => line.trim().isNotEmpty).map((line) => line.trim()).join('\n');

    // Early return for cases where subtitles shouldn't be rendered
    if ((widget.controller.player.platform?.configuration.libass ?? false) || text.isEmpty) {
      return const SizedBox.shrink();
    }

    return SubtitleText(
      subModel: settings,
      padding: padding,
      offset: _calculateSubtitleOffset(settings),
      text: text,
    );
  }
}
