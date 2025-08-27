// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i24;

import 'package:auto_route/auto_route.dart' as _i18;
import 'package:collection/collection.dart' as _i23;
import 'package:fladder/models/item_base_model.dart' as _i19;
import 'package:fladder/models/items/photos_model.dart' as _i22;
import 'package:fladder/models/library_search/library_search_options.dart'
    as _i21;
import 'package:fladder/routes/nested_details_screen.dart' as _i4;
import 'package:fladder/screens/dashboard/dashboard_screen.dart' as _i3;
import 'package:fladder/screens/favourites/favourites_screen.dart' as _i5;
import 'package:fladder/screens/home_screen.dart' as _i6;
import 'package:fladder/screens/library/library_screen.dart' as _i7;
import 'package:fladder/screens/library_search/library_search_screen.dart'
    as _i8;
import 'package:fladder/screens/login/lock_screen.dart' as _i9;
import 'package:fladder/screens/login/login_screen.dart' as _i10;
import 'package:fladder/screens/photo_viewer/photo_viewer_screen.dart' as _i11;
import 'package:fladder/screens/settings/about_settings_page.dart' as _i1;
import 'package:fladder/screens/settings/client_settings_page.dart' as _i2;
import 'package:fladder/screens/settings/player_settings_page.dart' as _i12;
import 'package:fladder/screens/settings/security_settings_page.dart' as _i13;
import 'package:fladder/screens/settings/settings_screen.dart' as _i14;
import 'package:fladder/screens/settings/settings_selection_screen.dart'
    as _i15;
import 'package:fladder/screens/splash_screen.dart' as _i16;
import 'package:fladder/screens/syncing/synced_screen.dart' as _i17;
import 'package:flutter/foundation.dart' as _i20;
import 'package:flutter/material.dart' as _i25;

/// generated route for
/// [_i1.AboutSettingsPage]
class AboutSettingsRoute extends _i18.PageRouteInfo<void> {
  const AboutSettingsRoute({List<_i18.PageRouteInfo>? children})
      : super(AboutSettingsRoute.name, initialChildren: children);

  static const String name = 'AboutSettingsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutSettingsPage();
    },
  );
}

/// generated route for
/// [_i2.ClientSettingsPage]
class ClientSettingsRoute extends _i18.PageRouteInfo<void> {
  const ClientSettingsRoute({List<_i18.PageRouteInfo>? children})
      : super(ClientSettingsRoute.name, initialChildren: children);

  static const String name = 'ClientSettingsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i2.ClientSettingsPage();
    },
  );
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i18.PageRouteInfo<void> {
  const DashboardRoute({List<_i18.PageRouteInfo>? children})
      : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.DetailsScreen]
class DetailsRoute extends _i18.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    String id = '',
    _i19.ItemBaseModel? item,
    _i20.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(id: id, item: item, key: key),
          rawQueryParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<DetailsRouteArgs>(
        orElse: () => DetailsRouteArgs(id: queryParams.getString('id', '')),
      );
      return _i4.DetailsScreen(id: args.id, item: args.item, key: args.key);
    },
  );
}

class DetailsRouteArgs {
  const DetailsRouteArgs({this.id = '', this.item, this.key});

  final String id;

  final _i19.ItemBaseModel? item;

  final _i20.Key? key;

  @override
  String toString() {
    return 'DetailsRouteArgs{id: $id, item: $item, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DetailsRouteArgs) return false;
    return id == other.id && item == other.item && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ item.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i5.FavouritesScreen]
class FavouritesRoute extends _i18.PageRouteInfo<void> {
  const FavouritesRoute({List<_i18.PageRouteInfo>? children})
      : super(FavouritesRoute.name, initialChildren: children);

  static const String name = 'FavouritesRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.FavouritesScreen();
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.LibraryScreen]
class LibraryRoute extends _i18.PageRouteInfo<void> {
  const LibraryRoute({List<_i18.PageRouteInfo>? children})
      : super(LibraryRoute.name, initialChildren: children);

  static const String name = 'LibraryRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i7.LibraryScreen();
    },
  );
}

