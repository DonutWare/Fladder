import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/flat_button.dart';
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
  });

  final EpisodeModel episode;
  final SyncedItem syncedItem;

  @override
  ConsumerState<SyncedEpisodeItem> createState() => _SyncedEpisodeItemState();
}

class _SyncedEpisodeItemState extends ConsumerState<SyncedEpisodeItem> {
  late SyncedItem syncedItem = widget.syncedItem;
  @override
  Widget build(BuildContext context) {
    final downloadTask = ref.watch(downloadTasksProvider(syncedItem.id));
    final hasFile = widget.syncedItem.videoFile.existsSync();

    return IntrinsicHeight(
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.3),
            child: FlatButton(
              onTap: () {
                widget.episode.navigateTo(context);
                return context.maybePop();
              },
              child: SizedBox(
                width: 175,
                child: EpisodePoster(
                  episode: widget.episode,
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
                          widget.episode.seasonEpisodeLabel(context.localized),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!hasFile && downloadTask.hasDownload)
                  Flexible(
                    child: SyncProgressBar(item: syncedItem, task: downloadTask),
                  )
                else
                  Flexible(
                    child: SyncLabel(
                      label:
                          context.localized.totalSize(ref.watch(syncSizeProvider(syncedItem, [])).byteFormat ?? '--'),
                      status: ref.watch(syncDownloadStatusProvider(syncedItem, [])
                          .select((value) => value?.status ?? TaskStatus.notFound)),
                    ),
                  )
              ],
            ),
          ),
          if (!hasFile && !downloadTask.hasDownload)
            IconButtonAwait(
              onPressed: () async => await ref.read(syncProvider.notifier).syncFile(syncedItem, false),
              icon: const Icon(IconsaxPlusLinear.cloud_change),
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
              icon: const Icon(IconsaxPlusLinear.trash),
            )
        ].addInBetween(const SizedBox(width: 16)),
      ),
    );
  }
}
