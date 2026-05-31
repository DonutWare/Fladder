import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overflow_view/overflow_view.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

const videoPlayerHeroTag = "HeroPlayer";

class FloatingPlayerBarPreview extends StatelessWidget {
  const FloatingPlayerBarPreview({
    super.key,
    required this.showExpandButton,
    required this.onShowExpandButton,
    required this.openFullScreenPlayer,
    required this.child,
  });

  final bool showExpandButton;
  final ValueChanged<bool> onShowExpandButton;
  final VoidCallback openFullScreenPlayer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: MouseRegion(
          onEnter: (_) => onShowExpandButton(true),
          onExit: (_) => onShowExpandButton(false),
          child: Stack(
            children: [
              Hero(
                tag: videoPlayerHeroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: child,
                ),
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
                        onTap: openFullScreenPlayer,
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
    );
  }
}

class FloatingPlayerBarTitle extends StatelessWidget {
  const FloatingPlayerBarTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
            ),
          ),
          if (subtitle.isNotEmpty)
            Flexible(
              child: Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                    ),
                maxLines: 1,
              ),
            ),
        ],
      ),
    );
  }
}

class FloatingPlayerBarActionsRow extends StatelessWidget {
  const FloatingPlayerBarActionsRow({
    super.key,
    required this.constraints,
    required this.playbackInfo,
    required this.lastPosition,
    required this.onPlayPause,
    required this.itemActions,
  });

  final BoxConstraints constraints;
  final MediaPlaybackModel playbackInfo;
  final Duration lastPosition;
  final VoidCallback onPlayPause;
  final List<ItemActionButton> itemActions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (constraints.maxWidth > 500)
          Flexible(
            child: Text("${lastPosition.readAbleDuration} / ${playbackInfo.duration.readAbleDuration}"),
          ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton.filledTonal(
              onPressed: onPlayPause,
              icon: playbackInfo.playing ? const Icon(Icons.pause_rounded) : const Icon(Icons.play_arrow_rounded),
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
        )
      ],
    );
  }
}

class FloatingPlayerBarProgress extends ConsumerStatefulWidget {
  const FloatingPlayerBarProgress({
    super.key,
    required this.onSeek,
  });

  final Future<void> Function(Duration) onSeek;

  @override
  ConsumerState<FloatingPlayerBarProgress> createState() => _FloatingPlayerBarProgressState();
}

class _FloatingPlayerBarProgressState extends ConsumerState<FloatingPlayerBarProgress> {
  Duration? _dragPosition;

  @override
  Widget build(BuildContext context) {
    final playback = ref.watch(mediaPlaybackProvider.select((s) => (
          position: s.position,
          duration: s.duration,
        )));
    final position = _dragPosition ?? playback.position;

    return AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer
        ? SizedBox(
            height: 8,
            child: FladderSlider(
              value: position.inMilliseconds.toDouble(),
              min: 0.0,
              max: playback.duration.inMilliseconds.toDouble(),
              thumbWidth: 8,
              onChangeStart: (value) => setState(() => _dragPosition = Duration(milliseconds: value.toInt())),
              onChanged: (value) => setState(() => _dragPosition = Duration(milliseconds: value.toInt())),
              onChangeEnd: (value) async {
                final seekPos = Duration(milliseconds: value.toInt());
                setState(() => _dragPosition = seekPos);
                await widget.onSeek(seekPos);
                if (mounted) setState(() => _dragPosition = null);
              },
            ),
          )
        : LinearProgressIndicator(
            minHeight: 8,
            backgroundColor: Colors.black.withValues(alpha: 0.25),
            color: Theme.of(context).colorScheme.primary,
            value: playback.duration.inMilliseconds > 0
                ? (position.inMilliseconds / playback.duration.inMilliseconds).clamp(0, 1)
                : 0,
          );
  }
}
