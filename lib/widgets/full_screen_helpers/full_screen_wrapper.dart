import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/widgets/full_screen_helpers/full_screen_helper_desktop.dart'
    if (dart.library.html) 'package:fladder/widgets/full_screen_helpers/full_screen_helper_web.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

final FullScreenHelper fullScreenHelper = FullScreenHelper.instantiate();

abstract class FullScreenWrapper {
  Future<void> closeFullScreen(WidgetRef ref);
  Future<void> toggleFullScreen(WidgetRef ref);
}

class FullScreenButton extends ConsumerWidget {
  const FullScreenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(argumentsStateProvider.select((value) => value.htpcMode))) return const SizedBox.shrink();
    final fullScreen = ref.watch(mediaPlaybackProvider.select((value) => value.fullScreen));
    return IconButton(
      onPressed: () => fullScreenHelper.toggleFullScreen(ref),
      icon: Icon(
        fullScreen ? IconsaxPlusLinear.screenmirroring : IconsaxPlusLinear.maximize_4,
      ),
    );
  }
}