/// generated route for
/// [_i8.LibrarySearchScreen]
class LibrarySearchRoute extends _i18.PageRouteInfo<LibrarySearchRouteArgs> {
  LibrarySearchRoute({
    String? viewModelId,
    List<String>? folderId,
    bool? favourites,
    _i21.SortingOrder? sortOrder,
    _i21.SortingOptions? sortingOptions,
    Map<_i19.FladderItemType, bool>? types,
    bool recursive = true,
    _i22.PhotoModel? photoToView,
    _i20.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          LibrarySearchRoute.name,
          args: LibrarySearchRouteArgs(
            viewModelId: viewModelId,
            folderId: folderId,
            favourites: favourites,
            sortOrder: sortOrder,
            sortingOptions: sortingOptions,
            types: types,
            recursive: recursive,
            photoToView: photoToView,
            key: key,
          ),
          rawQueryParams: {
            'parentId': viewModelId,
            'folderId': folderId,
            'favourites': favourites,
            'sortOrder': sortOrder,
            'sortOptions': sortingOptions,
            'itemTypes': types,
            'recursive': recursive,
          },
          initialChildren: children,
        );

  static const String name = 'LibrarySearchRoute';

  static _i18.PageInfo page = _i18.PageInfo(
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
          types: queryParams.get('itemTypes'),
          recursive: queryParams.getBool('recursive', true),
        ),
      );
      return _i8.LibrarySearchScreen(
        viewModelId: args.viewModelId,
        folderId: args.folderId,
        favourites: args.favourites,
        sortOrder: args.sortOrder,
        sortingOptions: args.sortingOptions,
        types: args.types,
        recursive: args.recursive,
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
    this.types,
    this.recursive = true,
    this.photoToView,
    this.key,
  });

  final String? viewModelId;

  final List<String>? folderId;

  final bool? favourites;

  final _i21.SortingOrder? sortOrder;

  final _i21.SortingOptions? sortingOptions;

  final Map<_i19.FladderItemType, bool>? types;

  final bool recursive;

  final _i22.PhotoModel? photoToView;

  final _i20.Key? key;

  @override
  String toString() {
    return 'LibrarySearchRouteArgs{viewModelId: $viewModelId, folderId: $folderId, favourites: $favourites, sortOrder: $sortOrder, sortingOptions: $sortingOptions, types: $types, recursive: $recursive, photoToView: $photoToView, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LibrarySearchRouteArgs) return false;
    return viewModelId == other.viewModelId &&
        const _i23.ListEquality().equals(folderId, other.folderId) &&
        favourites == other.favourites &&
        sortOrder == other.sortOrder &&
        sortingOptions == other.sortingOptions &&
        const _i23.MapEquality().equals(types, other.types) &&
        recursive == other.recursive &&
        photoToView == other.photoToView &&
        key == other.key;
  }

  @override
  int get hashCode =>
      viewModelId.hashCode ^
      const _i23.ListEquality().hash(folderId) ^
      favourites.hashCode ^
      sortOrder.hashCode ^
      sortingOptions.hashCode ^
      const _i23.MapEquality().hash(types) ^
      recursive.hashCode ^
      photoToView.hashCode ^
      key.hashCode;
}

/// generated route for
/// [_i9.LockScreen]
class LockRoute extends _i18.PageRouteInfo<void> {
  const LockRoute({List<_i18.PageRouteInfo>? children})
      : super(LockRoute.name, initialChildren: children);

  static const String name = 'LockRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i9.LockScreen();
    },
  );
}

/// generated route for
/// [_i10.LoginScreen]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i10.LoginScreen();
    },
  );
}

/// generated route for
/// [_i11.PhotoViewerScreen]
class PhotoViewerRoute extends _i18.PageRouteInfo<PhotoViewerRouteArgs> {
  PhotoViewerRoute({
    List<_i22.PhotoModel>? items,
    String? selected,
    _i24.Future<List<_i22.PhotoModel>>? loadingItems,
    _i25.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          PhotoViewerRoute.name,
          args: PhotoViewerRouteArgs(
            items: items,
            selected: selected,
            loadingItems: loadingItems,
            key: key,
          ),
          rawQueryParams: {'selectedId': selected},
          initialChildren: children,
        );

  static const String name = 'PhotoViewerRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<PhotoViewerRouteArgs>(
        orElse: () =>
            PhotoViewerRouteArgs(selected: queryParams.optString('selectedId')),
      );
      return _i11.PhotoViewerScreen(
        items: args.items,
        selected: args.selected,
        loadingItems: args.loadingItems,
        key: args.key,
      );
    },
  );
}

