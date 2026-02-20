import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';

const settingsPageRoute = "settings";
const controlPanelPageRoute = "control-panel";

const fullScreenRoutes = {
  PhotoViewerRoute.name,
};

const topBarNoBlurRoutes = {
  SettingsRoute.name,
  ControlPanelRoute.name,
  DetailsRoute.name,
};

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AutoRouter extends RootStackRouter {
  AutoRouter({
    required this.ref,
  });

  final WidgetRef ref;

  @override
  List<AutoRouteGuard> get guards => [...super.guards, AuthGuard(ref: ref)];

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        ..._defaultRoutes,
        ...otherRoutes,
      ];

  final List<AutoRoute> otherRoutes = [
    _homeRoute.copyWith(
      children: [
        ...homeRoutes,
        ...detailsRoutes,
        AutoRoute(
          page: SettingsRoute.page,
          path: settingsPageRoute,
          children: _settingsChildren,
        ),
        AutoRoute(
          page: ControlPanelRoute.page,
          path: controlPanelPageRoute,
          children: _controlPanelRoutes,
        ),
      ],
    ),
    AutoRoute(page: LockRoute.page, path: '/locked'),
  ];
}

final AutoRoute _homeRoute = AutoRoute(page: HomeRoute.page, path: '/');
final List<AutoRoute> homeRoutes = [
  AutoRoute(
    page: DashboardRoute.page,
    initial: true,
    path: 'dashboard',
  ),
  AutoRoute(
    page: SeerrRoute.page,
    path: 'seerr',
  ),
  AutoRoute(
    page: FavouritesRoute.page,
    path: 'favourites',
  ),
  AutoRoute(
    page: SyncedRoute.page,
    path: 'synced',
  ),
  AutoRoute(
    page: LibraryRoute.page,
    path: 'libraries',
  ),
];

final List<AutoRoute> detailsRoutes = [
  AutoRoute(page: DetailsRoute.page, path: 'details'),
  AutoRoute(page: PhotoViewerRoute.page, path: "album"),
  AutoRoute(page: LibrarySearchRoute.page, path: 'library'),
  AutoRoute(page: LiveTvRoute.page, path: 'live-tv'),
  AutoRoute(page: SeerrSearchRoute.page, path: 'seerr-search'),
  AutoRoute(page: SeerrDetailsRoute.page, path: 'seerr/:mediaType/:tmdbId'),
];

final List<AutoRoute> _defaultRoutes = [
  AutoRoute(page: SplashRoute.page, path: '/splash'),
  AutoRoute(page: LoginRoute.page, path: '/login', maintainState: false),
];

final List<AutoRoute> _settingsChildren = [
  AutoRoute(page: SettingsSelectionRoute.page, path: 'list'),
  AutoRoute(page: ClientSettingsRoute.page, path: 'client', maintainState: false),
  AutoRoute(page: ProfileSettingsRoute.page, path: 'security', maintainState: false),
  AutoRoute(page: PlayerSettingsRoute.page, path: 'player', maintainState: false),
  AutoRoute(page: AboutSettingsRoute.page, path: 'about'),
];

final List<AutoRoute> _controlPanelRoutes = [
  AutoRoute(page: ControlPanelSelectionRoute.page, path: 'list'),
  AutoRoute(page: ControlDashboardRoute.page, path: 'dashboard', maintainState: false),
  AutoRoute(page: ControlActiveTasksRoute.page, path: 'active-tasks', maintainState: false),
  AutoRoute(page: ControlServerRoute.page, path: 'server-settings', maintainState: false),
  AutoRoute(page: ControlUsersRoute.page, path: 'user-management', maintainState: false),
  AutoRoute(page: ControlUserEditRoute.page, path: 'edit-user', maintainState: false),
  AutoRoute(page: ControlLibrariesRoute.page, path: 'library-management', maintainState: false),
  AutoRoute(page: ControlLiveTvRoute.page, path: 'live-tv', maintainState: false),
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
    if (resolver.route == router.current.route) {
      return;
    }

    if (ref.read(userProvider) != null ||
        resolver.routeName == const LoginRoute().routeName ||
        resolver.routeName == SplashRoute().routeName) {
      // We assume the last main focus is no longer active after navigating
      lastMainFocus = null;
      return resolver.next(true);
    }

    resolver.redirectUntil<bool>(SplashRoute(loggedIn: (value) {
      if (value) {
        resolver.next(true);
      } else {
        router.replace(const LoginRoute());
      }
    }));

    // We assume the last main focus is no longer active after navigating
    lastMainFocus = null;
    return;
  }
}
