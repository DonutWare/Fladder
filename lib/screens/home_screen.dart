import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/dashboard_mode_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/window_title_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/global_hotkeys.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/keyboard/slide_in_keyboard.dart';
import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/destination_model.dart';
import 'package:fladder/widgets/navigation_scaffold/navigation_scaffold.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

enum HomeTabs {
  dashboard,
  library,
  favorites,
  seerr,
  sync;

  const HomeTabs();

  IconData get icon => switch (this) {
        HomeTabs.dashboard => IconsaxPlusLinear.home_1,
        HomeTabs.library => IconsaxPlusLinear.book,
        HomeTabs.favorites => IconsaxPlusLinear.heart,
        HomeTabs.seerr => IconsaxPlusLinear.discover_1,
        HomeTabs.sync => IconsaxPlusLinear.cloud,
      };

  IconData get selectedIcon => switch (this) {
        HomeTabs.dashboard => IconsaxPlusBold.home_1,
        HomeTabs.library => IconsaxPlusBold.book,
        HomeTabs.favorites => IconsaxPlusBold.heart,
        HomeTabs.seerr => IconsaxPlusBold.discover,
        HomeTabs.sync => IconsaxPlusBold.cloud,
      };

  Future navigate(BuildContext context) => switch (this) {
        HomeTabs.dashboard => context.router.navigate(const DashboardRoute()),
        HomeTabs.library => context.router.navigate(const LibraryRoute()),
        HomeTabs.favorites => context.router.navigate(const FavouritesRoute()),
        HomeTabs.seerr => context.router.navigate(const SeerrRoute()),
        HomeTabs.sync => context.router.navigate(const SyncedRoute()),
      };

  String label(BuildContext context) => switch (this) {
        HomeTabs.dashboard => context.localized.dashboard,
        HomeTabs.library => context.localized.library(0),
        HomeTabs.favorites => context.localized.favorites,
        HomeTabs.seerr => 'Seerr',
        HomeTabs.sync => context.localized.sync,
      };
}

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _showDashboardSwitcher(BuildContext context, WidgetRef ref) async {
    void switchDashboard(PageRouteInfo route) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.router.navigate(route);
        }
      });
    }

    await showBottomSheetPill(
      context: context,
      content: (sheetContext, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(IconsaxPlusLinear.home_1),
              title: Text(sheetContext.localized.dashboard),
              onTap: () {
                Navigator.of(sheetContext).pop();
                ref.read(musicDashboardModeProvider.notifier).state = false;
                ref.read(windowTitleProvider.notifier).refreshTitle();
                switchDashboard(const DashboardRoute());
              },
            ),
            ListTile(
              leading: const Icon(IconsaxPlusLinear.music),
              title: Text(context.localized.musicDashboard),
              onTap: () {
                Navigator.of(sheetContext).pop();
                ref.read(musicDashboardModeProvider.notifier).state = true;
                ref.read(windowTitleProvider.notifier).refreshTitle();
                switchDashboard(const DashboardRoute());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canDownload = ref.watch(showSyncButtonProviderProvider);
    final isMusicDashboardMode = ref.watch(musicDashboardModeProvider);
    final seerrAuthenticated = ref.watch(
      userProvider.select((user) => user?.seerrCredentials?.isConfigured ?? false),
    );
    final destinations = HomeTabs.values
        .map((e) {
          switch (e) {
            case HomeTabs.dashboard:
              return DestinationModel(
                label: context.localized.navigationDashboard,
                icon: Icon(
                  isMusicDashboardMode ? IconsaxPlusLinear.music_square : IconsaxPlusLinear.home_1,
                ),
                selectedIcon: Icon(
                  isMusicDashboardMode ? IconsaxPlusBold.music_square : IconsaxPlusBold.home_1,
                ),
                route: const DashboardRoute(),
                action: () => e.navigate(context),
                onLongPress: () => _showDashboardSwitcher(context, ref),
                onSecondaryTapDown: (_) => _showDashboardSwitcher(context, ref),
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
            case HomeTabs.seerr:
              if (seerrAuthenticated) {
                return DestinationModel(
                  label: context.localized.discover,
                  icon: Icon(e.icon),
                  selectedIcon: Icon(e.selectedIcon),
                  route: const SeerrRoute(),
                  floatingActionButton: AdaptiveFab(
                    context: context,
                    title: context.localized.search,
                    key: Key(e.name.capitalize()),
                    onPressed: () => context.router.navigate(SeerrSearchRoute(
                      mode: SeerrSearchMode.search,
                    )),
                    child: const Icon(IconsaxPlusLinear.search_status),
                  ),
                  action: () => e.navigate(context),
                );
              }
            case HomeTabs.sync:
              if (canDownload && !kIsWeb) {
                return DestinationModel(
                  label: context.localized.navigationSync,
                  icon: Icon(e.icon),
                  badge: Consumer(
                    builder: (context, ref, child) {
                      final length = ref.watch(activeDownloadTasksProvider.select((value) => value.length));
                      return length != 0
                          ? CircleAvatar(
                              radius: 10,
                              child: FittedBox(
                                child: Text(length.toString()),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  selectedIcon: Icon(e.selectedIcon),
                  route: const SyncedRoute(),
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
                floatingActionButton: AdaptiveFab(
                  context: context,
                  title: context.localized.search,
                  key: Key(e.name.capitalize()),
                  onPressed: () => context.router.navigate(LibrarySearchRoute()),
                  child: const Icon(IconsaxPlusLinear.search_status),
                ),
              );
          }
        })
        .nonNulls
        .toList();
    return NotificationManagerInitializer(
      child: GlobalHotkeys(
        enabledHotkeys: GlobalHotKeys.values.toSet(),
        child: HeroControllerScope(
          controller: HeroController(),
          child: AutoRouter(
            builder: (context, child) {
              return CustomKeyboardWrapper(
                child: NavigationScaffold(
                  destinations: destinations.nonNulls.toList(),
                  currentRouteName: context.router.current.name,
                  nestedChild: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
