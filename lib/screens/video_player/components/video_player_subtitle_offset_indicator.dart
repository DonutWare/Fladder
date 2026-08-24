import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/settings/video_player_settings_provider.dart';

class VideoPlayerSubtitleOffsetIndicator extends ConsumerStatefulWidget {
  const VideoPlayerSubtitleOffsetIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerSubtitleOffsetIndicatorState();
}

class _VideoPlayerSubtitleOffsetIndicatorState extends ConsumerState<VideoPlayerSubtitleOffsetIndicator> {
  late Duration currentOffset = ref.read(subtitleTimingOffsetProvider);

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
      subtitleTimingOffsetProvider,
      (previous, next) {
        if (previous == next) return;
        setState(() {
          showIndicator = true;
          currentOffset = next;
        });
        timer.reset();
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
                  const Icon(IconsaxPlusLinear.textalign_left),
                  Text(_subtitleDelayLabel(currentOffset)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _subtitleDelayLabel(Duration offset) {
  final absMilliseconds = offset.inMilliseconds.abs();
  final sign = offset.inMilliseconds >= 0 ? '+' : '-';
  return 'Subtitle $sign${absMilliseconds}ms';
}
