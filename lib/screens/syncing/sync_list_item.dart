import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/syncing/sync_item_details.dart';
import 'package:fladder/screens/syncing/sync_widgets.dart';
import 'package:fladder/screens/syncing/widgets/sync_progress_builder.dart';
import 'package:fladder/screens/syncing/widgets/sync_status_overlay.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/size_formatting.dart';

class SyncListItem extends ConsumerStatefulWidget {
  final SyncedItem syncedItem;
  const SyncListItem({required this.syncedItem, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SyncListItemState();
}

class SyncListItemState extends ConsumerState<SyncListItem> {
  @override
  Widget build(BuildContext context) {
    final syncedItem = widget.syncedItem;
    final baseItem = ref.read(syncProvider.notifier).getItem(syncedItem);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SyncStatusOverlay(
        syncedItem: syncedItem,
        child: Card(
          elevation: 1,
          color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.2),
          shadowColor: Colors.transparent,
          child: Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.errorContainer,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [Icon(IconsaxBold.trash)],
                ),
              ),
            ),
            key: Key(syncedItem.id),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (direction) async {
              await showDefaultAlertDialog(
                  context,
                  context.localized.deleteItem(baseItem?.detailedName(context) ?? ""),
                  context.localized.syncDeletePopupPermanent,
                  (context) async {
                    ref.read(syncProvider.notifier).removeSync(context, syncedItem);
                    Navigator.of(context).pop();
                    return true;
                  },
                  context.localized.delete,
                  (context) async {
                    Navigator.of(context).pop();
                  },
                  context.localized.cancel);
              return false;
            },
            child: LayoutBuilder(builder: (context, constraints) {
              return IntrinsicHeight(
                child: InkWell(
                  onTap: () => baseItem?.navigateTo(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 125, maxWidth: constraints.maxWidth * 0.2),
                          child: Card(
                            child: AspectRatio(
                                aspectRatio: baseItem?.primaryRatio ?? 1.0,
                                child: FladderImage(
                                  image: baseItem?.getPosters?.primary,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Expanded(
                          child: SyncProgressBuilder(
                            item: syncedItem,
                            builder: (context, combinedStream) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      baseItem?.detailedName(context) ?? "",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  Flexible(
                                    child: SyncSubtitle(syncItem: syncedItem),
                                  ),
                                  Flexible(
                                    child: SyncLabel(
                                      label: context.localized
                                          .totalSize(ref.watch(syncSizeProvider(syncedItem)).byteFormat ?? '--'),
                                      status: ref.watch(syncStatusesProvider(syncedItem)).value ?? SyncStatus.partially,
                                    ),
                                  ),
                                  if (combinedStream != null && combinedStream.hasDownload == true)
                                    SyncProgressBar(item: syncedItem, task: combinedStream)
                                ].addInBetween(const SizedBox(height: 4)),
                              );
                            },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  child: Text(baseItem != null ? baseItem.type.label(context) : ""),
                                )),
                            IconButton(
                              onPressed: () => showSyncItemDetails(context, syncedItem, ref),
                              icon: const Icon(IconsaxOutline.more_square),
                            ),
                          ],
                        ),
                      ].addInBetween(const SizedBox(width: 16)),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
