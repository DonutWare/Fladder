// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i29;

import 'package:auto_route/auto_route.dart' as _i23;
import 'package:collection/collection.dart' as _i27;
import 'package:fladder/models/item_base_model.dart' as _i24;
import 'package:fladder/models/items/photos_model.dart' as _i28;
import 'package:fladder/models/library_search/library_search_options.dart'
    as _i26;
import 'package:fladder/routes/nested_details_screen.dart' as _i9;
import 'package:fladder/screens/control_panel/control_active_tasks_page.dart'
    as _i3;
import 'package:fladder/screens/control_panel/control_dashboard_page.dart'
    as _i4;
import 'package:fladder/screens/control_panel/control_panel_screen.dart' as _i5;
import 'package:fladder/screens/control_panel/control_panel_selection_screen.dart'
    as _i6;
import 'package:fladder/screens/control_panel/control_server_page.dart' as _i7;
import 'package:fladder/screens/dashboard/dashboard_screen.dart' as _i8;
import 'package:fladder/screens/favourites/favourites_screen.dart' as _i10;
import 'package:fladder/screens/home_screen.dart' as _i11;
import 'package:fladder/screens/library/library_screen.dart' as _i12;
import 'package:fladder/screens/library_search/library_search_screen.dart'
    as _i13;
import 'package:fladder/screens/login/lock_screen.dart' as _i14;
import 'package:fladder/screens/login/login_screen.dart' as _i15;
import 'package:fladder/screens/photo_viewer/photo_viewer_screen.dart' as _i16;
import 'package:fladder/screens/settings/about_settings_page.dart' as _i1;
import 'package:fladder/screens/settings/client_settings_page.dart' as _i2;
import 'package:fladder/screens/settings/player_settings_page.dart' as _i17;
import 'package:fladder/screens/settings/profile_settings_page.dart' as _i18;
import 'package:fladder/screens/settings/settings_screen.dart' as _i19;
import 'package:fladder/screens/settings/settings_selection_screen.dart'
    as _i20;
import 'package:fladder/screens/splash_screen.dart' as _i21;
import 'package:fladder/screens/syncing/synced_screen.dart' as _i22;
import 'package:flutter/foundation.dart' as _i25;
import 'package:flutter/material.dart' as _i30;

/// generated route for
/// [_i1.AboutSettingsPage]
class AboutSettingsRoute extends _i23.PageRouteInfo<void> {
  const AboutSettingsRoute({List<_i23.PageRouteInfo>? children})
      : super(AboutSettingsRoute.name, initialChildren: children);

  static const String name = 'AboutSettingsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutSettingsPage();
    },
  );
}

/// generated route for
/// [_i2.ClientSettingsPage]
class ClientSettingsRoute extends _i23.PageRouteInfo<void> {
  const ClientSettingsRoute({List<_i23.PageRouteInfo>? children})
      : super(ClientSettingsRoute.name, initialChildren: children);

  static const String name = 'ClientSettingsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i2.ClientSettingsPage();
    },
  );
}

/// generated route for
/// [_i3.ControlActiveTasksPage]
class ControlActiveTasksRoute extends _i23.PageRouteInfo<void> {
  const ControlActiveTasksRoute({List<_i23.PageRouteInfo>? children})
      : super(ControlActiveTasksRoute.name, initialChildren: children);

  static const String name = 'ControlActiveTasksRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i3.ControlActiveTasksPage();
    },
  );
}

/// generated route for
/// [_i4.ControlDashboardPage]
class ControlDashboardRoute extends _i23.PageRouteInfo<void> {
  const ControlDashboardRoute({List<_i23.PageRouteInfo>? children})
      : super(ControlDashboardRoute.name, initialChildren: children);

  static const String name = 'ControlDashboardRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i4.ControlDashboardPage();
    },
  );
}

/// generated route for
/// [_i5.ControlPanelScreen]
class ControlPanelRoute extends _i23.PageRouteInfo<void> {
  const ControlPanelRoute({List<_i23.PageRouteInfo>? children})
      : super(ControlPanelRoute.name, initialChildren: children);

  static const String name = 'ControlPanelRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i5.ControlPanelScreen();
    },
  );
}

/// generated route for
/// [_i6.ControlPanelSelectionScreen]
class ControlPanelSelectionRoute extends _i23.PageRouteInfo<void> {
  const ControlPanelSelectionRoute({List<_i23.PageRouteInfo>? children})
      : super(ControlPanelSelectionRoute.name, initialChildren: children);

  static const String name = 'ControlPanelSelectionRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i6.ControlPanelSelectionScreen();
    },
  );
}

/// generated route for
/// [_i7.ControlServerPage]
class ControlServerRoute extends _i23.PageRouteInfo<void> {
  const ControlServerRoute({List<_i23.PageRouteInfo>? children})
      : super(ControlServerRoute.name, initialChildren: children);

