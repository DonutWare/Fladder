import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/login_screen_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/dashboard_provider.dart';
import 'package:fladder/providers/favourites_provider.dart';
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/providers/library_screen_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/fladder_config.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';

final authProvider = StateNotifierProvider<AuthNotifier, LoginScreenModel>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<LoginScreenModel> {
  AuthNotifier(this.ref) : super(LoginScreenModel());

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  BuildContext? context;

  Future<void> initModel(BuildContext newContext) async {
    context ??= newContext;
    ref.read(userProvider.notifier).clear();
    final currentAccounts = ref.read(authProvider.notifier).getSavedAccounts();
    ref.read(lockScreenActiveProvider.notifier).update((state) => true);
    if (FladderConfig.baseUrl != null) {
      final url = FladderConfig.baseUrl;
      state = state.copyWith(
        hasBaseUrl: true,
      );
      if (url != null) {
        await setServer(url);
      }
    }
    state = state.copyWith(
      accounts: currentAccounts,
      screen: currentAccounts.isEmpty ? LoginScreenType.login : LoginScreenType.users,
    );
  }

  Future<void> _fetchServerInfo(String url) async {
    try {
      final newCredentials = CredentialsModel.createNewCredentials().copyWith(server: url.rtrim('/'));
      final newLoginModel = ServerLoginModel(tempCredentials: newCredentials);
      state = state.copyWith(
        serverLoginModel: newLoginModel,
        loading: true,
      );
      final publicUsers = (await getPublicUsers())?.body ?? [];
      final quickConnectStatus = (await api.quickConnectEnabled()).body ?? false;
      final branding = await api.getBranding();
      state = state.copyWith(
        screen: quickConnectStatus ? LoginScreenType.code : LoginScreenType.login,
        serverLoginModel: newLoginModel.copyWith(
          tempCredentials: newCredentials,
          accounts: publicUsers,
          hasQuickConnect: quickConnectStatus,
          serverMessage: branding.body?.loginDisclaimer,
        ),
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: context?.localized.invalidUrl,
        loading: false,
      );
      if (context != null) {
        fladderSnackbar(context!, title: context!.localized.unableToConnectHost);
      }
    }
  }

  String? _parseUrl(String url) {
    if (url.isEmpty) {
      return null;
    }
    if (!Uri.parse(url).isAbsolute) {
      return context?.localized.invalidUrl;
    }

    if (!url.startsWith('https://') && !url.startsWith('http://')) {
      return context?.localized.invalidUrlDesc;
    }
    return null;
  }

  Future<Response<List<AccountModel>>?> getPublicUsers() async {
    try {
      state = state.copyWith(loading: true);
      final credentials = state.serverLoginModel?.tempCredentials;
      if (credentials == null) return null;
      var response = await api.usersPublicGet(credentials);
      if (response.isSuccessful && response.body != null) {
        var models = response.body ?? [];
        return response.copyWith(body: models.toList());
      }
      state = state.copyWith(
        serverLoginModel: state.serverLoginModel?.copyWith(
          accounts: response.body ?? [],
        ),
      );
      return response.copyWith(body: []);
    } catch (e) {
      return null;
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<Response<AccountModel>?> authenticateByName(String userName, String password) async {
    clearAllProviders();
    var response = await api.usersAuthenticateByNamePost(userName: userName, password: password);
    CredentialsModel? credentials = state.serverLoginModel?.tempCredentials;
    if (credentials == null) return null;
    if (response.isSuccessful && (response.body?.accessToken?.isNotEmpty ?? false)) {
      var serverResponse = await api.systemInfoPublicGet();
      credentials = credentials.copyWith(
        token: response.body?.accessToken ?? "",
        serverId: response.body?.serverId,
        serverName: serverResponse.body?.serverName ?? "",
      );
      var imageUrl = ref.read(imageUtilityProvider).getUserImageUrl(response.body?.user?.id ?? "");
      AccountModel newUser = AccountModel(
        name: response.body?.user?.name ?? "",
        id: response.body?.user?.id ?? "",
        avatar: imageUrl,
        credentials: credentials,
        lastUsed: DateTime.now(),
      );
      ref.read(sharedUtilityProvider).addAccount(newUser);
      ref.read(userProvider.notifier).userState = newUser;
      final currentAccounts = ref.read(authProvider.notifier).getSavedAccounts();

      state = state.copyWith(
        serverLoginModel: null,
        accounts: currentAccounts,
      );

      return Response(response.base, newUser);
    }
    return Response(response.base, null);
  }

  Future<Response?> logOutUser() async {
    final currentUser = ref.read(userProvider);
    state = state.copyWith(serverLoginModel: null);
    await ref.read(sharedUtilityProvider).removeAccount(currentUser);
    clearAllProviders();
    return null;
  }

  Future<void> switchUser() async {
    clearAllProviders();
  }

  void clearAllProviders() {
    ref.read(dashboardProvider.notifier).clear();
    ref.read(viewsProvider.notifier).clear();
    ref.read(favouritesProvider.notifier).clear();
    ref.read(userProvider.notifier).clear();
    ref.read(libraryScreenProvider.notifier).clear();
  }

  Future<void> setServer(String server) async {
    final url = (state.hasBaseUrl ? FladderConfig.baseUrl : server);
    if (url == null) return;
    final isUrlValid = _parseUrl(url);
    state = state.copyWith(
      errorMessage: isUrlValid,
      serverLoginModel: null,
    );
    if (isUrlValid == null) {
      await _fetchServerInfo(url);
    }
  }

  List<AccountModel> getSavedAccounts() {
    state = state.copyWith(accounts: ref.read(sharedUtilityProvider).getAccounts());
    return state.accounts;
  }

  void reOrderUsers(int oldIndex, int newIndex) {
    final accounts = state.accounts;
    final original = accounts.elementAt(oldIndex);
    accounts.removeAt(oldIndex);
    accounts.insert(newIndex, original);
    ref.read(sharedUtilityProvider).saveAccounts(accounts);
  }

  void addNewUser() {
    state = state.copyWith(
      screen: LoginScreenType.login,
    );
  }

  void goUserSelect() {
    state = state.copyWith(
      serverLoginModel: state.hasBaseUrl ? state.serverLoginModel : null,
      screen: LoginScreenType.users,
    );
  }

  void tryParseUrl(String server) {
    if (server.isNotEmpty && state.errorMessage != null) {
      final url = server;
      final isUrlValid = _parseUrl(url);
      state = state.copyWith(
        errorMessage: isUrlValid,
      );
    }
  }
}
