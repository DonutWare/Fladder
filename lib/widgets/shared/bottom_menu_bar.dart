import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/navigation_scaffold/components/floating_player_bar.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class BottomMenuBar extends ConsumerWidget {
  final List<ItemAction> actions;
  final FloatingActionButton? fabAction;
  final bool combined;
  final bool extended;
  final bool sticky;
  const BottomMenuBar({
    super.key,
    required this.actions,
    this.fabAction,
    this.combined = false,
    this.extended = true,
    this.sticky = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final playerState = ref.watch(mediaPlaybackProvider.select((value) => value.state));

    final alignment =
        AdaptiveLayout.of(context).viewSize <= ViewSize.phone ? MainAxisAlignment.center : MainAxisAlignment.end;

    final bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;

    final showPlayerBar = playerState == VideoPlayerState.minimized;

    final calculatedBottomViewPadding =
        showPlayerBar ? floatingPlayerHeight(context) + bottomViewPadding : bottomViewPadding;

    final actionButton = fabAction != null
        ? Theme(
            data: theme.copyWith(
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                elevation: 0,
                shape: FladderTheme.largeShape,
              ),
            ),
            child: fabAction!,
          )
        : null;

    return Padding(
      padding: const EdgeInsets.all(16).add(AdaptiveLayout.adaptivePadding(context)).add(
            EdgeInsets.only(bottom: calculatedBottomViewPadding),
          ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: alignment,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 6,
          children: [
            Flexible(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: !combined && !(extended || sticky) ? 0.0 : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: sticky ? theme.colorScheme.primaryContainer : theme.colorScheme.surface,
                    borderRadius: FladderTheme.largeShape.borderRadius,
                    border: Border.all(
                      color: theme.colorScheme.primary.withAlpha(sticky ? 255 : 0),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: AnimatedFadeSize(
                            duration: const Duration(milliseconds: 250),
                            alignment: Alignment.centerRight,
                            child: extended || sticky
                                ? Row(
                                    children: [...actions.reversed.map((e) => e.toButton())],
                                  )
                                : const SizedBox.shrink(key: ValueKey('empty')),
                          ),
                        ),
                      ),
                      if (actionButton != null && combined)
                        SizedBox.square(
                          dimension: 48,
                          child: actionButton,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (actionButton != null && !combined)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: actionButton,
              ),
          ],
        ),
      ),
    );
  }
}
