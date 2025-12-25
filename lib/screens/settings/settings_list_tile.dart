import 'package:flutter/material.dart';

import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class SettingsListTileCheckbox extends StatelessWidget {
  final Widget label;
  final Widget? subLabel;
  final Function(bool?) onChanged;
  final bool value;
  const SettingsListTileCheckbox({
    required this.label,
    this.subLabel,
    required this.onChanged,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      label: label,
      subLabel: subLabel,
      onTap: () {
        onChanged(!value);
      },
      trailing: Switch(
        value: value,
        onChanged: onChanged,
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
            padding: const EdgeInsets.only(right: 12.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 125),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: selected ? 1 : 0),
                borderRadius: BorderRadius.circular(selected ? 5 : 20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: (leading ?? iconWidget),
              ),
            ),
          )
        : leading;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.surfaceContainerLow : Colors.transparent,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ).copyWith(
              left: (leading ?? iconWidget) != null ? 0 : null,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
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
                          padding: const EdgeInsets.only(left: 16),
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