  static const String name = 'ControlServerRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i7.ControlServerPage();
    },
  );
}

/// generated route for
/// [_i8.DashboardScreen]
class DashboardRoute extends _i23.PageRouteInfo<void> {
  const DashboardRoute({List<_i23.PageRouteInfo>? children})
      : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i8.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i9.DetailsScreen]
class DetailsRoute extends _i23.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    String id = '',
    _i24.ItemBaseModel? item,
    Object? tag,
    _i25.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(id: id, item: item, tag: tag, key: key),
          rawQueryParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<DetailsRouteArgs>(
        orElse: () => DetailsRouteArgs(id: queryParams.getString('id', '')),
      );
      return _i9.DetailsScreen(
        id: args.id,
        item: args.item,
        tag: args.tag,
        key: args.key,
      );
    },
  );
}

class DetailsRouteArgs {
  const DetailsRouteArgs({this.id = '', this.item, this.tag, this.key});

  final String id;

  final _i24.ItemBaseModel? item;

  final Object? tag;

  final _i25.Key? key;

  @override
  String toString() {
    return 'DetailsRouteArgs{id: $id, item: $item, tag: $tag, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DetailsRouteArgs) return false;
    return id == other.id &&
        item == other.item &&
        tag == other.tag &&
        key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ item.hashCode ^ tag.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i10.FavouritesScreen]
class FavouritesRoute extends _i23.PageRouteInfo<void> {
  const FavouritesRoute({List<_i23.PageRouteInfo>? children})
      : super(FavouritesRoute.name, initialChildren: children);

  static const String name = 'FavouritesRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i10.FavouritesScreen();
    },
  );
}

/// generated route for
/// [_i11.HomeScreen]
class HomeRoute extends _i23.PageRouteInfo<void> {
  const HomeRoute({List<_i23.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i11.HomeScreen();
    },
  );
}

/// generated route for
/// [_i12.LibraryScreen]
class LibraryRoute extends _i23.PageRouteInfo<void> {
  const LibraryRoute({List<_i23.PageRouteInfo>? children})
      : super(LibraryRoute.name, initialChildren: children);

  static const String name = 'LibraryRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i12.LibraryScreen();
    },
  );
}

/// generated route for
/// [_i13.LibrarySearchScreen]
class LibrarySearchRoute extends _i23.PageRouteInfo<LibrarySearchRouteArgs> {
  LibrarySearchRoute({
    String? viewModelId,
    List<String>? folderId,
    bool? favourites,
    _i26.SortingOrder? sortOrder,
    _i26.SortingOptions? sortingOptions,
    Map<_i24.FladderItemType, bool>? types,
    Map<String, bool>? genres,
    bool? recursive,
    _i25.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          LibrarySearchRoute.name,
          args: LibrarySearchRouteArgs(
            viewModelId: viewModelId,
            folderId: folderId,
            favourites: favourites,
            sortOrder: sortOrder,
            sortingOptions: sortingOptions,
            types: types,
            genres: genres,
            recursive: recursive,
            key: key,
          ),
          rawQueryParams: {
            'parentId': viewModelId,
            'folderId': folderId,
            'favourites': favourites,
            'sortOrder': sortOrder,
            'sortOptions': sortingOptions,
            'itemTypes': types,
            'genres': genres,
            'recursive': recursive,
          },
          initialChildren: children,
        );

  static const String name = 'LibrarySearchRoute';

  static _i23.PageInfo page = _i23.PageInfo(
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
          genres: queryParams.get('genres'),
          recursive: queryParams.optBool('recursive'),
        ),
      );
      return _i13.LibrarySearchScreen(
        viewModelId: args.viewModelId,
        folderId: args.folderId,
        favourites: args.favourites,
        sortOrder: args.sortOrder,
        sortingOptions: args.sortingOptions,
        types: args.types,
        genres: args.genres,
        recursive: args.recursive,
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
    this.genres,
    this.recursive,
    this.key,
  });

  final String? viewModelId;

  final List<String>? folderId;

  final bool? favourites;

  final _i26.SortingOrder? sortOrder;

  final _i26.SortingOptions? sortingOptions;

  final Map<_i24.FladderItemType, bool>? types;

  final Map<String, bool>? genres;

  final bool? recursive;

  final _i25.Key? key;

  @override
  String toString() {
    return 'LibrarySearchRouteArgs{viewModelId: $viewModelId, folderId: $folderId, favourites: $favourites, sortOrder: $sortOrder, sortingOptions: $sortingOptions, types: $types, genres: $genres, recursive: $recursive, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LibrarySearchRouteArgs) return false;
    return viewModelId == other.viewModelId &&
        const _i27.ListEquality().equals(folderId, other.folderId) &&
        favourites == other.favourites &&
        sortOrder == other.sortOrder &&
        sortingOptions == other.sortingOptions &&
        const _i27.MapEquality().equals(types, other.types) &&
        const _i27.MapEquality().equals(genres, other.genres) &&
        recursive == other.recursive &&
        key == other.key;
  }

  @override
  int get hashCode =>
      viewModelId.hashCode ^
      const _i27.ListEquality().hash(folderId) ^
      favourites.hashCode ^
      sortOrder.hashCode ^
      sortingOptions.hashCode ^
      const _i27.MapEquality().hash(types) ^
      const _i27.MapEquality().hash(genres) ^
      recursive.hashCode ^
      key.hashCode;
}

