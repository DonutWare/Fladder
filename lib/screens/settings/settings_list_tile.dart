import 'package:flutter/material.dart';

import 'package:fladder/screens/shared/flat_button.dart';

class SettingsListTile extends StatelessWidget {
  final Widget label;
  final Widget? subLabel;
  final Widget? trailing;
  final bool selected;
  final bool autoFocus;
  final IconData? icon;
  final Widget? leading;
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
    this.contentColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = icon != null ? Icon(icon) : null;

    final leadingWidget = (leading ?? iconWidget) != null
        ? Padding(
            padding: const EdgeInsets.only(left: 8, right: 16.0),
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
        : leading ?? const SizedBox();
    return Card(
      elevation: selected ? 2 : 0,
      color: selected ? Theme.of(context).colorScheme.surfaceContainerLow : Colors.transparent,
      shadowColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
      margin: EdgeInsets.zero,
      child: FlatButton(
        onTap: onTap,
        autoFocus: autoFocus,
        onFocusChange: (value) {
          if (value) {
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 250),
              alignment: 0.5,
              curve: Curves.easeOut,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ).copyWith(
            left: (leading ?? iconWidget) != null ? 0 : null,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          color: Colors.transparent,
                          textStyle: Theme.of(context).textTheme.titleLarge,
                          child: label,
                        ),
                        if (subLabel != null)
                          Opacity(
                            opacity: 0.65,
                            child: Material(
                              color: Colors.transparent,
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              child: subLabel,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (trailing != null)
                    ExcludeFocusTraversal(
                      excluding: onTap != null,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: trailing,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
