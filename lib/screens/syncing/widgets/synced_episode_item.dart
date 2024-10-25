import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/media/episode_posters.dart';
import 'package:fladder/screens/syncing/sync_widgets.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/size_formatting.dart';
import 'package:fladder/widgets/shared/icon_button_await.dart';

class SyncedEpisodeItem extends ConsumerStatefulWidget {
  const SyncedEpisodeItem({
    super.key,
    required this.episode,
    required this.syncedItem,
    required this.hasFile,
  });

  final EpisodeModel episode;
  final SyncedItem syncedItem;
  final bool hasFile;

  @override
  ConsumerState<SyncedEpisodeItem> createState() => _SyncedEpisodeItemState();
}

class _SyncedEpisodeItemState extends ConsumerState<SyncedEpisodeItem> {
  late SyncedItem syncedItem = widget.syncedItem;
  @override
  Widget build(BuildContext context) {
    final downloadTask = ref.watch(downloadTasksProvider(syncedItem.id));
    final hasFile = widget.syncedItem.videoFile.existsSync();

    return Row(
      children: [
        IgnorePointer(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.3),
            child: SizedBox(
              width: 250,
              child: EpisodePoster(
                episode: widget.episode,
                syncedItem: syncedItem,
                actions: [],
                showLabel: false,
                isCurrentEpisode: false,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.episode.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Opacity(
                      opacity: 0.75,
                      child: Text(
                        widget.episode.seasonEpisodeLabel(context),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              if (!widget.hasFile && downloadTask.hasDownload)
                Flexible(
                  child: SyncProgressBar(item: syncedItem, task: downloadTask),
                )
              else
                Flexible(
                  child: SyncLabel(
                    label: context.localized.totalSize(ref.watch(syncSizeProvider(syncedItem)).byteFormat ?? '--'),
                    status: ref.watch(syncStatusesProvider(syncedItem)).value ?? SyncStatus.partially,
                  ),
                )
            ],
          ),
        ),
        if (!hasFile && !downloadTask.hasDownload)
          IconButtonAwait(
            onPressed: () async => await ref.read(syncProvider.notifier).syncVideoFile(syncedItem, false),
            icon: const Icon(IconsaxOutline.cloud_change),
          )
        else if (hasFile)
          IconButtonAwait(
            color: Theme.of(context).colorScheme.error,
            onPressed: () async {
              await showDefaultAlertDialog(
                context,
                context.localized.syncRemoveDataTitle,
                context.localized.syncRemoveDataDesc,
                (context) async {
                  await ref.read(syncProvider.notifier).deleteFullSyncFiles(syncedItem, downloadTask.task);
                  Navigator.pop(context);
                },
                context.localized.delete,
                (context) => Navigator.pop(context),
                context.localized.cancel,
              );
            },
            icon: const Icon(IconsaxOutline.trash),
          )
      ].addInBetween(const SizedBox(width: 16)),
    );
  }
}
