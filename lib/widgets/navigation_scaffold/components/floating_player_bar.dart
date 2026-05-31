import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/video_player/video_player.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/navigation_scaffold/components/music_player_bar_content.dart';
import 'package:fladder/widgets/navigation_scaffold/components/video_player_bar_content.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

double floatingPlayerHeight(BuildContext context) => switch (AdaptiveLayout.viewSizeOf(context)) {
      ViewSize.phone => 75,
      ViewSize.tablet => 85,
      ViewSize.desktop => 95,
      ViewSize.television => 105,
    };

class FloatingPlayerBar extends ConsumerStatefulWidget {
  const FloatingPlayerBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CurrentlyPlayingBarState();
}

class _CurrentlyPlayingBarState extends ConsumerState<FloatingPlayerBar> {
  bool showExpandButton = false;

  Future<void> openFullScreenPlayer() async {
    setState(() => showExpandButton = false);
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(state: VideoPlayerState.fullScreen));
    final item = ref.read(playBackModel.select((value) => value?.item));
    if (item is AudioModel) {
      if (context.mounted) {
        await context.refreshData();
      }
      return;
    }
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) {
          return const VideoPlayer();
        },
      ),
    );
    if (AdaptiveLayout.of(context).isDesktop || kIsWeb) {
      final fullScreen = await windowManager.isFullScreen();
      if (fullScreen) {
        await windowManager.setFullScreen(false);
      }
    }
    if (context.mounted) {
      await context.refreshData();
    }
  }

  void _setShowExpandButton(bool value) {
    if (showExpandButton != value) {
      setState(() => showExpandButton = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(playBackModel.select((value) => value?.item));
    final isFavourite = item?.userData.isFavourite == true;
    final isDesktop = AdaptiveLayout.of(context).isDesktop;

    final itemActions = [
      ItemActionButton(
          label: Text(context.localized.audio(1)),
          icon: Consumer(
            builder: (context, ref, child) {
              final volume = (ref.watch(videoPlayerProvider).lastState?.volume ?? 0) <= 0;
              return Icon(
                volume ? IconsaxPlusBold.volume_cross : IconsaxPlusBold.volume_high,
              );
            },
          ),
          action: () {
            final player = ref.read(videoPlayerProvider);
            final volume = player.lastState?.volume == 0 ? 100.0 : 0.0;
            player.setVolume(volume);
          }),
      ItemActionButton(
        label: Text(context.localized.stop),
        action: () async => ref.read(videoPlayerProvider).stop(),
        icon: const Icon(IconsaxPlusBold.stop),
      ),
      ItemActionButton(
        label: Text(isFavourite ? context.localized.removeAsFavorite : context.localized.addAsFavorite),
        icon: Icon(
          color: isFavourite ? Colors.red : null,
          isFavourite ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
        ),
        action: () async {
          final result = (await ref.read(userProvider.notifier).setAsFavorite(
                    !isFavourite,
                    item?.id ?? "",
                  ))
              ?.body;

          if (result != null) {
            ref.read(playBackModel.notifier).update((state) => state?.updateUserData(result));
          }
        },
      ),
    ];

    return Padding(
      padding: MediaQuery.paddingOf(context).copyWith(
        top: 0,
        bottom: isDesktop ? 0 : MediaQuery.paddingOf(context).bottom,
      ),
      child: Dismissible(
        key: const Key("CurrentlyPlayingBar"),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.up) {
            await openFullScreenPlayer();
          } else {
            await ref.read(videoPlayerProvider).stop();
          }
          return false;
        },
        direction: DismissDirection.vertical,
        child: InkWell(
          onLongPress: () => FladderSnack.show("Swipe up/down to open/close the player", context: context),
          child: Container(
            height: floatingPlayerHeight(context),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: FladderTheme.defaultShape.borderRadius,
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return switch (item) {
                AudioModel audioItem => MusicFloatingPlayerBarContent(
                    constraints: constraints,
                    item: audioItem,
                    itemActions: itemActions,
                    showExpandButton: showExpandButton,
                    onShowExpandButton: _setShowExpandButton,
                    openFullScreenPlayer: openFullScreenPlayer,
                  ),
                _ => VideoFloatingPlayerBarContent(
                    constraints: constraints,
                    item: item,
                    itemActions: itemActions,
                    showExpandButton: showExpandButton,
                    onShowExpandButton: _setShowExpandButton,
                    openFullScreenPlayer: openFullScreenPlayer,
                  ),
              };
            }),
          ),
        ),
      ),
    );
  }
}
