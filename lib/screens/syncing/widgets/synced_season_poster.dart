import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/syncing/widgets/synced_episode_item.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/widgets/shared/icon_button_await.dart';

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
    final children = ref.read(syncProvider.notifier).getChildren(widget.syncedItem);
    final unSyncedChildren = children.where((child) => child.status == SyncStatus.partially).toList();
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Row(
        spacing: 6,
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
          Column(
            children: [
              Text(
                season.name,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (unSyncedChildren.isNotEmpty)
            IconButtonAwait(
              onPressed: () async {
                for (var i = 0; i < unSyncedChildren.length; i++) {
                  final childSyncedItem = unSyncedChildren[i];
                  await ref.read(syncProvider.notifier).syncFile(childSyncedItem, false);
                }
              },
              icon: const Icon(IconsaxPlusLinear.cloud_change),
            ),
        ],
      ),
      children: children.map(
        (item) {
          final baseItem = ref.read(syncProvider.notifier).getItem(item);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: IntrinsicHeight(
              child: SyncedEpisodeItem(
                episode: baseItem as EpisodeModel,
                syncedItem: item,
                hasFile: item.videoFile.existsSync(),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
