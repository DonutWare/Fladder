import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';

class NestedSliverAppBar extends ConsumerWidget {
  final BuildContext parent;
  final PageRouteInfo? route;
  const NestedSliverAppBar({required this.parent, this.route, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final buttonStyle = Theme.of(context).filledButtonTheme.style?.copyWith(
          backgroundColor: WidgetStatePropertyAll(
            surfaceColor.withValues(alpha: 0.8),
          ),
        );
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      forceElevated: false,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            surfaceColor.withValues(alpha: 0.7),
            surfaceColor.withValues(alpha: 0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Padding(
          padding: MediaQuery.paddingOf(context).copyWith(bottom: 0),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: IconButton.filledTonal(
                      style: buttonStyle,
                      onPressed: () => Scaffold.of(parent).openDrawer(),
                      icon: const Icon(IconsaxPlusLinear.menu),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Spacer(),
                  const SettingsUserIcon()
                ],
              ),
            ),
          ),
        ),
      ),
      toolbarHeight: 80,
      floating: true,
    );
  }
}
