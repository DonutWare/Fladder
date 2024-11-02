import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/models/login_screen_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/dashboard_provider.dart';
import 'package:fladder/providers/favourites_provider.dart';
import 'package:fladder/providers/image_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/views_provider.dart';

final authProvider = StateNotifierProvider<AuthNotifier, LoginScreenModel>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<LoginScreenModel> {
  AuthNotifier(this.ref)
      : super(
          LoginScreenModel(
            accounts: [],
            tempCredentials: CredentialsModel.createNewCredentials(),
            loading: false,
          ),
        );

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response<List<AccountModel>>?> getPublicUsers() async {
    try {
      var response = await api.usersPublicGet(state.tempCredentials);
      if (response.isSuccessful && response.body != null) {
        var models = response.body ?? [];

        return response.copyWith(body: models.toList());
      }
      return response.copyWith(body: []);
    } catch (e) {
      return null;
    }
  }

  Future<Response<AccountModel>?> authenticateByName(String userName, String password) async {
    state = state.copyWith(loading: true);
    clearAllProviders();
    var response = await api.usersAuthenticateByNamePost(userName: userName, password: password);
    var serverResponse = await api.systemInfoPublicGet();
    CredentialsModel credentials = state.tempCredentials;
    if (response.isSuccessful && (response.body?.accessToken?.isNotEmpty ?? false)) {
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
      state = state.copyWith(loading: false);
      return Response(response.base, newUser);
    }
    state = state.copyWith(loading: false);
    return Response(response.base, null);
  }

  Future<Response?> logOutUser() async {
    final currentUser = ref.read(userProvider);
    state = state.copyWith(tempCredentials: CredentialsModel.createNewCredentials());
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
    ref.read(syncProvider.notifier).setup();
  }

  void setServer(String server) {
    state = state.copyWith(
      tempCredentials: state.tempCredentials.copyWith(server: server),
    );
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
}
