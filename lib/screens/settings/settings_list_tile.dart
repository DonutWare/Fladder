import 'package:flutter/material.dart';

import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class SettingsListTileCheckbox extends StatelessWidget {
  final Widget label;
  final Widget? subLabel;
  final Function(bool?)? onChanged;
  final bool value;
  const SettingsListTileCheckbox({
    required this.label,
    this.subLabel,
    this.onChanged,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      label: label,
      subLabel: subLabel,
      onTap: onChanged != null
          ? () {
              onChanged!(!value);
            }
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class SettingsListTileEnum extends StatelessWidget {
  final Widget label;
  final Widget? subLabel;
  final String? current;
  final Widget? currentWidget;
  final List<ItemAction> Function(BuildContext context) itemBuilder;
  final bool selected;
  final bool autoFocus;
  final IconData? icon;
  final Widget? leading;
  final bool trailingInlineWithLabel;
  final Color? contentColor;

  const SettingsListTileEnum({
    required this.label,
    this.subLabel,
    this.current,
    this.currentWidget,
    required this.itemBuilder,
    this.selected = false,
    this.autoFocus = false,
    this.icon,
    this.leading,
    this.trailingInlineWithLabel = false,
    this.contentColor,
    super.key,
  }) : assert(
          current != null || currentWidget != null,
          "At least one of 'current' or 'currentWidget' must be provided",
        );

  @override
  Widget build(BuildContext context) {
    final itemList = itemBuilder(context);
    final useBottomSheet = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad;
    final hasMultipleItems = itemList.length > 1;

    void openSelectionSheet() {
      if (!hasMultipleItems) return;
      showBottomSheetPill(
        context: context,
        content: (context, scrollController) => ListView(
          shrinkWrap: true,
          controller: scrollController,
          children: [
            const SizedBox(height: 6),
            ...itemList.map((e) => e.toListItem(context)),
          ],
        ),
      );
    }

    return SettingsListTile(
      label: label,
      subLabel: subLabel,
      selected: selected,
      autoFocus: autoFocus,
      icon: icon,
      leading: leading,
      trailingInlineWithLabel: trailingInlineWithLabel,
      contentColor: contentColor,
      onTap: useBottomSheet ? openSelectionSheet : null,
      trailing: EnumBox(
        current: current,
        currentWidget: currentWidget,
        autoFocus: autoFocus,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final Widget label;
  final Widget? subLabel;
  final Widget? trailing;
  final bool selected;
  final bool autoFocus;
  final IconData? icon;
  final Widget? leading;
  final bool trailingInlineWithLabel;
  final Color? contentColor;
  final Function()? onTap;
  const SettingsListTile({
    required this.label,
    this.subLabel,
    this.trailing,
    this.selected = false,
    this.autoFocus = false,
    this.leading,
    this.icon,
    this.trailingInlineWithLabel = false,
    this.contentColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = icon != null ? Icon(icon) : null;

    final leadingWidget = (leading ?? iconWidget) != null
        ? Padding(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 125),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: selected ? 1 : 0),
                borderRadius: BorderRadius.circular(selected ? 5 : 20),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.all(12),
                child: (leading ?? iconWidget),
              ),
            ),
          )
        : leading;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.surfaceContainerLow : Colors.transparent,
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(8),
            bottomStart: Radius.circular(8),
          ),
        ),
        margin: EdgeInsets.zero,
        child: FlatButton(
          onTap: onTap,
          autoFocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad && autoFocus,
          onFocusChange: (value) {
            if (value) {
              context.ensureVisible();
            }
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 6,
            ).copyWith(
              start: (leading ?? iconWidget) != null ? 4 : null,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                spacing: 4,
                children: [
                  if (leadingWidget != null)
                    DefaultTextStyle.merge(
                      style: TextStyle(
                        color: contentColor ?? Theme.of(context).colorScheme.onSurface,
                      ),
                      child: IconTheme(
                        data: IconThemeData(
                          color: contentColor ?? Theme.of(context).colorScheme.onSurface,
                        ),
                        child: leadingWidget,
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: contentColor),
                                child: label,
                              ),
                            ),
                            if (trailing != null && trailingInlineWithLabel) ...[
                              const SizedBox(width: 8),
                              Flexible(
                                child: ExcludeFocusTraversal(
                                  excluding: onTap != null,
                                  child: trailing!,
                                ),
                              ),
                            ]
                          ],
                        ),
                        if (subLabel != null)
                          Material(
                            color: Colors.transparent,
                            textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color:
                                      (contentColor ?? Theme.of(context).colorScheme.onSurface).withValues(alpha: 0.65),
                                ),
                            child: subLabel,
                          ),
                      ],
                    ),
                  ),
                  if (trailing != null && !trailingInlineWithLabel)
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 50, maxWidth: constraints.maxWidth * 0.5),
                      child: ExcludeFocusTraversal(
                        excluding: onTap != null,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 16),
                          child: trailing,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
