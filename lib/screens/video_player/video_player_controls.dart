import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/default_title_bar.dart';
import 'package:fladder/screens/shared/media/components/item_logo.dart';
import 'package:fladder/screens/video_player/components/video_playback_information.dart';
import 'package:fladder/screens/video_player/components/video_player_controls_extras.dart';
import 'package:fladder/screens/video_player/components/video_player_options_sheet.dart';
import 'package:fladder/screens/video_player/components/video_player_quality_controls.dart';
import 'package:fladder/screens/video_player/components/video_player_screenshot_indicator.dart';
import 'package:fladder/screens/video_player/components/video_player_seek_indicator.dart';
import 'package:fladder/screens/video_player/components/video_player_speed_indicator.dart';
import 'package:fladder/screens/video_player/components/video_player_volume_indicator.dart';
import 'package:fladder/screens/video_player/components/video_progress_bar.dart';
import 'package:fladder/screens/video_player/components/video_volume_slider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/input_handler.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/full_screen_helpers/full_screen_wrapper.dart';

class DesktopControls extends ConsumerStatefulWidget {
  const DesktopControls({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopControlsState();
}

class _DesktopControlsState extends ConsumerState<DesktopControls> {
  final GlobalKey _bottomControlsKey = GlobalKey();

  late final initInputDevice = AdaptiveLayout.inputDeviceOf(context);

  late RestartableTimer timer = RestartableTimer(
    const Duration(seconds: 5),
    () => mounted ? toggleOverlay(value: false) : null,
  );

  double? previousVolume;

  final fadeDuration = const Duration(milliseconds: 350);
  bool showOverlay = true;
  bool wasPlaying = false;
  SystemUiMode? _currentSystemUiMode;

  late final double topPadding = MediaQuery.of(context).viewPadding.top;
  late final double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

  @override
  void initState() {
    super.initState();
    timer.reset();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSegments = ref.watch(playBackModel.select((value) => value?.mediaSegments));
    final player = ref.watch(videoPlayerProvider);
    final subtitleWidget = player.subtitleWidget(showOverlay, controlsKey: _bottomControlsKey);
    return Listener(
      onPointerSignal: setVolume,
      child: InputHandler(
        autoFocus: true,
        keyMap: ref.watch(videoPlayerSettingsProvider.select((value) => value.currentShortcuts)),
        keyMapResult: _onKey,
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
                    onTap: initInputDevice == InputDevice.pointer ? () => player.playOrPause() : () => toggleOverlay(),
                    onDoubleTap:
                        initInputDevice == InputDevice.pointer ? () => fullScreenHelper.toggleFullScreen(ref) : null,
                  ),
                ),
                if (subtitleWidget != null) subtitleWidget,

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
                const VideoPlayerVolumeIndicator(),
                const VideoPlayerSpeedIndicator(),
                const VideoPlayerScreenshotIndicator(),
                Consumer(
                  builder: (context, ref, child) {
                    final position = ref.watch(mediaPlaybackProvider.select((value) => value.position));
                    final skippedSegments = ref.watch(mediaPlaybackProvider.select((value) => value.skippedSegments));
                    MediaSegment? segment = mediaSegments?.atPosition(position);
                    SegmentVisibility forceShow =
                        segment?.visibility(position, force: showOverlay) ?? SegmentVisibility.hidden;
                    final segmentSkipType = ref
                        .watch(videoPlayerSettingsProvider.select((value) => value.segmentSkipSettings[segment?.type]));

                    final segmentId = segment != null ? '${segment.type.name}_${segment.start.inMilliseconds}' : null;
                    final wasSkipped = segmentId != null && skippedSegments.contains(segmentId);

                    final autoSkip = forceShow != SegmentVisibility.hidden &&
                        (segmentSkipType == SegmentSkip.skip ||
                            (segmentSkipType == SegmentSkip.skipOnce && !wasSkipped)) &&
                        player.lastState?.buffering == false;

                    if (autoSkip) {
                      skipToSegmentEnd(segment, segmentId);
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
                              visibility: forceShow,
                              pressedSkip: () => skipToSegmentEnd(segment, null),
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
      ),
    );
  }

  Widget topButtons(BuildContext context) {
    final currentItem = ref.watch(playBackModel.select((value) => value?.item));
    final maxHeight = 150.clamp(50, (MediaQuery.sizeOf(context).height * 0.25).clamp(51, double.maxFinite)).toDouble();
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
                  spacing: 16,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => minimizePlayer(context),
                      icon: const Icon(
                        IconsaxPlusLinear.arrow_down_1,
                        size: 24,
                      ),
                    ),
                    if (currentItem != null)
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: maxHeight,
                                ),
                                child: ItemLogo(
                                  item: currentItem,
                                  imageAlignment: Alignment.topLeft,
                                  textStyle: Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (initInputDevice == InputDevice.touch)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Tooltip(
                            message: context.localized.stop,
                            child: IconButton(
                                onPressed: () => closePlayer(), icon: const Icon(IconsaxPlusLinear.close_square))),
                      ),
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
        key: _bottomControlsKey, // Add key to measure height
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
                        if (initInputDevice == InputDevice.pointer || AdaptiveLayout.of(context).isDesktop)
                          Tooltip(
                            message: context.localized.stop,
                            child: IconButton(
                              onPressed: () => closePlayer(),
                              icon: const Icon(IconsaxPlusLinear.close_square),
                            ),
                          ),
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
                        if ((initInputDevice == InputDevice.pointer || AdaptiveLayout.of(context).isDesktop) &&
                            AdaptiveLayout.viewSizeOf(context) > ViewSize.phone) ...[
                          VideoVolumeSlider(
                            onChanged: () => resetTimer(),
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
              ? context.localized.endsAt(DateTime.now().add(Duration(
                  milliseconds: (mediaPlayback.duration.inMilliseconds - mediaPlayback.position.inMilliseconds) ~/
                      ref.read(playbackRateProvider))))
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
                if (playbackModel != null)
                  InkWell(
                    onTap: () => showVideoPlaybackInformation(context),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          playbackModel.label(context) ?? "",
                        ),
                      ),
                    ),
                  ),
                if (item != null) ...{
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        item.streamModel?.mediaInfoTag ?? "",
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
        return Tooltip(
          message: previousVideo?.detailedName(context) ?? "",
          textAlign: TextAlign.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
          ),
          textStyle: Theme.of(context).textTheme.labelLarge,
          child: IconButton(
            onPressed: loadPreviousVideo(ref, video: previousVideo),
            iconSize: 30,
            icon: const Icon(
              IconsaxPlusLinear.backward,
            ),
          ),
        );
      },
    );
  }

  Function()? loadPreviousVideo(WidgetRef ref, {ItemBaseModel? video}) {
    final previousVideo = video ?? ref.read(playBackModel.select((value) => value?.previousVideo));
    final buffering = ref.read(mediaPlaybackProvider.select((value) => value.buffering));
    return previousVideo != null && !buffering ? () => ref.read(playbackModelHelper).loadNewVideo(previousVideo) : null;
  }

  Widget get nextVideoButton {
    return Consumer(
      builder: (context, ref, child) {
        final nextVideo = ref.watch(playBackModel.select((value) => value?.nextVideo));
        return Tooltip(
          message: nextVideo?.detailedName(context) ?? "",
          textAlign: TextAlign.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
          ),
          textStyle: Theme.of(context).textTheme.labelLarge,
          child: IconButton(
            onPressed: loadNextVideo(ref, video: nextVideo),
            iconSize: 30,
            icon: const Icon(
              IconsaxPlusLinear.forward,
            ),
          ),
        );
      },
    );
  }

  Function()? loadNextVideo(WidgetRef ref, {ItemBaseModel? video}) {
    final nextVideo = video ?? ref.read(playBackModel.select((value) => value?.nextVideo));
    final buffering = ref.read(mediaPlaybackProvider.select((value) => value.buffering));
    return nextVideo != null && !buffering ? () => ref.read(playbackModelHelper).loadNewVideo(nextVideo) : null;
  }

  Widget seekBackwardButton(WidgetRef ref) {
    final backwardSpeed =
        ref.read(userProvider.select((value) => value?.userSettings?.skipBackDuration.inSeconds ?? 30));
    return IconButton(
      onPressed: () => seekBack(ref, seconds: backwardSpeed),
      tooltip: "-$backwardSpeed",
      iconSize: 40,
      icon: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            IconsaxPlusBroken.refresh,
            size: 45,
          ),
          Transform.translate(
            offset: const Offset(0, 1),
            child: Text(
              "-$backwardSpeed",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget seekForwardButton(WidgetRef ref) {
    final forwardSpeed =
        ref.read(userProvider.select((value) => value?.userSettings?.skipForwardDuration.inSeconds ?? 30));
    return IconButton(
      onPressed: () => seekForward(ref, seconds: forwardSpeed),
      tooltip: forwardSpeed.toString(),
      iconSize: 40,
      icon: Stack(
        alignment: Alignment.center,
        children: [
          Transform.flip(
            flipX: true,
            child: const Icon(
              IconsaxPlusBroken.refresh,
              size: 45,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 1),
            child: Text(
              forwardSpeed.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  void skipToSegmentEnd(MediaSegment? mediaSegment, String? segmentId) {
    final end = mediaSegment?.end;
    if (end != null) {
      resetTimer();
      ref.read(videoPlayerProvider).seek(end);

      if (segmentId != null) {
        Future(() {
          final currentSkipped = ref.read(mediaPlaybackProvider).skippedSegments;
          ref.read(mediaPlaybackProvider.notifier).update(
                (state) => state.copyWith(
                  skippedSegments: {...currentSkipped, segmentId},
                ),
              );
        });
      }
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

    final desiredMode = showOverlay ? SystemUiMode.edgeToEdge : SystemUiMode.immersiveSticky;

    if (_currentSystemUiMode != desiredMode) {
      _currentSystemUiMode = desiredMode;
      SystemChrome.setEnabledSystemUIMode(desiredMode, overlays: []);
    }

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
    if (initInputDevice != InputDevice.pointer) {
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
    if (AdaptiveLayout.of(context).isDesktop && defaultTargetPlatform != TargetPlatform.macOS) {
      fullScreenHelper.closeFullScreen(ref);
    }
  }

  void setVolume(PointerEvent event) {
    if (event is PointerScrollEvent) {
      if (event.scrollDelta.dy > 0) {
        ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(-5);
      } else {
        ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(5);
      }
    }
  }

  bool _onKey(VideoHotKeys value) {
    final mediaSegments = ref.read(playBackModel.select((value) => value?.mediaSegments));
    final position = ref.read(mediaPlaybackProvider).position;

    MediaSegment? segment = mediaSegments?.atPosition(position);

    final volume = ref.read(videoPlayerSettingsProvider.select((value) => value.volume));

    switch (value) {
      case VideoHotKeys.playPause:
        ref.read(videoPlayerProvider).playOrPause();
        return true;
      case VideoHotKeys.volumeUp:
        resetTimer();
        ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(5);
        return true;
      case VideoHotKeys.volumeDown:
        resetTimer();
        ref.read(videoPlayerSettingsProvider.notifier).steppedVolume(-5);
        return true;
      case VideoHotKeys.speedUp:
        resetTimer();
        ref.read(videoPlayerSettingsProvider.notifier).steppedSpeed(0.1);
        return true;
      case VideoHotKeys.speedDown:
        resetTimer();
        ref.read(videoPlayerSettingsProvider.notifier).steppedSpeed(-0.1);
        return true;
      case VideoHotKeys.fullScreen:
        fullScreenHelper.toggleFullScreen(ref);
        return true;
      case VideoHotKeys.skipMediaSegment:
        if (segment != null) {
          skipToSegmentEnd(segment, null);
        }
        return true;
      case VideoHotKeys.exit:
        closePlayer();
        return false;
      case VideoHotKeys.mute:
        if (volume != 0) {
          previousVolume = volume;
        }
        ref.read(videoPlayerSettingsProvider.notifier).setVolume(volume == 0 ? (previousVolume ?? 100) : 0);
        return true;
      case VideoHotKeys.nextVideo:
        loadNextVideo(ref)?.call();
        return true;
      case VideoHotKeys.prevVideo:
        loadPreviousVideo(ref)?.call();
        return true;
      case VideoHotKeys.nextChapter:
        ref.read(videoPlayerSettingsProvider.notifier).nextChapter();
        return true;
      case VideoHotKeys.prevChapter:
        ref.read(videoPlayerSettingsProvider.notifier).prevChapter();
        return true;
      default:
        return false;
    }
  }
}
