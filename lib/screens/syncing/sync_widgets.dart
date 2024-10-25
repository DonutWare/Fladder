import 'package:flutter/material.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/background_download_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';

class SyncLabel extends ConsumerWidget {
  final String? label;
  final SyncStatus status;
  const SyncLabel({this.label, required this.status, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          label ?? status.label(context),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: status.color,
              ),
        ),
      ),
    );
  }
}

class SyncProgressBar extends ConsumerWidget {
  final SyncedItem item;
  final DownloadStream task;
  const SyncProgressBar({required this.item, required this.task, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadStatus = task.status;
    final downloadProgress = task.progress;
    final downloadTask = task.task;
    if (!task.hasDownload) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(downloadStatus.name(context)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: LinearProgressIndicator(
                minHeight: 8,
                value: downloadProgress,
                color: downloadStatus.color(context),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Opacity(opacity: 0.75, child: Text("${(downloadProgress * 100).toStringAsFixed(0)}%")),
            if (downloadTask != null) ...{
              if (downloadStatus != TaskStatus.paused)
                IconButton(
                  onPressed: () => ref.read(backgroundDownloaderProvider).pause(downloadTask),
                  icon: const Icon(IconsaxBold.pause),
                )
            },
            if (downloadStatus == TaskStatus.paused && downloadTask != null) ...[
              IconButton(
                onPressed: () => ref.read(backgroundDownloaderProvider).resume(downloadTask),
                icon: const Icon(IconsaxBold.play),
              ),
              IconButton(
                onPressed: () => ref.read(syncProvider.notifier).deleteFullSyncFiles(item, downloadTask),
                icon: const Icon(IconsaxBold.stop),
              )
            ],
          ].addInBetween(const SizedBox(width: 8)),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}

class SyncSubtitle extends ConsumerWidget {
  final SyncedItem syncItem;
  const SyncSubtitle({
    required this.syncItem,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseItem = ref.read(syncProvider.notifier).getItem(syncItem);
    final children = syncItem.nestedChildren(ref);
    final syncStatus = ref.watch(syncStatusesProvider(syncItem)).value ?? SyncStatus.partially;
    return Container(
      decoration: BoxDecoration(color: syncStatus.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: const Color.fromARGB(0, 208, 130, 130),
        textStyle:
            Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: syncStatus.color),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: switch (baseItem) {
            SeriesModel _ => Builder(
                builder: (context) {
                  final itemBaseModels = children.map((e) => ref.read(syncProvider.notifier).getItem(e));
                  final seriesItemsSyncLeft = children.where((element) => element.taskId != null).length;
                  final seasons = itemBaseModels.whereType<SeasonModel>().length;
                  final episodes = itemBaseModels.whereType<EpisodeModel>().length;
                  return Text(
                    [
                      "${context.localized.season(seasons)}: $seasons",
                      "${context.localized.episode(seasons)}: $episodes | ${context.localized.sync}: ${children.where((element) => element.videoFile.existsSync()).length}${seriesItemsSyncLeft > 0 ? " | Syncing: $seriesItemsSyncLeft" : ""}"
                    ].join('\n'),
                  );
                },
              ),
            _ => Text(syncStatus.label(context)),
          },
        ),
      ),
    );
  }
}
