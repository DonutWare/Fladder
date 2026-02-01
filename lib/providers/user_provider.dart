import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/enum_models.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/models/seerr_credentials_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';

part 'user_provider.g.dart';

@riverpod
bool showSyncButtonProvider(Ref ref) {
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

    final customConfig = await api.getCustomConfig();

    var imageUrl = ref.read(imageUtilityProvider).getUserImageUrl(response.body?.id ?? "");

    final user = response.body;
    if (user == null) return null;

    if (response.isSuccessful && response.body != null) {
      userState = state?.copyWith(
        name: user.name ?? state?.name ?? "",
        policy: user.policy,
        avatar: imageUrl,
        serverConfiguration: systemConfiguration.body,
        userConfiguration: user.configuration,
        quickConnectState: quickConnectStatus.body ?? false,
        latestItemsExcludes: user.configuration?.latestItemsExcludes ?? [],
        userSettings: customConfig.body,
        hasConfiguredPassword: user.hasConfiguredPassword ?? false,
        hasPassword: user.hasPassword ?? false,
      );
      return response.copyWith(body: state);
    }
    return null;
  }

  void setRememberAudioSelections() async {
    final newUserConfiguration = await api.updateRememberAudioSelections();
    if (newUserConfiguration != null) {
      userState = state?.copyWith(userConfiguration: newUserConfiguration);
    }
  }

  void setRememberSubtitleSelections() async {
    final newUserConfiguration = await api.updateRememberSubtitleSelections();
    if (newUserConfiguration != null) {
      userState = state?.copyWith(userConfiguration: newUserConfiguration);
    }
  }

  void updateSubtitleLanguagePreference(String? language) async {
    final currentUserConfiguration = state?.userConfiguration;
    if (currentUserConfiguration == null) return;

    final updated = currentUserConfiguration.copyWith(
      subtitleLanguagePreference: language?.isEmpty ?? true ? null : language,
    );
    final newUserConfiguration = await api.updateUserConfiguration(updated);
    if (newUserConfiguration != null) {
      userState = state?.copyWith(userConfiguration: newUserConfiguration);
    }
  }

  void updateSubtitleMode(enums.SubtitlePlaybackMode? mode) async {
    final currentUserConfiguration = state?.userConfiguration;
    if (currentUserConfiguration == null) return;

    final updated = currentUserConfiguration.copyWith(subtitleMode: mode);
    final newUserConfiguration = await api.updateUserConfiguration(updated);
    if (newUserConfiguration != null) {
      userState = state?.copyWith(userConfiguration: newUserConfiguration);
    }
  }

  void setBackwardSpeed(int value) {
    final userSettings = state?.userSettings?.copyWith(skipBackDuration: Duration(seconds: value));
    if (userSettings != null) {
      updateCustomConfig(userSettings);
    }
  }

  void setForwardSpeed(int value) {
    final userSettings = state?.userSettings?.copyWith(skipForwardDuration: Duration(seconds: value));
    if (userSettings != null) {
      updateCustomConfig(userSettings);
    }
  }

  Future<Response<dynamic>> updateCustomConfig(UserSettings settings) async {
    state = state?.copyWith(userSettings: settings);
    return api.setCustomConfig(settings);
  }

  Future<Response> refreshMetaData(
    String itemId, {
    MetadataRefresh? metadataRefreshMode,
    bool? replaceAllMetadata,
    bool? replaceTrickplayImages,
  }) async {
    return api.itemsItemIdRefreshPost(
      itemId: itemId,
      metadataRefreshMode: switch (metadataRefreshMode) {
        MetadataRefresh.defaultRefresh => MetadataRefresh.defaultRefresh,
        _ => MetadataRefresh.fullRefresh,
      },
      imageRefreshMode: switch (metadataRefreshMode) {
        MetadataRefresh.defaultRefresh => MetadataRefresh.defaultRefresh,
        _ => MetadataRefresh.fullRefresh,
      },
      replaceAllMetadata: switch (metadataRefreshMode) {
        MetadataRefresh.fullRefresh => true,
        _ => false,
      },
      replaceAllImages: switch (metadataRefreshMode) {
        MetadataRefresh.fullRefresh => replaceAllMetadata,
        MetadataRefresh.validation => replaceAllMetadata,
        _ => false,
      },
      replaceTrickplayImages: switch (metadataRefreshMode) {
        MetadataRefresh.fullRefresh => replaceTrickplayImages,
        MetadataRefresh.validation => replaceTrickplayImages,
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

  void clear() => userState = null;
  void updateUser(AccountModel? user) => userState = user;
  void loginUser(AccountModel? user) => state = user;
  void setAuthMethod(Authentication method) => userState = state?.copyWith(authMethod: method);
  void setLocalURL(String? value) {
    final user = state;
    if (user == null) return;
    state = user.copyWith(
      credentials: user.credentials.copyWith(localUrl: value?.isEmpty == true ? null : value),
    );
  }

  void setSeerrServerUrl(String? value) {
    final user = state;
    if (user == null) return;
    final updated = (user.seerrCredentials ?? const SeerrCredentialsModel()).copyWith(
      serverUrl: value?.trim() ?? "",
    );
    userState = user.copyWith(seerrCredentials: updated);
  }

  void logoutSeerr() {
    final user = state;
    if (user == null) return;
    final updated = (user.seerrCredentials ?? const SeerrCredentialsModel()).copyWith(
      apiKey: "",
      sessionCookie: "",
    );
    userState = user.copyWith(seerrCredentials: updated);
  }

  void setSeerrApiKey(String? value) {
    final user = state;
    if (user == null) return;
    final updated = (user.seerrCredentials ?? const SeerrCredentialsModel()).copyWith(
      apiKey: value?.trim() ?? "",
    );
    userState = user.copyWith(seerrCredentials: updated);
  }

  void setSeerrSessionCookie(String? value) {
    final user = state;
    if (user == null) return;
    final updated = (user.seerrCredentials ?? const SeerrCredentialsModel()).copyWith(
      sessionCookie: value?.trim() ?? "",
    );
    userState = user.copyWith(seerrCredentials: updated);
  }

  void setSeerrCustomHeaders(Map<String, String> headers) {
    final user = state;
    if (user == null) return;
    final updated = (user.seerrCredentials ?? const SeerrCredentialsModel()).copyWith(
      customHeaders: headers,
    );
    userState = user.copyWith(seerrCredentials: updated);
  }

  void clearSeerrCustomHeaders() {
    final user = state;
    if (user == null) return;
    final updated = (user.seerrCredentials ?? const SeerrCredentialsModel()).copyWith(
      customHeaders: {},
    );
    userState = user.copyWith(seerrCredentials: updated);
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
    await ref.read(videoPlayerProvider).stop();
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
    final currentList = ((state?.libraryFilters ?? [])).toList(growable: true);
    currentList.remove(model);
    userState = state?.copyWith(libraryFilters: currentList);
  }

  void saveFilter(LibraryFiltersModel model) {
    final currentList = (state?.libraryFilters ?? []).toList(growable: true);
    if (currentList.firstWhereOrNull((value) => value.id == model.id) != null) {
      userState = state?.copyWith(
          libraryFilters: currentList.map(
        (e) {
          if (e.id == model.id) {
            return model;
          } else {
            return e.copyWith(
              isFavourite: model.isFavourite && model.containsSameIds(e.ids) ? false : e.isFavourite,
            );
          }
        },
      ).toList());
    } else {
      userState = state?.copyWith(libraryFilters: [model, ...currentList]);
    }
  }

  void deleteAllFilters() => userState = state?.copyWith(libraryFilters: []);

  String? createDownloadUrl(ItemBaseModel item) =>
      Uri.encodeFull("${state?.credentials.url}/Items/${item.id}/Download?api_key=${state?.credentials.token}");

  Future<void> createNewUser(
    String userName,
    String password, {
    required bool enableAllFolders,
    required List<String> enabledFolders,
  }) async {
    final newUser = (await api.createNewUser(
      CreateUserByName(name: userName, password: password),
    ))
        .body;
    if (newUser == null) return;
    await api.setUserPolicy(
      id: newUser.id ?? "",
      policy: newUser.policy?.copyWith(
        enableAllFolders: enableAllFolders,
        enabledFolders: enabledFolders,
      ),
    );
  }
}
