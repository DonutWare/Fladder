import 'package:flutter/material.dart';

import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/util/localization_helper.dart';

Future<(SortingOptions? sortOptions, SortingOrder? sortingOrder)?> openSortByDialogue(
  BuildContext context, {
  required (SortingOptions sortOptions, SortingOrder sortingOrder) options,
  required LibrarySearchNotifier libraryProvider,
  required Key uniqueKey,
}) async {
  SortingOptions? newSortingOptions = options.$1;
  SortingOrder? newSortOrder = options.$2;
  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, state) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(context.localized.sortBy, style: Theme.of(context).textTheme.titleLarge),
                  ),
                  const SizedBox(height: 8),
                  ...SortingOptions.values.map((e) => RadioGroup(
                        groupValue: newSortingOptions,
                        onChanged: (value) {
                          state(
                            () {
                              newSortingOptions = value;
                            },
                          );
                        },
                        child: RadioListTile.adaptive(
                          value: e,
                          title: Text(e.label(context)),
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(context.localized.sortOrder, style: Theme.of(context).textTheme.titleLarge),
                  ),
                  const SizedBox(height: 8),
                  ...SortingOrder.values.map(
                    (e) => RadioGroup(
                      groupValue: newSortOrder,
                      onChanged: (value) {
                        state(
                          () {
                            newSortOrder = value;
                          },
                        );
                      },
                      child: RadioListTile.adaptive(
                        value: e,
                        title: Text(e.label(context)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
  if (newSortingOptions == null && newSortOrder == null) {
    return null;
  } else {
    return (newSortingOptions, newSortOrder);
  }
}
