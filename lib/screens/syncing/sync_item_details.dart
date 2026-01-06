import 'package:flutter/material.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/media/poster_widget.dart';
import 'package:fladder/screens/syncing/sync_child_item.dart';
import 'package:fladder/screens/syncing/sync_widgets.dart';
import 'package:fladder/screens/syncing/widgets/sync_options_button.dart';
import 'package:fladder/screens/syncing/widgets/sync_progress_builder.dart';
import 'package:fladder/screens/syncing/widgets/sync_status_overlay.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/size_formatting.dart';
import 'package:fladder/widgets/shared/alert_content.dart';
import 'package:fladder/widgets/shared/icon_button_await.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

Future<void> showSyncItemDetails(
  BuildContext context,
  SyncedItem syncItem,
  WidgetRef ref,
) async {
  await showDialogAdaptive(
    context: context,
    builder: (context) => SyncItemDetails(
      syncItem: syncItem,
    ),
  );
  context.refreshData();
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
    final baseItem = syncedItem.itemModel;
    final hasFile = syncedItem.videoFile.existsSync();
    final downloadTask = ref.watch(downloadTasksProvider(syncedItem.id));
    final syncedChildren = ref.watch(syncedChildrenProvider(syncedItem));
    final nestedChildren = ref.watch(syncedNestedChildrenProvider(syncedItem));
    return PullToRefresh(
      refreshOnStart: false,
      onRefresh: () async {
        final newItem = await ref.read(syncProvider.notifier).refreshSyncItem(syncedItem);
        setState(() {
          syncedItem = newItem;
        });
      },
      child: (context) =>  Padding(
        padding: const EdgeInsets.all(12.0),
        child: SyncStatusOverlay(
          syncedItem: syncedItem,
          child: switch (syncedChildren) {
            AsyncValue<List<SyncedItem>>(value: final children) => ActionContent(
                padding: EdgeInsets.zero,
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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (baseItem != null) ...{
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        spacing: 16,
                        children: [
                          SizedBox(
                            height: (AdaptiveLayout.poster(context).size *
                                    ref.watch(clientSettingsProvider.select((value) => value.posterSize))) *
                                0.6,
                            child: IgnorePointer(
                              child: PosterWidget(
                                aspectRatio: 0.70,
                                poster: baseItem,
                                underTitle: false,
                              ),
                            ),
                          ),
                          Expanded(
                            child: switch (nestedChildren) {
                              AsyncValue<List<SyncedItem>>(:final value) => Builder(
                                  builder: (context) {
                                    final nestedChildren = value ?? [];
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
                                                baseItem.detailedName(context) ?? "",
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
                                                  label: context.localized.totalSize(ref
                                                          .watch(syncSizeProvider(syncedItem, nestedChildren))
                                                          .byteFormat ??
                                                      '--'),
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
                            },
                          ),
                          if (syncedItem.hasVideoFile && !hasFile && !downloadTask.hasDownload)
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
                          nestedChildren.when(
                            data: (data) => SyncOptionsButton(
                              syncedItem: syncedItem,
                              children: data,
                            ),
                            error: (error, stackTrace) => const SizedBox.shrink(),
                            loading: () => const SizedBox.shrink(),
                          )
                        ],
                      ),
                    },
                    if (children?.isNotEmpty == true) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(),
                      ),
                      ...children!.map(
                        (e) => ChildSyncWidget(syncedChild: e),
                      ),
                    ],
                  ],
                ),
                actions: [
                  if (syncedItem.parentId == null)
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
                          (localContext) async {
                            await ref.read(syncProvider.notifier).removeSync(context, syncedItem);
                            Navigator.pop(localContext);
                            Navigator.pop(context);
                          },
                          context.localized.delete,
                          (context) => Navigator.pop(context),
                          context.localized.cancel,
                        );
                      },
                      child: Text(context.localized.delete),
                    )
                  else if (baseItem?.parentBaseModel != null)
                    ElevatedButton(
                      onPressed: () async {
                        final parentItem =
                            await ref.read(syncProvider.notifier).getSyncedItem(baseItem!.parentBaseModel.id);
                        setState(() {
                          if (parentItem != null) {
                            syncedItem = parentItem;
                          }
                        });
                      },
                      child: Text(context.localized.syncOpenParent),
                    )
                ],
              ),
          },
        ),
      ),
    );
  }
}
