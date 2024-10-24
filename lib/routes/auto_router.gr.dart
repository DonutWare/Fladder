// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:fladder/models/item_base_model.dart' as _i15;
import 'package:fladder/models/items/photos_model.dart' as _i18;
import 'package:fladder/models/library_search/library_search_options.dart'
    as _i17;
import 'package:fladder/routes/nested_details_screen.dart' as _i3;
import 'package:fladder/screens/dashboard/dashboard_screen.dart' as _i2;
import 'package:fladder/screens/favourites/favourites_screen.dart' as _i4;
import 'package:fladder/screens/home_screen.dart' as _i5;
import 'package:fladder/screens/library_search/library_search_screen.dart'
    as _i6;
import 'package:fladder/screens/login/lock_screen.dart' as _i7;
import 'package:fladder/screens/login/login_screen.dart' as _i8;
import 'package:fladder/screens/settings/client_settings_page.dart' as _i1;
import 'package:fladder/screens/settings/player_settings_page.dart' as _i9;
import 'package:fladder/screens/settings/security_settings_page.dart' as _i10;
import 'package:fladder/screens/settings/settings_screen.dart' as _i11;
import 'package:fladder/screens/splash_screen.dart' as _i12;
import 'package:fladder/screens/syncing/synced_screen.dart' as _i13;
import 'package:flutter/foundation.dart' as _i16;
import 'package:flutter/material.dart' as _i19;

/// generated route for
/// [_i1.ClientSettingsPage]
class ClientSettingsRoute extends _i14.PageRouteInfo<void> {
  const ClientSettingsRoute({List<_i14.PageRouteInfo>? children})
      : super(
          ClientSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClientSettingsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.ClientSettingsPage();
    },
  );
}

/// generated route for
/// [_i2.DashboardScreen]
class DashboardRoute extends _i14.PageRouteInfo<void> {
  const DashboardRoute({List<_i14.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i3.DetailsScreen]
class DetailsRoute extends _i14.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    String id = '',
    _i15.ItemBaseModel? item,
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(
            id: id,
            item: item,
            key: key,
          ),
          rawQueryParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<DetailsRouteArgs>(
          orElse: () => DetailsRouteArgs(
                  id: queryParams.getString(
                'id',
                '',
              )));
      return _i3.DetailsScreen(
        id: args.id,
        item: args.item,
        key: args.key,
      );
    },
  );
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    this.id = '',
    this.item,
    this.key,
  });

  final String id;

  final _i15.ItemBaseModel? item;

  final _i16.Key? key;

  @override
  String toString() {
    return 'DetailsRouteArgs{id: $id, item: $item, key: $key}';
  }
}

/// generated route for
/// [_i4.FavouritesScreen]
class FavouritesRoute extends _i14.PageRouteInfo<void> {
  const FavouritesRoute({List<_i14.PageRouteInfo>? children})
      : super(
          FavouritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouritesRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.FavouritesScreen();
    },
  );
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.LibrarySearchScreen]
class LibrarySearchRoute extends _i14.PageRouteInfo<LibrarySearchRouteArgs> {
  LibrarySearchRoute({
    String? viewModelId,
    List<String>? folderId,
    bool? favourites,
    _i17.SortingOrder? sortOrder,
    _i17.SortingOptions? sortingOptions,
    _i18.PhotoModel? photoToView,
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LibrarySearchRoute.name,
          args: LibrarySearchRouteArgs(
            viewModelId: viewModelId,
            folderId: folderId,
            favourites: favourites,
            sortOrder: sortOrder,
            sortingOptions: sortingOptions,
            photoToView: photoToView,
            key: key,
          ),
          rawQueryParams: {
            'parentId': viewModelId,
            'folderId': folderId,
            'favourites': favourites,
            'sortOrder': sortOrder,
            'sortOptions': sortingOptions,
          },
          initialChildren: children,
        );

  static const String name = 'LibrarySearchRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<LibrarySearchRouteArgs>(
          orElse: () => LibrarySearchRouteArgs(
                viewModelId: queryParams.optString('parentId'),
                folderId: queryParams.optList('folderId'),
                favourites: queryParams.optBool('favourites'),
                sortOrder: queryParams.get('sortOrder'),
                sortingOptions: queryParams.get('sortOptions'),
              ));
      return _i6.LibrarySearchScreen(
        viewModelId: args.viewModelId,
        folderId: args.folderId,
        favourites: args.favourites,
        sortOrder: args.sortOrder,
        sortingOptions: args.sortingOptions,
        photoToView: args.photoToView,
        key: args.key,
      );
    },
  );
}

