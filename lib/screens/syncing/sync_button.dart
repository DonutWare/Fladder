import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';

class SyncButton extends ConsumerStatefulWidget {
  final ItemBaseModel item;
  final SyncedItem? syncedItem;
  const SyncButton({required this.item, required this.syncedItem, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SyncButtonState();
}

class _SyncButtonState extends ConsumerState<SyncButton> {
  @override
  Widget build(BuildContext context) {
    final syncedItem = widget.syncedItem;
    final status = syncedItem != null ? ref.watch(syncStatusesProvider(syncedItem, null)).value : null;
    final progress = syncedItem != null ? ref.watch(syncDownloadStatusProvider(syncedItem, [])) : null;
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          syncedItem != null
              ? status == SyncStatus.partially
                  ? (progress?.progress ?? 0) > 0
                      ? IconsaxPlusLinear.arrow_down
                      : IconsaxPlusLinear.more_circle
                  : IconsaxPlusLinear.tick_circle
              : IconsaxPlusLinear.arrow_down_2,
          color: status?.color,
          size: (progress?.progress ?? 0) > 0 ? 16 : null,
        ),
        if ((progress?.progress ?? 0) > 0)
          IgnorePointer(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(10),
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                strokeWidth: 2,
                color: status?.color,
                value: progress?.progress,
              ),
            ),
          )
      ],
    );
  }
}
