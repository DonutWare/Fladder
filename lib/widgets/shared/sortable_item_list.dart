import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class SortableItemList<T> extends StatelessWidget {
  final T? selected;
  final List<T> items;
  final List<T>? included;
  final Function(T item) itemBuilder;
  final Function(List<T> items)? onReorder;
  final Function(List<T> items) onIncludeChange;
  final double? maxHeight;
  const SortableItemList({
    this.selected,
    required this.items,
    this.included,
    required this.itemBuilder,
    this.onReorder,
    required this.onIncludeChange,
    this.maxHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bigDragHandles = AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer;
    final list = ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      onReorder: (oldIndex, newIndex) {
        final updatedList = List<T>.from(items);
        final item = updatedList.removeAt(oldIndex);
        updatedList.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
        onReorder?.call(updatedList);
      },
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        final item = items[index];
        return ReorderableDragStartListener(
          key: ValueKey(item),
          index: index,
          enabled: onReorder != null && bigDragHandles,
          child: MouseRegion(
            cursor: bigDragHandles ? SystemMouseCursors.grab : SystemMouseCursors.basic,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (included != null)
                    Checkbox(
                      value: included?.contains(item) ?? false,
                      onChanged: (value) {
                        final updatedIncluded = List<T>.from(included ?? []);
                        if (value == true) {
                          updatedIncluded.add(item);
                        } else {
                          updatedIncluded.remove(item);
                        }
                        onIncludeChange(updatedIncluded);
                      },
                    ),
                  Expanded(child: itemBuilder(item)),
                  if (items.length > 1 && onReorder != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(IconsaxPlusBold.arrow_up_1),
                          onPressed: index > 0
                              ? () {
                                  final updatedList = List<T>.from(items);
                                  final temp = updatedList[index - 1];
                                  updatedList[index - 1] = updatedList[index];
                                  updatedList[index] = temp;
                                  onReorder?.call(updatedList);
                                }
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(IconsaxPlusBold.arrow_down),
                          onPressed: index < items.length - 1
                              ? () {
                                  final updatedList = List<T>.from(items);
                                  final temp = updatedList[index + 1];
                                  updatedList[index + 1] = updatedList[index];
                                  updatedList[index] = temp;
                                  onReorder?.call(updatedList);
                                }
                              : null,
                        ),
                        ReorderableDragStartListener(
                          index: index,
                          enabled: !bigDragHandles,
                          child: const Icon(
                            IconsaxPlusLinear.menu,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (maxHeight != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? 150,
        ),
        child: SingleChildScrollView(
          child: list,
        ),
      );
    }
    return list;
  }
}