class PhotoViewerRouteArgs {
  const PhotoViewerRouteArgs({
    this.items,
    this.selected,
    this.loadingItems,
    this.key,
  });

  final List<_i22.PhotoModel>? items;

  final String? selected;

  final _i24.Future<List<_i22.PhotoModel>>? loadingItems;

  final _i25.Key? key;

  @override
  String toString() {
    return 'PhotoViewerRouteArgs{items: $items, selected: $selected, loadingItems: $loadingItems, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PhotoViewerRouteArgs) return false;
    return const _i23.ListEquality().equals(items, other.items) &&
        selected == other.selected &&
        loadingItems == other.loadingItems &&
        key == other.key;
  }

  @override
  int get hashCode =>
      const _i23.ListEquality().hash(items) ^
      selected.hashCode ^
      loadingItems.hashCode ^
      key.hashCode;
}

/// generated route for
/// [_i12.PlayerSettingsPage]
class PlayerSettingsRoute extends _i18.PageRouteInfo<void> {
  const PlayerSettingsRoute({List<_i18.PageRouteInfo>? children})
      : super(PlayerSettingsRoute.name, initialChildren: children);

  static const String name = 'PlayerSettingsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i12.PlayerSettingsPage();
    },
  );
}

/// generated route for
/// [_i13.SecuritySettingsPage]
class SecuritySettingsRoute extends _i18.PageRouteInfo<void> {
  const SecuritySettingsRoute({List<_i18.PageRouteInfo>? children})
      : super(SecuritySettingsRoute.name, initialChildren: children);

  static const String name = 'SecuritySettingsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i13.SecuritySettingsPage();
    },
  );
}

/// generated route for
/// [_i14.SettingsScreen]
class SettingsRoute extends _i18.PageRouteInfo<void> {
  const SettingsRoute({List<_i18.PageRouteInfo>? children})
      : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i14.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i15.SettingsSelectionScreen]
class SettingsSelectionRoute extends _i18.PageRouteInfo<void> {
  const SettingsSelectionRoute({List<_i18.PageRouteInfo>? children})
      : super(SettingsSelectionRoute.name, initialChildren: children);

  static const String name = 'SettingsSelectionRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i15.SettingsSelectionScreen();
    },
  );
}

/// generated route for
/// [_i16.SplashScreen]
class SplashRoute extends _i18.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    dynamic Function(bool)? loggedIn,
    _i25.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(loggedIn: loggedIn, key: key),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>(
        orElse: () => const SplashRouteArgs(),
      );
      return _i16.SplashScreen(loggedIn: args.loggedIn, key: args.key);
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({this.loggedIn, this.key});

  final dynamic Function(bool)? loggedIn;

  final _i25.Key? key;

  @override
  String toString() {
    return 'SplashRouteArgs{loggedIn: $loggedIn, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SplashRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i17.SyncedScreen]
class SyncedRoute extends _i18.PageRouteInfo<SyncedRouteArgs> {
  SyncedRoute({
    _i25.ScrollController? navigationScrollController,
    _i20.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          SyncedRoute.name,
          args: SyncedRouteArgs(
            navigationScrollController: navigationScrollController,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SyncedRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SyncedRouteArgs>(
        orElse: () => const SyncedRouteArgs(),
      );
      return _i17.SyncedScreen(
        navigationScrollController: args.navigationScrollController,
        key: args.key,
      );
    },
  );
}

class SyncedRouteArgs {
  const SyncedRouteArgs({this.navigationScrollController, this.key});

  final _i25.ScrollController? navigationScrollController;

  final _i20.Key? key;

  @override
  String toString() {
    return 'SyncedRouteArgs{navigationScrollController: $navigationScrollController, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SyncedRouteArgs) return false;
    return navigationScrollController == other.navigationScrollController &&
        key == other.key;
  }

  @override
  int get hashCode => navigationScrollController.hashCode ^ key.hashCode;
}