class LibrarySearchRouteArgs {
  const LibrarySearchRouteArgs({
    this.viewModelId,
    this.folderId,
    this.favourites,
    this.sortOrder,
    this.sortingOptions,
    this.photoToView,
    this.key,
  });

  final String? viewModelId;

  final List<String>? folderId;

  final bool? favourites;

  final _i17.SortingOrder? sortOrder;

  final _i17.SortingOptions? sortingOptions;

  final _i18.PhotoModel? photoToView;

  final _i16.Key? key;

  @override
  String toString() {
    return 'LibrarySearchRouteArgs{viewModelId: $viewModelId, folderId: $folderId, favourites: $favourites, sortOrder: $sortOrder, sortingOptions: $sortingOptions, photoToView: $photoToView, key: $key}';
  }
}

/// generated route for
/// [_i7.LockScreen]
class LockRoute extends _i14.PageRouteInfo<void> {
  const LockRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LockRoute.name,
          initialChildren: children,
        );

  static const String name = 'LockRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.LockScreen();
    },
  );
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.LoginScreen();
    },
  );
}

/// generated route for
/// [_i9.PlayerSettingsPage]
class PlayerSettingsRoute extends _i14.PageRouteInfo<void> {
  const PlayerSettingsRoute({List<_i14.PageRouteInfo>? children})
      : super(
          PlayerSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlayerSettingsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.PlayerSettingsPage();
    },
  );
}

/// generated route for
/// [_i10.SecuritySettingsPage]
class SecuritySettingsRoute extends _i14.PageRouteInfo<void> {
  const SecuritySettingsRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SecuritySettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SecuritySettingsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.SecuritySettingsPage();
    },
  );
}

/// generated route for
/// [_i11.SettingsScreen]
class SettingsRoute extends _i14.PageRouteInfo<void> {
  const SettingsRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i14.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    dynamic Function(bool)? loggedIn,
    _i19.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            loggedIn: loggedIn,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SplashRouteArgs>(orElse: () => const SplashRouteArgs());
      return _i12.SplashScreen(
        loggedIn: args.loggedIn,
        key: args.key,
      );
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({
    this.loggedIn,
    this.key,
  });

  final dynamic Function(bool)? loggedIn;

  final _i19.Key? key;

  @override
  String toString() {
    return 'SplashRouteArgs{loggedIn: $loggedIn, key: $key}';
  }
}

/// generated route for
/// [_i13.SyncedScreen]
class SyncedRoute extends _i14.PageRouteInfo<SyncedRouteArgs> {
  SyncedRoute({
    _i19.ScrollController? navigationScrollController,
    _i19.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SyncedRoute.name,
          args: SyncedRouteArgs(
            navigationScrollController: navigationScrollController,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SyncedRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SyncedRouteArgs>(orElse: () => const SyncedRouteArgs());
      return _i13.SyncedScreen(
        navigationScrollController: args.navigationScrollController,
        key: args.key,
      );
    },
  );
}

class SyncedRouteArgs {
  const SyncedRouteArgs({
    this.navigationScrollController,
    this.key,
  });

  final _i19.ScrollController? navigationScrollController;

  final _i19.Key? key;

  @override
  String toString() {
    return 'SyncedRouteArgs{navigationScrollController: $navigationScrollController, key: $key}';
  }
}
