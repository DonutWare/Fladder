import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/map_bool_helper.dart';
import 'package:fladder/widgets/shared/button_group.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/modal_side_sheet.dart';

class CategoryChip<T> extends StatelessWidget {
  final Map<T, bool> items;
  final Widget label;
  final Widget? dialogueTitle;
  final Widget Function(T item) labelBuilder;
  final IconData? activeIcon;
  final Function(Map<T, bool> value)? onSave;
  final VoidCallback? onCancel;
  final VoidCallback? onClear;
  final VoidCallback? onDismiss;
  const CategoryChip({
    required this.label,
    this.dialogueTitle,
    this.activeIcon,
    required this.items,
    required this.labelBuilder,
    this.onSave,
    this.onCancel,
    this.onClear,
    this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var selection = items.included.isNotEmpty;
    return ExpressiveButton(
      isSelected: selection,
      icon: selection ? Icon(activeIcon ?? IconsaxPlusBold.archive_tick) : null,
      label: Row(
        spacing: 6,
        children: [
          label,
          const Icon(
            IconsaxPlusLinear.arrow_down,
            size: 16,
          )
        ],
      ),
      onPressed: items.isNotEmpty
          ? () async {
              final newEntry = await openActionSheet(context);
              if (newEntry != null) {
                onSave?.call(newEntry);
              }
            }
          : null,
    );
  }

  Future<Map<T, bool>?> openActionSheet(BuildContext context) async {
    Map<T, bool>? newEntry;
    List<Widget> actions() => [
          FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).pop();
              newEntry = null;
              onCancel?.call();
            },
            child: Text(context.localized.cancel),
          ),
          if (onClear != null)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                newEntry = null;
                onClear!();
              },
              icon: const Icon(IconsaxPlusLinear.back_square),
              label: Text(context.localized.clear),
            )
        ].addInBetween(const SizedBox(width: 6));
    Widget header(BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              textStyle: Theme.of(context).textTheme.titleLarge,
              child: dialogueTitle ?? label,
            ),
            Row(
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    Navigator.of(context).pop();
                    newEntry = null;
                    onCancel?.call();
                  },
                  child: Text(context.localized.cancel),
                ),
                if (onClear != null)
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      newEntry = null;
                      onClear!();
                    },
                    icon: const Icon(IconsaxPlusLinear.back_square),
                    label: Text(context.localized.clear),
                  )
              ].addInBetween(const SizedBox(width: 6)),
            ),
          ],
        );

    if (AdaptiveLayout.viewSizeOf(context) != ViewSize.phone) {
      await showModalSideSheet(
        context,
        addDivider: true,
        header: dialogueTitle ?? label,
        actions: actions(),
        content: CategoryChipEditor(
            labelBuilder: labelBuilder,
            items: items,
            onChanged: (value) {
              newEntry = value;
            }),
        onDismiss: () {
          if (newEntry != null) {
            onSave?.call(newEntry!);
          }
        },
      );
    } else {
      await showBottomSheetPill(
        context: context,
        content: (context, scrollController) => ListView(
          shrinkWrap: true,
          controller: scrollController,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: header(context),
            ),
            const Divider(),
            CategoryChipEditor(
                labelBuilder: labelBuilder,
                controller: scrollController,
                items: items,
                onChanged: (value) => newEntry = value),
          ],
        ),
        onDismiss: () {
          if (newEntry != null) {
            onSave?.call(newEntry!);
          }
        },
      );
    }
    return newEntry;
  }
}

class CategoryChipEditor<T> extends StatefulWidget {
  final Map<T, bool> items;
  final Widget Function(T item) labelBuilder;
  final Function(Map<T, bool> value) onChanged;
  final ScrollController? controller;
  const CategoryChipEditor({
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.controller,
    super.key,
  });

  @override
  State<CategoryChipEditor<T>> createState() => _CategoryChipEditorState<T>();
}

class _CategoryChipEditorState<T> extends State<CategoryChipEditor<T>> {
  late Map<T, bool?> currentState = Map.fromEntries(widget.items.entries);
  @override
  Widget build(BuildContext context) {
    Iterable<MapEntry<T, bool>> activeItems = widget.items.entries.where((element) => element.value);
    Iterable<MapEntry<T, bool>> otherItems = widget.items.entries.where((element) => !element.value);
    return ListView(
      shrinkWrap: true,
      controller: widget.controller,
      children: [
        if (activeItems.isNotEmpty == true) ...{
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.localized.active,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...activeItems.mapIndexed((index, element) {
            return Builder(builder: (context) {
              return CheckboxListTile(
                value: currentState[element.key],
                title: widget.labelBuilder(element.key),
                onFocusChange: (value) {
                  if (value) {
                    context.ensureVisible();
                  }
                },
                fillColor: WidgetStateProperty.resolveWith(
                  (states) {
                    if (currentState[element.key] == null) {
                      return Colors.redAccent;
                    }
                    return null;
                  },
                ),
                tristate: true,
                onChanged: (value) => updateKey(MapEntry(element.key, value == null ? null : element.value)),
              );
            });
          }),
          const Divider(),
        },
        ...otherItems.mapIndexed((index, element) {
          return Builder(builder: (context) {
            return CheckboxListTile(
              value: currentState[element.key],
              title: widget.labelBuilder(element.key),
              onFocusChange: (value) {
                if (value) {
                  context.ensureVisible();
                }
              },
              fillColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (currentState[element.key] == null || states.contains(WidgetState.selected)) {
                    return Colors.greenAccent;
                  }
                  return null;
                },
              ),
              tristate: true,
              onChanged: (value) => updateKey(MapEntry(element.key, value != false ? null : element.value)),
            );
          });
        }),
      ],
    );
  }

  void updateKey(MapEntry<T, bool?> entry) {
    setState(() {
      currentState.update(
        entry.key,
        (value) => entry.value,
      );
    });
    widget.onChanged(Map.from(currentState.map(
      (key, value) {
        final origKey = widget.items[key] == true;
        return MapEntry(key, origKey ? (value == null ? false : origKey) : (value == null ? true : origKey));
      },
    )));
  }
}
