import 'dart:async';

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
import 'package:fladder/screens/video_player/components/video_player_seek_indicator.dart';
import 'package:fladder/screens/video_player/components/video_progress_bar.dart';
import 'package:fladder/screens/video_player/components/video_volume_slider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/input_handler.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/full_screen_helpers/full_screen_wrapper.dart';

class TVControls extends ConsumerStatefulWidget {
  const TVControls({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TVControlsState();
}

class _TVControlsState extends ConsumerState<TVControls> {
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
  String? activeIndicator;
  RestartableTimer? _activeIndicatorTimer;
  final FocusNode controlsFocusNode = FocusNode();
  List<String> navOrder = [];
  int navIndex = 0;
  final Map<String, FocusNode> navFocusNodes = {};

  late final double topPadding = MediaQuery.of(context).viewPadding.top;
  late final double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

  @override
  void initState() {
    super.initState();
    timer.reset();
    HardwareKeyboard.instance.addHandler(_tizenHardwareHandler);
  }

  void _setActiveIndicator(String value) {
    _activeIndicatorTimer?.cancel();
    setState(() {
      activeIndicator = value;
    });
    _activeIndicatorTimer = RestartableTimer(const Duration(seconds: 1), () {
      setState(() {
        activeIndicator = null;
      });
    });
  }

  Widget _wrapNav(String id, Widget child) {
    final node = navFocusNodes.putIfAbsent(id, () => FocusNode());
    return FocusableActionDetector(
      focusNode: node,
      enabled: showOverlay,
      shortcuts: <LogicalKeySet, Intent>{
      },
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<Intent>(onInvoke: (intent) {
          activateSelection();
          return null;
        }),
      },
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          final idx = navOrder.indexOf(id);
          if (idx >= 0) {
            setState(() {
              navIndex = idx;
              _setActiveIndicator(id);
            });
          }
        }
      },
       child: Builder(builder: (context) {
        final focused = Focus.of(context).hasFocus;
        if (!showOverlay) return child;
        return Container(
          decoration: focused
              ? BoxDecoration(
                  border: Border.all(color: Colors.white.withValues(alpha: 0.9), width: 2),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          padding: focused ? const EdgeInsets.all(2) : EdgeInsets.zero,
          child: child,
        );
      }),
    );
  }

  void ensureNavOrder() {
    final List<String> order = [];
    order.add('options');
    order.add('subtitle');
    order.add('audio');
    order.add('previous');
    order.add('seekBack');
    order.add('playPause');
    order.add('seekForward');
    order.add('next');
    order.add('quality');

    navOrder = order;
    if (navIndex >= navOrder.length) navIndex = 0;

    final existing = Set<String>.from(navFocusNodes.keys);
    for (final id in navOrder) {
      existing.remove(id);
      navFocusNodes.putIfAbsent(id, () => FocusNode());
    }

    for (final id in existing) {
      navFocusNodes[id]?.dispose();
      navFocusNodes.remove(id);
    }
  }

