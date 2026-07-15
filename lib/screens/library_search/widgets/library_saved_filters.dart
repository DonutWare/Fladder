import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/library_filter_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

Future<void> showSavedFilters(
  BuildContext context,
  Key providerKey,
) {
  return showDialog(
    context: context,
    builder: (context) => LibrarySavedFiltersDialogue(
      providerKey: providerKey,
    ),
  );
}

class LibrarySavedFiltersDialogue extends ConsumerWidget {
  final Key providerKey;

  const LibrarySavedFiltersDialogue({
    super.key,
    required this.providerKey,
  });

  bool _isCurrentFilter(LibraryFilterModel filter, LibraryFilterModel currentFilters) {
    return filter == currentFilters;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final provider = ref.watch(librarySearchProvider(providerKey).notifier);

    final folderOverwrite = ref.watch(librarySearchProvider(providerKey).select((value) => value.folderOverwrite));
    final views = ref.watch(librarySearchProvider(providerKey).select((value) => value.views.included));

    final currentFilters = ref.watch(librarySearchProvider(providerKey).select((value) => value.filters));

    final filters = ref.watch(provider.filterProvider);
    final filterProvider = ref.watch(provider.filterProvider.notifier);

    final anyFilterSelected = filters.any(
      (element) => _isCurrentFilter(element.filter, currentFilters),
    );

    final activeLibraries = views.map((e) => e.name).join(", ");
    final folderNames = folderOverwrite.map((e) => e.name).join(", ");
    final libraryNames = folderNames.isNotEmpty ? folderNames : activeLibraries;

    List<ItemActionButton> filterActions(LibraryFiltersModel filter, bool isCurrentFilter) => [
          ItemActionButton(
            label: Text(context.localized.applyFilter),
            action: isCurrentFilter
                ? null
                : () {
                    provider.loadModel(filter);
                  },
            icon: const Icon(IconsaxPlusBold.filter_add),
          ),
          if (views.length == 1 || folderOverwrite.length == 1)
            ItemActionButton(
              label: Text(context.localized.defaultFilterForLibrary),
              backgroundColor: filter.isFavourite ? Colors.yellowAccent.shade700.withValues(alpha: 0.5) : null,
              foregroundColor: filter.isFavourite ? Colors.yellowAccent : null,
              action: () => provider.saveFilter(filter.copyWith(isFavourite: !filter.isFavourite)),
              icon: Icon(
                color: filter.isFavourite ? Colors.yellowAccent : null,
                filter.isFavourite ? IconsaxPlusBold.star_1 : IconsaxPlusLinear.star_1,
              ),
            ),
          ItemActionButton(
            label: Text(context.localized.showInSideBar),
            backgroundColor: filter.showInSideBar ? Colors.lightBlueAccent.shade700.withValues(alpha: 0.5) : null,
            foregroundColor: filter.showInSideBar ? Colors.lightBlueAccent : null,
            action: () => provider.saveFilter(filter.copyWith(showInSideBar: !filter.showInSideBar)),
            icon: Icon(
              color: filter.showInSideBar ? Colors.lightBlueAccent : null,
              filter.showInSideBar ? IconsaxPlusBold.menu : IconsaxPlusLinear.menu_1,
            ),
          ),
          ItemActionButton(
            label: Text(context.localized.updateFilterForLibrary),
            action: isCurrentFilter ? null : () => provider.updateFilter(filter),
            icon: const Icon(IconsaxPlusBold.refresh),
          ),
          ItemActionButton(
            label: Text(context.localized.delete),
            action: () {
              showDefaultAlertDialog(
                context,
                context.localized.removeFilterForLibrary(filter.name),
                context.localized.deleteFilterConfirmation,
                (context) {
                  filterProvider.removeFilter(filter);
                  Navigator.of(context).pop();
                },
                context.localized.delete,
                (context) {
                  Navigator.of(context).pop();
                },
                context.localized.cancel,
              );
            },
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            icon: const Icon(IconsaxPlusLinear.trash),
          ),
        ];

    final smallSize = AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${context.localized.filter(filters.length)} for $libraryNames",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (filters.isNotEmpty) ...[
              const Divider(),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...filters.map(
                      (filter) {
                        final isCurrentFilter = _isCurrentFilter(filter.filter, currentFilters);
                        return Container(
                          key: ValueKey(filter.id),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Card(
                            color: isCurrentFilter
                                ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.75)
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                spacing: 8,
                                children: [
                                  Expanded(
                                    child: OutlinedTextField(
                                      fillColor: Colors.transparent,
                                      controller: TextEditingController(text: filter.name),
                                      onSubmitted: (value) => provider.updateFilterName(
                                        filter.copyWith(name: value),
                                      ),
                                    ),
                                  ),
                                  if (smallSize)
                                    PopupMenuButton(
                                      icon: const Icon(IconsaxPlusLinear.more),
                                      itemBuilder: (context) => filterActions(filter, isCurrentFilter)
                                          .map((e) => e.toPopupMenuItem(useIcons: true))
                                          .toList(),
                                    )
                                  else
                                    ...filterActions(filter, isCurrentFilter).map((e) => e.toButton()),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
            if (!anyFilterSelected)
              StatefulBuilder(builder: (context, setState) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      child: Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: OutlinedTextField(
                              controller: controller,
                              label: context.localized.name,
                              onChanged: (value) => setState(() {}),
                              onSubmitted: (value) => provider.saveFiltersNew(value),
                            ),
                          ),
                          FilledButton(
                            onPressed: controller.text.isEmpty
                                ? null
                                : () {
                                    provider.saveFiltersNew(controller.text);
                                  },
                            child: Row(
                              spacing: 8,
                              children: [Text(context.localized.save), const Icon(IconsaxPlusLinear.save_2)],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
          ],
        ),
      ),
    );
  }
}
