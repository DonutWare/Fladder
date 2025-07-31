import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/background_download_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';

class SyncOptionsButton extends ConsumerWidget {
  final SyncedItem syncedItem;
  final List<SyncedItem> children;
  const SyncOptionsButton({
    required this.syncedItem,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (context) {
        final unSyncedChildren = children.where((element) {
          final hasDownload = ref.read(syncDownloadStatusProvider(element, []));
          return element.hasVideoFile && !element.videoFile.existsSync() && hasDownload?.status == TaskStatus.notFound;
        }).toList();

        final syncedChildren =
            children.where((element) => element.hasVideoFile && element.videoFile.existsSync()).toList();

        final syncTasks = children
            .map((element) {
              final task = ref.read(syncDownloadStatusProvider(element, []));
              if (task?.status != TaskStatus.notFound) {
                return task;
              } else {
                return null;
              }
            })
            .nonNulls
            .toList();

        final runningTasks = syncTasks.where((element) => element.status == TaskStatus.running).toList();
        final enqueuedTasks = syncTasks.where((element) => element.status == TaskStatus.enqueued).toList();
        final pausedTasks = syncTasks.where((element) => element.status == TaskStatus.paused).toList();
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: Row(
              spacing: 12,
              children: [
                const Icon(IconsaxPlusLinear.arrow_right),
                Text(context.localized.showDetails),
              ],
            ),
            onTap: () {
              syncedItem.itemModel?.navigateTo(context);
              context.maybePop();
            },
          ),
          PopupMenuItem(
            child: Row(
              spacing: 12,
              children: [
                const Icon(IconsaxPlusLinear.refresh_2),
                Text(context.localized.refreshMetadata),
              ],
            ),
            onTap: () => context.refreshData(),
          ),
          if (children.isNotEmpty) ...[
            const PopupMenuDivider(),
            PopupMenuItem(
              enabled: unSyncedChildren.isNotEmpty,
              child: Row(
                spacing: 12,
                children: [
                  const Icon(IconsaxPlusLinear.cloud_add),
                  Text(context.localized.syncAllFiles),
                ],
              ),
              onTap: () async => _syncRemainingItems(context, syncedItem, unSyncedChildren, ref),
            ),
            PopupMenuItem(
              enabled: syncedChildren.isNotEmpty,
              child: Row(
                spacing: 12,
                children: [
                  const Icon(IconsaxPlusLinear.trash),
                  Text(context.localized.syncDeleteAll),
                ],
              ),
              onTap: () async => _deleteSyncedItems(context, syncedItem, syncedChildren, ref),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              enabled: pausedTasks.isNotEmpty,
              child: Row(
                spacing: 12,
                children: [
                  const Icon(IconsaxPlusLinear.play),
                  Text(context.localized.syncResumeAll),
                ],
              ),
              onTap: () => ref
                  .read(backgroundDownloaderProvider)
                  .resumeAll(tasks: pausedTasks.map((e) => e.task).nonNulls.toList()),
            ),
            PopupMenuItem(
              enabled: runningTasks.isNotEmpty,
              child: Row(
                spacing: 12,
                children: [
                  const Icon(IconsaxPlusLinear.pause),
                  Text(context.localized.syncPauseAll),
                ],
              ),
              onTap: () {
                ref
                    .read(backgroundDownloaderProvider)
                    .pauseAll(tasks: runningTasks.map((e) => e.task).nonNulls.toList());
              },
            ),
            PopupMenuItem(
              enabled: [...runningTasks, ...pausedTasks, ...enqueuedTasks].isNotEmpty,
              child: Row(
                spacing: 12,
                children: [
                  const Icon(IconsaxPlusLinear.stop),
                  Text(context.localized.syncStopAll),
                ],
              ),
              onTap: () {
                ref.read(backgroundDownloaderProvider).cancelAll(
                    tasks: [...runningTasks, ...pausedTasks, ...enqueuedTasks].map((e) => e.task).nonNulls.toList());
              },
            ),
          ]
        ];
      },
    );
  }
}

Future<dynamic> _deleteSyncedItems(
    BuildContext context, SyncedItem syncedItem, List<SyncedItem> syncedChildren, WidgetRef ref) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(context.localized.syncDeleteAllItemsTitle(syncedItem.itemModel?.name ?? "")),
      content: Text(
        context.localized.syncDeleteAllItemsDesc(syncedItem.itemModel?.name ?? "", syncedChildren.length),
      ),
      scrollable: true,
      actions: [
        ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.cancel)),
        FilledButtonAwait(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            iconColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
          onPressed: () async {
            final deleteList = syncedChildren.map((e) => ref.read(syncProvider.notifier).deleteFullSyncFiles(e, null));
            await Future.wait(deleteList);
            Navigator.of(context).pop();
          },
          child: Text(
            context.localized.delete,
          ),
        )
      ],
    ),
  );
}

Future<dynamic> _syncRemainingItems(
    BuildContext context, SyncedItem syncedItem, List<SyncedItem> unSyncedChildren, WidgetRef ref) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(context.localized.syncAllItemsTitle(syncedItem.itemModel?.name ?? "")),
      content: Text(
        context.localized.syncAllItemsDesc(
          syncedItem.itemModel?.name ?? "",
          unSyncedChildren.length,
        ),
      ),
      scrollable: true,
      actions: [
        ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.cancel)),
        FilledButtonAwait(
          onPressed: () async {
            final syncList = unSyncedChildren.map((e) => ref.read(syncProvider.notifier).syncFile(e, false));
            await Future.wait(syncList);
            Navigator.of(context).pop();
          },
          child: Text(
            context.localized.sync,
          ),
        )
      ],
    ),
  );
}
