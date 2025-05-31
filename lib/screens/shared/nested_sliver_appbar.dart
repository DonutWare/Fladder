import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';
import 'package:fladder/widgets/shared/shapes.dart';

class NestedSliverAppBar extends ConsumerWidget {
  final BuildContext parent;
  final String? searchTitle;
  final PageRouteInfo? route;
  const NestedSliverAppBar({required this.parent, this.route, this.searchTitle, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 16,
      forceElevated: true,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: AppBarShape(),
      title: SizedBox(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              IconButton(
                onPressed: () => Scaffold.of(parent).openDrawer(),
                icon: const Icon(IconsaxPlusLinear.menu),
                padding: EdgeInsets.zero,
              ),
              Expanded(
                child: Hero(
                  tag: "PrimarySearch",
                  child: Card(
                    elevation: 3,
                    shadowColor: Colors.transparent,
                    child: InkWell(
                      onTap: route != null
                          ? () {
                              route?.push(context);
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Opacity(
                          opacity: 0.65,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(IconsaxPlusLinear.search_normal),
                              const SizedBox(width: 16),
                              Transform.translate(
                                offset: const Offset(0, 1.5),
                                child: Text(searchTitle ?? "${context.localized.search}..."),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SettingsUserIcon()
            ],
          ),
        ),
      ),
      toolbarHeight: 80,
      floating: true,
    );
  }
}
