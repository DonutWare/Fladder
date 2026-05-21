import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:overflow_view/overflow_view.dart';

import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/widgets/navigation_scaffold/components/shared/player_bar_shared.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/theme_overwrite.dart';

class MusicFloatingPlayerBarContent extends StatelessWidget {
  const MusicFloatingPlayerBarContent({
    super.key,
    required this.constraints,
    required this.playbackInfo,
    required this.player,
    required this.item,
    required this.itemActions,
    required this.showExpandButton,
    required this.onShowExpandButton,
    required this.openFullScreenPlayer,
    required this.lastPosition,
    required this.onChangeStart,
    required this.onChanged,
    required this.onChangeEnd,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
    required this.shuffleEnabled,
    required this.repeatMode,
    required this.onToggleShuffle,
    required this.onCycleRepeatMode,
  });

  final BoxConstraints constraints;
  final MediaPlaybackModel playbackInfo;
  final dynamic player;
  final AudioModel item;
  final List<ItemActionButton> itemActions;
  final bool showExpandButton;
  final ValueChanged<bool> onShowExpandButton;
  final VoidCallback openFullScreenPlayer;
  final Duration lastPosition;
  final VoidCallback onChangeStart;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool shuffleEnabled;
  final AudioRepeatMode repeatMode;
  final VoidCallback onToggleShuffle;
  final VoidCallback onCycleRepeatMode;

  @override
  Widget build(BuildContext context) {
    final viewSize = AdaptiveLayout.viewSizeOf(context);
    return ThemeOverwrite(
        image: item.getPosters?.primary?.imageProvider,
        child: (context) {
          return Container(
            color: Theme.of(context).colorScheme.primary.withAlpha(25),
            child: Column(
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
                        Expanded(
                          child: Row(
                            spacing: 12,
                            children: [
                              if (playbackInfo.state == VideoPlayerState.minimized)
                                FloatingPlayerBarPreview(
                                  showExpandButton: showExpandButton,
                                  onShowExpandButton: onShowExpandButton,
                                  openFullScreenPlayer: openFullScreenPlayer,
                                  child: FladderImage(
                                    image: item.images?.primary,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Flexible(
                                child: FloatingPlayerBarTitle(
                                  title: item.title,
                                  subtitle:
                                      item.artistNames.isNotEmpty ? item.artistNames.join(', ') : item.album ?? "",
                                  onTap: () => item.navigateTo(context),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            spacing: 4,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (viewSize > ViewSize.phone)
                                Flexible(
                                  child: Text(
                                    "${lastPosition.readAbleDuration} / ${playbackInfo.duration.readAbleDuration}",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withAlpha(125),
                                        ),
                                  ),
                                ),
                              if (viewSize > ViewSize.phone)
                                IconButton(
                                  onPressed: onPrevious,
                                  icon: const Icon(IconsaxPlusBold.previous),
                                ),
                              IconButton.filledTonal(
                                onPressed: onPlayPause,
                                iconSize: 32,
                                icon: playbackInfo.playing
                                    ? const Icon(IconsaxPlusBold.pause)
                                    : const Icon(IconsaxPlusBold.play),
                              ),
                              if (viewSize > ViewSize.phone)
                                IconButton(
                                  onPressed: onNext,
                                  icon: const Icon(IconsaxPlusBold.next),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: onToggleShuffle,
                                icon: Icon(
                                  IconsaxPlusBold.shuffle,
                                  color: shuffleEnabled
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface.withAlpha(125),
                                ),
                              ),
                              IconButton(
                                onPressed: onCycleRepeatMode,
                                icon: Icon(
                                  repeatMode == AudioRepeatMode.one
                                      ? IconsaxPlusBold.repeate_one
                                      : IconsaxPlusBold.repeate_music,
                                  color: repeatMode == AudioRepeatMode.off
                                      ? Theme.of(context).colorScheme.onSurface.withAlpha(125)
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Flexible(
                                child: OverflowView.flexible(
                                  builder: (context, remainingItemCount) => PopupMenuButton(
                                    iconColor: Theme.of(context).colorScheme.onSurface.withAlpha(125),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context) => itemActions
                                        .sublist(itemActions.length - remainingItemCount)
                                        .map((e) => e.toPopupMenuItem(useIcons: true))
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
                FloatingPlayerBarProgress(
                  playbackInfo: playbackInfo,
                  lastPosition: lastPosition,
                  onChangeStart: onChangeStart,
                  onChanged: onChanged,
                  onChangeEnd: onChangeEnd,
                ),
              ],
            ),
          );
        });
  }
}
