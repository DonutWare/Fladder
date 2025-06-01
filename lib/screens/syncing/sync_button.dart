import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/syncing/sync_item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final status = syncedItem != null ? ref.watch(syncStatusesProvider(syncedItem)).value : null;
    final progress = syncedItem != null ? ref.watch(syncDownloadStatusProvider(syncedItem)) : null;
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: syncedItem != null
              ? () => showSyncItemDetails(context, syncedItem, ref)
              : () => showDefaultActionDialog(
                    context,
                    'Sync ${widget.item.detailedName}?',
                    null,
                    (context) async {
                      await ref.read(syncProvider.notifier).addSyncItem(context, widget.item);
                      Navigator.of(context).pop();
                    },
                    "Sync",
                    (context) => Navigator.of(context).pop(),
                    "Cancel",
                  ),
          child: Icon(
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
