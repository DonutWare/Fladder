import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final provider = ref.watch(librarySearchProvider(providerKey).notifier);
    final currentFilters = ref.watch(librarySearchProvider(providerKey).select((value) => value.filters));
    final filters = ref.watch(provider.filterProvider);
    final filterProvider = ref.watch(provider.filterProvider.notifier);
    final anyFilterSelected = filters.any((element) => element.filter == currentFilters);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.localized.filter(2),
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
                        final isCurrentFilter = filter.filter == currentFilters;
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Card(
                            color: isCurrentFilter
                                ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.75)
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(spacing: 8, children: [
                                Expanded(
                                  child: OutlinedTextField(
                                    fillColor: Colors.transparent,
                                    controller: TextEditingController(text: filter.name),
                                    onSubmitted: (value) => provider.updateFilter(filter.copyWith(name: value)),
                                  ),
                                ),
                                IconButton.filledTonal(
                                  onPressed: isCurrentFilter ? null : () => provider.loadModel(filter.filter),
                                  icon: const Icon(IconsaxPlusBold.filter_add),
                                ),
                                IconButton.filledTonal(
                                  tooltip: context.localized.defaultFilterForLibrary,
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      filter.isFavourite ? Colors.yellowAccent.shade700.withValues(alpha: 0.5) : null,
                                    ),
                                  ),
                                  onPressed: () =>
                                      filterProvider.saveFilter(filter.copyWith(isFavourite: !filter.isFavourite)),
                                  icon: Icon(
                                    color: filter.isFavourite ? Colors.yellowAccent : null,
                                    filter.isFavourite ? IconsaxPlusBold.star_1 : IconsaxPlusLinear.star_1,
                                  ),
                                ),
                                IconButton.filledTonal(
                                  tooltip: context.localized.updateFilterForLibrary,
                                  onPressed:
                                      isCurrentFilter || anyFilterSelected ? null : () => provider.updateFilter(filter),
                                  icon: const Icon(IconsaxPlusBold.refresh),
                                ),
                                IconButton.filledTonal(
                                  tooltip: context.localized.delete,
                                  onPressed: () {
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
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Theme.of(context).colorScheme.errorContainer),
                                    iconColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onErrorContainer),
                                    foregroundColor:
                                        WidgetStatePropertyAll(Theme.of(context).colorScheme.onErrorContainer),
                                  ),
                                  icon: const Icon(IconsaxPlusLinear.trash),
                                ),
                              ]),
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
            if (filters.length < 10 && !anyFilterSelected)
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
            else if (filters.length >= 10)
              Text(context.localized.libraryFiltersLimitReached),
            ElevatedButton(
              onPressed: () {
                showDefaultAlertDialog(
                  context,
                  context.localized.libraryFiltersRemoveAll,
                  context.localized.libraryFiltersRemoveAllConfirm,
                  (context) {
                    filterProvider.deleteAllFilters();
                    Navigator.of(context).pop();
                  },
                  context.localized.delete,
                  (context) {
                    Navigator.of(context).pop();
                  },
                  context.localized.cancel,
                );
              },
              child: Text(context.localized.libraryFiltersRemoveAll),
            ),
          ],
        ),
      ),
    );
  }
}
