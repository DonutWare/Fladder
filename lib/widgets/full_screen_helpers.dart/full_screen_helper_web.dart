import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/widgets/full_screen_helpers.dart/full_screen_wrapper.dart';

class FullScreenHelper implements FullScreenWrapper {
  const FullScreenHelper._();
  factory FullScreenHelper.instantiate() => const FullScreenHelper._();
  @override
  Future<void> closeFullScreen(WidgetRef ref) async {
    if (html.document.fullscreenElement != null) {
      html.document.exitFullscreen();
      await Future.delayed(const Duration(milliseconds: 500));
      ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: false));
    }
  }

  @override
  Future<void> toggleFullScreen(WidgetRef ref) async {
    final isFullScreen = html.document.fullscreenElement != null;

    if (isFullScreen) {
      html.document.exitFullscreen();
      //Wait for 1 second
      await Future.delayed(const Duration(seconds: 1));
    } else {
      await html.document.documentElement?.requestFullscreen();
    }
    ref
        .read(mediaPlaybackProvider.notifier)
        .update((state) => state.copyWith(fullScreen: html.document.fullscreenElement != null));
  }
}
