import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class VideoPlayerBrightnessIndicator extends ConsumerStatefulWidget {
  const VideoPlayerBrightnessIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerBrightnessIndicatorState();
}

class _VideoPlayerBrightnessIndicatorState extends ConsumerState<VideoPlayerBrightnessIndicator> {
  late double currentBrightness =
      ref.read(videoPlayerSettingsProvider.select((value) => value.screenBrightness ?? 1.0));

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
      videoPlayerSettingsProvider.select((value) => value.screenBrightness),
      (previous, next) {
        if (next == null) return;
        setState(() {
          showIndicator = true;
          currentBrightness = next;
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
                  const Icon(
                    IconsaxPlusLinear.sun_1,
                  ),
                  Text(
                    context.localized.brightnessIndicator((currentBrightness * 100).round()),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
