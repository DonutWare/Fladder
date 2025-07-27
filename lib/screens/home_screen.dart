import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/navigation_scaffold.dart';

enum HomeTabs {
  dashboard,
  library,
  favorites,
  sync,
  ;

  const HomeTabs();

  IconData get icon => switch (this) {
        HomeTabs.dashboard => IconsaxPlusLinear.home_1,
        HomeTabs.library => IconsaxPlusLinear.book,
        HomeTabs.favorites => IconsaxPlusLinear.heart,
        HomeTabs.sync => IconsaxPlusLinear.cloud,
      };

  IconData get selectedIcon => switch (this) {
        HomeTabs.dashboard => IconsaxPlusBold.home_1,
        HomeTabs.library => IconsaxPlusBold.book,
        HomeTabs.favorites => IconsaxPlusBold.heart,
        HomeTabs.sync => IconsaxPlusBold.cloud,
      };

  Future navigate(BuildContext context) => switch (this) {
        HomeTabs.dashboard => context.router.navigate(const DashboardRoute()),
        HomeTabs.library => context.router.navigate(const LibraryRoute()),
        HomeTabs.favorites => context.router.navigate(const FavouritesRoute()),
        HomeTabs.sync => context.router.navigate(SyncedRoute()),
      };

  String label(BuildContext context) => switch (this) {
        HomeTabs.dashboard => context.localized.dashboard,
        HomeTabs.library => context.localized.library(0),
        HomeTabs.favorites => context.localized.favorites,
        HomeTabs.sync => context.localized.sync,
      };
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
                icon: Icon(e.icon),
                selectedIcon: Icon(e.selectedIcon),
                route: const DashboardRoute(),
                action: () => e.navigate(context),
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
                icon: Icon(e.icon),
                selectedIcon: Icon(e.selectedIcon),
                route: const FavouritesRoute(),
                floatingActionButton: AdaptiveFab(
                  context: context,
                  title: context.localized.filter(0),
                  key: Key(e.name.capitalize()),
                  onPressed: () => context.router.navigate(LibrarySearchRoute(favourites: true)),
                  child: const Icon(IconsaxPlusLinear.heart_search),
                ),
                action: () => e.navigate(context),
              );
            case HomeTabs.sync:
              if (canDownload && !kIsWeb) {
                return DestinationModel(
                  label: context.localized.navigationSync,
                  icon: Icon(e.icon),
                  selectedIcon: Icon(e.selectedIcon),
                  route: SyncedRoute(),
                  action: () => e.navigate(context),
                );
              }
            case HomeTabs.library:
              return DestinationModel(
                label: context.localized.library(0),
                icon: Icon(e.icon),
                selectedIcon: Icon(e.selectedIcon),
                route: const LibraryRoute(),
                action: () => e.navigate(context),
              );
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
