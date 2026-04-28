import 'package:flutter/material.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/shared/player_bar_shared.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class VideoFloatingPlayerBarContent extends StatelessWidget {
  const VideoFloatingPlayerBarContent({
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
  });

  final BoxConstraints constraints;
  final MediaPlaybackModel playbackInfo;
  final dynamic player;
  final ItemBaseModel? item;
  final List<ItemActionButton> itemActions;
  final bool showExpandButton;
  final ValueChanged<bool> onShowExpandButton;
  final VoidCallback openFullScreenPlayer;
  final Duration lastPosition;
  final VoidCallback onChangeStart;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;
  final VoidCallback onPlayPause;

  @override
  Widget build(BuildContext context) {
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
                  child: FloatingPlayerBarActionsRow(
                    constraints: constraints,
                    playbackInfo: playbackInfo,
                    lastPosition: lastPosition,
                    onPlayPause: onPlayPause,
                    itemActions: itemActions,
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
    );
  }
}
