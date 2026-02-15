import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/control_panel/control_active_tasks_provider.dart';
import 'package:fladder/providers/control_panel/control_activity_provider.dart';
import 'package:fladder/providers/control_panel/control_dashboard_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/control_panel/widgets/control_panel_activity_card.dart';
import 'package:fladder/screens/control_panel/widgets/control_panel_card.dart';
import 'package:fladder/screens/control_panel/widgets/control_panel_info_item.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class ControlDashboardPage extends ConsumerStatefulWidget {
  const ControlDashboardPage({super.key});

  @override
  ConsumerState<ControlDashboardPage> createState() => _ControlDashboardPageState();
}

class _ControlDashboardPageState extends ConsumerState<ControlDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final controlDashboard = ref.watch(controlDashboardProvider);
    final dashboardProvider = ref.read(controlDashboardProvider.notifier);
    final isSinglePage = AdaptiveLayout.layoutModeOf(context) == LayoutMode.single;
    final itemCounts = controlDashboard.itemCounts;

    final storagePaths = controlDashboard.storagePaths;

    final activity = ref.watch(controlActivityProvider);
    final activeTasks = ref.watch(controlActiveTasksProvider).where(
          (element) => element.state == TaskState.running,
        );
    return PullToRefresh(
      onRefresh: () => ref.read(controlDashboardProvider.notifier).refreshDashboard(),
      child: (context) => SettingsScaffold(
        label: context.localized.controlDashboard,
        itemSpacing: 12.0,
        items: [
          ControlPanelCard(
            title: context.localized.server,
            navigationChild: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                ControlPanelInfoItem(label: context.localized.serverName, info: controlDashboard.serverName ?? "--"),
                ControlPanelInfoItem(
                    label: context.localized.serverVersion, info: controlDashboard.serverVersion ?? "--"),
                ControlPanelInfoItem(label: context.localized.webVersion, info: controlDashboard.webVersion ?? "--"),
              ],
            ),
          ),
          _SystemButtons(dashboardProvider: dashboardProvider, isSinglePage: isSinglePage),
          if (itemCounts != null) ...[
            _ItemCount(itemCounts: itemCounts),
          ],
          if (activeTasks.isNotEmpty)
            ControlPanelCard(
              title: context.localized.activeTasks,
              navigationChild: true,
              onTapTitle: () => const ControlActiveTasksRoute().navigate(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: activeTasks
                    .map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name ?? "",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Row(
                            spacing: 12,
                            children: [
                              Flexible(
                                child: LinearProgressIndicator(
                                  value: (e.currentProgressPercentage != null)
                                      ? (e.currentProgressPercentage! / 100)
                                      : null,
                                  minHeight: 8,
                                  borderRadius: BorderRadius.circular(16),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                ),
                              ),
                              Text("${e.currentProgressPercentage?.toStringAsFixed(2) ?? "0"}%"),
                            ],
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          if (activity.isNotEmpty)
            ControlPanelCard(
              title: context.localized.devices,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.spaceBetween,
                    alignment: WrapAlignment.spaceBetween,
                    children: activity.map(
                      (activity) {
                        final fullWidth = constraints.maxWidth < 600;
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: fullWidth
                                ? constraints.maxWidth
                                : (constraints.maxWidth / 2).clamp(250, double.infinity) - 5,
                          ),
                          child: ControlPanelActivityCard(activity: activity),
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            ),
          if (storagePaths != null) _StoragePaths(storage: storagePaths),
        ],
      ),
    );
  }
}

class _StoragePaths extends StatelessWidget {
  final SystemStorageDto storage;
  const _StoragePaths({
    required this.storage,
  });

