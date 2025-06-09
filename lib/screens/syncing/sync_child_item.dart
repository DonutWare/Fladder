import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/syncing/widgets/synced_season_poster.dart';

import 'widgets/synced_episode_item.dart';

class ChildSyncWidget extends ConsumerStatefulWidget {
  final SyncedItem syncedChild;
  const ChildSyncWidget({
    required this.syncedChild,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChildSyncWidgetState();
}

class _ChildSyncWidgetState extends ConsumerState<ChildSyncWidget> {
  late SyncedItem syncedItem = widget.syncedChild;

  @override
  Widget build(BuildContext context) {
    final baseItem = ref.read(syncProvider.notifier).getItem(syncedItem);
    final hasFile = syncedItem.videoFile.existsSync();
    if (baseItem == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                child: switch (baseItem) {
                  SeasonModel season => SyncedSeasonPoster(
                      syncedItem: syncedItem,
                      season: season,
                    ),
                  EpisodeModel episode => SyncedEpisodeItem(
                      episode: episode,
                      syncedItem: syncedItem,
                      hasFile: hasFile,
                    ),
                  _ => Container(),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
