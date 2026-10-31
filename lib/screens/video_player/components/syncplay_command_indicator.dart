import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/syncplay_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/syncplay/syncplay_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

/// Centre overlay driven by [resolveSyncPlayOverlay], shared with the native Android overlay. Drift
/// corrections are deliberately not shown here: they can fire every couple of seconds ([SyncPlayBadge] only).
class SyncPlayCommandIndicator extends ConsumerWidget {
  const SyncPlayCommandIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(isSyncPlayActiveProvider);
    final overlay = ref.watch(syncPlayProvider.select(resolveSyncPlayOverlay));
    final commandType = ref.watch(syncPlayProvider.select((s) => s.processingCommandType));

    final visible = isActive && overlay != SyncPlayOverlay.none;

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
                  _OverlayIcon(overlay: overlay, commandType: commandType),
                  const SizedBox(height: 12),
                  Text(
                    _label(context, overlay, commandType),
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

  String _label(BuildContext context, SyncPlayOverlay overlay, SyncPlayCommand? commandType) {
    return switch (overlay) {
      SyncPlayOverlay.switching => context.localized.syncPlaySwitchingItem,
      SyncPlayOverlay.command => commandType.syncPlayCommandOverlayLabel(context),
      SyncPlayOverlay.waiting => context.localized.syncPlayStateWaiting,
      SyncPlayOverlay.none => context.localized.syncPlayCommandSyncing,
    };
  }
}

class _OverlayIcon extends StatelessWidget {
  final SyncPlayOverlay overlay;
  final SyncPlayCommand? commandType;

  const _OverlayIcon({
    required this.overlay,
    required this.commandType,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (IconData icon, Color color) = switch (overlay) {
      SyncPlayOverlay.switching => (IconsaxPlusBold.refresh, scheme.primary),
      SyncPlayOverlay.command => commandType.syncPlayCommandIconAndColor(context),
      SyncPlayOverlay.waiting => SyncPlayGroupState.waiting.iconAndColor(context),
      SyncPlayOverlay.none => (IconsaxPlusBold.refresh, scheme.primary),
    };

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
