import 'package:flutter/material.dart';

import 'package:fladder/util/list_padding.dart';

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
      padding: padding ?? MediaQuery.paddingOf(context).add(const EdgeInsets.symmetric(horizontal: 16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            title!,
            if (showDividers)
              const Divider(
                height: 4,
              ),
          ],
          Expanded(child: child),
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
        ].addInBetween(const SizedBox(height: 16)),
      ),
    );
  }
}
