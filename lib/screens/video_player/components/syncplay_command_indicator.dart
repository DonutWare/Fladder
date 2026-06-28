import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/syncplay/syncplay_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

/// Centered overlay showing SyncPlay command being processed, sync drift
/// correction in progress, or a next-episode-style queue switch.
class SyncPlayCommandIndicator extends ConsumerWidget {
  const SyncPlayCommandIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(isSyncPlayActiveProvider);
    final isProcessing = ref.watch(syncPlayProvider.select((s) => s.isProcessingCommand));
    final commandType = ref.watch(syncPlayProvider.select((s) => s.processingCommandType));
    final strategy = ref.watch(syncCorrectionStrategyProvider);
    final isSwitching = ref.watch(syncPlayStartPlaybackInProgressProvider);

    final hasCorrection = strategy != SyncCorrectionStrategy.none;
    final showCommand = isProcessing && commandType != null;
    final visible = isActive && (showCommand || hasCorrection || isSwitching);

    return IgnorePointer(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: visible ? 1 : 0,
        child: Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: visible ? 1.0 : 0.8,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _CommandIcon(
                    commandType: commandType,
                    strategy: strategy,
                    isSwitching: isSwitching,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _label(context, isSwitching, showCommand, commandType, strategy),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.localized.syncPlaySyncingWithGroup,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _label(
    BuildContext context,
    bool isSwitching,
    bool showCommand,
    SyncPlayCommand? commandType,
    SyncCorrectionStrategy strategy,
  ) {
    if (isSwitching) {
      return context.localized.syncPlaySwitchingItem;
    }
    if (showCommand) {
      return commandType.syncPlayCommandOverlayLabel(context);
    }
    return strategy.label(context);
  }
}

class _CommandIcon extends StatelessWidget {
  final SyncPlayCommand? commandType;
  final SyncCorrectionStrategy strategy;
  final bool isSwitching;

  const _CommandIcon({
    required this.commandType,
    required this.strategy,
    required this.isSwitching,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (IconData icon, Color color) = isSwitching
        ? (IconsaxPlusBold.refresh, scheme.primary)
        : (commandType != null ? commandType.syncPlayCommandIconAndColor(context) : strategy.iconAndColor(context));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 48,
        color: color,
      ),
    );
  }
}
