import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/pip_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';

class PipLifecycleController extends ConsumerStatefulWidget {
  const PipLifecycleController({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<PipLifecycleController> createState() => _PipLifecycleControllerState();
}

class _PipLifecycleControllerState extends ConsumerState<PipLifecycleController> {
  bool get _platformSupported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();
    if (_platformSupported) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _applyCurrent());
    }
  }

  void _applyCurrent() {
    if (!mounted) return;
    final state = ref.read(mediaPlaybackProvider).state;
    final autoEnter = ref.read(videoPlayerSettingsProvider).enablePictureInPicture;
    _apply(state, autoEnter);
  }

  void _apply(VideoPlayerState state, bool autoEnter) {
    final manager = ref.read(pipManagerProvider);
    if (state == VideoPlayerState.fullScreen || state == VideoPlayerState.minimized) {
      manager.enable(aspectWidth: 16.0, aspectHeight: 9.0, autoEnter: autoEnter);
    } else {
      manager.disable();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_platformSupported) {
      return widget.child;
    }
    ref.listen<VideoPlayerState>(
      mediaPlaybackProvider.select((v) => v.state),
      (previous, next) {
        if (previous == next) return;
        final autoEnter = ref.read(videoPlayerSettingsProvider).enablePictureInPicture;
        _apply(next, autoEnter);
      },
    );
    ref.listen<bool>(
      videoPlayerSettingsProvider.select((v) => v.enablePictureInPicture),
      (previous, next) {
        if (previous == next) return;
        final state = ref.read(mediaPlaybackProvider).state;
        _apply(state, next);
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
