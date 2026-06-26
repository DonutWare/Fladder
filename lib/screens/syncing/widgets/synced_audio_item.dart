import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/syncing/sync_widgets.dart';
import 'package:fladder/screens/syncing/widgets/sync_file_button.dart';
import 'package:fladder/screens/syncing/widgets/sync_item_poster.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/size_formatting.dart';
import 'package:fladder/widgets/shared/icon_button_await.dart';

class SyncedAudioItem extends ConsumerStatefulWidget {
  const SyncedAudioItem({
    required this.audio,
    required this.syncedItem,
    this.playlistMode = false,
    super.key,
  });

  final AudioModel audio;
  final SyncedItem syncedItem;
  final bool playlistMode;

  @override
  ConsumerState<SyncedAudioItem> createState() => _SyncedAudioItemState();
}

class _SyncedAudioItemState extends ConsumerState<SyncedAudioItem> {
  late SyncedItem syncedItem = widget.syncedItem;
  SyncedItem? parentAlbumItem;

  @override
  void initState() {
    super.initState();
    _resolveParentAlbumItem();
  }

  @override
  void didUpdateWidget(covariant SyncedAudioItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.syncedItem.id != widget.syncedItem.id || oldWidget.playlistMode != widget.playlistMode) {
      syncedItem = widget.syncedItem;
      parentAlbumItem = null;
      _resolveParentAlbumItem();
    }
  }

  Future<void> _resolveParentAlbumItem() async {
    if (!widget.playlistMode) {
      return;
    }
    final parent = await ref.read(syncProvider.notifier).getParentItem(widget.syncedItem.id);
    if (!mounted) {
      return;
    }
    if (parent?.itemModel is AlbumModel) {
      setState(() {
        parentAlbumItem = parent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncedItem = ref.watch(syncedItemProvider(widget.syncedItem.itemModel));

    Widget buildWidget(SyncedItem syncedItem) {
      final downloadTask = ref.watch(downloadTasksProvider(syncedItem.id));
      final hasFile = syncedItem.videoFile.existsSync();
      final artistLabel = widget.audio.artistsLabel;
      final trackLabel = widget.audio.trackLabel(context, widget.audio.trackNumber);
      final albumLabel = widget.audio.albumLabel();
      final coverImage = widget.audio.getPosters?.primary ??
          widget.audio.getPosters?.backDrop?.firstOrNull ??
          parentAlbumItem?.itemModel?.getPosters?.primary ??
          parentAlbumItem?.itemModel?.getPosters?.backDrop?.firstOrNull;

      return IntrinsicHeight(
        child: Row(
          children: [
            SyncItemPoster(
              item: syncedItem,
              child: FlatButton(
                onTap: () {
                  widget.audio.navigateTo(context);
                  return context.maybePop();
                },
                child: SizedBox(
                  width: 64,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      child: FladderImage(
                        image: coverImage,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                        Flexible(
                          child: Text(
                            widget.audio.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Flexible(
                          child: Opacity(
                            opacity: 0.75,
                            child: Text(
                              [
                                if (trackLabel.isNotEmpty) trackLabel,
                                if (artistLabel.isNotEmpty) artistLabel,
                                if (albumLabel.isNotEmpty) albumLabel,
                              ].join(' • '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
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
                    ),
                ],
              ),
            ),
            if (!hasFile && !downloadTask.hasDownload)
              SyncFileButton(syncedItem: syncedItem)
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
              ),
          ].addInBetween(const SizedBox(width: 16)),
        ),
      );
    }

    return switch (syncedItem) {
      AsyncData(:final asData) => buildWidget(asData?.value ?? widget.syncedItem),
      _ => const SizedBox.shrink(),
    };
  }
}
