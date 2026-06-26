import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overflow_view/overflow_view.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/shared/player_bar_shared.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class VideoFloatingPlayerBarContent extends ConsumerWidget {
  const VideoFloatingPlayerBarContent({
    super.key,
    required this.constraints,
    required this.item,
    required this.itemActions,
    required this.showExpandButton,
    required this.onShowExpandButton,
    required this.openFullScreenPlayer,
  });

  final BoxConstraints constraints;
  final ItemBaseModel? item;
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
        )));
    final player = ref.read(videoPlayerProvider);

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
                if (playbackState.state == VideoPlayerState.minimized)
                  FloatingPlayerBarPreview(
                    showExpandButton: showExpandButton,
                    onShowExpandButton: onShowExpandButton,
                    openFullScreenPlayer: openFullScreenPlayer,
                    child: player.videoWidget(
                          const ValueKey("mini_player_video"),
                          BoxFit.fitHeight,
                        ) ??
                        const SizedBox.shrink(),
                  ),
                Expanded(
                  child: FloatingPlayerBarTitle(
                    title: item?.title ?? "",
                    subtitle: item?.detailedName(context.localized) ?? "",
                    onTap: () => item?.navigateTo(context),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (constraints.maxWidth > 500)
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
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IconButton.filledTonal(
                            onPressed: () => ref.read(videoPlayerProvider).playOrPause(),
                            icon: playbackState.playing
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
                                .map((e) => e.toPopupMenuItem(useIcons: true))
                                .toList(),
                          ),
                          children: itemActions.map((e) => e.toButton()).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
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
    );
  }
}