  void _moveSelection(int delta) {
    if (navOrder.isEmpty) return;
    setState(() {
      navIndex = (navIndex + delta) % navOrder.length;
      if (navIndex < 0) navIndex += navOrder.length;
      _setActiveIndicator(navOrder[navIndex]);
    });

    final id = navOrder[navIndex];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) navFocusNodes[id]?.requestFocus();
    });
  }

  void activateSelection() {
    if (navOrder.isEmpty) return;
    final id = navOrder[navIndex];
    switch (id) {
      case 'options':
        showVideoPlayerOptions(context, () => minimizePlayer(context));
        break;
      case 'subtitle':
        showSubSelection(context);
        break;
      case 'audio':
        showAudioSelection(context);
        break;
      case 'previous':
        loadPreviousVideo(ref)?.call();
        break;
      case 'seekBack':
        final backwardSpeed = 
          ref.read(userProvider.select((value) => value?.userSettings?.skipBackDuration.inSeconds ?? 10));
        seekBack(ref, seconds: backwardSpeed);
        break;
      case 'playPause':
        doPlayPause();
        break;
      case 'seekForward':

        final forwardSpeed = 
          ref.read(userProvider.select((value) => value?.userSettings?.skipForwardDuration.inSeconds ?? 30));
        seekForward(ref, seconds: forwardSpeed);
        break;
      case 'next':
        loadNextVideo(ref)?.call();
        break;
      case 'quality':
        openQualityOptions(context);
        break;
      default:
        break;
    }
  }

  void doPlayPause() {
    ref.read(videoPlayerProvider).playOrPause();
    _setActiveIndicator('Play/Pause');
    resetTimer();
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_tizenHardwareHandler);
    controlsFocusNode.dispose();
    for (final node in navFocusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build nav order for remote navigation each build so it reflects visible controls
    ensureNavOrder();
    final mediaSegments = ref.watch(playBackModel.select((value) => value?.mediaSegments));
    final player = ref.watch(videoPlayerProvider);
    final subtitleWidget = player.subtitleWidget(showOverlay, controlsKey: _bottomControlsKey);
    // final currentShortcuts = ref.watch(videoPlayerSettingsProvider.select((value) => value.currentShortcuts));
    // final effectiveKeyMap = showOverlay ? Map.of(currentShortcuts) : currentShortcuts;

    // if (showOverlay) {
    //   effectiveKeyMap.remove(VideoHotKeys.seekForward);
    //   effectiveKeyMap.remove(VideoHotKeys.seekBack);     
    // }

    //effectiveKeyMap.remove(VideoHotKeys.playPause);
    //effectiveKeyMap.remove(VideoHotKeys.exit);

    return Listener(
      onPointerSignal: setVolume,
      child: InputHandler(
        autoFocus: true,
        listenRawKeyboard: true,
        //keyMap: effectiveKeyMap,
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              closePlayer();
            }
          },
          child: Stack(
              children: [
                if (subtitleWidget != null) subtitleWidget,
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: fadeDuration,
                    opacity: showOverlay ? 1 : 0,
                    child: Column(
                      children: [
                        topButtons(context),
                        const Spacer(),
                        ExcludeFocus(
                          excluding: !showOverlay,
                          child: FocusTraversalGroup(
                            policy: OrderedTraversalPolicy(),
                            child: Focus(
                              focusNode: controlsFocusNode,
                              child: bottomButtons(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!showOverlay) const VideoPlayerSeekIndicator(),

                Consumer(
                  builder: (context, ref, child) {
                    final position = ref.watch(mediaPlaybackProvider.select((value) => value.position));
                    MediaSegment? segment = mediaSegments?.atPosition(position);
                    SegmentVisibility forceShow =
                        segment?.visibility(position, force: showOverlay) ?? SegmentVisibility.hidden;
                    final segmentSkipType = ref
                        .watch(videoPlayerSettingsProvider.select((value) => value.segmentSkipSettings[segment?.type]));
                    final autoSkip = forceShow != SegmentVisibility.hidden &&
                        segmentSkipType == SegmentSkip.skip &&
                        player.lastState?.buffering == false;
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
                              visibility: forceShow,
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
                         _wrapNav(
                           'options',
                           IconButton(
                               onPressed: () => showVideoPlayerOptions(context, () => minimizePlayer(context)),
                               icon: const Icon(IconsaxPlusLinear.more)),
                         ),
                        if (AdaptiveLayout.layoutOf(context) == ViewSize.tablet) ...[
                            _wrapNav(
                              'subtitle',
                              IconButton(
                                onPressed: () => showSubSelection(context),
                                icon: const Icon(IconsaxPlusLinear.subtitle),
                              ),
                            ),
                            _wrapNav(
                              'audio',
                              IconButton(
                                onPressed: () => showAudioSelection(context),
                                icon: const Icon(IconsaxPlusLinear.audio_square),
                              ),
                            ),
                        ],
                        if (AdaptiveLayout.layoutOf(context) == ViewSize.television) ...[
                          Flexible(
                           child: _wrapNav(
                             'subtitle',
                             ElevatedButton.icon(
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
                          ),
                          Flexible(
                           child: _wrapNav(
                             'audio',
                             ElevatedButton.icon(
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
                  _wrapNav(
                    'playPause',
                    // Wrap the IconButton in a Consumer so the Icon rebuilds
                    // specifically when the playing state changes.
                    Consumer(builder: (context, ref, child) {
                      final playing = ref.watch(mediaPlaybackProvider.select((m) => m.playing));
                      return IconButton.filledTonal(
                        iconSize: 38,
                        onPressed: doPlayPause,
                        icon: Icon(
                          playing ? IconsaxPlusBold.pause : IconsaxPlusBold.play,
                        ),
                      );
                    }),
                  ),
                  seekForwardButton(ref),
                  nextVideoButton,
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Removed the pointer close button to avoid showing a cross in the corner.
                        const Spacer(),
                        if (AdaptiveLayout.viewSizeOf(context) >= ViewSize.tablet &&
                            ref.read(videoPlayerProvider).hasPlayer) ...{
                          if (bitRateOptions?.isNotEmpty == true)
                            Tooltip(
                              message: context.localized.qualityOptionsTitle,
                             child: _wrapNav(
                               'quality',
                               IconButton(
                                 onPressed: () =>openQualityOptions(context),
                                 icon: const Icon(IconsaxPlusLinear.speedometer),
                               ),
                             ),
                            ),
                        },
                        if (initInputDevice == InputDevice.pointer &&
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
        final List<String?> details = [ null
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
          child: _wrapNav(
            'previous',
            IconButton(
              onPressed: loadPreviousVideo(ref, video: previousVideo),
              iconSize: 30,
              icon: const Icon(
                IconsaxPlusLinear.backward,
              ),
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
          child: _wrapNav(
            'next',
            IconButton(
              onPressed: loadNextVideo(ref, video: nextVideo),
              iconSize: 30,
              icon: const Icon(
                IconsaxPlusLinear.forward,
              ),
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
    final backwardSpeed = 10;
        //ref.read(userProvider.select((value) => value?.userSettings?.skipBackDuration.inSeconds ?? 30));
     return _wrapNav(
       'seekBack',
       IconButton(
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
       ),
     );
  }

  Widget seekForwardButton(WidgetRef ref) {
    final forwardSpeed = 
      ref.read(userProvider.select((value) => value?.userSettings?.skipForwardDuration.inSeconds ?? 30));
     return _wrapNav(
       'seekForward',
       IconButton(
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

    // When overlay becomes visible, set focus to the controls so arrow keys
    // navigate the control buttons.
    if (showOverlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) controlsFocusNode.requestFocus();
      });
    }
    if (showOverlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && navOrder.isNotEmpty) {
          final id = navOrder[navIndex];
          navFocusNodes[id]?.requestFocus();
        }
      });
    }

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
    fullScreenHelper.closeFullScreen(ref);
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

  bool _tizenHardwareHandler(KeyEvent event) {
    // Only handle on key down to avoid double triggers
    if (event is! KeyDownEvent) return false;
    final key = event.logicalKey;

    // Common media keys
    if (key == LogicalKeyboardKey.mediaPlayPause || key == LogicalKeyboardKey.mediaPlay || key == LogicalKeyboardKey.mediaPause) {
      // toggle play/pause
      ref.read(videoPlayerProvider).playOrPause();
      _setActiveIndicator('Play/Pause');
      resetTimer();
      return true;
    }

    // If overlay is visible, use D-pad to navigate controls
    if (showOverlay) {
      if (key == LogicalKeyboardKey.arrowLeft) {
        _moveSelection(-1);
        resetTimer();
        return true;
      }
      if (key == LogicalKeyboardKey.arrowRight) {
        _moveSelection(1);
        resetTimer();
        return true;
      }
      // if (key == LogicalKeyboardKey.arrowUp) {
      //   // Move up a few steps (best-effort grid movement)
      //   _moveSelection(-3);
      //   return true;
      // }
      // if (key == LogicalKeyboardKey.arrowDown) {
      //   _moveSelection(3);
      //   return true;
      // }
      // Activation keys
      
      if (key == LogicalKeyboardKey.select || key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space) {
        //activateSelection();
        //_setActiveIndicator('Activate');
        resetTimer();
        return true;
      }
    }

    // // Arrow keys -> seek indicator (when overlay not visible)
    // if (key == LogicalKeyboardKey.arrowLeft || key == LogicalKeyboardKey.arrowRight) {
    //   _setActiveIndicator('Seek');
    //   // do not swallow here; other handlers (seek indicator) will process the key
    //   return false;
    // }

    // Up/Down -> volume (when overlay not visible)
    if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.arrowDown) {
      // _setActiveIndicator('Volume');
      // do not swallow here; allow normal processing
      toggleOverlay(value: true);
      return false;
    }

    return false;
  }
}
