import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/library_search/library_search_model.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';

Future<void> showSavedFilters(
  BuildContext context,
  LibrarySearchModel model,
  LibrarySearchNotifier provider,
) {
  return showDialog(
    context: context,
    builder: (context) => LibrarySavedFiltersDialogue(
      searchModel: model,
      provider: provider,
    ),
  );
}

class LibrarySavedFiltersDialogue extends ConsumerWidget {
  final LibrarySearchModel searchModel;
  final LibrarySearchNotifier provider;
  const LibrarySavedFiltersDialogue({
    required this.searchModel,
    required this.provider,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final filters = ref.watch(provider.filterProvider);
    final filterProvider = ref.watch(provider.filterProvider.notifier);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Card(
                            child: FlatButton(
                              onTap: () => provider.loadModel(filter),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(filter.name)),
                                    IconButton.filledTonal(
                                      tooltip: context.localized.defaultFilterForLibrary,
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          filter.isFavourite ? Colors.yellowAccent.shade700.withOpacity(0.5) : null,
                                        ),
                                      ),
                                      onPressed: () =>
                                          filterProvider.saveFilter(filter.copyWith(isFavourite: !filter.isFavourite)),
                                      icon: Icon(
                                        color: filter.isFavourite ? Colors.yellowAccent : null,
                                        filter.isFavourite ? IconsaxBold.star_1 : IconsaxOutline.star,
                                      ),
                                    ),
                                    IconButton.filledTonal(
                                      tooltip: context.localized.updateFilterForLibrary,
                                      onPressed: () => provider.updateFilter(filter),
                                      icon: const Icon(IconsaxBold.refresh),
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
                                        foregroundColor:
                                            WidgetStatePropertyAll(Theme.of(context).colorScheme.onErrorContainer),
                                      ),
                                      icon: const Icon(IconsaxOutline.trash),
                                    ),
                                  ].addInBetween(const SizedBox(width: 8)),
                                ),
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
            if (filters.length < 10)
              Row(
                children: [
                  Flexible(
                    child: OutlinedTextField(
                      controller: controller,
                      label: context.localized.name,
                      onSubmitted: (value) => provider.saveFiltersNew(value),
                    ),
                  ),
                  const SizedBox(width: 6),
                  FilledButton.tonal(
                    onPressed: () => provider.saveFiltersNew(controller.text),
                    child: const Icon(IconsaxOutline.save_2),
                  ),
                ],
              )
            else
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