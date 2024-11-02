import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/screens/library_search/widgets/library_views.dart';
import 'package:fladder/screens/shared/chips/category_chip.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/scroll_position.dart';

class LibraryFilterChips extends ConsumerWidget {
  final Key uniqueKey;
  final ScrollController controller;
  final LibrarySearchModel librarySearchResults;
  final LibrarySearchNotifier libraryProvider;
  final List<ItemBaseModel> postersList;
  final LibraryViewTypes libraryViewType;
  const LibraryFilterChips({
    required this.uniqueKey,
    required this.controller,
    required this.librarySearchResults,
    required this.libraryProvider,
    required this.postersList,
    required this.libraryViewType,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollStatePosition(
      controller: controller,
      positionBuilder: (state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: libraryFilterChips(
            context,
            ref,
            uniqueKey,
            librarySearchResults: librarySearchResults,
            libraryProvider: libraryProvider,
            postersList: postersList,
            libraryViewType: libraryViewType,
          ).addPadding(const EdgeInsets.symmetric(horizontal: 8)),
        );
      },
    );
  }
}

List<Widget> libraryFilterChips(
  BuildContext context,
  WidgetRef ref,
  Key uniqueKey, {
  required LibrarySearchModel librarySearchResults,
  required LibrarySearchNotifier libraryProvider,
  required List<ItemBaseModel> postersList,
  required LibraryViewTypes libraryViewType,
}) {
  Future<dynamic> openGroupDialogue() {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            return AlertDialog(
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(context.localized.groupBy),
                    ...GroupBy.values.map((groupBy) => RadioListTile.adaptive(
                          value: groupBy,
                          title: Text(groupBy.value(context)),
                          groupValue: ref.watch(librarySearchProvider(uniqueKey).select((value) => value.groupBy)),
                          onChanged: (value) {
                            libraryProvider.setGroupBy(groupBy);
                            Navigator.pop(context);
                          },
                        )),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  return [
    if (librarySearchResults.folderOverwrite.isEmpty)
      CategoryChip(
        label: Text(context.localized.library(2)),
        items: librarySearchResults.views,
        labelBuilder: (item) => Text(item.name),
        onSave: (value) => libraryProvider.setViews(value),
        onCancel: () => libraryProvider.setViews(librarySearchResults.views),
        onClear: () => libraryProvider.setViews(librarySearchResults.views.setAll(false)),
      ),
    CategoryChip<FladderItemType>(
      label: Text(context.localized.type(librarySearchResults.types.length)),
      items: librarySearchResults.types,
      labelBuilder: (item) => Row(
        children: [
          Icon(item.icon),
          const SizedBox(width: 12),
          Text(item.label(context)),
        ],
      ),
      onSave: (value) => libraryProvider.setTypes(value),
      onClear: () => libraryProvider.setTypes(librarySearchResults.types.setAll(false)),
    ),
    FilterChip(
      label: Text(context.localized.favorites),
      avatar: Icon(
        librarySearchResults.favourites ? IconsaxBold.heart : IconsaxOutline.heart,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      selected: librarySearchResults.favourites,
      showCheckmark: false,
      onSelected: (value) {
        libraryProvider.toggleFavourite();
        context.refreshData();
      },
    ),
    FilterChip(
      label: Text(context.localized.recursive),
      selected: librarySearchResults.recursive,
      onSelected: (value) {
        libraryProvider.toggleRecursive();
        context.refreshData();
      },
    ),
    if (librarySearchResults.genres.isNotEmpty)
      CategoryChip<String>(
        label: Text(context.localized.genre(librarySearchResults.genres.length)),
        activeIcon: IconsaxBold.hierarchy_2,
        items: librarySearchResults.genres,
        labelBuilder: (item) => Text(item),
        onSave: (value) => libraryProvider.setGenres(value),
        onCancel: () => libraryProvider.setGenres(librarySearchResults.genres),
        onClear: () => libraryProvider.setGenres(librarySearchResults.genres.setAll(false)),
      ),
    if (librarySearchResults.studios.isNotEmpty)
      CategoryChip<Studio>(
        label: Text(context.localized.studio(librarySearchResults.studios.length)),
        activeIcon: IconsaxBold.airdrop,
        items: librarySearchResults.studios,
        labelBuilder: (item) => Text(item.name),
        onSave: (value) => libraryProvider.setStudios(value),
        onCancel: () => libraryProvider.setStudios(librarySearchResults.studios),
        onClear: () => libraryProvider.setStudios(librarySearchResults.studios.setAll(false)),
      ),
    if (librarySearchResults.tags.isNotEmpty)
      CategoryChip<String>(
        label: Text(context.localized.label(librarySearchResults.tags.length)),
        activeIcon: Icons.label_rounded,
        items: librarySearchResults.tags,
        labelBuilder: (item) => Text(item),
        onSave: (value) => libraryProvider.setTags(value),
        onCancel: () => libraryProvider.setTags(librarySearchResults.tags),
        onClear: () => libraryProvider.setTags(librarySearchResults.tags.setAll(false)),
      ),
    FilterChip(
      label: Text(context.localized.group),
      selected: librarySearchResults.groupBy != GroupBy.none,
      onSelected: (value) {
        openGroupDialogue();
      },
    ),
    CategoryChip<ItemFilter>(
      label: Text(context.localized.filter(librarySearchResults.filters.length)),
      items: librarySearchResults.filters,
      labelBuilder: (item) => Text(item.label(context)),
      onSave: (value) => libraryProvider.setFilters(value),
      onClear: () => libraryProvider.setFilters(librarySearchResults.filters.setAll(false)),
    ),
    if (librarySearchResults.types[FladderItemType.series] == true)
      FilterChip(
        avatar: Icon(
          librarySearchResults.hideEmptyShows ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        selected: librarySearchResults.hideEmptyShows,
        showCheckmark: false,
        label: Text(context.localized.hideEmpty),
        onSelected: libraryProvider.setHideEmpty,
      ),
    if (librarySearchResults.officialRatings.isNotEmpty)
      CategoryChip<String>(
        label: Text(context.localized.rating(librarySearchResults.officialRatings.length)),
        activeIcon: Icons.star_rate_rounded,
        items: librarySearchResults.officialRatings,
        labelBuilder: (item) => Text(item),
        onSave: (value) => libraryProvider.setRatings(value),
        onCancel: () => libraryProvider.setRatings(librarySearchResults.officialRatings),
        onClear: () => libraryProvider.setRatings(librarySearchResults.officialRatings.setAll(false)),
      ),
    if (librarySearchResults.years.isNotEmpty)
      CategoryChip<int>(
        label: Text(context.localized.year(librarySearchResults.years.length)),
        items: librarySearchResults.years,
        labelBuilder: (item) => Text(item.toString()),
        onSave: (value) => libraryProvider.setYears(value),
        onCancel: () => libraryProvider.setYears(librarySearchResults.years),
        onClear: () => libraryProvider.setYears(librarySearchResults.years.setAll(false)),
      ),
  ];
}