/// generated route for
/// [_i14.LockScreen]
class LockRoute extends _i23.PageRouteInfo<void> {
  const LockRoute({List<_i23.PageRouteInfo>? children})
      : super(LockRoute.name, initialChildren: children);

  static const String name = 'LockRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i14.LockScreen();
    },
  );
}

/// generated route for
/// [_i15.LoginScreen]
class LoginRoute extends _i23.PageRouteInfo<void> {
  const LoginRoute({List<_i23.PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i15.LoginScreen();
    },
  );
}

/// generated route for
/// [_i16.PhotoViewerScreen]
class PhotoViewerRoute extends _i23.PageRouteInfo<PhotoViewerRouteArgs> {
  PhotoViewerRoute({
    List<_i28.PhotoModel>? items,
    String? selected,
    _i29.Future<List<_i28.PhotoModel>>? loadingItems,
    _i30.Key? key,
    List<_i23.PageRouteInfo>? children,
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

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<PhotoViewerRouteArgs>(
        orElse: () =>
            PhotoViewerRouteArgs(selected: queryParams.optString('selectedId')),
      );
      return _i16.PhotoViewerScreen(
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

  final List<_i28.PhotoModel>? items;

  final String? selected;

  final _i29.Future<List<_i28.PhotoModel>>? loadingItems;

  final _i30.Key? key;

  @override
  String toString() {
    return 'PhotoViewerRouteArgs{items: $items, selected: $selected, loadingItems: $loadingItems, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PhotoViewerRouteArgs) return false;
    return const _i27.ListEquality().equals(items, other.items) &&
        selected == other.selected &&
        loadingItems == other.loadingItems &&
        key == other.key;
  }

  @override
  int get hashCode =>
      const _i27.ListEquality().hash(items) ^
      selected.hashCode ^
      loadingItems.hashCode ^
      key.hashCode;
}

/// generated route for
/// [_i17.PlayerSettingsPage]
class PlayerSettingsRoute extends _i23.PageRouteInfo<void> {
  const PlayerSettingsRoute({List<_i23.PageRouteInfo>? children})
      : super(PlayerSettingsRoute.name, initialChildren: children);

  static const String name = 'PlayerSettingsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i17.PlayerSettingsPage();
    },
  );
}

/// generated route for
/// [_i18.ProfileSettingsPage]
class ProfileSettingsRoute extends _i23.PageRouteInfo<void> {
  const ProfileSettingsRoute({List<_i23.PageRouteInfo>? children})
      : super(ProfileSettingsRoute.name, initialChildren: children);

  static const String name = 'ProfileSettingsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i18.ProfileSettingsPage();
    },
  );
}

/// generated route for
/// [_i19.SettingsScreen]
class SettingsRoute extends _i23.PageRouteInfo<void> {
  const SettingsRoute({List<_i23.PageRouteInfo>? children})
      : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i19.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i20.SettingsSelectionScreen]
class SettingsSelectionRoute extends _i23.PageRouteInfo<void> {
  const SettingsSelectionRoute({List<_i23.PageRouteInfo>? children})
      : super(SettingsSelectionRoute.name, initialChildren: children);

  static const String name = 'SettingsSelectionRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i20.SettingsSelectionScreen();
    },
  );
}

/// generated route for
/// [_i21.SplashScreen]
class SplashRoute extends _i23.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    dynamic Function(bool)? loggedIn,
    _i30.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(loggedIn: loggedIn, key: key),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>(
        orElse: () => const SplashRouteArgs(),
      );
      return _i21.SplashScreen(loggedIn: args.loggedIn, key: args.key);
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({this.loggedIn, this.key});

  final dynamic Function(bool)? loggedIn;

  final _i30.Key? key;

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
/// [_i22.SyncedScreen]
class SyncedRoute extends _i23.PageRouteInfo<void> {
  const SyncedRoute({List<_i23.PageRouteInfo>? children})
      : super(SyncedRoute.name, initialChildren: children);

  static const String name = 'SyncedRoute';

  static _i23.PageInfo page = _i23.PageInfo(
    name,
    builder: (data) {
      return const _i22.SyncedScreen();
    },
  );
}
