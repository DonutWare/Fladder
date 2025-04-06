import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:fladder/models/boxset_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/models/playlist_model.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/photo_viewer/photo_viewer_screen.dart';
import 'package:fladder/screens/shared/media/poster_grid.dart';
import 'package:fladder/screens/shared/media/poster_list_item.dart';
import 'package:fladder/screens/shared/media/poster_widget.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

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
        child: _getWidget(ref, context),
      ),
    );
  }

  Widget _getWidget(WidgetRef ref, BuildContext context) {
    final selected = ref.watch(librarySearchProvider(key!).select((value) => value.selectedPosters));
    final posterSizeMultiplier = ref.watch(clientSettingsProvider.select((value) => value.posterSize));
    final libraryProvider = ref.read(librarySearchProvider(key!).notifier);
    final posterSize = MediaQuery.sizeOf(context).width /
        (AdaptiveLayout.poster(context).gridRatio *
            ref.watch(clientSettingsProvider.select((value) => value.posterSize)));
    final decimal = posterSize - posterSize.toInt();

    final sortingOptions = ref.watch(librarySearchProvider(key!).select((value) => value.sortingOption));

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
        if (groupByType != GroupBy.none) {
          final groupedItems = groupItemsBy(context, items, groupByType);
          return SliverList.builder(
            itemCount: groupedItems.length,
            itemBuilder: (context, index) {
              final name = groupedItems.keys.elementAt(index);
              final group = groupedItems[name];
              if (group?.isEmpty ?? false || group == null) {
                return Text(context.localized.empty);
              }
              return PosterGrid(
                posters: group!,
                name: name,
                itemBuilder: (context, index) {
                  final item = group[index];
                  return PosterWidget(
                    key: Key(item.id),
                    poster: group[index],
                    maxLines: 2,
                    heroTag: true,
                    subTitle: item.subTitle(sortingOptions),
                    excludeActions: excludeActions,
                    otherActions: otherActions(item),
                    selected: selected.contains(item),
                    onUserDataChanged: (id, newData) => libraryProvider.updateUserData(id, newData),
                    onItemRemoved: (oldItem) => libraryProvider.removeFromPosters([oldItem.id]),
                    onItemUpdated: (newItem) => libraryProvider.updateItem(newItem),
                    onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
                  );
                },
                onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
              );
            },
          );
        } else {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: posterSize.toInt(),
                mainAxisSpacing: (8 * decimal) + 8,
                crossAxisSpacing: (8 * decimal) + 8,
                childAspectRatio: AdaptiveLayout.poster(context).ratio,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return PosterWidget(
                  key: Key(item.id),
                  poster: item,
                  maxLines: 2,
                  heroTag: true,
                  subTitle: item.subTitle(sortingOptions),
                  excludeActions: excludeActions,
                  otherActions: otherActions(item),
                  selected: selected.contains(item),
                  onUserDataChanged: (id, newData) => libraryProvider.updateUserData(id, newData),
                  onItemRemoved: (oldItem) => libraryProvider.removeFromPosters([oldItem.id]),
                  onItemUpdated: (newItem) => libraryProvider.updateItem(newItem),
                  onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
                );
              },
            ),
          );
        }
      case LibraryViewTypes.list:
        if (groupByType != GroupBy.none) {
          final groupedItems = groupItemsBy(context, items, groupByType);
          return SliverList.builder(
            itemCount: groupedItems.length,
            itemBuilder: (context, index) {
              final name = groupedItems.keys.elementAt(index);
              final group = groupedItems[name];
              if (group?.isEmpty ?? false) {
                return Text(context.localized.empty);
              }
              return StickyHeader(
                header: Text(name, style: Theme.of(context).textTheme.headlineSmall),
                content: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: group?.length,
                  itemBuilder: (context, index) {
                    final poster = group![index];
                    return PosterListItem(
                      key: Key(poster.id),
                      poster: poster,
                      subTitle: poster.subTitle(sortingOptions),
                      excludeActions: excludeActions,
                      otherActions: otherActions(poster),
                      selected: selected.contains(poster),
                      onUserDataChanged: (id, newData) => libraryProvider.updateUserData(id, newData),
                      onItemRemoved: (oldItem) => libraryProvider.removeFromPosters([oldItem.id]),
                      onItemUpdated: (newItem) => libraryProvider.updateItem(newItem),
                      onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
                    );
                  },
                ),
              );
            },
          );
        }
        return SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final poster = items[index];
            return PosterListItem(
              poster: poster,
              selected: selected.contains(poster),
              excludeActions: excludeActions,
              otherActions: otherActions(poster),
              subTitle: poster.subTitle(sortingOptions),
              onUserDataChanged: (id, newData) => libraryProvider.updateUserData(id, newData),
              onItemRemoved: (oldItem) => libraryProvider.removeFromPosters([oldItem.id]),
              onItemUpdated: (newItem) => libraryProvider.updateItem(newItem),
              onPressed: (action, item) async => onItemPressed(action, key, item, ref, context),
            );
          },
        );
      case LibraryViewTypes.masonry:
        if (groupByType != GroupBy.none) {
          final groupedItems = groupItemsBy(context, items, groupByType);
          return SliverList.builder(
            itemCount: groupedItems.length,
            itemBuilder: (context, index) {
              final name = groupedItems.keys.elementAt(index);
              final group = groupedItems[name];
              if (group?.isEmpty ?? false) {
                return Text(context.localized.empty);
              }
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 64.0),
                child: StickyHeader(
                    header: Text(name, style: Theme.of(context).textTheme.headlineMedium),
                    overlapHeaders: true,
                    content: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: MasonryGridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: (8 * decimal) + 8,
                        crossAxisSpacing: (8 * decimal) + 8,
                        gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              (MediaQuery.sizeOf(context).width ~/ (lerpDouble(250, 75, posterSizeMultiplier) ?? 1.0))
                                      .toDouble() *
                                  20,
                        ),
                        itemCount: group!.length,
                        itemBuilder: (context, index) {
                          final item = group[index];
                          return PosterWidget(
                            key: Key(item.id),
                            poster: item,
                            aspectRatio: item.primaryRatio,
                            selected: selected.contains(item),
                            inlineTitle: true,
                            heroTag: true,
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
                    )),
              );
            },
          );
        } else {
          return SliverMasonryGrid.count(
            mainAxisSpacing: (8 * decimal) + 8,
            crossAxisSpacing: (8 * decimal) + 8,
            crossAxisCount: posterSize.toInt(),
            childCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return PosterWidget(
                poster: item,
                key: Key(item.id),
                aspectRatio: item.primaryRatio,
                selected: selected.contains(item),
                inlineTitle: true,
                heroTag: true,
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
        return groupBy(list, (poster) => poster.type.label(context));
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
          await Navigator.of(context, rootNavigator: true).push(
            PageTransition(
                child: PhotoViewerScreen(
                  items: photoList,
                  loadingItems: ref.read(librarySearchProvider(key).notifier).fetchGallery(),
                  indexOfSelected: photoList.indexWhere((element) => element.id == item.id),
                ),
                type: PageTransitionType.fade),
          );
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
