import 'package:flutter/material.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';

class SyncButton extends ConsumerWidget {
  final ItemBaseModel item;
  final SyncedItem syncedItem;
  const SyncButton({required this.item, required this.syncedItem, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nested = ref.watch(syncedNestedChildrenProvider(syncedItem));
    return switch (nested) {
      AsyncValue<List<SyncedItem>>(:final value) => Builder(
          builder: (context) {
            final download = ref.watch(syncDownloadStatusProvider(syncedItem, value ?? []));
            final status = download?.status ?? TaskStatus.notFound;
            final progress = download?.progress ?? 0.0;

            return Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  status == TaskStatus.notFound
                      ? (progress > 0 ? IconsaxPlusLinear.arrow_down_1 : IconsaxPlusLinear.more_circle)
                      : status.icon,
                  color: status.color(context),
                  size: status == TaskStatus.running && progress > 0 ? 16 : null,
                ),
                SizedBox.fromSize(
                  size: const Size.fromRadius(10),
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    strokeWidth: 1.5,
                    color: status.color(context),
                    value: status == TaskStatus.running ? progress.clamp(0.0, 1.0) : 0,
                  ),
                ),
              ],
            );
          },
        ),
    };
  }
}
