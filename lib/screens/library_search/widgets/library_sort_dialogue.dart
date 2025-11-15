import 'package:flutter/material.dart';

import 'package:fladder/models/library_search/library_search_options.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

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
                  ...SortingOptions.values.map(
                    (e) => _CheckBoxListItem(
                      value: e,
                      current: newSortingOptions,
                      onSelected: (value) => state(() => newSortingOptions = e),
                      title: Text(e.label(context)),
                    ),
                  ),
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
                    (e) => _CheckBoxListItem(
                      value: e,
                      current: newSortOrder,
                      onSelected: (value) => state(() => newSortOrder = e),
                      title: Text(e.label(context)),
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

class _CheckBoxListItem<T> extends StatelessWidget {
  final T value;
  final T current;
  final Widget? title;
  final Function(T selected) onSelected;
  const _CheckBoxListItem({
    required this.value,
    required this.current,
    required this.onSelected,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: current == value,
      onFocusChange: (value) {
        if (value) {
          context.ensureVisible();
        }
      },
      onChanged: (newState) {
        if (newState == true) {
          onSelected(value);
        }
      },
      title: title,
    );
  }
}
