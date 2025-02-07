import 'package:flutter/material.dart';

Future<void> openOptionDialogue<T>(
  BuildContext context, {
  required String label,
  required List<T> items,
  bool isNullable = false,
  required Widget Function(T? type) itemBuilder,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(label),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              if (isNullable) itemBuilder(null),
              ...items.map(
                (e) => itemBuilder(e),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<List<T>> openMultiSelectOptions<T>(
  BuildContext context, {
  required String label,
  bool allowMultiSelection = false,
  bool forceAtleastOne = true,
  required List<T> selected,
  required List<T> items,
  required Widget Function(T type, bool selected, Function onTap) itemBuilder,
}) async {
  Set<T> currentSelection = selected.toSet();
  await showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(label),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: items.map((item) {
              bool isSelected = currentSelection.contains(item);

              return itemBuilder(
                item,
                isSelected,
                () {
                  setState(() {
                    if (allowMultiSelection) {
                      if (isSelected) {
                        if (!forceAtleastOne || currentSelection.length > 1) {
                          currentSelection.remove(item);
                        }
                      } else {
                        currentSelection.add(item);
                      }
                    } else {
                      currentSelection = {item};
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
    ),
  );
  return currentSelection.toList();
}
