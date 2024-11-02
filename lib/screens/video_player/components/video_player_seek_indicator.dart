import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/input_handler.dart';
import 'package:fladder/util/localization_helper.dart';

class VideoPlayerSeekIndicator extends ConsumerStatefulWidget {
  const VideoPlayerSeekIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerSeekIndicatorState();
}

class _VideoPlayerSeekIndicatorState extends ConsumerState<VideoPlayerSeekIndicator> {
  RestartableTimer? timer;

  bool visible = false;
  int seekPosition = 0;

  void onSeekEnd() {
    setState(() {
      visible = false;
    });
    timer?.cancel();
    timer = null;
    if (seekPosition == 0) return;
    final mediaPlayback = ref.read(mediaPlaybackProvider);
    final newPosition = (mediaPlayback.position.inSeconds + seekPosition).clamp(0, mediaPlayback.duration.inSeconds);
    ref.read(videoPlayerProvider).seek(Duration(seconds: newPosition));
  }

  void onSeekStart(int value) {
    if (timer == null) {
      timer = RestartableTimer(const Duration(milliseconds: 500), () => onSeekEnd());
      setState(() {
        seekPosition = 0;
      });
    } else {
      timer?.reset();
    }
    setState(() {
      visible = true;
      seekPosition += value;
    });
  }

  bool _onKey(KeyEvent value) {
    if (value is KeyRepeatEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
        seekBack();
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
        seekForward();
        return true;
      }
    }
    if (value is KeyDownEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
        seekBack();
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
        seekForward();
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return InputHandler(
      autoFocus: true,
      onKeyEvent: (node, event) => _onKey(event) ? KeyEventResult.handled : KeyEventResult.ignored,
      child: IgnorePointer(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: (visible && seekPosition != 0) ? 1 : 0,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      seekPosition > 0
                          ? "+$seekPosition ${context.localized.seconds(seekPosition)}"
                          : "$seekPosition ${context.localized.seconds(seekPosition)}",
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

  void seekBack({int seconds = -10}) => onSeekStart(seconds);
  void seekForward({int seconds = 30}) => onSeekStart(seconds);
}
