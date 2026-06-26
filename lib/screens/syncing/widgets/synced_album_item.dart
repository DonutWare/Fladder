import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/syncing/sync_widgets.dart';
import 'package:fladder/screens/syncing/widgets/sync_options_button.dart';
import 'package:fladder/screens/syncing/widgets/sync_progress_builder.dart';
import 'package:fladder/screens/syncing/widgets/synced_audio_item.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/size_formatting.dart';

class SyncedAlbumItem extends ConsumerStatefulWidget {
  const SyncedAlbumItem({
    required this.syncedItem,
    required this.album,
    super.key,
  });

  final SyncedItem syncedItem;
  final AlbumModel album;

  @override
  ConsumerState<SyncedAlbumItem> createState() => _SyncedAlbumItemState();
}

class _SyncedAlbumItemState extends ConsumerState<SyncedAlbumItem> {
  @override
  Widget build(BuildContext context) {
    final childrenAsync = ref.watch(syncedChildrenProvider(widget.syncedItem));

    Widget buildWidget(List<SyncedItem> children, bool loading) {
      final trackChildren = children.where((item) => item.itemModel is AudioModel).toList();
      final album = widget.album;
      final syncedItem = widget.syncedItem;
      return ExpansionTile(
        tilePadding: EdgeInsets.zero,
        shape: const Border(),
        title: Row(
          spacing: 12,
          children: [
            SizedBox(
              width: 125,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: FlatButton(
                  onTap: () {
                    album.navigateTo(context);
                    return context.maybePop();
                  },
                  child: Card(
                    child: FladderImage(
                      image: album.getPosters?.primary ?? album.getPosters?.backDrop?.firstOrNull,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: SyncProgressBuilder(
                item: syncedItem,
                children: trackChildren,
                builder: (context, combinedStream) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      Flexible(
                        child: Text(
                          album.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      if (album.artistLabel.isNotEmpty)
                        Flexible(
                          child: Opacity(
                            opacity: 0.75,
                            child: Text(
                              album.artistLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      Flexible(
                        child: SyncSubtitle(
                          syncItem: syncedItem,
                          children: trackChildren,
                        ),
                      ),
                      Flexible(
                        child: Consumer(
                          builder: (context, ref, child) => SyncLabel(
                            label: context.localized
                                .totalSize(ref.watch(syncSizeProvider(syncedItem, trackChildren))?.byteFormat ?? '--'),
                            status: combinedStream?.status ?? TaskStatus.notFound,
                          ),
                        ),
                      ),
                      if (combinedStream != null && combinedStream.hasDownload)
                        SyncProgressBar(item: syncedItem, task: combinedStream),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        trailing: loading
            ? const CircularProgressIndicator()
            : SyncOptionsButton(syncedItem: syncedItem, children: trackChildren),
        children: trackChildren
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SyncedAudioItem(
                  audio: item.itemModel as AudioModel,
                  syncedItem: item,
                ),
              ),
            )
            .toList(),
      );
    }

    return switch (childrenAsync) {
      AsyncData(:final asData) => buildWidget(asData?.value ?? [], false),
      _ => buildWidget([], true),
    };
  }
}
