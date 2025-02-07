import 'package:flutter/material.dart';

Future<List<T>> openMultiSelectOptions<T>(
  BuildContext context, {
  required String label,
  bool allowMultiSelection = false,
  bool forceAtleastOne = true,
  required List<T> selected,
  required List<T> items,
  Function(List<T> values)? onChanged,
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
                  onChanged?.call(currentSelection.toList());
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
