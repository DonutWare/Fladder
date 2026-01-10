import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';

/// Badge widget showing SyncPlay status in the video player
class SyncPlayBadge extends ConsumerWidget {
  const SyncPlayBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(isSyncPlayActiveProvider);

    if (!isActive) return const SizedBox.shrink();

    final groupName = ref.watch(syncPlayGroupNameProvider);
    final groupState = ref.watch(syncPlayGroupStateProvider);

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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            IconsaxPlusLinear.people,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            groupName ?? 'SyncPlay',
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
      ),
    );
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

    final color = switch (groupState) {
      SyncPlayGroupState.idle => Theme.of(context).colorScheme.onSurfaceVariant,
      SyncPlayGroupState.waiting => Theme.of(context).colorScheme.tertiary,
      SyncPlayGroupState.paused => Theme.of(context).colorScheme.secondary,
      SyncPlayGroupState.playing => Theme.of(context).colorScheme.primary,
    };

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        IconsaxPlusBold.people,
        size: 16,
        color: color,
      ),
    );
  }
}
