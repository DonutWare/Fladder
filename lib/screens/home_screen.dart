import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
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
    final destinations = HomeTabs.values
        .map((e) {
          switch (e) {
            case HomeTabs.dashboard:
              return DestinationModel(
                label: context.localized.navigationDashboard,
                icon: const Icon(IconsaxPlusLinear.home),
                selectedIcon: const Icon(IconsaxPlusBold.home),
                route: const DashboardRoute(),
                action: () => context.router.navigate(const DashboardRoute()),
                floatingActionButton: AdaptiveFab(
                  context: context,
                  title: context.localized.search,
                  key: Key(e.name.capitalize()),
                  onPressed: () => context.router.navigate(LibrarySearchRoute()),
                  child: const Icon(IconsaxPlusLinear.search_normal_1),
                ),
              );
            case HomeTabs.favorites:
              return DestinationModel(
                label: context.localized.navigationFavorites,
                icon: const Icon(IconsaxPlusLinear.heart),
                selectedIcon: const Icon(IconsaxPlusBold.heart),
                route: const FavouritesRoute(),
                floatingActionButton: AdaptiveFab(
                  context: context,
                  title: context.localized.filter(0),
                  key: Key(e.name.capitalize()),
                  onPressed: () => context.router.navigate(LibrarySearchRoute(favourites: true)),
                  child: const Icon(IconsaxPlusLinear.heart_search),
                ),
                action: () => context.router.navigate(const FavouritesRoute()),
              );
            case HomeTabs.sync:
              if (canDownload) {
                return DestinationModel(
                  label: context.localized.navigationSync,
                  icon: const Icon(IconsaxPlusLinear.cloud),
                  selectedIcon: const Icon(IconsaxPlusBold.cloud),
                  route: SyncedRoute(),
                  action: () => context.router.navigate(SyncedRoute()),
                );
              }
              return null;
          }
        })
        .nonNulls
        .toList();
    return HeroControllerScope(
      controller: HeroController(),
      child: AutoRouter(
        builder: (context, child) {
          return NavigationScaffold(
            destinations: destinations.nonNulls.toList(),
            currentRouteName: context.router.current.name,
            nestedChild: child,
          );
        },
      ),
    );
  }
}
