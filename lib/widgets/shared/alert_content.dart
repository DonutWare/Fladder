import 'package:flutter/material.dart';

class ActionContent extends StatelessWidget {
  final Widget? title;
  final Widget child;
  final List<Widget> actions;
  final bool showDividers;
  final EdgeInsetsGeometry? padding;
  const ActionContent({
    this.title,
    required this.child,
    this.padding,
    this.showDividers = true,
    this.actions = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          if (title != null) ...[
            title!,
            if (showDividers)
              const Divider(
                height: 4,
              ),
          ],
          Flexible(child: child),
          if (actions.isNotEmpty) ...[
            if (showDividers)
              const Divider(
                height: 4,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            )
          ],
        ],
      ),
    );
  }
}
