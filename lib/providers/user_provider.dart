import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/enum_models.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/sync_provider.dart';

part 'user_provider.g.dart';

@riverpod
bool showSyncButtonProvider(ShowSyncButtonProviderRef ref) {
  final userCanSync = ref.watch(userProvider.select((value) => value?.canDownload ?? false));
  final hasSyncedItems = ref.watch(syncProvider.select((value) => value.items.isNotEmpty));
  return userCanSync || hasSyncedItems;
}

@Riverpod(keepAlive: true)
class User extends _$User {
  late final JellyService api = ref.read(jellyApiProvider);

  set userState(AccountModel? account) {
    state = account?.copyWith(lastUsed: DateTime.now());
    if (account != null) {
      ref.read(sharedUtilityProvider).updateAccountInfo(account);
    }
  }

  Future<Response<bool>> quickConnect(String pin) async => api.quickConnect(pin);

  Future<Response<AccountModel>?> updateInformation() async {
    if (state == null) return null;
    var response = await api.usersMeGet();
    var quickConnectStatus = await api.quickConnectEnabled();
    var systemConfiguration = await api.systemConfigurationGet();
    if (response.isSuccessful && response.body != null) {
      userState = state?.copyWith(
        name: response.body?.name ?? state?.name ?? "",
        policy: response.body?.policy,
        serverConfiguration: systemConfiguration.body,
        quickConnectState: quickConnectStatus.body ?? false,
        latestItemsExcludes: response.body?.configuration?.latestItemsExcludes ?? [],
      );
      return response.copyWith(body: state);
    }
    return null;
  }

  Future<Response> refreshMetaData(
    String itemId, {
    MetadataRefresh? metadataRefreshMode,
    bool? replaceAllMetadata,
  }) async {
    return api.itemsItemIdRefreshPost(
      itemId: itemId,
      metadataRefreshMode: metadataRefreshMode,
      imageRefreshMode: metadataRefreshMode,
      replaceAllMetadata: switch (metadataRefreshMode) {
        MetadataRefresh.fullRefresh => false,
        MetadataRefresh.validation => true,
        _ => false,
      },
      replaceAllImages: switch (metadataRefreshMode) {
        MetadataRefresh.fullRefresh => true,
        MetadataRefresh.validation => true,
        _ => false,
      },
    );
  }

  Future<Response<UserData>?> setAsFavorite(bool favorite, String itemId) async {
    final response = await (favorite
        ? api.usersUserIdFavoriteItemsItemIdPost(itemId: itemId)
        : api.usersUserIdFavoriteItemsItemIdDelete(itemId: itemId));
    return Response(response.base, UserData.fromDto(response.body));
  }

  Future<Response<UserData>?> markAsPlayed(bool enable, String itemId) async {
    final response = await (enable
        ? api.usersUserIdPlayedItemsItemIdPost(
            itemId: itemId,
            datePlayed: DateTime.now(),
          )
        : api.usersUserIdPlayedItemsItemIdDelete(
            itemId: itemId,
          ));
    return Response(response.base, UserData.fromDto(response.body));
  }

  void clear() {
    userState = null;
  }

  void updateUser(AccountModel? user) {
    userState = user;
  }

  void loginUser(AccountModel? user) {
    state = user;
  }

  void setAuthMethod(Authentication method) {
    userState = state?.copyWith(authMethod: method);
  }

  void addSearchQuery(String value) {
    if (value.isEmpty) return;
    final newList = state?.searchQueryHistory.toList() ?? [];
    if (newList.contains(value)) {
      newList.remove(value);
    }
    newList.add(value);
    userState = state?.copyWith(searchQueryHistory: newList);
  }

  void removeSearchQuery(String value) {
    userState = state?.copyWith(
      searchQueryHistory: state?.searchQueryHistory ?? []
        ..remove(value)
        ..take(50),
    );
  }

  void clearSearchQuery() {
    userState = state?.copyWith(searchQueryHistory: []);
  }

  Future<void> logoutUser() async {
    if (state == null) return;
    userState = null;
  }

  Future<void> forceLogoutUser(AccountModel account) async {
    userState = account;
    await api.sessionsLogoutPost();
    userState = null;
  }

  @override
  AccountModel? build() {
    return null;
  }

  void removeFilter(LibraryFiltersModel model) {
    final currentList = ((state?.savedFilters ?? [])).toList(growable: true);
    currentList.remove(model);
    state = state?.copyWith(savedFilters: currentList);
  }

  void saveFilter(LibraryFiltersModel model) {
    final currentList = (state?.savedFilters ?? []).toList(growable: true);
    if (currentList.firstWhereOrNull((value) => value.id == model.id) != null) {
      state = state?.copyWith(
          savedFilters: currentList.map(
        (e) {
          if (e.id == model.id) {
            return model;
          } else {
            return e.copyWith(isFavourite: model.isFavourite && model.containsSameIds(e.ids) ? false : e.isFavourite);
          }
        },
      ).toList());
    } else {
      state = state?.copyWith(savedFilters: [model, ...currentList]);
    }
  }

  void deleteAllFilters() => state = state?.copyWith(savedFilters: []);
}
