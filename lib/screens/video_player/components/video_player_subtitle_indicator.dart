import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/subtitle_action_provider.dart';

class VideoPlayerSubtitleIndicator extends ConsumerStatefulWidget {
  const VideoPlayerSubtitleIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerSubtitleIndicatorState();
}

class _VideoPlayerSubtitleIndicatorState extends ConsumerState<VideoPlayerSubtitleIndicator> {
  String currentMessage = '';
  SubtitleAction? currentAction;

  bool showIndicator = false;
  late final timer = RestartableTimer(const Duration(seconds: 1), () {
    setState(() {
      showIndicator = false;
    });
  });

  @override
  void dispose() {
    showIndicator = false;
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      subtitleActionProvider,
      (previous, next) {
        if (next != null) {
          setState(() {
            showIndicator = true;
            currentMessage = next.message;
            currentAction = next.action;
          });
          timer.reset();
        }
      },
    );
    return IgnorePointer(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: showIndicator ? 1 : 0,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Icon(
                    _getIconForAction(currentAction),
                    color: Colors.white,
                  ),
                  Text(
                    currentMessage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForAction(SubtitleAction? action) {
    switch (action) {
      case SubtitleAction.toggle:
        return IconsaxPlusLinear.subtitle;
      case SubtitleAction.nextTrack:
        return IconsaxPlusLinear.next;
      case SubtitleAction.prevTrack:
        return IconsaxPlusLinear.previous;
      case SubtitleAction.offsetIncrease:
      case SubtitleAction.offsetDecrease:
        return IconsaxPlusLinear.clock;
      case SubtitleAction.notSupported:
        return IconsaxPlusLinear.close_circle;
      default:
        return IconsaxPlusLinear.subtitle;
    }
  }
}
