import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:fladder/models/boxset_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/playlist_model.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/media/poster_list_item.dart';
import 'package:fladder/screens/shared/media/poster_widget.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/util/theme_extensions.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/grid_focus_traveler.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

final libraryViewTypeProvider = StateProvider<LibraryViewTypes>((ref) {
  return LibraryViewTypes.grid;
});

enum LibraryViewTypes {
  grid(icon: IconsaxPlusLinear.grid_2),
  list(icon: IconsaxPlusLinear.grid_6),
  masonry(icon: IconsaxPlusLinear.grid_3);

  const LibraryViewTypes({required this.icon});

  String label(BuildContext context) => switch (this) {
        LibraryViewTypes.grid => context.localized.grid,
        LibraryViewTypes.list => context.localized.list,
        LibraryViewTypes.masonry => context.localized.masonry,
      };

  final IconData icon;
}

class LibraryViews extends ConsumerWidget {
  final List<ItemBaseModel> items;
  final GroupBy groupByType;
  final Function(ItemBaseModel)? onPressed;
  final Set<ItemActions> excludeActions = const {ItemActions.openParent};
  const LibraryViews({required this.items, required this.groupByType, this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      sliver: SliverAnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _getWidget(context, ref),
      ),
    );
  }

  Widget _getWidget(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(librarySearchProvider(key!).select((value) => value.selectedPosters));
    final posterSizeMultiplier = ref.watch(clientSettingsProvider.select((value) => value.posterSize));
    final libraryProvider = ref.read(librarySearchProvider(key!).notifier);
    final posterSize = MediaQuery.sizeOf(context).width /
        (AdaptiveLayout.poster(context).gridRatio *
            ref.watch(clientSettingsProvider.select((value) => value.posterSize)));
    final decimal = posterSize - posterSize.toInt();

    final sortingOptions = ref.watch(librarySearchProvider(key!).select((value) => value.filters.sortingOption));

    List<ItemAction> otherActions(ItemBaseModel item) {
      return [
        if (ref.watch(librarySearchProvider(key!).select((value) => value.nestedCurrentItem is BoxSetModel))) ...{
          ItemActionButton(
            label: Text(context.localized.removeFromCollection),
            icon: const Icon(IconsaxPlusLinear.archive_slash),
            action: () async {
              await libraryProvider.removeFromCollection(items: [item]);
              if (context.mounted) {
                context.refreshData();
              }
            },
          )
        },
        if (ref.watch(librarySearchProvider(key!).select((value) => value.nestedCurrentItem is PlaylistModel))) ...{
          ItemActionButton(
            label: Text(context.localized.removeFromPlaylist),
            icon: const Icon(IconsaxPlusLinear.archive_minus),
            action: () async {
              await libraryProvider.removeFromPlaylist(items: [item]);
              if (context.mounted) {
                context.refreshData();
              }
            },
          )
        }
      ];
    }

    switch (ref.watch(libraryViewTypeProvider)) {
      case LibraryViewTypes.grid:
        Widget createGrid(List<ItemBaseModel> items) {
          final width = MediaQuery.of(context).size.width;
          final cellWidth = (width / posterSize).floorToDouble();
          final crossAxisCount = ((width / cellWidth).floor()).clamp(2, 10);
          return GridFocusTraveler(
            itemCount: items.length,
            crossAxisCount: crossAxisCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: items.getMostCommonType.aspectRatio,
            ),
            itemBuilder: (other, selectedIndex, index) {
              final item = items[index];
              return PosterWidget(
                key: Key(item.id),
                poster: item,
                maxLines: 2,
                subTitle: item.subTitle(sortingOptions),
                excludeActions: excludeActions,
                otherActions: otherActions(item),
                selected: selected.contains(item),
                onUserDataChanged: (id, newData) => libraryProvider.updateUserData(id, newData),
                onItemRemoved: (oldItem) => libraryProvider.removeFromPosters([oldItem.id]),
                onItemUpdated: (newItem) => libraryProvider.updateItem(newItem),
                onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
                onFocusChanged: (focus) {
                  if (focus) {
                    other.ensureVisible();
                  }
                },
              );
            },
          );
        }

        if (groupByType != GroupBy.none) {
          final groupedItems = groupItemsBy(context, items, groupByType);
          return MultiSliver(
              children: groupedItems.entries.map(
            (element) {
              final name = element.key;
              final group = element.value;
              return stickyHeaderBuilder(
                context,
                header: name,
                sliver: createGrid(group),
              );
            },
          ).toList());
        } else {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: createGrid(items),
          );
        }
      case LibraryViewTypes.list:
        Widget listBuilder(List<ItemBaseModel> items) {
          return SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final poster = items[index];
              return FocusProvider(
                autoFocus: index == 0,
                child: PosterListItem(
                  poster: poster,
                  selected: selected.contains(poster),
                  excludeActions: excludeActions,
                  otherActions: otherActions(poster),
                  subTitle: poster.subTitle(sortingOptions),
                  onUserDataChanged: (id, newData) => libraryProvider.updateUserData(id, newData),
                  onItemRemoved: (oldItem) => libraryProvider.removeFromPosters([oldItem.id]),
                  onItemUpdated: (newItem) => libraryProvider.updateItem(newItem),
                  onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
                ),
              );
            },
          );
        }
        if (groupByType != GroupBy.none) {
          final groupedItems = groupItemsBy(context, items, groupByType);
          return MultiSliver(
              children: groupedItems.entries.map(
            (element) {
              final name = element.key;
              final group = element.value;
              return stickyHeaderBuilder(
                context,
                header: name,
                sliver: listBuilder(group),
              );
            },
          ).toList());
        }
        return listBuilder(items);
      case LibraryViewTypes.masonry:
        if (groupByType != GroupBy.none) {
          final groupedItems = groupItemsBy(context, items, groupByType);
          return MultiSliver(
              children: groupedItems.entries.map(
            (element) {
              final name = element.key;
              final group = element.value;
              return stickyHeaderBuilder(
                context,
                header: name,
                //MasonryGridView because SliverMasonryGrid breaks scrolling
                sliver: SliverToBoxAdapter(
                  child: MasonryGridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: (8 * decimal) + 8,
                    crossAxisSpacing: (8 * decimal) + 8,
                    gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          (MediaQuery.sizeOf(context).width ~/ (lerpDouble(250, 75, posterSizeMultiplier) ?? 1.0))
                                  .toDouble() *
                              12,
                    ),
                    itemCount: group.length,
                    itemBuilder: (context, index) {
                      final item = group[index];
                      return PosterWidget(
                        key: Key(item.id),
                        poster: item,
                        aspectRatio: item.primaryRatio,
                        selected: selected.contains(item),
                        inlineTitle: true,
                        subTitle: item.subTitle(sortingOptions),
                        excludeActions: excludeActions,
                        otherActions: otherActions(group[index]),
                        onUserDataChanged: (id, newData) => libraryProvider.updateUserData(id, newData),
                        onItemRemoved: (oldItem) => libraryProvider.removeFromPosters([oldItem.id]),
                        onItemUpdated: (newItem) => libraryProvider.updateItem(newItem),
                        onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
                      );
                    },
                  ),
                ),
              );
            },
          ).toList());
        } else {
          return SliverMasonryGrid.count(
            mainAxisSpacing: (8 * decimal) + 8,
            crossAxisSpacing: (8 * decimal) + 8,
            crossAxisCount: posterSize.clamp(2, double.maxFinite).toInt(),
            childCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return PosterWidget(
                poster: item,
                key: Key(item.id),
                aspectRatio: item.primaryRatio,
                selected: selected.contains(item),
                inlineTitle: true,
                excludeActions: excludeActions,
                otherActions: otherActions(item),
                subTitle: item.subTitle(sortingOptions),
                onUserDataChanged: (id, newData) => libraryProvider.updateUserData(id, newData),
                onItemRemoved: (oldItem) => libraryProvider.removeFromPosters([oldItem.id]),
                onItemUpdated: (newItem) => libraryProvider.updateItem(newItem),
                onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
              );
            },
          );
        }
    }
  }

  SliverStickyHeader stickyHeaderBuilder(
    BuildContext context, {
    required String header,
    Widget? sliver,
  }) {
    return SliverStickyHeader(
      header: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        child: Transform.translate(
          offset: const Offset(-20, 0),
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.surface.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                header,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      sliver: sliver,
    );
  }

  Map<String, List<ItemBaseModel>> groupItemsBy(BuildContext context, List<ItemBaseModel> list, GroupBy groupOption) {
    switch (groupOption) {
      case GroupBy.dateAdded:
        return groupBy(
            items,
            (poster) => DateFormat.yMMMMd().format(DateTime(
                poster.overview.dateAdded!.year, poster.overview.dateAdded!.month, poster.overview.dateAdded!.day)));
      case GroupBy.releaseDate:
        return groupBy(list, (poster) => poster.overview.yearAired?.toString() ?? context.localized.unknown);
      case GroupBy.rating:
        return groupBy(list, (poster) => poster.overview.parentalRating ?? context.localized.noRating);
      case GroupBy.tags:
        return groupByList(context, list, true);
      case GroupBy.genres:
        return groupByList(context, list, false);
      case GroupBy.name:
        return groupBy(list, (poster) => poster.name[0].capitalize());
      case GroupBy.type:
        return groupBy(list, (poster) => poster.type.label(context.localized));
      case GroupBy.none:
        return {};
    }
  }

  Future<void> onItemPressed(
      Function() action, Key? key, ItemBaseModel item, WidgetRef ref, BuildContext context) async {
    final selectMode = ref.read(librarySearchProvider(key!).select((value) => value.selecteMode));
    if (selectMode) {
      ref.read(librarySearchProvider(key).notifier).toggleSelection(item);
      return;
    }
    switch (item) {
      case PhotoModel _:
        final photoList = items.whereType<PhotoModel>().toList();
        if (context.mounted) {
          await context.router.push(PhotoViewerRoute(
            items: photoList,
            loadingItems: ref.read(librarySearchProvider(key).notifier).fetchGallery(),
            selected: item.id,
          ));
        }
        if (context.mounted) context.refreshData();
        break;
      default:
        action.call();
        break;
    }
  }
}

Map<String, List<ItemBaseModel>> groupByList(BuildContext context, List<ItemBaseModel> items, bool tags) {
  Map<String, int> tagsCount = {};
  for (var item in items) {
    for (var tag in (tags ? item.overview.tags : item.overview.genres)) {
      tagsCount[tag] = (tagsCount[tag] ?? 0) + 1;
    }
  }

  List<String> sortedTags = tagsCount.keys.toList()..sort((a, b) => tagsCount[a]!.compareTo(tagsCount[b]!));

  Map<String, List<ItemBaseModel>> groupedItems = {};

  for (var item in items) {
    List<String> itemTags = (tags ? item.overview.tags : item.overview.genres);
    itemTags.sort((a, b) => sortedTags.indexOf(a).compareTo(sortedTags.indexOf(b)));
    String key = itemTags.take(2).join(', ');
    key = key.isNotEmpty ? key : context.localized.none;
    groupedItems[key] = [...(groupedItems[key] ?? []), item];
  }

  return groupedItems;
}
