// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

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
  final Color? backgroundColor;
  final Color? foregroundColor;
  ItemActionButton({
    this.selected = false,
    this.icon,
    this.label,
    this.action,
    this.backgroundColor,
    this.foregroundColor,
  });

  ItemActionButton copyWith({
    bool? selected,
    Widget? icon,
    Widget? label,
    Future<void> Function()? action,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return ItemActionButton(
      selected: selected ?? this.selected,
      icon: icon ?? this.icon,
      label: label ?? this.label,
      action: action ?? this.action,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  Color _resolveForegroundColor(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor =
        foregroundColor ?? (selected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface);
    return baseColor.withAlpha(action == null ? 75 : 255);
  }

  Color _resolveBackgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    return backgroundColor ?? (selected ? theme.colorScheme.primaryContainer : Colors.transparent);
  }

  @override
  MenuItemButton toMenuItemButton() => MenuItemButton(
        leadingIcon: icon,
        onPressed: action,
        style: ButtonStyle(
          backgroundColor: backgroundColor == null ? null : WidgetStatePropertyAll(backgroundColor),
          foregroundColor: foregroundColor == null ? null : WidgetStatePropertyAll(foregroundColor),
          iconColor: foregroundColor == null ? null : WidgetStatePropertyAll(foregroundColor),
        ),
        child: label,
      );

  @override
  Widget toButton() => IconButton(onPressed: action, icon: icon ?? const SizedBox.shrink());

  @override
  PopupMenuItem toPopupMenuItem({bool useIcons = false}) {
    return PopupMenuItem(
      onTap: action,
      enabled: action != null,
      child: Builder(
        builder: (context) {
          final resolvedForegroundColor = _resolveForegroundColor(context);

          final child = useIcons
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      if (icon != null) icon!,
                      const SizedBox(width: 8),
                      if (label != null) Flexible(child: label!),
                    ],
                  ),
                )
              : Row(
                  children: [
                    if (label != null) Expanded(child: label!),
                    if (selected) Icon(IconsaxPlusBold.tick_square, size: 24, color: resolvedForegroundColor),
                  ],
                );

          return IconTheme(
            data: IconThemeData(color: resolvedForegroundColor),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: resolvedForegroundColor),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget toLabel() {
    return label ?? const Text("Empty");
  }

  @override
  Widget toListItem(BuildContext context, {bool useIcons = false, bool shouldPop = true}) {
    final foregroundColor = _resolveForegroundColor(context);
    final background = _resolveBackgroundColor(context);
    return ElevatedButton(
      autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad && selected,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(background),
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
                return IconTheme(
                  data: IconThemeData(color: foregroundColor),
                  child: Row(
                    children: [
                      if (icon != null) icon!,
                      const SizedBox(width: 8),
                      if (label != null) Flexible(child: label!),
                    ],
                  ),
                );
              },
            )
          : DefaultTextStyle.merge(
              style: TextStyle(color: foregroundColor),
              child: label ?? const SizedBox.shrink(),
            ),
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
