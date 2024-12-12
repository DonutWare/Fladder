import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/navigation_scaffold.dart';

enum HomeTabs {
  dashboard,
  favorites,
  sync;
}

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canDownload = ref.watch(showSyncButtonProviderProvider);
    final destinations = HomeTabs.values.map((e) {
      switch (e) {
        case HomeTabs.dashboard:
          return DestinationModel(
            label: context.localized.navigationDashboard,
            icon: const Icon(IconsaxOutline.home),
            selectedIcon: const Icon(IconsaxBold.home),
            route: const DashboardRoute(),
            action: () => context.router.navigate(const DashboardRoute()),
            floatingActionButton: AdaptiveFab(
              context: context,
              title: context.localized.search,
              key: Key(e.name.capitalize()),
              onPressed: () => context.router.navigate(LibrarySearchRoute()),
              child: const Icon(IconsaxOutline.search_normal_1),
            ),
          );
        case HomeTabs.favorites:
          return DestinationModel(
            label: context.localized.navigationFavorites,
            icon: const Icon(IconsaxOutline.heart),
            selectedIcon: const Icon(IconsaxBold.heart),
            route: const FavouritesRoute(),
            floatingActionButton: AdaptiveFab(
              context: context,
              title: context.localized.filter(0),
              key: Key(e.name.capitalize()),
              onPressed: () => context.router.navigate(LibrarySearchRoute(favourites: true)),
              child: const Icon(IconsaxOutline.heart_search),
            ),
            action: () => context.router.navigate(const FavouritesRoute()),
          );
        case HomeTabs.sync:
          if (canDownload) {
            return DestinationModel(
              label: context.localized.navigationSync,
              icon: const Icon(IconsaxOutline.cloud),
              selectedIcon: const Icon(IconsaxBold.cloud),
              route: SyncedRoute(),
              action: () => context.router.navigate(SyncedRoute()),
            );
          }
          return null;
      }
    });
    return HeroControllerScope(
      controller: HeroController(),
      child: AutoRouter(
        builder: (context, child) {
          return NavigationScaffold(
            destinations: destinations.whereNotNull().toList(),
            currentRouteName: context.router.current.name,
            nestedChild: child,
          );
        },
      ),
    );
  }
}
