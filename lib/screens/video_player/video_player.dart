import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/video_player/video_player_controls.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/themes_data.dart';

class VideoPlayer extends ConsumerStatefulWidget {
  const VideoPlayer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends ConsumerState<VideoPlayer> with WidgetsBindingObserver {
  double lastScale = 0.0;

  bool errorPlaying = false;
  bool playing = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //Don't pause on desktop focus loss
    if (!(AdaptiveLayout.of(context).isDesktop || kIsWeb)) {
      switch (state) {
        case AppLifecycleState.resumed:
          if (playing) ref.read(videoPlayerProvider).play();
          break;
        case AppLifecycleState.hidden:
        case AppLifecycleState.paused:
        case AppLifecycleState.detached:
          if (playing) ref.read(videoPlayerProvider).pause();
          break;
        default:
          break;
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() {
      ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(state: VideoPlayerState.fullScreen));
      return ref.read(videoPlayerSettingsProvider.notifier).setSavedBrightness();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fillScreen = ref.watch(videoPlayerSettingsProvider.select((value) => value.fillScreen));
    final videoFit = ref.watch(videoPlayerSettingsProvider.select((value) => value.videoFit));
    final padding = MediaQuery.of(context).padding;

    final playerController = ref.watch(videoPlayerProvider.select((value) => value.controller));

    return Material(
      color: Colors.black,
      child: Theme(
        data: ThemesData.of(context).dark,
        child: Container(
          color: Colors.black,
          child: GestureDetector(
            onScaleUpdate: (details) {
              lastScale = details.scale;
            },
            onScaleEnd: (details) {
              if (lastScale < 1.0) {
                ref.read(videoPlayerSettingsProvider.notifier).setFillScreen(false, context: context);
              } else if (lastScale > 1.0) {
                ref.read(videoPlayerSettingsProvider.notifier).setFillScreen(true, context: context);
              }
              lastScale = 0.0;
            },
            child: Hero(
              tag: "HeroPlayer",
              child: Stack(
                children: [
                  if (playerController != null)
                    Padding(
                      padding: fillScreen ? EdgeInsets.zero : EdgeInsets.only(left: padding.left, right: padding.right),
                      child: OrientationBuilder(builder: (context, orientation) {
                        return Video(
                          key: Key(orientation.toString()),
                          controller: playerController,
                          fill: Colors.transparent,
                          wakelock: true,
                          fit: fillScreen
                              ? (MediaQuery.of(context).orientation == Orientation.portrait ? videoFit : BoxFit.cover)
                              : videoFit,
                          subtitleViewConfiguration: const SubtitleViewConfiguration(visible: false),
                          controls: NoVideoControls,
                        );
                      }),
                    ),
                  const DesktopControls(),
                  if (errorPlaying) const _VideoErrorWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoErrorWidget extends StatelessWidget {
  const _VideoErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_rounded,
            size: 46,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 8),
          Text(
            "Error playing file",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
