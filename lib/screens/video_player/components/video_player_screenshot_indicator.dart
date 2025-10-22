import 'package:fladder/util/localization_helper.dart';
import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/input_handler.dart';

class VideoPlayerScreenshotIndicator extends ConsumerStatefulWidget {
  const VideoPlayerScreenshotIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerScreenshotIndicatorState();
}

class _VideoPlayerScreenshotIndicatorState extends ConsumerState<VideoPlayerScreenshotIndicator> {
  RestartableTimer? timer;

  bool visible = false;
  bool screenshotTaken = false;
  bool isCleanScreenshot = false;

  void onTimerEnd() {
    setState(() {
      visible = false;
    });

    timer?.cancel();
    timer = null;
  }

  void onTakeScreenshot(bool cleanScreenshot) async {
    final result = await ref.read(videoPlayerProvider.notifier).takeScreenshot(withSubtitles: !cleanScreenshot);  // Placeholder

    if (timer == null) {
      timer = RestartableTimer(const Duration(milliseconds: 500), () => onTimerEnd());
    } else {
      timer?.reset();
    }

    setState(() {
      visible = true;
      screenshotTaken = result;
      isCleanScreenshot = cleanScreenshot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputHandler(
      autoFocus: true,
      keyMap: ref.watch(videoPlayerSettingsProvider.select((value) => value.currentShortcuts)),
      keyMapResult: (result) => _onKey(result),
      child: IgnorePointer(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: visible ? 1 : 0,
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
                  spacing: 8.0,
                  children: [
                    const Icon(Icons.image),
                    Text(
                      screenshotTaken
                          ? isCleanScreenshot ? context.localized.screenshotCleanTaken : context.localized.screenshotTaken
                          : context.localized.errorTakingScreenshot,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _onKey(VideoHotKeys value) {
    switch (value) {
      case VideoHotKeys.takeScreenshot:
        takeScreenshot();
        return true;
      case VideoHotKeys.takeScreenshotClean:
        takeScreenshotClean();
        return true;
      default:
        break;
    }
    return false;
  }

  void takeScreenshot() {
    onTakeScreenshot(false);
  }

  void takeScreenshotClean() {
    onTakeScreenshot(true);
  }
}
