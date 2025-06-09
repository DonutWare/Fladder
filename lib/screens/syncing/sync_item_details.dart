import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/media/poster_widget.dart';
import 'package:fladder/screens/syncing/sync_child_item.dart';
import 'package:fladder/screens/syncing/sync_widgets.dart';
import 'package:fladder/screens/syncing/widgets/sync_progress_builder.dart';
import 'package:fladder/screens/syncing/widgets/sync_status_overlay.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/size_formatting.dart';
import 'package:fladder/widgets/shared/alert_content.dart';
import 'package:fladder/widgets/shared/icon_button_await.dart';

Future<void> showSyncItemDetails(
  BuildContext context,
  SyncedItem syncItem,
  WidgetRef ref,
) {
  return showDialogAdaptive(
    context: context,
    builder: (context) => SyncItemDetails(
      syncItem: syncItem,
    ),
  );
}

class SyncItemDetails extends ConsumerStatefulWidget {
  final SyncedItem syncItem;
  const SyncItemDetails({required this.syncItem, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SyncItemDetailsState();
}

class _SyncItemDetailsState extends ConsumerState<SyncItemDetails> {
  late SyncedItem syncedItem = widget.syncItem;

  @override
  Widget build(BuildContext context) {
    final baseItem = ref.read(syncProvider.notifier).getItem(syncedItem);
    final hasFile = syncedItem.videoFile.existsSync();
    final syncChildren = ref.read(syncProvider.notifier).getChildren(syncedItem);
    final downloadTask = ref.read(downloadTasksProvider(syncedItem.id));

    return SyncStatusOverlay(
        syncedItem: syncedItem,
        child: ActionContent(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(baseItem?.type.label(context) ?? ""),
                  )),
              Text(
                context.localized.navigationSync,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(IconsaxPlusBold.close_circle),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (baseItem != null) ...{
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (AdaptiveLayout.poster(context).size *
                              ref.watch(clientSettingsProvider.select((value) => value.posterSize))) *
                          0.6,
                      child: IgnorePointer(
                        child: PosterWidget(
                          aspectRatio: 0.7,
                          poster: baseItem,
                          inlineTitle: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SyncProgressBuilder(
                        item: syncedItem,
                        children: syncChildren,
                        builder: (context, combinedStream) {
                          return Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      baseItem.detailedName(context) ?? "",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    SyncSubtitle(syncItem: syncedItem),
                                    SyncLabel(
                                      label: context.localized.totalSize(
                                          ref.watch(syncSizeProvider(syncedItem, syncChildren)).byteFormat ?? '--'),
                                      status: ref.watch(syncStatusesProvider(syncedItem, syncChildren)).value ??
                                          SyncStatus.partially,
                                    ),
                                    if (combinedStream?.task != null && combinedStream != null) ...{
                                      SyncProgressBar(item: syncedItem, task: combinedStream)
                                    },
                                  ].addInBetween(const SizedBox(height: 8)),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    if (!hasFile && !downloadTask.hasDownload && syncedItem.hasVideoFile)
                      IconButtonAwait(
                        onPressed: () async => await ref.read(syncProvider.notifier).syncFile(syncedItem, false),
                        icon: const Icon(IconsaxPlusLinear.cloud_change),
                      )
                    else if (hasFile)
                      IconButtonAwait(
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () {
                          showDefaultAlertDialog(
                            context,
                            context.localized.syncRemoveDataTitle,
                            context.localized.syncRemoveDataDesc,
                            (context) {
                              ref.read(syncProvider.notifier).deleteFullSyncFiles(syncedItem, downloadTask.task);
                              Navigator.of(context).pop();
                            },
                            context.localized.delete,
                            (context) => Navigator.of(context).pop(),
                            context.localized.cancel,
                          );
                        },
                        icon: const Icon(IconsaxPlusLinear.trash),
                      ),
                  ].addInBetween(const SizedBox(width: 16)),
                ),
              },
              const Divider(),
              if (syncChildren.isNotEmpty == true)
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ...syncChildren.map(
                        (e) => ChildSyncWidget(syncedChild: e),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            if (baseItem is! EpisodeModel)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                  iconColor: Theme.of(context).colorScheme.onErrorContainer,
                ),
                onPressed: () {
                  showDefaultAlertDialog(
                    context,
                    context.localized.syncDeleteItemTitle,
                    context.localized.syncDeleteItemDesc(baseItem?.detailedName(context) ?? ""),
                    (context) async {
                      await ref.read(syncProvider.notifier).removeSync(context, syncedItem);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    context.localized.delete,
                    (context) => Navigator.pop(context),
                    context.localized.cancel,
                  );
                },
                child: Text(context.localized.delete),
              )
            else if (syncedItem.parentId != null)
              ElevatedButton(
                onPressed: () {
                  final parentItem = ref.read(syncProvider.notifier).getParentItem(syncedItem.parentId!);
                  setState(() {
                    if (parentItem != null) {
                      syncedItem = parentItem;
                    }
                  });
                },
                child: Text(context.localized.syncOpenParent),
              )
          ],
        ));
  }
}
