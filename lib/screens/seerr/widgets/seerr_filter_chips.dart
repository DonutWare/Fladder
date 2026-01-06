import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/seerr_search_provider.dart';
import 'package:fladder/screens/seerr/widgets/seerr_filter_dialogs.dart';
import 'package:fladder/screens/shared/chips/category_chip.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/util/position_provider.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/button_group.dart';

class SeerrFilterChips extends ConsumerWidget {
  const SeerrFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(seerrSearchProvider);
    final searchMode = searchState.searchMode;
    final filters = searchState.filters;
    final notifier = ref.read(seerrSearchProvider.notifier);
    final watchRegions = searchState.watchProviderRegions;
    final selectedWatchProviders = filters.watchProviders.values.where((v) => v).length;
    final showFilters = searchMode == SeerrSearchMode.discoverMovies || searchMode == SeerrSearchMode.discoverTv;

    final chips = [
      ExpressiveButton(
        isSelected: true,
        icon: Icon(searchMode.icon),
        label: Text(searchMode.label(context)),
        onPressed: () => openSearchModeDialog(context, notifier, searchMode),
      ),
      if (showFilters) ...[
        const VerticalDivider(),
        if (filters.genres.isNotEmpty)
          CategoryChip<SeerrGenre>(
            label: Text(context.localized.genre(filters.genres.values.where((v) => v).length)),
            items: filters.genres,
            activeIcon: IconsaxPlusBold.hierarchy_2,
            labelBuilder: (item) => Text(item.name ?? ''),
            onSave: (value) {
              notifier.setGenres(value);
              context.refreshData();
            },
            onCancel: () => notifier.setGenres(filters.genres),
            onClear: () {
              notifier.setGenres(filters.genres.setAll(false));
              context.refreshData();
            },
          ),
        if (searchMode == SeerrSearchMode.discoverMovies)
          ExpressiveButton(
            isSelected: filters.studio != null,
            icon: filters.studio != null ? const Icon(IconsaxPlusBold.building) : null,
            label: Text(filters.studio?.name ?? context.localized.studio(1)),
            onPressed: () => openStudioDialog(context, notifier, filters),
          ),
        ExpressiveButton(
          isSelected: filters.yearGte != null || filters.yearLte != null,
          icon: const Icon(IconsaxPlusBold.calendar_1),
          label: Text(yearLabel(context, filters)),
          onPressed: () => openYearDialog(context, notifier, filters),
        ),
        if (watchRegions.isNotEmpty)
          ExpressiveButton(
            isSelected: true,
            icon: const Icon(Icons.public),
            label: Text('${context.localized.countryRegion}: ${filters.watchRegion ?? 'US'}'),
            onPressed: () => openWatchRegionDialog(context, notifier, filters, watchRegions),
          ),
        if (filters.watchProviders.isNotEmpty)
          CategoryChip<SeerrWatchProvider>(
            label: Text(context.localized.streamingServices(selectedWatchProviders)),
            activeIcon: IconsaxPlusBold.video,
            items: filters.watchProviders,
            labelBuilder: (item) => Row(
              spacing: 8,
              children: [
                if (item.logoUrl?.isNotEmpty == true)
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: item.logoUrl!,
                        fit: BoxFit.contain,
                        key: ValueKey(item.providerName),
                        placeholder: (context, url) => const SizedBox(),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    ),
                  ),
                Flexible(child: Text(item.providerName ?? '')),
              ],
            ),
            onSave: (value) {
              notifier.setWatchProviders(value);
              notifier.submit();
            },
            onCancel: () => notifier.setWatchProviders(filters.watchProviders),
            onClear: () {
              notifier.setWatchProviders(filters.watchProviders.setAll(false));
              notifier.submit();
            },
          ),
        ExpressiveButton(
          isSelected: filters.voteAverageGte != null || filters.voteAverageLte != null,
          icon: filters.voteAverageGte != null || filters.voteAverageLte != null
              ? const Icon(IconsaxPlusBold.star)
              : null,
          label: Text(ratingLabel(context, filters)),
          onPressed: () => openRatingDialog(context, notifier, filters),
        ),
        if (filters.certifications.isNotEmpty)
          CategoryChip<SeerrCertification>(
            label: Text(context.localized.contentRating),
            items: filters.certifications,
            labelBuilder: (item) => Text(item.certification ?? ''),
            onSave: (value) {
              notifier.setCertifications(value);
              context.refreshData();
            },
            onCancel: () => notifier.setCertifications(filters.certifications),
            onClear: () {
              notifier.setCertifications(filters.certifications.setAll(false));
              context.refreshData();
            },
          ),
        if (searchMode == SeerrSearchMode.discoverMovies)
          ExpressiveButton(
            isSelected: filters.runtimeGte != null || filters.runtimeLte != null,
            icon: filters.runtimeGte != null || filters.runtimeLte != null ? const Icon(IconsaxPlusBold.timer) : null,
            label: Text(runtimeLabel(context, filters)),
            onPressed: () => openRuntimeDialog(context, notifier, filters),
          ),
      ],
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
}
