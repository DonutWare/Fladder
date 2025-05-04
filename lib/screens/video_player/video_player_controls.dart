import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/default_title_bar.dart';
import 'package:fladder/screens/shared/media/components/item_logo.dart';
import 'package:fladder/screens/video_player/components/video_playback_information.dart';
import 'package:fladder/screens/video_player/components/video_player_controls_extras.dart';
import 'package:fladder/screens/video_player/components/video_player_options_sheet.dart';
import 'package:fladder/screens/video_player/components/video_player_quality_controls.dart';
import 'package:fladder/screens/video_player/components/video_player_seek_indicator.dart';
import 'package:fladder/screens/video_player/components/video_progress_bar.dart';
import 'package:fladder/screens/video_player/components/video_volume_slider.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/input_handler.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/full_screen_button.dart'
    if (dart.library.html) 'package:fladder/widgets/shared/full_screen_button_web.dart';

class DesktopControls extends ConsumerStatefulWidget {
  const DesktopControls({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopControlsState();
}

class _DesktopControlsState extends ConsumerState<DesktopControls> {
  late RestartableTimer timer = RestartableTimer(
    const Duration(seconds: 5),
    () => mounted ? toggleOverlay(value: false) : null,
  );

  final fadeDuration = const Duration(milliseconds: 350);
  bool showOverlay = true;
  bool wasPlaying = false;

  late final double topPadding = MediaQuery.of(context).viewPadding.top;
  late final double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

  bool _onKey(KeyEvent value) {
    final mediaSegments = ref.read(playBackModel.select((value) => value?.mediaSegments));
    final position = ref.read(mediaPlaybackProvider).position;
    MediaSegment? segment = mediaSegments?.atPosition(position);
    if (value is KeyRepeatEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowUp) {
        resetTimer();
        ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(5);
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowDown) {
        resetTimer();
        ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(-5);
        return true;
      }
    }
    if (value is KeyDownEvent) {
      if (value.logicalKey == LogicalKeyboardKey.keyS) {
        if (segment != null) {
          skipToSegmentEnd(segment);
        }
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.escape) {
        disableFullScreen();
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.space) {
        ref.read(videoPlayerProvider).playOrPause();
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.keyF) {
        toggleFullScreen(ref);
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowUp) {
        resetTimer();
        ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(5);
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowDown) {
        resetTimer();
        ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(-5);
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    timer.reset();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSegments = ref.watch(playBackModel.select((value) => value?.mediaSegments));
    final player = ref.watch(videoPlayerProvider);
    final subtitleWidget = player.subtitleWidget(showOverlay);
    return InputHandler(
      autoFocus: false,
      onKeyEvent: (node, event) => _onKey(event) ? KeyEventResult.handled : KeyEventResult.ignored,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            closePlayer();
          }
        },
        child: MouseRegion(
          cursor: showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
          onExit: (event) => toggleOverlay(value: false),
          onEnter: (event) => toggleOverlay(value: true),
          onHover: AdaptiveLayout.of(context).isDesktop || kIsWeb ? (event) => toggleOverlay(value: true) : null,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: AdaptiveLayout.of(context).inputDevice == InputDevice.pointer
                      ? () => player.playOrPause()
                      : () => toggleOverlay(),
                  onDoubleTap: AdaptiveLayout.of(context).inputDevice == InputDevice.pointer
                      ? () => toggleFullScreen(ref)
                      : null,
                ),
              ),
              if (subtitleWidget != null) subtitleWidget,
              if (AdaptiveLayout.of(context).isDesktop)
                Consumer(builder: (context, ref, child) {
                  final playing = ref.watch(mediaPlaybackProvider.select((value) => value.playing));
                  final buffering = ref.watch(mediaPlaybackProvider.select((value) => value.buffering));
                  return playButton(playing, buffering);
                }),
              IgnorePointer(
                ignoring: !showOverlay,
                child: AnimatedOpacity(
                  duration: fadeDuration,
                  opacity: showOverlay ? 1 : 0,
                  child: Column(
                    children: [
                      topButtons(context),
                      const Spacer(),
                      bottomButtons(context),
                    ],
                  ),
                ),
              ),
              const VideoPlayerSeekIndicator(),
              Consumer(
                builder: (context, ref, child) {
                  final position = ref.watch(mediaPlaybackProvider.select((value) => value.position));
                  MediaSegment? segment = mediaSegments?.atPosition(position);
                  bool forceShow = segment?.forceShow(position) ?? false;
                  final segmentSkipType = ref
                      .watch(videoPlayerSettingsProvider.select((value) => value.segmentSkipSettings[segment?.type]));
                  final autoSkip =
                      forceShow == true && segmentSkipType == SegmentSkip.skip && player.lastState?.buffering == false;
                  if (autoSkip) {
                    skipToSegmentEnd(segment);
                  }
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: SkipSegmentButton(
                            segment: segment,
                            skipType: segmentSkipType,
                            isOverlayVisible: forceShow ? true : showOverlay,
                            pressedSkip: () => skipToSegmentEnd(segment),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playButton(bool playing, bool buffering) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedScale(
        curve: Curves.easeInOutCubicEmphasized,
        scale: playing
            ? 0
            : buffering
                ? 0
                : 1,
        duration: const Duration(milliseconds: 250),
        child: IconButton.outlined(
          onPressed: () => ref.read(videoPlayerProvider).play(),
          isSelected: true,
          iconSize: 65,
          tooltip: "Resume video",
          icon: const Icon(IconsaxPlusBold.play),
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
          Colors.black.withValues(alpha: 0.8),
          Colors.black.withValues(alpha: 0),
        ],
      )),
      child: Padding(
        padding: MediaQuery.paddingOf(context).copyWith(bottom: 0, top: 0),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: DefaultTitleBar(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => minimizePlayer(context),
                      icon: const Icon(
                        IconsaxPlusLinear.arrow_down_1,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (currentItem != null)
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 150.clamp(50, MediaQuery.sizeOf(context).height * 0.25).toDouble(),
                          ),
                          child: ItemLogo(
                            item: currentItem,
                            imageAlignment: Alignment.topLeft,
                            textStyle: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                    if (AdaptiveLayout.of(context).inputDevice == InputDevice.touch)
                      Tooltip(
                          message: context.localized.stop,
                          child: IconButton(
                              onPressed: () => closePlayer(), icon: const Icon(IconsaxPlusLinear.close_square))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomButtons(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final mediaPlayback = ref.watch(mediaPlaybackProvider);
      final bitRateOptions = ref.watch(playBackModel.select((value) => value?.bitRateOptions));
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withValues(alpha: 0.8),
            Colors.black.withValues(alpha: 0),
          ],
        )),
        child: Padding(
          padding: MediaQuery.paddingOf(context).add(
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: progressBar(mediaPlayback),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () => showVideoPlayerOptions(context, () => minimizePlayer(context)),
                            icon: const Icon(IconsaxPlusLinear.more)),
                        if (AdaptiveLayout.layoutOf(context) == ViewSize.tablet) ...[
                          IconButton(
                            onPressed: () => showSubSelection(context),
                            icon: const Icon(IconsaxPlusLinear.subtitle),
                          ),
                          IconButton(
                            onPressed: () => showAudioSelection(context),
                            icon: const Icon(IconsaxPlusLinear.audio_square),
                          ),
                        ],
                        if (AdaptiveLayout.layoutOf(context) == ViewSize.desktop) ...[
                          Flexible(
                            child: ElevatedButton.icon(
                              onPressed: () => showSubSelection(context),
                              icon: const Icon(IconsaxPlusLinear.subtitle),
                              label: Text(
                                ref.watch(playBackModel.select((value) {
                                      final language = value?.mediaStreams?.currentSubStream?.language;
                                      return language?.isEmpty == true ? context.localized.off : language;
                                    }))?.capitalize() ??
                                    "",
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Flexible(
                            child: ElevatedButton.icon(
                              onPressed: () => showAudioSelection(context),
                              icon: const Icon(IconsaxPlusLinear.audio_square),
                              label: Text(
                                ref.watch(playBackModel.select((value) {
                                      final language = value?.mediaStreams?.currentAudioStream?.language;
                                      return language?.isEmpty == true ? context.localized.off : language;
                                    }))?.capitalize() ??
                                    "",
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
                  seekBackwardButton(ref),
                  IconButton.filledTonal(
                    iconSize: 38,
                    onPressed: () {
                      ref.read(videoPlayerProvider).playOrPause();
                    },
                    icon: Icon(
                      mediaPlayback.playing ? IconsaxPlusBold.pause : IconsaxPlusBold.play,
                    ),
                  ),
                  seekForwardButton(ref),
                  nextVideoButton,
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer)
                          Tooltip(
                              message: context.localized.stop,
                              child: IconButton(
                                  onPressed: () => closePlayer(), icon: const Icon(IconsaxPlusLinear.close_square))),
                        const Spacer(),
                        if (AdaptiveLayout.viewSizeOf(context) >= ViewSize.tablet &&
                            ref.read(videoPlayerProvider).hasPlayer) ...{
                          if (bitRateOptions?.isNotEmpty == true)
                            Tooltip(
                              message: context.localized.qualityOptionsTitle,
                              child: IconButton(
                                onPressed: () => openQualityOptions(context),
                                icon: const Icon(IconsaxPlusLinear.speedometer),
                              ),
                            ),
                        },
                        if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer &&
                            AdaptiveLayout.viewSizeOf(context) > ViewSize.phone) ...[
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
                          const FullScreenButton(),
                        ]
                      ].addInBetween(const SizedBox(width: 8)),
                    ),
                  ),
                ].addInBetween(const SizedBox(width: 6)),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget progressBar(MediaPlaybackModel mediaPlayback) {
    return Consumer(
      builder: (context, ref, child) {
        final playbackModel = ref.watch(playBackModel);
        final item = playbackModel?.item;
        final List<String?> details = [
          if (AdaptiveLayout.of(context).isDesktop) item?.label(context),
          mediaPlayback.duration.inMinutes > 1
                ? context.localized.endsAt(DateTime.now().add(
                  Duration(milliseconds: 
                    (mediaPlayback.duration.inMilliseconds - mediaPlayback.position.inMilliseconds) ~/ ref.read(playbackRateProvider)))
                  )
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
                    details.nonNulls.join(' - '),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
                        child: Text(
                          playbackModel?.label ?? "",
                        ),
                      ),
                    ),
                  ),
                if (item != null) ...{
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        '${item.streamModel?.displayProfile?.value} ${item.streamModel?.resolution?.value}',
                      ),
                    ),
                  ),
                },
              ].addPadding(const EdgeInsets.symmetric(horizontal: 4)),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 25,
              child: VideoProgressBar(
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
                Text(
                  mediaPlayback.position.readAbleDuration,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "-${(mediaPlayback.duration - mediaPlayback.position).readAbleDuration}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
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
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
          ),
          textStyle: Theme.of(context).textTheme.labelLarge,
          child: IconButton(
            onPressed: previousVideo != null && !buffering
                ? () => ref.read(playbackModelHelper).loadNewVideo(previousVideo)
                : null,
            iconSize: 30,
            icon: const Icon(
              IconsaxPlusLinear.backward,
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
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
          ),
          textStyle: Theme.of(context).textTheme.labelLarge,
          child: IconButton(
            onPressed:
                nextVideo != null && !buffering ? () => ref.read(playbackModelHelper).loadNewVideo(nextVideo) : null,
            iconSize: 30,
            icon: const Icon(
              IconsaxPlusLinear.forward,
            ),
          ),
        );
      },
    );
  }

  Widget seekBackwardButton(WidgetRef ref) {
    return IconButton(
      onPressed: () => seekBack(ref),
      tooltip: "-10",
      iconSize: 40,
      icon: const Icon(
        IconsaxPlusLinear.backward_10_seconds,
      ),
    );
  }

  Widget seekForwardButton(WidgetRef ref) {
    return IconButton(
      onPressed: () => seekForward(ref),
      tooltip: "15",
      iconSize: 40,
      icon: const Stack(
        children: [
          Icon(IconsaxPlusLinear.forward_15_seconds),
        ],
      ),
    );
  }

  void skipToSegmentEnd(MediaSegment? mediaSegments) {
    final end = mediaSegments?.end;
    if (end != null) {
      resetTimer();
      ref.read(videoPlayerProvider).seek(end);
    }
  }

  void seekBack(WidgetRef ref, {int seconds = 15}) {
    final mediaPlayback = ref.read(mediaPlaybackProvider);
    resetTimer();
    final newPosition = (mediaPlayback.position.inSeconds - seconds).clamp(0, mediaPlayback.duration.inSeconds);
    ref.read(videoPlayerProvider).seek(Duration(seconds: newPosition));
  }

  void seekForward(WidgetRef ref, {int seconds = 15}) {
    final mediaPlayback = ref.read(mediaPlaybackProvider);
    resetTimer();
    final newPosition = (mediaPlayback.position.inSeconds + seconds).clamp(0, mediaPlayback.duration.inSeconds);
    ref.read(videoPlayerProvider).seek(Duration(seconds: newPosition));
  }

  void toggleOverlay({bool? value}) {
    if (showOverlay == (value ?? !showOverlay)) return;
    setState(() => showOverlay = (value ?? !showOverlay));
    resetTimer();
    SystemChrome.setEnabledSystemUIMode(showOverlay ? SystemUiMode.edgeToEdge : SystemUiMode.leanBack, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  void minimizePlayer(BuildContext context) {
    clearOverlaySettings();
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(state: VideoPlayerState.minimized));
    Navigator.of(context).pop();
  }

  void resetTimer() => timer.reset();

  Future<void> closePlayer() async {
    clearOverlaySettings();
    ref.read(videoPlayerProvider).stop();
    Navigator.of(context).pop();
  }

  Future<void> clearOverlaySettings() async {
    toggleOverlay(value: true);
    if (AdaptiveLayout.of(context).inputDevice != InputDevice.pointer) {
      ScreenBrightness().resetApplicationScreenBrightness();
    } else {
      disableFullScreen();
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: ref.read(clientSettingsProvider.select((value) => value.statusBarBrightness(context))),
    ));

    timer.cancel();
  }

  Future<void> disableFullScreen() async {
    resetTimer();
    closeFullScreen();
  }
}
