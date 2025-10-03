import 'package:flutter/material.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/syncing/sync_item_details.dart';
import 'package:fladder/screens/syncing/sync_widgets.dart';
import 'package:fladder/screens/syncing/widgets/sync_progress_builder.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/size_formatting.dart';

class SyncListItem extends ConsumerWidget {
  final SyncedItem syncedItem;
  const SyncListItem({
    required this.syncedItem,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseItem = syncedItem.itemModel;
    print(FocusManager.instance.primaryFocus);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 1,
        color: Theme.of(context).colorScheme.surfaceDim,
        shadowColor: Colors.transparent,
        child: Dismissible(
          key: Key(syncedItem.id),
          background: Container(
            color: Theme.of(context).colorScheme.errorContainer,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [Icon(IconsaxPlusBold.trash)],
              ),
            ),
          ),
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
          child: FocusButton(
            onTap: () => baseItem?.navigateTo(context),
            onLongPress: () => showSyncItemDetails(context, syncedItem, ref),
            autoFocus: FocusProvider.autoFocusOf(context) && AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
            child: ExcludeFocus(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 125, maxWidth: 512),
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
                      child: FutureBuilder(
                        future: ref.read(syncProvider.notifier).getNestedChildren(syncedItem),
                        builder: (context, asyncSnapshot) {
                          final nestedChildren = asyncSnapshot.data ?? [];
                          return SyncProgressBuilder(
                            item: syncedItem,
                            children: nestedChildren,
                            builder: (context, combinedStream) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                spacing: 4,
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
                                    child: SyncSubtitle(
                                      syncItem: syncedItem,
                                      children: nestedChildren,
                                    ),
                                  ),
                                  Flexible(
                                    child: Consumer(
                                      builder: (context, ref, child) => SyncLabel(
                                        label: context.localized.totalSize(
                                            ref.watch(syncSizeProvider(syncedItem, nestedChildren)).byteFormat ?? '--'),
                                        status: combinedStream?.status ?? TaskStatus.notFound,
                                      ),
                                    ),
                                  ),
                                  if (combinedStream != null && combinedStream.hasDownload == true)
                                    SyncProgressBar(item: syncedItem, task: combinedStream)
                                ],
                              );
                            },
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
                          icon: const Icon(IconsaxPlusLinear.more_square),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
