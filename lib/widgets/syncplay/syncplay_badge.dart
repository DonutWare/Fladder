import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/syncplay/syncplay_extensions.dart';

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

    final (icon, color) = groupState.iconAndColor(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isProcessing
            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.95)
            : Theme.of(context).colorScheme.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isProcessing ? Theme.of(context).colorScheme.primary : color.withValues(alpha: 0.5),
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
              processingCommand.syncPlayProcessingLabel(context),
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

    final color = groupState.color(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isProcessing ? Theme.of(context).colorScheme.primaryContainer : color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: isProcessing ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : null,
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
