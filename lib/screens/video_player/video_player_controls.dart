import 'dart:async';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:fladder/models/items/intro_skip_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/default_titlebar.dart';
import 'package:fladder/screens/video_player/components/video_playback_information.dart';
import 'package:fladder/screens/video_player/components/video_player_controls_extras.dart';
import 'package:fladder/screens/video_player/components/video_player_options_sheet.dart';
import 'package:fladder/screens/video_player/components/video_progress_bar.dart';
import 'package:fladder/screens/video_player/components/video_subtitles.dart';
import 'package:fladder/screens/video_player/components/video_volume_slider.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:window_manager/window_manager.dart';

class DesktopControls extends ConsumerStatefulWidget {
  const DesktopControls({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopControlsState();
}

class _DesktopControlsState extends ConsumerState<DesktopControls> {
  final fadeDuration = const Duration(milliseconds: 350);
  final focusNode = FocusNode();
  bool showOverlay = true;
  bool wasPlaying = false;

  late final double topPadding = MediaQuery.of(context).viewPadding.top;
  late final double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

  Future<void> clear() async {
    toggleOverlay(value: true);
    if (!AdaptiveLayout.of(context).isDesktop) {
      ScreenBrightness().resetScreenBrightness();
    } else {
      disableFullscreen();
    }
    timer.cancel();
  }

  void resetTimer() => timer.reset();

  Future<void> closePlayer() async {
    clear();
    ref.read(videoPlayerProvider).stop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mediaPlayback = ref.watch(mediaPlaybackProvider);
    final introSkipModel = ref.watch(playBackModel.select((value) => value?.introSkipModel));
    final player = ref.watch(videoPlayerProvider);
    bool showIntroSkipButton = introSkipModel?.introInRange(mediaPlayback.position) ?? false;
    bool showCreditSkipButton = introSkipModel?.creditsInRange(mediaPlayback.position) ?? false;
    if (AdaptiveLayout.of(context).isDesktop) {
      focusNode.requestFocus();
    }

    return Listener(
      onPointerSignal: (event) {
        log('Timer reset');
        resetTimer();
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            closePlayer();
          }
        },
        child: KeyboardListener(
          focusNode: focusNode,
          autofocus: AdaptiveLayout.of(context).inputDevice == InputDevice.pointer,
          onKeyEvent: (value) {
            if (value is KeyRepeatEvent) {}
            if (value is KeyDownEvent) {
              if (value.logicalKey == LogicalKeyboardKey.keyS) {
                if (showIntroSkipButton) {
                  skipIntro(introSkipModel);
                } else if (showCreditSkipButton) {
                  skipCredits(introSkipModel);
                }
                focusNode.requestFocus();
              }
              if (value.logicalKey == LogicalKeyboardKey.escape) {
                disableFullscreen();
              }
              if (value.logicalKey == LogicalKeyboardKey.space) {
                ref.read(videoPlayerProvider).playOrPause();
              }
              if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
                seekBack(mediaPlayback);
              }
              if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
                seekForward(mediaPlayback);
              }
              if (value.logicalKey == LogicalKeyboardKey.keyF) {
                toggleFullScreen();
              }
              if (AdaptiveLayout.of(context).isDesktop || kIsWeb) {
                if (value.logicalKey == LogicalKeyboardKey.arrowUp) {
                  resetTimer();
                  ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(5);
                }
                if (value.logicalKey == LogicalKeyboardKey.arrowDown) {
                  resetTimer();
                  ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(-5);
                }
              }
              focusNode.requestFocus();
            }
          },
          child: GestureDetector(
            onTap: () => toggleOverlay(),
            child: MouseRegion(
              cursor: showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
              onEnter: (event) => toggleOverlay(value: true),
              onExit: (event) => toggleOverlay(value: false),
              onHover: AdaptiveLayout.of(context).isDesktop || kIsWeb ? (event) => toggleOverlay(value: true) : null,
              child: Stack(
                children: [
                  if (player.controller != null)
                    VideoSubtitles(
                      key: const Key('subtitles'),
                      controller: player.controller!,
                      overlayed: showOverlay,
                    ),
                  if (AdaptiveLayout.of(context).isDesktop) playButton(mediaPlayback),
                  IgnorePointer(
                    ignoring: !showOverlay,
                    child: AnimatedOpacity(
                      duration: fadeDuration,
                      opacity: showOverlay ? 1 : 0,
                      child: Column(
                        children: [
                          topButtons(context),
                          const Spacer(),
                          bottomButtons(context, mediaPlayback),
                        ],
                      ),
                    ),
                  ),
                  if (showIntroSkipButton)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: IntroSkipButton(
                          isOverlayVisible: showOverlay,
                          skipIntro: () => skipIntro(introSkipModel),
                        ),
                      ),
                    ),
                  if (showCreditSkipButton)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: CreditsSkipButton(
                          isOverlayVisible: showOverlay,
                          skipCredits: () => skipCredits(introSkipModel),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget playButton(MediaPlaybackModel mediaPlayback) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedScale(
        curve: Curves.easeInOutCubicEmphasized,
        scale: mediaPlayback.playing
            ? 0
            : mediaPlayback.buffering
                ? 0
                : 1,
        duration: const Duration(milliseconds: 250),
        child: IconButton.outlined(
          onPressed: () => ref.read(videoPlayerProvider).play(),
          isSelected: true,
          iconSize: 65,
          tooltip: "Resume video",
          icon: const Icon(IconsaxBold.play),
        ),
      ),
    );
  }

  Widget topButtons(BuildContext context) {
    final currentItem = ref.watch(playBackModel.select((value) => value?.item));
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.8),
          Colors.black.withOpacity(0),
        ],
      )),
      child: Padding(
        padding:
            EdgeInsets.only(top: topPadding + (AdaptiveLayout.of(context).platform == TargetPlatform.macOS ? 28 : 0.0)),
        child: Container(
          alignment: Alignment.topCenter,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    clear();
                    ref
                        .read(mediaPlaybackProvider.notifier)
                        .update((state) => state.copyWith(state: VideoPlayerState.minimized));
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    IconsaxOutline.arrow_down_1,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                if (!AdaptiveLayout.of(context).isDesktop)
                  Flexible(
                    child: Text(
                      currentItem?.title ?? "",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                else
                  const Flexible(child: Align(alignment: Alignment.topRight, child: DefaultTitleBar()))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomButtons(BuildContext context, MediaPlaybackModel mediaPlayback) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.black.withOpacity(0.8),
          Colors.black.withOpacity(0),
        ],
      )),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding)
            .copyWith(bottom: 21)
            .add(const EdgeInsets.symmetric(vertical: 16))
            .add(EdgeInsets.symmetric(horizontal: AdaptiveLayout.of(context).isDesktop ? 32 : 0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: progressBar(mediaPlayback),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: () => showVideoPlayerOptions(context), icon: const Icon(IconsaxOutline.more)),
                      if (AdaptiveLayout.layoutOf(context) == LayoutState.tablet) ...[
                        IconButton(
                          onPressed: () => showSubSelection(context),
                          icon: const Icon(IconsaxOutline.subtitle),
                        ),
                        IconButton(
                          onPressed: () => showAudioSelection(context),
                          icon: const Icon(IconsaxOutline.audio_square),
                        ),
                      ],
                      if (AdaptiveLayout.layoutOf(context) == LayoutState.desktop) ...[
                        Flexible(
                          child: ElevatedButton.icon(
                            onPressed: () => showSubSelection(context),
                            icon: const Icon(IconsaxOutline.subtitle),
                            label: Text(
                              ref
                                      .watch(playBackModel.select((value) => value?.mediaStreams?.currentSubStream))
                                      ?.language
                                      .capitalize() ??
                                  "Off",
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton.icon(
                            onPressed: () => showAudioSelection(context),
                            icon: const Icon(IconsaxOutline.audio_square),
                            label: Text(
                              ref
                                      .watch(playBackModel.select((value) => value?.mediaStreams?.currentAudioStream))
                                      ?.language
                                      .capitalize() ??
                                  "Off",
                              maxLines: 1,
                            ),
                          ),
                        )
                      ],
                    ].addInBetween(const SizedBox(
                      width: 4,
                    )),
                  ),
                ),
                previousButton,
                seekBackwardButton(mediaPlayback),
                IconButton.filledTonal(
                  iconSize: 38,
                  onPressed: () {
                    ref.read(videoPlayerProvider).playOrPause();
                  },
                  icon: Icon(
                    mediaPlayback.playing ? IconsaxBold.pause : IconsaxBold.play,
                  ),
                ),
                seekForwardButton(mediaPlayback),
                nextVideoButton,
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Tooltip(
                          message: "Stop",
                          child: IconButton(onPressed: () => closePlayer(), icon: const Icon(IconsaxOutline.stop))),
                      const Spacer(),
                      if (AdaptiveLayout.of(context).isDesktop && ref.read(videoPlayerProvider).player != null) ...{
                        // OpenQueueButton(x),
                        // ChapterButton(
                        //   position: position,
                        //   player: ref.read(videoPlayerProvider).player!,
                        // ),
                        Listener(
                          onPointerSignal: (event) {
                            if (event is PointerScrollEvent) {
                              if (event.scrollDelta.dy > 0) {
                                ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(-5);
                              } else {
                                ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(5);
                              }
                            }
                          },
                          child: VideoVolumeSlider(
                            onChanged: () => resetTimer(),
                          ),
                        ),
                        FutureBuilder(
                          future: windowManager.isFullScreen(),
                          builder: (context, snapshot) {
                            final isFullScreen = snapshot.data ?? true;
                            return IconButton(
                              onPressed: () => windowManager.setFullScreen(!isFullScreen),
                              icon: Icon(
                                isFullScreen ? IconsaxOutline.close_square : IconsaxOutline.maximize_4,
                              ),
                            );
                          },
                        ),
                      }
                    ].addInBetween(const SizedBox(width: 8)),
                  ),
                ),
              ].addInBetween(const SizedBox(width: 6)),
            ),
          ],
        ),
      ),
    );
  }

  Widget progressBar(MediaPlaybackModel mediaPlayback) {
    return Consumer(
      builder: (context, ref, child) {
        final playbackModel = ref.watch(playBackModel);
        final item = playbackModel?.item;
        final List<String?> details = [
          if (AdaptiveLayout.of(context).isDesktop) item?.label(context),
          mediaPlayback.duration.inMinutes > 1
              ? 'ends at ${DateFormat('HH:mm').format(DateTime.now().add(mediaPlayback.duration - mediaPlayback.position))}'
              : null
        ];
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    details.whereNotNull().join(' - '),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(blurRadius: 16),
                      ],
                    ),
                    maxLines: 2,
                  ),
                ),
                const Spacer(),
                if (playbackModel.label != null)
                  InkWell(
                    onTap: () => showVideoPlaybackInformation(context),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(playbackModel?.label ?? ""),
                      ),
                    ),
                  ),
                if (item != null) ...{
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text('${item.streamModel?.displayProfile?.value} ${item.streamModel?.resolution?.value}'),
                    ),
                  ),
                }
              ].addPadding(const EdgeInsets.symmetric(horizontal: 4)),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 25,
              child: ChapterProgressSlider(
                wasPlayingChanged: (value) => wasPlaying = value,
                wasPlaying: wasPlaying,
                duration: mediaPlayback.duration,
                position: mediaPlayback.position,
                buffer: mediaPlayback.buffer,
                buffering: mediaPlayback.buffering,
                timerReset: () => timer.reset(),
                onPositionChanged: (position) => ref.read(videoPlayerProvider).seek(position),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mediaPlayback.position.readAbleDuration),
                Text("-${(mediaPlayback.duration - mediaPlayback.position).readAbleDuration}"),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget get previousButton {
    return Consumer(
      builder: (context, ref, child) {
        final previousVideo = ref.watch(playBackModel.select((value) => value?.previousVideo));
        final buffering = ref.watch(mediaPlaybackProvider.select((value) => value.buffering));

        return Tooltip(
          message: previousVideo?.detailedName(context) ?? "",
          textAlign: TextAlign.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
          ),
          textStyle: Theme.of(context).textTheme.labelLarge,
          child: IconButton(
            onPressed: previousVideo != null && !buffering
                ? () => ref.read(playbackModelHelper).loadNewVideo(previousVideo)
                : null,
            iconSize: 30,
            icon: const Icon(
              IconsaxOutline.backward,
            ),
          ),
        );
      },
    );
  }

  Widget get nextVideoButton {
    return Consumer(
      builder: (context, ref, child) {
        final nextVideo = ref.watch(playBackModel.select((value) => value?.nextVideo));
        final buffering = ref.watch(mediaPlaybackProvider.select((value) => value.buffering));
        return Tooltip(
          message: nextVideo?.detailedName(context) ?? "",
          textAlign: TextAlign.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
          ),
          textStyle: Theme.of(context).textTheme.labelLarge,
          child: IconButton(
            onPressed:
                nextVideo != null && !buffering ? () => ref.read(playbackModelHelper).loadNewVideo(nextVideo) : null,
            iconSize: 30,
            icon: const Icon(
              IconsaxOutline.forward,
            ),
          ),
        );
      },
    );
  }

  Widget seekBackwardButton(MediaPlaybackModel mediaPlaybackModel) {
    return IconButton(
      onPressed: () => seekBack(mediaPlaybackModel),
      tooltip: "-10",
      iconSize: 40,
      icon: const Icon(
        IconsaxOutline.backward_10_seconds,
      ),
    );
  }

  Widget seekForwardButton(MediaPlaybackModel mediaPlaybackModel) {
    return IconButton(
      onPressed: () => seekForward(mediaPlaybackModel),
      tooltip: "15",
      iconSize: 40,
      icon: const Stack(
        children: [
          Icon(IconsaxOutline.forward_15_seconds),
        ],
      ),
    );
  }

  void skipIntro(IntroOutSkipModel? introSkipModel) {
    resetTimer();
    final end = introSkipModel?.intro?.end;
    if (end != null) {
      ref.read(videoPlayerProvider).seek(end);
    }
  }

  void skipCredits(IntroOutSkipModel? introSkipModel) {
    resetTimer();
    final end = introSkipModel?.credits?.end;
    if (end != null) {
      ref.read(videoPlayerProvider).seek(end);
    }
  }

  void seekBack(MediaPlaybackModel mediaPlayback, {int seconds = 15}) {
    resetTimer();
    final newPosition = (mediaPlayback.position.inSeconds - seconds).clamp(0, mediaPlayback.duration.inSeconds);
    ref.read(videoPlayerProvider).seek(Duration(seconds: newPosition));
  }

  void seekForward(MediaPlaybackModel mediaPlayback, {int seconds = 15}) {
    resetTimer();
    final newPosition = (mediaPlayback.position.inSeconds + seconds).clamp(0, mediaPlayback.duration.inSeconds);
    ref.read(videoPlayerProvider).seek(Duration(seconds: newPosition));
  }

  late RestartableTimer timer = RestartableTimer(
    const Duration(seconds: 5),
    () => mounted ? toggleOverlay(value: false) : null,
  );

  void toggleOverlay({bool? value}) {
    setState(() => showOverlay = (value ?? !showOverlay));
    resetTimer();
    SystemChrome.setEnabledSystemUIMode(showOverlay ? SystemUiMode.edgeToEdge : SystemUiMode.leanBack, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  Future<void> disableFullscreen() async {
    resetTimer();
    final isFullScreen = await windowManager.isFullScreen();
    if (isFullScreen) {
      await windowManager.setFullScreen(false);
    }
  }

  Future<void> toggleFullScreen() async {
    final isFullScreen = await windowManager.isFullScreen();
    await windowManager.setFullScreen(!isFullScreen);
  }
}
