import 'package:flutter/material.dart';

class ControlPanelInfoItem extends StatelessWidget {
  final Widget? icon;
  final String label;
  final String info;
  const ControlPanelInfoItem({
    super.key,
    this.icon,
    required this.label,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 12,
          children: [
            if (icon != null) ...[
              icon!,
            ],
            Text(label),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
              child: Text(info),
            ),
          ),
        ),
      ],
    );
  }
}
