import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/input_handler.dart';
import 'package:fladder/util/localization_helper.dart';

class VideoPlayerScreenshotIndicator extends ConsumerStatefulWidget {
  const VideoPlayerScreenshotIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => VideoPlayerScreenshotIndicatorState();
}

class VideoPlayerScreenshotIndicatorState extends ConsumerState<VideoPlayerScreenshotIndicator> {
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
    bool result;

    if (cleanScreenshot) {
      final playbackModel = ref.watch(playBackModel);
      final player = ref.watch(videoPlayerProvider);
      final selectedSubs = playbackModel?.mediaStreams?.currentSubStream;
      final noSubsModel = await playbackModel?.setSubtitle(SubStreamModel.no(), player);

      ref.read(playBackModel.notifier).update((state) => noSubsModel);

      if (noSubsModel != null) {
        await ref.read(playbackModelHelper).shouldReload(noSubsModel);
      }

      result = await ref.read(videoPlayerProvider.notifier).takeScreenshot();

      final restoredModel = await playbackModel?.setSubtitle(selectedSubs, player);
      ref.read(playBackModel.notifier).update((state) => restoredModel);

      if (restoredModel != null) {
        await ref.read(playbackModelHelper).shouldReload(restoredModel);
      }
    } else {
      result = await ref.read(videoPlayerProvider.notifier).takeScreenshot();
    }

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
    return InputHandler<VideoHotKeys>(
      autoFocus: false,
      listenRawKeyboard: true,
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
                          ? isCleanScreenshot
                              ? context.localized.screenshotCleanTaken
                              : context.localized.screenshotTaken
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

  void takeScreenshot() {
    onTakeScreenshot(false);
  }

  void takeScreenshotClean() {
    onTakeScreenshot(true);
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
        return false;
    }
  }
}
