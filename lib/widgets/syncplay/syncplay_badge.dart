import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/util/localization_helper.dart';

/// Badge widget showing SyncPlay status in the video player
class SyncPlayBadge extends ConsumerWidget {
  const SyncPlayBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(isSyncPlayActiveProvider);

    if (!isActive) return const SizedBox.shrink();

    final groupName = ref.watch(syncPlayGroupNameProvider);
    final groupState = ref.watch(syncPlayGroupStateProvider);
    final isProcessing = ref.watch(syncPlayProvider.select((s) => s.isProcessingCommand));
    final processingCommand = ref.watch(syncPlayProvider.select((s) => s.processingCommandType));

    final (icon, color) = switch (groupState) {
      SyncPlayGroupState.idle => (
          IconsaxPlusLinear.pause_circle,
          Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      SyncPlayGroupState.waiting => (
          IconsaxPlusLinear.timer_1,
          Theme.of(context).colorScheme.tertiary,
        ),
      SyncPlayGroupState.paused => (
          IconsaxPlusLinear.pause,
          Theme.of(context).colorScheme.secondary,
        ),
      SyncPlayGroupState.playing => (
          IconsaxPlusLinear.play,
          Theme.of(context).colorScheme.primary,
        ),
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isProcessing 
            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.95)
            : Theme.of(context).colorScheme.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isProcessing 
              ? Theme.of(context).colorScheme.primary
              : color.withValues(alpha: 0.5),
          width: isProcessing ? 2 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isProcessing) ...[
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              _getProcessingText(context, processingCommand),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ] else ...[
            Icon(
              IconsaxPlusLinear.people,
              size: 14,
              color: color,
            ),
            const SizedBox(width: 6),
            Text(
              groupName ?? context.localized.syncPlay,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              size: 12,
              color: color,
            ),
          ],
        ],
      ),
    );
  }

  String _getProcessingText(BuildContext context, String? command) {
    return switch (command) {
      'Pause' => context.localized.syncPlaySyncingPause,
      'Unpause' => context.localized.syncPlaySyncingPlay,
      'Seek' => context.localized.syncPlaySyncingSeek,
      'Stop' => context.localized.syncPlayStopping,
      _ => context.localized.syncPlaySyncing,
    };
  }
}

/// Compact SyncPlay indicator for tight spaces
class SyncPlayIndicator extends ConsumerWidget {
  const SyncPlayIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(isSyncPlayActiveProvider);

    if (!isActive) return const SizedBox.shrink();

    final groupState = ref.watch(syncPlayGroupStateProvider);
    final isProcessing = ref.watch(syncPlayProvider.select((s) => s.isProcessingCommand));

    final color = switch (groupState) {
      SyncPlayGroupState.idle => Theme.of(context).colorScheme.onSurfaceVariant,
      SyncPlayGroupState.waiting => Theme.of(context).colorScheme.tertiary,
      SyncPlayGroupState.paused => Theme.of(context).colorScheme.secondary,
      SyncPlayGroupState.playing => Theme.of(context).colorScheme.primary,
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isProcessing 
            ? Theme.of(context).colorScheme.primaryContainer
            : color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: isProcessing 
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
      ),
      child: isProcessing
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : Icon(
              IconsaxPlusBold.people,
              size: 16,
              color: color,
            ),
    );
  }
}
