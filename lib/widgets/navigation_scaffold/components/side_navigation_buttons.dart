import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/collection_types.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/dashboard_mode_provider.dart';
import 'package:fladder/providers/library_filters_provider.dart';
import 'package:fladder/providers/playlist_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/color_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_button.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_items.dart';
import 'package:fladder/widgets/shared/custom_tooltip.dart';
import 'package:fladder/widgets/shared/simple_overflow_widget.dart';

class SideNavigationButtons extends ConsumerWidget {
  const SideNavigationButtons({
    super.key,
    required this.largeBar,
    required this.destinations,
    required this.tooltipPosition,
    required this.currentIndex,
    required this.shouldExpand,
    this.useOverflow = true,
  });

  final bool largeBar;
  final List<DestinationModel> destinations;
  final TooltipPosition tooltipPosition;
  final int currentIndex;
  final bool shouldExpand;
  final bool useOverflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedSideBar = ref.watch(clientSettingsProvider.select((value) => value.expandSideBar));
    final views = ref.watch(viewsProvider.select((value) => value.views));
    final usePostersForLibrary = ref.watch(clientSettingsProvider.select((value) => value.usePosterForLibrary));
    final musicDashboard = ref.watch(musicDashboardModeProvider);
    final playLists = ref.watch(playlistProvider.select((value) => value.collections));

    final filters =
        ref.watch(userLibraryFilters.select((value) => value.where((element) => element.showInSideBar).toList()));

    final List<Widget> navItems = [
      if (filters.isNotEmpty) LabelDivider(label: context.localized.filter(2), shouldExpand: shouldExpand),
      ...filters.map(
        (filter) {
          final viewsInFilter = views.where((view) => filter.ids.contains(view.id)).toList();
          return FilterNavigationItem(
            views: viewsInFilter,
            filter: filter,
            expandedSideBar: expandedSideBar,
            usePostersForLibrary: usePostersForLibrary,
            shouldExpand: shouldExpand,
            toolTipPosition: tooltipPosition,
          );
        },
      ),
      if (views.isNotEmpty) LabelDivider(label: context.localized.library(2), shouldExpand: shouldExpand),
      if (musicDashboard) ...[
        ...buildMusicDashboardNavItems(
          context,
          views,
          playLists,
          shouldExpand,
          ref,
        )
      ] else ...[
        ...views.map(
          (view) => ViewNavigationItem(
            view: view,
            expandedSideBar: expandedSideBar,
            usePostersForLibrary: usePostersForLibrary,
            shouldExpand: shouldExpand,
            toolTipPosition: tooltipPosition,
          ),
        )
      ]
    ];

    final overFlowItems = [
      ...filters,
      ...(musicDashboard
          ? [...MusicLibraryItem.fromViews(context, views, expandedSideBar, ref), ...playLists.keys]
          : views),
    ];

    return Column(
      mainAxisAlignment: !largeBar ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        ...destinations.mapIndexed(
          (index, destination) => CustomTooltip(
            tooltipContent: expandedSideBar
                ? null
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        destination.label,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
            position: tooltipPosition,
            child: destination.toNavigationButton(
              currentIndex == index,
              true,
              navFocusNode: index == 0,
              shouldExpand,
            ),
          ),
        ),
        if (largeBar) ...[
          if (useOverflow)
            Flexible(
              child: SimpleOverflowWidget(
                axis: Axis.vertical,
                isCountable: (child) {
                  return child is FilterNavigationItem ||
                      child is ViewNavigationItem ||
                      child is CombinedViewNavigationItem;
                },
                children: navItems,
                overflowBuilder: (remainingCount) => CustomTooltip(
                  tooltipContent: expandedSideBar
                      ? null
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: FladderTheme.smallShape.borderRadius,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              context.localized.moreOptions,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                  position: tooltipPosition,
                  child: PopupMenuButton(
                    iconColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
                    padding: EdgeInsets.zero,
                    tooltip: "",
                    icon: ExcludeFocus(
                      child: NavigationButton(
                        label: context.localized.other,
                        selectedIcon: const Icon(IconsaxPlusLinear.arrow_square_down),
                        icon: const Icon(IconsaxPlusLinear.arrow_square_down),
                        expanded: shouldExpand,
                        customIcon: usePostersForLibrary
                            ? ClipRRect(
                                borderRadius: FladderTheme.smallShape.borderRadius,
                                child: const SizedBox.square(
                                  dimension: 50,
                                  child: Card(
                                    child: Icon(IconsaxPlusLinear.arrow_square_down),
                                  ),
                                ),
                              )
                            : null,
                        horizontal: true,
                      ),
                    ),
                    itemBuilder: (context) => overFlowItems.sublist(overFlowItems.length - remainingCount).map(
                      (e) {
                        if (e is ViewModel) {
                          return PopupMenuItem(
                            onTap: () => e.navigateToView(context),
                            child: Row(
                              spacing: 8,
                              children: [
                                usePostersForLibrary
                                    ? e.createIcon(context, selected: false)
                                    : Icon(e.collectionType.iconOutlined),
                                Text(e.name),
                              ],
                            ),
                          );
                        } else if (e is LibraryFiltersModel) {
                          return PopupMenuItem(
                            onTap: () => e.navigateTo(context),
                            child: Row(
                              spacing: 8,
                              children: [
                                e.createIcon(
                                      context,
                                      usePostersForLibrary: usePostersForLibrary,
                                      expandedSideBar: false,
                                      selected: false,
                                      views: views,
                                    ) ??
                                    const Icon(IconsaxPlusLinear.document_filter),
                                Text(e.name),
                              ],
                            ),
                          );
                        } else if (e is PlaylistModel) {
                          final derivePosterColor =
                              ref.watch(clientSettingsProvider.select((value) => value.dynamicPosterColors));
                          final backgroundColor = derivePosterColor
                              ? e.name.toColor.harmonizeWith(Theme.of(context).colorScheme.surface)
                              : Theme.of(context).colorScheme.surface;
                          return PopupMenuItem(
                            onTap: () => e.navigateTo(context),
                            child: Row(
                              spacing: 8,
                              children: [
                                e.iconWidget(
                                  context,
                                  usePoster: usePostersForLibrary,
                                  backgroundColor: backgroundColor,
                                ),
                                Text(e.name),
                              ],
                            ),
                          );
                        } else if (e is MusicLibraryItem) {
                          return PopupMenuItem(
                            onTap: () => e.onTap(),
                            child: Row(
                              spacing: 8,
                              children: [
                                e.icon,
                                Text(e.label),
                              ],
                            ),
                          );
                        }
                        return const PopupMenuItem(
                          onTap: null,
                          child: SizedBox.shrink(),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            )
          else
            ...navItems,
        ]
      ],
    );
  }
}

class LabelDivider extends StatelessWidget {
  final String label;
  final bool shouldExpand;

  const LabelDivider({
    required this.label,
    required this.shouldExpand,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        if (shouldExpand)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                    ),
              ),
            ),
          ),
        Expanded(
          child: Divider(
            indent: shouldExpand ? 0 : 16,
            endIndent: 16,
          ),
        ),
      ],
    );
  }
}