  @override
  Widget build(BuildContext context) {
    Widget infoBuilder(String name, FolderStorageDto storage) {
      final freeSpace = (storage.freeSpace ?? 0) / (1024 * 1024 * 1024);
      final usedSpace = (storage.usedSpace ?? 0) / (1024 * 1024 * 1024);
      final totalSpace = freeSpace + usedSpace;
      return FocusButton(
        onTap: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad ? () {} : null,
        onFocusChanged: (value) {
          if (value) {
            context.ensureVisible();
          }
        },
        child: Row(
          spacing: 12,
          children: [
            const Icon(IconsaxPlusBold.box),
            Flexible(
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(storage.path ?? "--"),
                  LinearProgressIndicator(
                    value: totalSpace == 0 ? 0 : usedSpace / totalSpace,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          "${context.localized.used}: ${usedSpace.toStringAsFixed(2)} GB / ${totalSpace.toStringAsFixed(2)} GB")),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return ControlPanelCard(
      title: context.localized.storagePaths,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          if (storage.programDataFolder != null)
            infoBuilder(
              context.localized.programData,
              storage.programDataFolder!,
            ),
          if (storage.webFolder != null)
            infoBuilder(
              context.localized.web,
              storage.webFolder!,
            ),
          if (storage.cacheFolder != null)
            infoBuilder(
              context.localized.cache,
              storage.cacheFolder!,
            ),
          if (storage.logFolder != null)
            infoBuilder(
              context.localized.logs,
              storage.logFolder!,
            ),
          if (storage.transcodingTempFolder != null)
            infoBuilder(
              context.localized.transcodingTemp,
              storage.transcodingTempFolder!,
            ),
        ],
      ),
    );
  }
}

class _ItemCount extends StatelessWidget {
  final ItemCounts itemCounts;
  const _ItemCount({
    required this.itemCounts,
  });

  @override
  Widget build(BuildContext context) {
    return ControlPanelCard(
      title: context.localized.count,
      navigationChild: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          if (itemCounts.movieCount != 0)
            ControlPanelInfoItem(
              icon: Icon(FladderItemType.movie.icon),
              label: FladderItemType.movie.label(context.localized, count: itemCounts.movieCount ?? 1),
              info: itemCounts.movieCount.toString(),
            ),
          if (itemCounts.seriesCount != 0) ...[
            Row(
              spacing: 12,
              children: [
                Icon(FladderItemType.series.icon),
                Expanded(
                  child: ControlPanelInfoItem(
                    label: FladderItemType.series.label(context.localized, count: itemCounts.seriesCount ?? 1),
                    info: itemCounts.seriesCount.toString(),
                  ),
                ),
                Expanded(
                  child: ControlPanelInfoItem(
                    label: FladderItemType.episode.label(context.localized, count: itemCounts.episodeCount ?? 1),
                    info: itemCounts.episodeCount.toString(),
                  ),
                )
              ],
            ),
          ],
          if (itemCounts.albumCount != 0)
            Row(
              spacing: 12,
              children: [
                Icon(FladderItemType.musicAlbum.icon),
                Expanded(
                  child: ControlPanelInfoItem(
                    label: FladderItemType.musicAlbum.label(context.localized, count: itemCounts.albumCount ?? 1),
                    info: itemCounts.albumCount.toString(),
                  ),
                ),
                Expanded(
                  child: ControlPanelInfoItem(
                    label: FladderItemType.audio.label(context.localized, count: itemCounts.songCount ?? 1),
                    info: itemCounts.songCount.toString(),
                  ),
                )
              ],
            ),
          if (itemCounts.bookCount != 0)
            ControlPanelInfoItem(
              icon: Icon(FladderItemType.book.icon),
              label: FladderItemType.book.label(context.localized, count: itemCounts.bookCount ?? 1),
              info: itemCounts.bookCount.toString(),
            ),
          if (itemCounts.boxSetCount != 0)
            ControlPanelInfoItem(
              icon: Icon(FladderItemType.boxset.icon),
              label: FladderItemType.boxset.label(context.localized, count: itemCounts.boxSetCount ?? 1),
              info: itemCounts.boxSetCount.toString(),
            ),
        ],
      ),
    );
  }
}

class _SystemButtons extends StatelessWidget {
  const _SystemButtons({
    required this.dashboardProvider,
    required this.isSinglePage,
  });

  final ControlDashboard dashboardProvider;
  final bool isSinglePage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FilledButton(
            onPressed: () {
              showDefaultAlertDialog(
                context,
                context.localized.scanAllLibraries,
                null,
                (context) {
                  dashboardProvider.refreshLibrary();
                  context.pop();
                },
                context.localized.accept,
                (context) => context.pop(),
                context.localized.cancel,
              );
            },
            child: Row(
              mainAxisSize: isSinglePage ? MainAxisSize.max : MainAxisSize.min,
              spacing: 8,
              children: [
                const Icon(IconsaxPlusLinear.refresh),
                Text(context.localized.scanAllLibraries),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDefaultAlertDialog(
                context,
                context.localized.restartServer,
                null,
                (context) {
                  dashboardProvider.restartServer();
                  context.pop();
                },
                context.localized.accept,
                (context) => context.pop(),
                context.localized.cancel,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            ),
            child: Row(
              spacing: 8,
              mainAxisSize: isSinglePage ? MainAxisSize.max : MainAxisSize.min,
              children: [
                const Icon(IconsaxPlusLinear.refresh_2),
                Text(context.localized.restartServer),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDefaultAlertDialog(
                context,
                context.localized.shutDownServer,
                null,
                (context) {
                  dashboardProvider.shutdownServer();
                  context.pop();
                },
                context.localized.accept,
                (context) => context.pop(),
                context.localized.cancel,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            ),
            child: Row(
              spacing: 8,
              mainAxisSize: isSinglePage ? MainAxisSize.max : MainAxisSize.min,
              children: [
                const Icon(Icons.power_rounded),
                Text(context.localized.shutDownServer),
              ],
            ),
          )
        ],
      ),
    );
  }
}
