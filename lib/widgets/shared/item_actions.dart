// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

abstract class ItemAction {
  Widget toMenuItemButton();
  PopupMenuEntry toPopupMenuItem({bool useIcons = false});
  Widget toLabel();
  Widget toListItem(BuildContext context, {bool useIcons = false, bool shouldPop = true});
  Widget toButton();
}

class ItemActionDivider extends ItemAction {
  Widget toWidget() => const Divider();

  @override
  Divider toMenuItemButton() => const Divider();

  @override
  PopupMenuEntry toPopupMenuItem({bool useIcons = false}) => const PopupMenuDivider(height: 3);

  @override
  Widget toLabel() => Container();

  @override
  Widget toListItem(BuildContext context, {bool useIcons = false, bool shouldPop = true}) => const Divider();

  @override
  Widget toButton() => Container();
}

class ItemActionButton extends ItemAction {
  final bool selected;
  final Widget? icon;
  final Widget? label;
  final FutureOr<void> Function()? action;
  ItemActionButton({
    this.selected = false,
    this.icon,
    this.label,
    this.action,
  });

  ItemActionButton copyWith({
    bool? selected,
    Widget? icon,
    Widget? label,
    Future<void> Function()? action,
  }) {
    return ItemActionButton(
      selected: selected ?? this.selected,
      icon: icon ?? this.icon,
      label: label ?? this.label,
      action: action ?? this.action,
    );
  }

  @override
  MenuItemButton toMenuItemButton() => MenuItemButton(leadingIcon: icon, onPressed: action, child: label);

  @override
  Widget toButton() => IconButton(onPressed: action, icon: icon ?? const SizedBox.shrink());

  @override
  PopupMenuItem toPopupMenuItem({bool useIcons = false}) {
    return PopupMenuItem(
      onTap: action,
      child: useIcons
          ? Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Theme(
                  data: ThemeData(
                    iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  child: Row(
                    children: [
                      if (icon != null) icon!,
                      const SizedBox(width: 8),
                      if (label != null) Flexible(child: label!)
                    ],
                  ),
                ),
              );
            })
          : label,
    );
  }

  @override
  Widget toLabel() {
    return label ?? const Text("Empty");
  }

  @override
  Widget toListItem(BuildContext context, {bool useIcons = false, bool shouldPop = true}) {
    final foregroundColor =
        selected ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onSurface;
    return ElevatedButton(
      autofocus: selected,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          selected ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
        minimumSize: const WidgetStatePropertyAll(Size(50, 50)),
        elevation: const WidgetStatePropertyAll(0),
        foregroundColor: WidgetStatePropertyAll(foregroundColor),
        iconColor: WidgetStatePropertyAll(foregroundColor),
      ),
      onPressed: () {
        if (shouldPop) {
          Navigator.of(context).pop();
        }
        action?.call();
      },
      child: useIcons
          ? Builder(
              builder: (context) {
                return Theme(
                  data: ThemeData(
                    iconTheme: IconThemeData(color: foregroundColor),
                  ),
                  child: Row(
                    children: [
                      if (icon != null) icon!,
                      const SizedBox(width: 8),
                      if (label != null) Flexible(child: label!)
                    ],
                  ),
                );
              },
            )
          : label,
    );
  }
}

extension ItemActionExtension on List<ItemAction> {
  List<PopupMenuEntry> popupMenuItems({bool useIcons = false}) => map((e) => e.toPopupMenuItem(useIcons: useIcons))
      .whereNotIndexed((index, element) => (index == 0 && element is PopupMenuDivider))
      .toList();

  List<Widget> menuItemButtonItems() =>
      map((e) => e.toMenuItemButton()).whereNotIndexed((index, element) => (index == 0 && element is Divider)).toList();

  List<Widget> listTileItems(BuildContext context, {bool useIcons = false, bool shouldPop = true}) {
    return map((e) => e.toListItem(context, useIcons: useIcons, shouldPop: shouldPop))
        .whereNotIndexed((index, element) => (index == 0 && element is Divider))
        .toList();
  }
}
