import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';

import 'package:fladder/screens/shared/default_title_bar.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class FladderAppBar extends StatelessWidget implements PreferredSize {
  final double height;
  final String? label;
  final bool automaticallyImplyLeading;
  final bool isDesktop;
  const FladderAppBar({
    this.height = 35,
    this.automaticallyImplyLeading = false,
    this.label,
    required this.isDesktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (AdaptiveLayout.of(context).isDesktop) {
      return PreferredSize(
          preferredSize: Size(double.infinity, height),
          child: SizedBox(
            height: height,
            child: Row(
              children: [
                if (automaticallyImplyLeading && context.router.canPop()) const BackButton(),
                Expanded(
                  child: DefaultTitleBar(
                    label: label,
                  ),
                )
              ],
            ),
          ));
    } else {
      return AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0),
        scrolledUnderElevation: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(),
        title: const Text(""),
        automaticallyImplyLeading: automaticallyImplyLeading,
      );
    }
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => Size(double.infinity, isDesktop ? height : 0);
}
