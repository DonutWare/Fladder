import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/syncing/sync_widgets.dart';
import 'package:fladder/screens/syncing/widgets/sync_options_button.dart';
import 'package:fladder/screens/syncing/widgets/sync_progress_builder.dart';
import 'package:fladder/screens/syncing/widgets/synced_episode_item.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/size_formatting.dart';

class SyncedSeasonPoster extends ConsumerStatefulWidget {
  const SyncedSeasonPoster({
    super.key,
    required this.syncedItem,
    required this.season,
  });

  final SyncedItem syncedItem;
  final SeasonModel season;

  @override
  ConsumerState<SyncedSeasonPoster> createState() => _SyncedSeasonPosterState();
}

class _SyncedSeasonPosterState extends ConsumerState<SyncedSeasonPoster> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    final season = widget.season;
    final nestedChildren = ref.watch(syncedNestedChildrenProvider(widget.syncedItem));
    return nestedChildren.when(
      data: (children) => Builder(
        builder: (context) {
          final syncedItem = widget.syncedItem;
          return ExpansionTile(
            tilePadding: EdgeInsets.zero,
            shape: const Border(),
            title: Row(
              spacing: 12,
              children: [
                SizedBox(
                  width: 75,
                  child: AspectRatio(
                    aspectRatio: 0.65,
                    child: FlatButton(
                      onTap: () {
                        season.navigateTo(context);
                        return context.maybePop();
                      },
                      child: Card(
                        child: FladderImage(
                          image: season.getPosters?.primary ??
                              season.parentImages?.backDrop?.firstOrNull ??
                              season.parentImages?.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: SyncProgressBuilder(
                    item: syncedItem,
                    children: children,
                    builder: (context, combinedStream) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4,
                        children: [
                          Flexible(
                            child: Text(
                              season.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Flexible(
                            child: SyncSubtitle(
                              syncItem: syncedItem,
                              children: children,
                            ),
                          ),
                          Flexible(
                            child: Consumer(
                              builder: (context, ref, child) => SyncLabel(
                                label: context.localized
                                    .totalSize(ref.watch(syncSizeProvider(syncedItem, children))?.byteFormat ?? '--'),
                                status: combinedStream?.status ?? TaskStatus.notFound,
                              ),
                            ),
                          ),
                          if (combinedStream != null && combinedStream.hasDownload == true)
                            SyncProgressBar(item: syncedItem, task: combinedStream)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            trailing: SyncOptionsButton(syncedItem: syncedItem, children: children),
            children: children.map(
              (item) {
                final baseItem = item.itemModel;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SyncedEpisodeItem(
                    episode: baseItem as EpisodeModel,
                    syncedItem: item,
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}
