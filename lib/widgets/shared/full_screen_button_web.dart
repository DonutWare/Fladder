import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import 'package:fladder/providers/video_player_provider.dart';

Future<void> closeFullScreen() async {
  if (html.document.fullscreenElement != null) {
    html.document.exitFullscreen();
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

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

class FullScreenButton extends ConsumerWidget {
  const FullScreenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullScreen = ref.watch(mediaPlaybackProvider.select((value) => value.fullScreen));
    return IconButton(
      onPressed: () => toggleFullScreen(ref),
      icon: Icon(
        fullScreen ? IconsaxOutline.screenmirroring : IconsaxOutline.maximize_4,
      ),
    );
  }
}
