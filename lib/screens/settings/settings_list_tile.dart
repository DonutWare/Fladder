import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final Widget label;
  final Widget? subLabel;
  final Widget? trailing;
  final bool selected;
  final IconData? icon;
  final Widget? suffix;
  final Color? contentColor;
  final Function()? onTap;
  const SettingsListTile({
    required this.label,
    this.subLabel,
    this.trailing,
    this.selected = false,
    this.suffix,
    this.icon,
    this.contentColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = icon != null ? Icon(icon) : null;
    return Card(
      elevation: selected ? 2 : 0,
      color: selected ? null : Colors.transparent,
      shadowColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
      margin: EdgeInsets.zero,
      child: MediaQuery(
        data: const MediaQueryData(padding: EdgeInsets.zero),
        child: ListTile(
          minVerticalPadding: 12,
          minLeadingWidth: 16,
          minTileHeight: 75,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          horizontalTitleGap: 0,
          titleAlignment: ListTileTitleAlignment.center,
          contentPadding: const EdgeInsets.only(right: 12, left: 2),
          leading: (suffix ?? iconWidget) != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 125),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(selected ? 1 : 0),
                      borderRadius: BorderRadius.circular(selected ? 5 : 20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                      child: (suffix ?? iconWidget),
                    ),
                  ),
                )
              : suffix ?? const SizedBox(),
          title: label,
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
          trailing: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: trailing,
          ),
          selected: selected,
          textColor: contentColor,
          iconColor: contentColor,
          subtitle: subLabel,
          onTap: onTap,
        ),
      ),
    );
  }
}
