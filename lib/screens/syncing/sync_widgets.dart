import 'package:flutter/material.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/background_download_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/localization_helper.dart';

const _cancellableStatuses = {
  TaskStatus.canceled,
  TaskStatus.failed,
  TaskStatus.enqueued,
  TaskStatus.waitingToRetry,
};

class SyncLabel extends ConsumerWidget {
  final String? label;
  final TaskStatus status;
  const SyncLabel({this.label, required this.status, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: status.color(context).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          label ?? status.name(context),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: status.color(context),
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
    final downloadSpeed = task.downloadSpeed;
    final downloadTask = task.task;

    if (!task.hasDownload) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: [
            Text(downloadStatus.name(context)),
            if (downloadSpeed.isNotEmpty) Opacity(opacity: 0.45, child: Text("($downloadSpeed)")),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Flexible(
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: downloadProgress,
                ),
                builder: (context, value, child) => LinearProgressIndicator(
                  minHeight: 8,
                  value: value,
                  color: downloadStatus.color(context),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Opacity(opacity: 0.75, child: Text("${(downloadProgress * 100).toStringAsFixed(0)}%")),
            if (downloadTask != null) ...{
              if (downloadStatus != TaskStatus.paused && downloadStatus != TaskStatus.enqueued)
                IconButton(
                  onPressed: () => ref.read(backgroundDownloaderProvider).pause(downloadTask),
                  icon: const Icon(IconsaxPlusBold.pause),
                ),
              if (downloadStatus == TaskStatus.paused) ...[
                IconButton(
                  onPressed: () => ref.read(syncProvider.notifier).deleteFullSyncFiles(item, downloadTask),
                  icon: const Icon(IconsaxPlusBold.stop),
                ),
                IconButton(
                  onPressed: () => ref.read(backgroundDownloaderProvider).resume(downloadTask),
                  icon: const Icon(IconsaxPlusBold.play),
                ),
              ],
              if (_cancellableStatuses.contains(downloadStatus)) ...[
                IconButton(
                  onPressed: () => ref.read(syncProvider.notifier).deleteFullSyncFiles(item, downloadTask),
                  icon: const Icon(IconsaxPlusBold.stop),
                ),
              ],
            },
          ],
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}

class SyncSubtitle extends ConsumerWidget {
  final SyncedItem syncItem;
  final List<SyncedItem> children;
  const SyncSubtitle({
    required this.syncItem,
    this.children = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseItem = syncItem.itemModel;
    final syncStatus = ref
        .watch(syncDownloadStatusProvider(syncItem, children).select((value) => value?.status ?? TaskStatus.notFound));
    return Container(
      decoration: BoxDecoration(
          color: syncStatus.color(context).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: const Color.fromARGB(0, 208, 130, 130),
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold, color: syncStatus.color(context)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: switch (baseItem) {
            SeasonModel _ => Builder(
                builder: (context) {
                  final itemBaseModels = children.map((e) => e.itemModel);
                  final episodes = itemBaseModels.whereType<EpisodeModel>().length;
                  return Text(
                    [
                      "${context.localized.episode(2)}: $episodes | ${context.localized.syncStatusSynced}: ${children.where((element) => element.videoFile.existsSync()).length}"
                    ].join('\n'),
                  );
                },
              ),
            SeriesModel _ => Builder(
                builder: (context) {
                  final itemBaseModels = children.map((e) => e.itemModel);
                  final seasons = itemBaseModels.whereType<SeasonModel>().length;
                  final episodes = itemBaseModels.whereType<EpisodeModel>().length;
                  return Text(
                    [
                      "${context.localized.season(2)}: $seasons",
                      "${context.localized.episode(2)}: $episodes | ${context.localized.syncStatusSynced}: ${children.where((element) => element.videoFile.existsSync()).length}"
                    ].join('\n'),
                  );
                },
              ),
            _ => Text(syncStatus.name(context)),
          },
        ),
      ),
    );
  }
}
