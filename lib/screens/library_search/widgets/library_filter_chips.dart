import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/screens/library_search/widgets/library_views.dart';
import 'package:fladder/screens/shared/chips/category_chip.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/util/refresh_state.dart';

class LibraryFilterChips extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return _LibraryChipsRow(
      uniqueKey: uniqueKey,
      librarySearchResults: librarySearchResults,
      libraryProvider: libraryProvider,
      postersList: postersList,
      libraryViewType: libraryViewType,
    );
  }
}

class _LibraryChipsRow extends ConsumerWidget {
  final Key uniqueKey;
  final LibrarySearchModel librarySearchResults;
  final LibrarySearchNotifier libraryProvider;
  final List<ItemBaseModel> postersList;
  final LibraryViewTypes libraryViewType;

  const _LibraryChipsRow({
    required this.uniqueKey,
    required this.librarySearchResults,
    required this.libraryProvider,
    required this.postersList,
    required this.libraryViewType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupBy = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.groupBy));
    final favourites = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.favourites));
    final recursive = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.recursive));
    final hideEmpty = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.hideEmptyShows));

    return Row(
      spacing: 8,
      children: [
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
            favourites ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          selected: favourites,
          showCheckmark: false,
          onSelected: (_) {
            libraryProvider.toggleFavourite();
            context.refreshData();
          },
        ),
        FilterChip(
          label: Text(context.localized.recursive),
          selected: recursive,
          onSelected: (_) {
            libraryProvider.toggleRecursive();
            context.refreshData();
          },
        ),
        if (librarySearchResults.genres.isNotEmpty)
          CategoryChip<String>(
            label: Text(context.localized.genre(librarySearchResults.genres.length)),
            activeIcon: IconsaxPlusBold.hierarchy_2,
            items: librarySearchResults.genres,
            labelBuilder: (item) => Text(item),
            onSave: (value) => libraryProvider.setGenres(value),
            onCancel: () => libraryProvider.setGenres(librarySearchResults.genres),
            onClear: () => libraryProvider.setGenres(librarySearchResults.genres.setAll(false)),
          ),
        if (librarySearchResults.studios.isNotEmpty)
          CategoryChip<Studio>(
            label: Text(context.localized.studio(librarySearchResults.studios.length)),
            activeIcon: IconsaxPlusBold.airdrop,
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
          selected: groupBy != GroupBy.none,
          onSelected: (_) {
            _openGroupDialogue(context, ref, libraryProvider, uniqueKey);
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
              hideEmpty ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            selected: hideEmpty,
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
      ],
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
      builder: (_) {
        final groupBy = ref.watch(librarySearchProvider(uniqueKey).select((v) => v.groupBy));
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(context.localized.groupBy),
                ...GroupBy.values.map(
                  (group) => RadioListTile.adaptive(
                    value: group,
                    groupValue: groupBy,
                    title: Text(group.value(context)),
                    onChanged: (_) {
                      provider.setGroupBy(group);
                      Navigator.pop(context);
                    },
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
