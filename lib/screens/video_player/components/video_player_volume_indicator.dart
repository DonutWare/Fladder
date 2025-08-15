import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class VideoPlayerVolumeIndicator extends ConsumerStatefulWidget {
  const VideoPlayerVolumeIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerVolumeIndicatorState();
}

class _VideoPlayerVolumeIndicatorState extends ConsumerState<VideoPlayerVolumeIndicator> {
  late double currentVolume = ref.read(videoPlayerSettingsProvider.select((value) => value.volume));

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
      videoPlayerSettingsProvider.select((value) => value.volume),
      (previous, next) {
        setState(() {
          showIndicator = true;
          currentVolume = next;
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
                  Icon(
                    volumeIcon(currentVolume),
                  ),
                  Text(context.localized.volumeIndicator(currentVolume.round()))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

IconData volumeIcon(double value) {
  if (value <= 0) {
    return IconsaxPlusLinear.volume_mute;
  }
  if (value < 50) {
    return IconsaxPlusLinear.volume_low_1;
  }
  return IconsaxPlusLinear.volume_high;
}
