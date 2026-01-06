import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';

class SyncStatusOverlay extends ConsumerWidget {
  final SyncedItem syncedItem;
  final Widget child;
  const SyncStatusOverlay({required this.syncedItem, required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        if (syncedItem.markedForDelete)
          Positioned.fill(
            child: Card(
              elevation: 0,
              semanticContainer: false,
              color: Colors.black.withValues(alpha: 0.6),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round,
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.error),
                  ),
                  Text(context.localized.syncOverlayDeleting),
                  const Icon(IconsaxPlusLinear.trash)
                ].addPadding(const EdgeInsets.symmetric(horizontal: 16)),
              ),
            ),
          ),
        if (syncedItem.syncing)
          Positioned.fill(
            child: IgnorePointer(
              child: Card(
                elevation: 0,
                semanticContainer: false,
                color: Colors.black.withValues(alpha: 0.6),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(
                      strokeCap: StrokeCap.round,
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.error),
                    ),
                    Text(context.localized.syncOverlaySyncing),
                    const Icon(IconsaxPlusLinear.cloud_notif)
                  ].addPadding(const EdgeInsets.symmetric(horizontal: 16)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
