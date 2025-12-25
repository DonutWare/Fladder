import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:overflow_view/overflow_view.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/video_player/video_player.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

const videoPlayerHeroTag = "HeroPlayer";

double floatingPlayerHeight(BuildContext context) => switch (AdaptiveLayout.viewSizeOf(context)) {
      ViewSize.phone => 75,
      ViewSize.tablet => 85,
      ViewSize.desktop => 95,
      ViewSize.television => 105,
    };

class FloatingPlayerBar extends ConsumerStatefulWidget {
  const FloatingPlayerBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CurrentlyPlayingBarState();
}

class _CurrentlyPlayingBarState extends ConsumerState<FloatingPlayerBar> {
  bool showExpandButton = false;
  bool changingSliderValue = false;
  Duration lastPosition = Duration.zero;

  Future<void> openFullScreenPlayer() async {
    setState(() => showExpandButton = false);
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(state: VideoPlayerState.fullScreen));
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const VideoPlayer(),
      ),
    );
    if (AdaptiveLayout.of(context).isDesktop || kIsWeb) {
      final fullScreen = await windowManager.isFullScreen();
      if (fullScreen) {
        await windowManager.setFullScreen(false);
      }
    }
    if (context.mounted) {
      await context.refreshData();
    }
  }

  Future<void> stopPlayer() async => ref.read(videoPlayerProvider).stop();

  @override
  Widget build(BuildContext context) {
    final playbackInfo = ref.watch(mediaPlaybackProvider);
    final player = ref.watch(videoPlayerProvider);
    final item = ref.watch(playBackModel.select((value) => value?.item));
    if (!changingSliderValue) {
      lastPosition = playbackInfo.position;
    }

    var isFavourite = item?.userData.isFavourite == true;

    final isDesktop = AdaptiveLayout.of(context).isDesktop;

    final itemActions = [
      ItemActionButton(
          label: Text(context.localized.audio(1)),
          icon: Consumer(
            builder: (context, ref, child) {
              var volume = (player.lastState?.volume ?? 0) <= 0;
              return Icon(
                volume ? IconsaxPlusBold.volume_cross : IconsaxPlusBold.volume_high,
              );
            },
          ),
          action: () {
            final volume = player.lastState?.volume == 0 ? 100.0 : 0.0;
            player.setVolume(volume);
          }),
      ItemActionButton(
        label: Text(context.localized.stop),
        action: () async => stopPlayer(),
        icon: const Icon(IconsaxPlusBold.stop),
      ),
      ItemActionButton(
        label: Text(isFavourite ? context.localized.removeAsFavorite : context.localized.addAsFavorite),
        icon: Icon(
          color: isFavourite ? Colors.red : null,
          isFavourite ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
        ),
        action: () async {
          final result = (await ref.read(userProvider.notifier).setAsFavorite(
                    !isFavourite,
                    item?.id ?? "",
                  ))
              ?.body;

          if (result != null) {
            ref.read(playBackModel.notifier).update((state) => state?.updateUserData(result));
          }
        },
      ),
    ];
    return Padding(
      padding:
          MediaQuery.paddingOf(context).copyWith(top: 0, bottom: isDesktop ? 0 : MediaQuery.paddingOf(context).bottom),
      child: Dismissible(
        key: const Key("CurrentlyPlayingBar"),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.up) {
            await openFullScreenPlayer();
          } else {
            await stopPlayer();
          }
          return false;
        },
        direction: DismissDirection.vertical,
        child: InkWell(
          onLongPress: () => fladderSnackbar(context, title: "Swipe up/down to open/close the player"),
          child: Card(
            elevation: 5,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: SizedBox(
              height: floatingPlayerHeight(context),
              child: LayoutBuilder(builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          spacing: 12,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (playbackInfo.state == VideoPlayerState.minimized)
                              Card(
                                child: AspectRatio(
                                  aspectRatio: 1.67,
                                  child: MouseRegion(
                                    onEnter: (event) => setState(() => showExpandButton = true),
                                    onExit: (event) => setState(() => showExpandButton = false),
                                    child: Stack(
                                      children: [
                                        Hero(
                                          tag: videoPlayerHeroTag,
                                          child: player.videoWidget(
                                                UniqueKey(),
                                                BoxFit.fitHeight,
                                              ) ??
                                              const SizedBox.shrink(),
                                        ),
                                        Positioned.fill(
                                          child: Tooltip(
                                            message: "Expand player",
                                            waitDuration: const Duration(milliseconds: 500),
                                            child: AnimatedOpacity(
                                              opacity: showExpandButton ? 1 : 0,
                                              duration: const Duration(milliseconds: 125),
                                              child: Container(
                                                color: Colors.black.withValues(alpha: 0.6),
                                                child: FlatButton(
                                                  onTap: () async => openFullScreenPlayer(),
                                                  child: const Icon(Icons.keyboard_arrow_up_rounded),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: InkWell(
                                onTap: () => item?.navigateTo(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        item?.title ?? "",
                                        style: Theme.of(context).textTheme.titleMedium,
                                        maxLines: 1,
                                      ),
                                    ),
                                    if (item?.detailedName(context)?.isNotEmpty == true)
                                      Flexible(
                                        child: Text(
                                          item?.detailedName(context) ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                                              ),
                                          maxLines: 1,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (constraints.maxWidth > 500)
                                    Flexible(
                                      child: Text(
                                          "${lastPosition.readAbleDuration} / ${playbackInfo.duration.readAbleDuration}"),
                                    ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: IconButton.filledTonal(
                                        onPressed: () => ref.read(videoPlayerProvider).playOrPause(),
                                        icon: playbackInfo.playing
                                            ? const Icon(Icons.pause_rounded)
                                            : const Icon(Icons.play_arrow_rounded),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: OverflowView.flexible(
                                      builder: (context, remainingItemCount) => PopupMenuButton(
                                        iconColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context) => itemActions
                                            .sublist(itemActions.length - remainingItemCount)
                                            .map(
                                              (e) => e.toPopupMenuItem(useIcons: true),
                                            )
                                            .toList(),
                                      ),
                                      children: itemActions.map((e) => e.toButton()).toList(),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer
                        ? SizedBox(
                            height: 8,
                            child: FladderSlider(
                              value: lastPosition.inMilliseconds.toDouble(),
                              min: 0.0,
                              max: playbackInfo.duration.inMilliseconds.toDouble(),
                              thumbWidth: 8,
                              onChangeStart: (value) {
                                setState(() {
                                  changingSliderValue = true;
                                });
                              },
                              onChangeEnd: (value) async {
                                await player.seek(Duration(milliseconds: value ~/ 1));
                                await Future.delayed(const Duration(milliseconds: 250));
                                if (player.lastState?.playing == true) {
                                  player.play();
                                }
                                setState(() {
                                  lastPosition = Duration(milliseconds: value.toInt());
                                  changingSliderValue = false;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  lastPosition = Duration(milliseconds: value.toInt());
                                });
                              },
                            ),
                          )
                        : LinearProgressIndicator(
                            minHeight: 8,
                            backgroundColor: Colors.black.withValues(alpha: 0.25),
                            color: Theme.of(context).colorScheme.primary,
                            value: (playbackInfo.position.inMilliseconds / playbackInfo.duration.inMilliseconds)
                                .clamp(0, 1),
                          )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
