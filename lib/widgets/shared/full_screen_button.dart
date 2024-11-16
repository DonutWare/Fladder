import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/providers/video_player_provider.dart';

Future<void> closeFullScreen() async {
  final isFullScreen = await windowManager.isFullScreen();
  if (isFullScreen) {
    await windowManager.setFullScreen(false);
  }
}

Future<void> toggleFullScreen(WidgetRef ref) async {
  final isFullScreen = await windowManager.isFullScreen();
  await windowManager.setFullScreen(!isFullScreen);
  ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: !isFullScreen));
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
