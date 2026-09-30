import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/providers/library_filters_provider.dart';
import 'package:fladder/screens/library_search/widgets/library_saved_filters.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/alert_content.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/sortable_item_list.dart';

Future<void> showFiltersDialogue(BuildContext context) {
  return showDialogAdaptive(
    context: context,
    builder: (context) => const FiltersDialog(),
  );
}

class FiltersDialog extends ConsumerWidget {
  const FiltersDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(libraryFiltersProvider([]).notifier);
    final userFilters = ref.watch(libraryFiltersProvider([]));

    return ActionContent(
      child: Column(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.localized.libraryFiltersTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(context.localized.libraryFiltersDesc),
          userFilters.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(context.localized.libraryNoFiltersSaved),
                )
              : Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ...FilterSortKey.values.map(
                        (key) {
                          final filtersForKey = ref.watch(libraryFiltersByKeyProvider(key));
                          return ExpansionTile(
                            title: Row(
                              spacing: 6,
                              children: [
                                Icon(key.icon),
                                Text(key.label(context)),
                              ],
                            ),
                            tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                            enabled: filtersForKey.any((filter) => filter.sortKeys[key] == true),
                            children: [
                              SortableItemList(
                                items: filtersForKey.where((filter) => filter.sortKeys[key] == true).toList(),
                                itemBuilder: (filter) {
                                  return FilterListItem(
                                    filter: filter,
                                    moreActions: [
                                      ItemActionButton(
                                        label: Text(context.localized.goTo),
                                        action: () {
                                          filter.navigateTo(context);
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(IconsaxPlusBold.folder_open),
                                      ),
                                    ],
                                  );
                                },
                                onReorder: (reordered) {
                                  provider.updateSortOrder(key, reordered.map((e) => e.id).toList());
                                },
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(),
                      ),
                      Text(context.localized.filter(userFilters.length),
                          style: Theme.of(context).textTheme.titleMedium),
                      ...userFilters.map(
                        (filter) => FilterListItem(
                          filter: filter,
                          moreActions: [
                            ItemActionButton(
                              label: Text(context.localized.goTo),
                              action: () {
                                filter.navigateTo(context);
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(IconsaxPlusBold.folder_open),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.localized.close),
          ),
        ],
      ),
    );
  }
}
