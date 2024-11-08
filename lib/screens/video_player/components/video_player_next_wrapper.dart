import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/default_titlebar.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/floating_player_bar.dart';
import 'package:fladder/widgets/shared/progress_floating_button.dart';

class VideoPlayerNextWrapper extends ConsumerStatefulWidget {
  final Widget video;
  final Widget controls;
  final List<Widget> overlays;
  const VideoPlayerNextWrapper({
    required this.video,
    required this.controls,
    this.overlays = const [],
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerNextWrapperState();
}

class _VideoPlayerNextWrapperState extends ConsumerState<VideoPlayerNextWrapper> {
  bool show = false;
  bool showOverwrite = false;
  late RestarableTimerController timerController =
      RestarableTimerController(const Duration(seconds: 30), const Duration(milliseconds: 33), onTimeout: onTimeOut);

  void onTimeOut() {
    timerController.cancel();
    if (showOverwrite == true) return;
    final nextUp = ref.read(playBackModel.select((value) => value?.nextVideo));
    if (nextUp != null) {
      ref.read(playbackModelHelper).loadNewVideo(nextUp);
    }
    hideNextUp();
  }

  void showNextScreen(MediaPlaybackModel model) {
    final nextUp = ref.read(playBackModel.select((value) => value?.nextVideo));
    if (nextUp == null) return;
    if (show) return;
    if (showOverwrite) return;
    if (!model.playing) return;
    if (model.buffering) return;

    setState(() {
      show = true;
      timerController.reset();
      timerController.play();
    });
  }

  void determineShow(MediaPlaybackModel model) {
    final playerState = ref.watch(mediaPlaybackProvider.select((value) => value.state));
    if (playerState != VideoPlayerState.fullScreen) {
      showOverwrite = false;
      show = false;
      return;
    }

    final nextType = ref.read(videoPlayerSettingsProvider.select((value) => value.nextVideoType));
    if (nextType == AutoNextType.off || model.duration < const Duration(seconds: 40)) {
      showOverwrite = false;
      show = false;
      return;
    }

    final credits = ref.read(playBackModel)?.introSkipModel?.credits;

    if (nextType == AutoNextType.static || credits == null) {
      if ((model.duration - model.position).abs() < const Duration(seconds: 32)) {
        showNextScreen(model);
        return;
      }
    } else if (nextType == AutoNextType.smart) {
      final maxTime = ref.read(userProvider.select((value) => value?.serverConfiguration?.maxResumePct ?? 90));
      final resumeDuration = model.duration * (maxTime / 100);
      final timeLeft = model.duration - credits.end;
      if (credits.end > resumeDuration && timeLeft < const Duration(seconds: 30)) {
        if (model.position >= credits.start) {
          showNextScreen(model);
          return;
        }
      } else if ((model.duration - model.position).abs() < const Duration(seconds: 32)) {
        showNextScreen(model);
        return;
      }
    }
    setState(() {
      show = false;
      showOverwrite = false;
      timerController.cancel();
    });
  }

  void hideNextUp() {
    timerController.cancel();
    setState(() {
      show = false;
      showOverwrite = true;
    });
  }

  @override
  void dispose() {
    timerController.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const animSpeed = Duration(milliseconds: 250);
    final nextUp = ref.watch(playBackModel.select((value) => value?.nextVideo));
    final currentItem = ref.watch(playBackModel.select((value) => value?.item));
    final portraitMode = MediaQuery.sizeOf(context).width < MediaQuery.sizeOf(context).height;

    double padding = show ? 16 : 0;

    ref.listen(mediaPlaybackProvider, (previous, next) => determineShow(next));
    return Hero(
      tag: videoPlayerHeroTag,
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surfaceContainerLowest.withOpacity(0.2),
          ),
          if (nextUp != null)
            AnimatedAlign(
              duration: animSpeed,
              alignment: portraitMode ? Alignment.bottomCenter : Alignment.centerRight,
              child: AnimatedOpacity(
                duration: animSpeed,
                opacity: show ? 1 : 0,
                child: Padding(
                  padding: MediaQuery.paddingOf(context).add(const EdgeInsets.all(32)),
                  child: FractionallySizedBox(
                    widthFactor: portraitMode ? null : 0.35,
                    heightFactor: portraitMode ? 0.5 : null,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text(
                                    context.localized.nextUp,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.0),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 45.0,
                                  child: ProgressFloatingButton(
                                    controller: timerController,
                                  ),
                                ),
                              ].addInBetween(
                                const SizedBox(
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),
                            const Divider(),
                            Flexible(
                              child: SingleChildScrollView(
                                child: _NextUpInformation(
                                  item: nextUp,
                                ),
                              ),
                            ),
                          ].addInBetween(const SizedBox(
                            height: 8,
                            width: 8,
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          AnimatedAlign(
            duration: animSpeed,
            alignment: portraitMode ? Alignment.topCenter : Alignment.centerLeft,
            child: AnimatedPadding(
              duration: animSpeed,
              padding: EdgeInsets.all(padding).add(show ? MediaQuery.paddingOf(context) : EdgeInsets.zero),
              child: AnimatedFractionallySizedBox(
                duration: animSpeed,
                heightFactor: show ? (portraitMode ? 0.40 : 0.9) : 1.0,
                widthFactor: show ? (portraitMode ? 1 : 0.60) : 1.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (currentItem != null)
                      AnimatedFadeSize(
                        duration: animSpeed,
                        child: show
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              child: Text(currentItem.title,
                                                  style: Theme.of(context).textTheme.displaySmall)),
                                          if (currentItem.label(context) != null)
                                            Flexible(
                                              child: Text(
                                                currentItem.label(context)!,
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton.filledTonal(
                                      onPressed: () => hideNextUp(),
                                      tooltip: "Resume video",
                                      icon: const Icon(IconsaxBold.maximize_4),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    Flexible(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          AnimatedContainer(
                            duration: animSpeed,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(show ? 16 : 0),
                            ),
                            child: widget.video,
                          ),
                          IgnorePointer(
                            ignoring: show,
                            child: AnimatedOpacity(
                              opacity: show ? 0 : 1,
                              duration: animSpeed,
                              child: widget.controls,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IgnorePointer(
                      ignoring: !show,
                      child: AnimatedFadeSize(
                        duration: animSpeed,
                        child: show
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: _SimpleControls(
                                  skip: nextUp != null ? () => onTimeOut() : null,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (AdaptiveLayout.of(context).isDesktop)
            IgnorePointer(
              ignoring: !show,
              child: AnimatedOpacity(
                duration: animSpeed,
                opacity: show ? 1 : 0,
                child: const Align(
                  alignment: Alignment.topRight,
                  child: DefaultTitleBar(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NextUpInformation extends StatelessWidget {
  final ItemBaseModel item;
  const _NextUpInformation({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      MovieModel _ => Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 150),
                    child: AspectRatio(
                      aspectRatio: 0.67,
                      child: Card(
                        child: FladderImage(
                          image: item.images?.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ].addInBetween(
                const SizedBox(height: 8),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localized.overview,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(),
                  Text(item.overview.summary),
                ],
              ),
            )
          ].addInBetween(
            const SizedBox(width: 16),
          ),
        ),
      _ => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (item.label(context) != null)
              Text(
                item.label(context)!,
              ),
            Flexible(
              child: AspectRatio(
                aspectRatio: 2.1,
                child: Card(
                  child: FladderImage(
                    image: item.images?.primary,
                  ),
                ),
              ),
            ),
            Text(
              context.localized.overview,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(item.overview.summary),
            const SizedBox(height: 12)
          ].addInBetween(
            const SizedBox(height: 8),
          ),
        )
    };
  }
}

class _SimpleControls extends ConsumerWidget {
  final Function()? skip;
  const _SimpleControls({
    this.skip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(videoPlayerProvider.select((value) => value.controller?.player));
    final isPlaying = ref.watch(mediaPlaybackProvider.select((value) => value.playing));
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filledTonal(
            onPressed: () => player?.playOrPause(),
            icon: Icon(isPlaying ? IconsaxBold.pause : IconsaxBold.play),
          ),
          if (skip != null)
            IconButton.filledTonal(
              onPressed: skip,
              tooltip: "Play next video",
              icon: const Icon(IconsaxBold.next),
            )
        ].addInBetween(const SizedBox(width: 4)));
  }
}
