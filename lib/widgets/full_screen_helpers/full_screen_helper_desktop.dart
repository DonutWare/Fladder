import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/widgets/full_screen_helpers/full_screen_wrapper.dart';

class FullScreenHelper implements FullScreenWrapper {
  const FullScreenHelper._();
  factory FullScreenHelper.instantiate() => const FullScreenHelper._();
  @override
  Future<void> closeFullScreen(WidgetRef ref) async {
    if (ref.watch(argumentsStateProvider.select((value) => value.htpcMode))) return;
    final isFullScreen = await windowManager.isFullScreen();
    if (isFullScreen) {
      await windowManager.setFullScreen(false);
    }
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: false));
  }

  @override
  Future<void> toggleFullScreen(WidgetRef ref) async {
    if (ref.watch(argumentsStateProvider.select((value) => value.htpcMode))) return;
    final isFullScreen = await windowManager.isFullScreen();
    await windowManager.setFullScreen(!isFullScreen);
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(fullScreen: !isFullScreen));
  }
}
