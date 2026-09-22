import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/pip_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/wrappers/pip_manager.dart';

class PipLifecycleController extends ConsumerStatefulWidget {
  const PipLifecycleController({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<PipLifecycleController> createState() => _PipLifecycleControllerState();
}

class _PipLifecycleControllerState extends ConsumerState<PipLifecycleController> {
  @override
  void initState() {
    super.initState();
    if (pipPlatformSupported) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _applyCurrent());
    }
  }

  void _applyCurrent() {
    if (!mounted) return;
    final state = ref.read(mediaPlaybackProvider).state;
    final autoEnter = ref.read(videoPlayerSettingsProvider).enablePictureInPicture;
    final isAudioPlayback = ref.read(playBackModel)?.isAudioPlayback ?? false;
    _apply(state, autoEnter, isAudioPlayback: isAudioPlayback);
  }

  void _apply(
    VideoPlayerState state,
    bool autoEnter, {
    required bool isAudioPlayback,
  }) {
    final manager = ref.read(pipManagerProvider);
    final autoEnterAllowed = autoEnter && !isAudioPlayback;
    if (state == VideoPlayerState.fullScreen || state == VideoPlayerState.minimized) {
      manager.enable(aspectWidth: 16.0, aspectHeight: 9.0, autoEnter: autoEnterAllowed);
    } else {
      manager.disable();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!pipPlatformSupported) {
      return widget.child;
    }
    ref.listen<VideoPlayerState>(
      mediaPlaybackProvider.select((v) => v.state),
      (previous, next) {
        if (previous == next) return;
        final autoEnter = ref.read(videoPlayerSettingsProvider).enablePictureInPicture;
        final isAudioPlayback = ref.read(playBackModel)?.isAudioPlayback ?? false;
        _apply(next, autoEnter, isAudioPlayback: isAudioPlayback);
      },
    );
    ref.listen<bool>(
      videoPlayerSettingsProvider.select((v) => v.enablePictureInPicture),
      (previous, next) {
        if (previous == next) return;
        final state = ref.read(mediaPlaybackProvider).state;
        final isAudioPlayback = ref.read(playBackModel)?.isAudioPlayback ?? false;
        _apply(state, next, isAudioPlayback: isAudioPlayback);
      },
    );
    ref.listen<bool>(
      playBackModel.select((value) => value?.isAudioPlayback ?? false),
      (previous, next) {
        if (previous == next) return;
        final state = ref.read(mediaPlaybackProvider).state;
        final autoEnter = ref.read(videoPlayerSettingsProvider).enablePictureInPicture;
        _apply(state, autoEnter, isAudioPlayback: next);
      },
    );

    final inPip = ref.watch(pipStateProvider).asData?.value ?? false;
    final state = ref.watch(mediaPlaybackProvider.select((v) => v.state));
    if (inPip && state == VideoPlayerState.minimized) {
      final player = ref.watch(videoPlayerProvider);
      final video = player.videoWidget(const ValueKey('pip_minimized_video'), BoxFit.contain);
      final subtitle = player.subtitleWidget(false);
      return ColoredBox(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (video != null) video,
            if (subtitle != null) subtitle,
          ],
        ),
      );
    }
    return widget.child;
  }
}
