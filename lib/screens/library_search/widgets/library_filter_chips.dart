import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/chips/category_chip.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/util/position_provider.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/button_group.dart';

class LibraryFilterChips extends ConsumerStatefulWidget {
  const LibraryFilterChips({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryFilterChipsState();
}

class _LibraryFilterChipsState extends ConsumerState<LibraryFilterChips> {
  @override
  Widget build(BuildContext context) {
    final uniqueKey = widget.key ?? UniqueKey();
    final libraryProvider = ref.watch(librarySearchProvider(uniqueKey).notifier);
    final groupBy = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.filters.groupBy));
    final favourites = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.filters.favourites));
    final recursive = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.filters.recursive));
    final hideEmpty = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.filters.hideEmptyShows));
    final librarySearchResults = ref.watch(librarySearchProvider(uniqueKey));

    final seerrAuthenticated = ref.watch(
      userProvider.select((user) => user?.seerrCredentials?.isConfigured ?? false),
    );

    final chips = [
      if (seerrAuthenticated)
        ExpressiveButton(
          isSelected: true,
          icon: const Icon(IconsaxPlusBold.discover),
          label: Text(context.localized.discover),
          onPressed: () => context.pushRoute(SeerrSearchRoute(mode: SeerrSearchMode.search)),
        ),
      if (librarySearchResults.folderOverwrite.isEmpty)
        CategoryChip(
          label: Text(context.localized.library(2)),
          items: librarySearchResults.views.sortByKey((value) => value.name),
          labelBuilder: (item) => Text(item.name),
          onSave: (value) => libraryProvider.setViews(value),
          onCancel: () => libraryProvider.setViews(librarySearchResults.views),
          onClear: () => libraryProvider.setViews(librarySearchResults.views.setAll(false)),
        ),
      CategoryChip<FladderItemType>(
        label: Text(context.localized.type(librarySearchResults.filters.types.length)),
        items: librarySearchResults.filters.types.sortByKey((value) => value.label(context.localized)),
        activeIcon: IconsaxPlusBold.filter_tick,
        labelBuilder: (item) => Row(
          children: [
            Icon(item.icon),
            const SizedBox(width: 12),
            Text(item.label(context.localized)),
          ],
        ),
        onSave: (value) => libraryProvider.setTypes(value),
        onClear: () => libraryProvider.setTypes(librarySearchResults.filters.types.setAll(false)),
      ),
      ExpressiveButton(
        isSelected: favourites == true,
        icon: favourites == true ? const Icon(IconsaxPlusBold.heart) : null,
        label: Text(context.localized.favorites),
        onPressed: () {
          libraryProvider.toggleFavourite();
          context.refreshData();
        },
      ),
      ExpressiveButton(
        isSelected: recursive == true,
        icon: recursive == true ? const Icon(IconsaxPlusBold.tick_circle) : null,
        label: Text(context.localized.recursive),
        onPressed: () {
          libraryProvider.toggleRecursive();
          context.refreshData();
        },
      ),
      if (librarySearchResults.filters.genres.isNotEmpty)
        CategoryChip<String>(
          label: Text(context.localized.genre(librarySearchResults.filters.genres.length)),
          activeIcon: IconsaxPlusBold.hierarchy_2,
          items: librarySearchResults.filters.genres,
          labelBuilder: (item) => Text(item),
          onSave: (value) => libraryProvider.setGenres(value),
          onCancel: () => libraryProvider.setGenres(librarySearchResults.filters.genres),
          onClear: () => libraryProvider.setGenres(librarySearchResults.filters.genres.setAll(false)),
        ),
      if (librarySearchResults.filters.studios.isNotEmpty)
        CategoryChip<Studio>(
          label: Text(context.localized.studio(librarySearchResults.filters.studios.length)),
          activeIcon: IconsaxPlusBold.airdrop,
          items: librarySearchResults.filters.studios,
          labelBuilder: (item) => Text(item.name),
          onSave: (value) => libraryProvider.setStudios(value),
          onCancel: () => libraryProvider.setStudios(librarySearchResults.filters.studios),
          onClear: () => libraryProvider.setStudios(librarySearchResults.filters.studios.setAll(false)),
        ),
      if (librarySearchResults.filters.tags.isNotEmpty)
        CategoryChip<String>(
          label: Text(context.localized.label(librarySearchResults.filters.tags.length)),
          activeIcon: Icons.label_rounded,
          items: librarySearchResults.filters.tags,
          labelBuilder: (item) => Text(item),
          onSave: (value) => libraryProvider.setTags(value),
          onCancel: () => libraryProvider.setTags(librarySearchResults.filters.tags),
          onClear: () => libraryProvider.setTags(librarySearchResults.filters.tags.setAll(false)),
        ),
      ExpressiveButton(
        isSelected: groupBy != GroupBy.none,
        icon: groupBy != GroupBy.none ? const Icon(IconsaxPlusBold.bag_tick) : null,
        label: Text(context.localized.group),
        onPressed: () {
          _openGroupDialogue(context, ref, libraryProvider, uniqueKey);
        },
      ),
      CategoryChip<ItemFilter>(
        label: Text(context.localized.filter(librarySearchResults.filters.itemFilters.length)),
        items: librarySearchResults.filters.itemFilters,
        labelBuilder: (item) => Text(item.label(context)),
        onSave: (value) => libraryProvider.setFilters(value),
        onClear: () => libraryProvider.setFilters(librarySearchResults.filters.itemFilters.setAll(false)),
      ),
      if (librarySearchResults.filters.types[FladderItemType.series] == true)
        ExpressiveButton(
          isSelected: !hideEmpty,
          icon: !hideEmpty ? const Icon(IconsaxPlusBold.ghost) : null,
          label: Text(!hideEmpty ? context.localized.hideEmpty : context.localized.showEmpty),
          onPressed: libraryProvider.toggleEmptyShows,
        ),
      if (librarySearchResults.filters.officialRatings.isNotEmpty)
        CategoryChip<String>(
          label: Text(context.localized.rating(librarySearchResults.filters.officialRatings.length)),
          activeIcon: Icons.star_rate_rounded,
          items: librarySearchResults.filters.officialRatings,
          labelBuilder: (item) => Text(item),
          onSave: (value) => libraryProvider.setRatings(value),
          onCancel: () => libraryProvider.setRatings(librarySearchResults.filters.officialRatings),
          onClear: () => libraryProvider.setRatings(librarySearchResults.filters.officialRatings.setAll(false)),
        ),
      if (librarySearchResults.filters.years.isNotEmpty)
        CategoryChip<int>(
          label: Text(context.localized.year(librarySearchResults.filters.years.length)),
          items: librarySearchResults.filters.years,
          labelBuilder: (item) => Text(item.toString()),
          onSave: (value) => libraryProvider.setYears(value),
          onCancel: () => libraryProvider.setYears(librarySearchResults.filters.years),
          onClear: () => libraryProvider.setYears(librarySearchResults.filters.years.setAll(false)),
        ),
    ];

    return FocusTraversalGroup(
      policy: ReadingOrderTraversalPolicy(),
      child: Row(
        spacing: 4,
        children: chips.mapIndexed(
          (index, element) {
            final position = index == 0
                ? PositionContext.first
                : (index == chips.length - 1 ? PositionContext.last : PositionContext.middle);
            return PositionProvider(position: position, child: element);
          },
        ).toList(),
      ),
    );
  }

  void _openGroupDialogue(
    BuildContext context,
    WidgetRef ref,
    LibrarySearchNotifier provider,
    Key uniqueKey,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        final groupBy = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.filters.groupBy));
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(context.localized.groupBy),
                ...GroupBy.values.map(
                  (group) => CheckboxListTile(
                    value: groupBy == group,
                    onChanged: (_) {
                      if (group != groupBy) {
                        provider.setGroupBy(group);
                      }
                      Navigator.pop(context);
                    },
                    title: Text(group.value(context)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
