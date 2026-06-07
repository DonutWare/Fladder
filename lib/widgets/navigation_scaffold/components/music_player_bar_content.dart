import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:overflow_view/overflow_view.dart';

import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/video_player/components/video_volume_slider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/widgets/navigation_scaffold/components/shared/player_bar_shared.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/theme_overwrite.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class MusicFloatingPlayerBarContent extends ConsumerWidget {
  const MusicFloatingPlayerBarContent({
    super.key,
    required this.constraints,
    required this.item,
    required this.itemActions,
    required this.showExpandButton,
    required this.onShowExpandButton,
    required this.openFullScreenPlayer,
  });

  final BoxConstraints constraints;
  final AudioModel item;
  final List<ItemActionButton> itemActions;
  final bool showExpandButton;
  final ValueChanged<bool> onShowExpandButton;
  final VoidCallback openFullScreenPlayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(mediaPlaybackProvider.select((state) => (
          state: state.state,
          duration: state.duration,
          playing: state.playing,
          shuffleEnabled: state.shuffleEnabled,
          repeatMode: state.repeatMode,
        )));
    final viewSize = AdaptiveLayout.viewSizeOf(context);
    final layoutMode = AdaptiveLayout.layoutModeOf(context);

    final playerVolume = ref.watch(videoPlayerSettingsProvider.select((value) => value.volume));

    final showVolumeSlider = viewSize >= ViewSize.tablet &&
        layoutMode == LayoutMode.dual &&
        AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer;

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
                              if (playbackState.state == VideoPlayerState.minimized)
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: ClickableText(
                                        text: item.name,
                                        style: Theme.of(context).textTheme.titleMedium,
                                        maxLines: 1,
                                        onTap: () => item.navigateTo(context),
                                      ),
                                    ),
                                    if (item.albumArtists.isNotEmpty)
                                      Flexible(
                                        child: ClickableText(
                                            text: item.albumArtists.map((e) => e.name).join(', '),
                                            overflow: TextOverflow.ellipsis,
                                            opacity: 0.65,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color:
                                                      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                                                ),
                                            maxLines: 1,
                                            onTap: () {
                                              final artistModel = item.artistModel;
                                              if (artistModel != null) {
                                                artistModel.navigateTo(context);
                                              }
                                            }),
                                      ),
                                  ],
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
                                Consumer(
                                  builder: (context, ref, _) {
                                    final pos = ref.watch(mediaPlaybackProvider.select((s) => s.position));
                                    return Flexible(
                                      child: Text(
                                        "${pos.readAbleDuration} / ${playbackState.duration.readAbleDuration}",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Theme.of(context).colorScheme.onSurface.withAlpha(125),
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              if (viewSize > ViewSize.phone)
                                IconButton(
                                  onPressed: () => ref.read(videoPlayerProvider).skipToPrevious(),
                                  icon: const Icon(IconsaxPlusBold.previous),
                                ),
                              IconButton.filledTonal(
                                onPressed: () => ref.read(videoPlayerProvider).playOrPause(),
                                iconSize: 32,
                                icon: playbackState.playing
                                    ? const Icon(IconsaxPlusBold.pause)
                                    : const Icon(IconsaxPlusBold.play),
                              ),
                              if (viewSize > ViewSize.phone)
                                IconButton(
                                  onPressed: () => ref.read(videoPlayerProvider).skipToNext(),
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
                                onPressed: () =>
                                    ref.read(videoPlayerProvider).setShuffleEnabled(!playbackState.shuffleEnabled),
                                icon: Icon(
                                  IconsaxPlusBold.shuffle,
                                  color: playbackState.shuffleEnabled
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface.withAlpha(125),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    ref.read(videoPlayerProvider).setAudioRepeatMode(playbackState.repeatMode.next),
                                icon: Icon(
                                  playbackState.repeatMode == AudioRepeatMode.one
                                      ? IconsaxPlusBold.repeate_one
                                      : IconsaxPlusBold.repeate_music,
                                  color: playbackState.repeatMode == AudioRepeatMode.off
                                      ? Theme.of(context).colorScheme.onSurface.withAlpha(125)
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              if (showVolumeSlider)
                                const VideoVolumeSlider()
                              else
                                IconButton(
                                  onPressed: () {
                                    final volume = playerVolume == 0 ? 100.0 : 0.0;
                                    ref.read(videoPlayerProvider).setVolume(volume);
                                  },
                                  icon: Icon(
                                    playerVolume == 0 ? IconsaxPlusBold.volume_cross : IconsaxPlusBold.volume_high,
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
                  onSeek: (pos) async {
                    final player = ref.read(videoPlayerProvider);
                    await player.seek(pos);
                    await Future.delayed(const Duration(milliseconds: 250));
                    if (player.lastState?.playing == true) {
                      player.play();
                    }
                  },
                ),
              ],
            ),
          );
        });
  }
}
