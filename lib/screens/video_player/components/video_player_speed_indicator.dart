import 'dart:math';

import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class VideoPlayerSpeedIndicator extends ConsumerStatefulWidget {
  const VideoPlayerSpeedIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerSpeedIndicatorState();
}

class _VideoPlayerSpeedIndicatorState extends ConsumerState<VideoPlayerSpeedIndicator> {
  late double currentSpeed = ref.read(playbackRateProvider);

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
      playbackRateProvider,
      (previous, next) {
        setState(() {
          showIndicator = true;
          currentSpeed = next;
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
                  Transform.rotate(
                    angle: currentSpeed < 1 ? pi : 0,
                    child: Icon(speedIcon(currentSpeed)),
                  ),
                  Text(context.localized.speedIndicator(currentSpeed)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

IconData speedIcon(double value) {
  if (value < 1) {
    return IconsaxPlusBroken.flash;
  }
  if (value == 1) {
    return IconsaxPlusLinear.flash_slash;
  }
  return IconsaxPlusLinear.flash;
}
