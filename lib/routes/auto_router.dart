import 'package:flutter/foundation.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/util/adaptive_layout.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AutoRouter extends RootStackRouter {
  AutoRouter({
    required this.layout,
    required this.ref,
  });

  final WidgetRef ref;
  final ScreenLayout layout;

  @override
  List<AutoRouteGuard> get guards => [...super.guards, AuthGuard(ref: ref)];

  @override
  RouteType get defaultRouteType => kIsWeb ? const RouteType.material() : const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        ..._defaultRoutes,
        ...(layout == ScreenLayout.dual ? desktopRoutes : mobileRoutes),
      ];

  final List<AutoRoute> mobileRoutes = [
    _homeRoute.copyWith(
      children: [
        _dashboardRoute,
        _favouritesRoute,
        _syncedRoute,
      ],
    ),
    AutoRoute(page: DetailsRoute.page, path: '/details', usesPathAsKey: true),
    AutoRoute(page: LibrarySearchRoute.page, path: '/library', usesPathAsKey: true),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
    ..._settingsChildren.map(
      (e) => e.copyWith(path: "/$e", initial: false),
    ),
    AutoRoute(page: LockRoute.page, path: '/locked'),
  ];
  final List<AutoRoute> desktopRoutes = [
    _homeRoute.copyWith(
      children: [
        _dashboardRoute,
        _favouritesRoute,
        _syncedRoute,
        AutoRoute(page: DetailsRoute.page, path: 'details', usesPathAsKey: true),
        AutoRoute(page: LibrarySearchRoute.page, path: 'library', usesPathAsKey: true),
        AutoRoute(
          page: SettingsRoute.page,
          path: 'settings',
          children: _settingsChildren,
        )
      ],
    ),
    AutoRoute(page: LockRoute.page, path: '/locked'),
  ];
}

final List<AutoRoute> _defaultRoutes = [
  AutoRoute(page: SplashRoute.page, path: '/splash'),
  AutoRoute(page: LoginRoute.page, path: '/login'),
];

final AutoRoute _homeRoute = AutoRoute(page: HomeRoute.page, path: '/');
final AutoRoute _dashboardRoute = CustomRoute(
  page: DashboardRoute.page,
  transitionsBuilder: TransitionsBuilders.fadeIn,
  initial: true,
  path: 'dashboard',
  maintainState: false,
);
final AutoRoute _favouritesRoute = CustomRoute(
  page: FavouritesRoute.page,
  transitionsBuilder: TransitionsBuilders.fadeIn,
  path: 'favourites',
  maintainState: false,
);
final AutoRoute _syncedRoute = CustomRoute(
  page: SyncedRoute.page,
  transitionsBuilder: TransitionsBuilders.fadeIn,
  path: 'synced',
  maintainState: false,
);

final List<AutoRoute> _settingsChildren = [
  CustomRoute(
      page: ClientSettingsRoute.page, initial: true, transitionsBuilder: TransitionsBuilders.fadeIn, path: 'client'),
  CustomRoute(page: SecuritySettingsRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, path: 'security'),
  CustomRoute(page: PlayerSettingsRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, path: 'player'),
  CustomRoute(page: AboutSettingsRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, path: 'about'),
];

class LockScreenGuard extends AutoRouteGuard {
  final WidgetRef ref;

  const LockScreenGuard({required this.ref});

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (ref.read(lockScreenActiveProvider) && resolver.routeName != const LockRoute().routeName) {
      router.replace(const LockRoute());
      return;
    } else {
      return resolver.next(true);
    }
  }
}

class AuthGuard extends AutoRouteGuard {
  final WidgetRef ref;

  const AuthGuard({required this.ref});

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (ref.read(userProvider) != null ||
        resolver.routeName == const LoginRoute().routeName ||
        resolver.routeName == SplashRoute().routeName) {
      return resolver.next(true);
    }

    resolver.redirect<bool>(SplashRoute(loggedIn: (value) {
      if (value) {
        resolver.next(true);
      } else {
        router.replace(const LoginRoute());
      }
    }));
  }
}
