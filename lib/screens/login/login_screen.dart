import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/screens/login/login_edit_user.dart';
import 'package:fladder/screens/login/login_user_grid.dart';
import 'package:fladder/screens/login/widgets/discover_servers_widget.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/fladder_logo.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/screens/shared/passcode_input.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/auth_service.dart';
import 'package:fladder/util/fladder_config.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/navigation_scaffold/components/fladder_appbar.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginScreen> {
  List<AccountModel> users = const [];
  bool loading = false;
  String? invalidUrl = "";
  bool startCheckingForErrors = false;
  bool addingNewUser = false;
  bool editingUsers = false;
  late final TextEditingController serverTextController = TextEditingController(text: '');

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void startAddingNewUser() {
    setState(() {
      addingNewUser = true;
      editingUsers = false;
    });
    if (FladderConfig.baseUrl != null) {
      serverTextController.text = FladderConfig.baseUrl!;
      _parseUrl(FladderConfig.baseUrl!);
      retrieveListOfUsers();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userProvider.notifier).clear();
      final currentAccounts = ref.read(authProvider.notifier).getSavedAccounts();
      addingNewUser = currentAccounts.isEmpty;
      ref.read(lockScreenActiveProvider.notifier).update((state) => true);
      if (FladderConfig.baseUrl != null) {
        serverTextController.text = FladderConfig.baseUrl!;
        _parseUrl(FladderConfig.baseUrl!);
        retrieveListOfUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUsers = ref.watch(authProvider.select((value) => value.accounts));
    final authLoading = ref.watch(authProvider.select((value) => value.loading));
    return Scaffold(
      appBar: const FladderAppbar(),
      floatingActionButton: !addingNewUser
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!AdaptiveLayout.of(context).isDesktop)
                  FloatingActionButton(
                    key: const Key("edit_button"),
                    child: const Icon(IconsaxOutline.edit_2),
                    onPressed: () => setState(() => editingUsers = !editingUsers),
                  ),
                FloatingActionButton(
                  key: const Key("new_button"),
                  child: const Icon(IconsaxOutline.add_square),
                  onPressed: startAddingNewUser,
                ),
              ].addInBetween(const SizedBox(width: 16)),
            )
          : null,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            children: [
              const Center(
                child: FladderLogo(),
              ),
              AnimatedFadeSize(
                child: addingNewUser
                    ? addUserFields(loggedInUsers, authLoading)
                    : Column(
                        key: UniqueKey(),
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LoginUserGrid(
                            users: loggedInUsers,
                            editMode: editingUsers,
                            onPressed: (user) async => tapLoggedInAccount(user),
                            onLongPress: (user) => openUserEditDialogue(context, user),
                          ),
                        ],
                      ),
              ),
            ].addPadding(const EdgeInsets.symmetric(vertical: 16)),
          ),
        ),
      ),
    );
  }

  void _parseUrl(String url) {
    setState(() {
      ref.read(authProvider.notifier).setServer("");
      users = [];

      if (url.isEmpty) {
        invalidUrl = "";
        return;
      }
      if (!Uri.parse(url).isAbsolute) {
        invalidUrl = context.localized.invalidUrl;
        return;
      }

      if (!url.startsWith('https://') && !url.startsWith('http://')) {
        invalidUrl = context.localized.invalidUrlDesc;
        return;
      }

      invalidUrl = null;

      if (invalidUrl == null) {
        ref.read(authProvider.notifier).setServer(url.rtrim('/'));
      }
    });
  }

  void openUserEditDialogue(BuildContext context, AccountModel user) {
    showDialog(
      context: context,
      builder: (context) => LoginEditUser(
        user: user,
        onTapServer: (value) {
          setState(() {
            _parseUrl(value);
            serverTextController.text = value;
            startAddingNewUser();
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void tapLoggedInAccount(AccountModel user) async {
    switch (user.authMethod) {
      case Authentication.autoLogin:
        handleLogin(user);
        break;
      case Authentication.biometrics:
        final authenticated = await AuthService.authenticateUser(context, user);
        if (authenticated) {
          handleLogin(user);
        }
        break;
      case Authentication.passcode:
        if (context.mounted) {
          showPassCodeDialog(context, (newPin) {
            if (newPin == user.localPin) {
              handleLogin(user);
            } else {
              fladderSnackbar(context, title: context.localized.incorrectPinTryAgain);
            }
          });
        }
        break;
      case Authentication.none:
        handleLogin(user);
        break;
    }
  }

  Future<void> handleLogin(AccountModel user) async {
    await ref.read(authProvider.notifier).switchUser();
    await ref.read(sharedUtilityProvider).updateAccountInfo(user.copyWith(
          lastUsed: DateTime.now(),
        ));
    ref.read(userProvider.notifier).updateUser(user.copyWith(lastUsed: DateTime.now()));

    loggedInGoToHome();
  }

  void loggedInGoToHome() {
    ref.read(lockScreenActiveProvider.notifier).update((state) => false);
    if (context.mounted) {
      context.router.replaceAll([const DashboardRoute()]);
    }
  }

  Future<Null> Function()? get enterCredentialsTryLogin => emptyFields()
      ? null
      : () async {
          serverTextController.text = serverTextController.text.rtrim('/');
          ref.read(authProvider.notifier).setServer(serverTextController.text.rtrim('/'));
          final response = await ref.read(authProvider.notifier).authenticateByName(
                usernameController.text,
                passwordController.text,
              );
          if (response?.isSuccessful == false) {
            fladderSnackbar(context,
                title:
                    "(${response?.base.statusCode}) ${response?.base.reasonPhrase ?? context.localized.somethingWentWrongPasswordCheck}");
          } else if (response?.body != null) {
            loggedInGoToHome();
          }
        };

  bool emptyFields() => usernameController.text.isEmpty;

  void retrieveListOfUsers() async {
    serverTextController.text = serverTextController.text.rtrim('/');
    ref.read(authProvider.notifier).setServer(serverTextController.text);
    setState(() => loading = true);
    final response = await ref.read(authProvider.notifier).getPublicUsers();
    if ((response == null || response.isSuccessful == false) && context.mounted) {
      fladderSnackbar(context, title: response?.base.reasonPhrase ?? context.localized.unableToConnectHost);
      setState(() => startCheckingForErrors = true);
    }
    if (response?.body?.isEmpty == true) {
      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() {
      users = response?.body ?? [];
      loading = false;
    });
  }

  Widget addUserFields(List<AccountModel> accounts, bool authLoading) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (accounts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton.filledTonal(
                  onPressed: () {
                    setState(() {
                      addingNewUser = false;
                      loading = false;
                      startCheckingForErrors = false;
                      serverTextController.text = "";
                      usernameController.text = "";
                      passwordController.text = "";
                      invalidUrl = "";
                    });
                    ref.read(authProvider.notifier).setServer("");
                  },
                  icon: const Icon(
                    IconsaxOutline.arrow_left_2,
                  ),
                ),
              ),
            if (FladderConfig.baseUrl == null) ...[
              Flexible(
                child: OutlinedTextField(
                  controller: serverTextController,
                  onChanged: _parseUrl,
                  onSubmitted: (value) => retrieveListOfUsers(),
                  autoFillHints: const [AutofillHints.url],
                  keyboardType: TextInputType.url,
                  autocorrect: false,
                  textInputAction: TextInputAction.go,
                  label: context.localized.server,
                  errorText: (invalidUrl == null || serverTextController.text.isEmpty || !startCheckingForErrors)
                      ? null
                      : invalidUrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Tooltip(
                  message: context.localized.retrievePublicListOfUsers,
                  waitDuration: const Duration(seconds: 1),
                  child: IconButton.filled(
                    onPressed: () => retrieveListOfUsers(),
                    icon: const Icon(
                      IconsaxOutline.refresh,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        AnimatedFadeSize(
          child: invalidUrl == null
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (loading || users.isNotEmpty)
                      AnimatedFadeSize(
                        duration: const Duration(milliseconds: 250),
                        child: loading
                            ? CircularProgressIndicator(key: UniqueKey(), strokeCap: StrokeCap.round)
                            : LoginUserGrid(
                                users: users,
                                onPressed: (value) {
                                  usernameController.text = value.name;
                                  passwordController.text = "";
                                  focusNode.requestFocus();
                                },
                              ),
                      ),
                    AutofillGroup(
                      child: Column(
                        children: [
                          OutlinedTextField(
                            controller: usernameController,
                            autoFillHints: const [AutofillHints.username],
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            onChanged: (value) => setState(() {}),
                            label: context.localized.userName,
                          ),
                          OutlinedTextField(
                            controller: passwordController,
                            autoFillHints: const [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                            focusNode: focusNode,
                            autocorrect: false,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (value) => enterCredentialsTryLogin?.call(),
                            onChanged: (value) => setState(() {}),
                            label: context.localized.password,
                          ),
                          FilledButton(
                            onPressed: enterCredentialsTryLogin,
                            child: authLoading
                                ? SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        color: Theme.of(context).colorScheme.inversePrimary,
                                        strokeCap: StrokeCap.round),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(context.localized.login),
                                      const SizedBox(width: 8),
                                      const Icon(IconsaxBold.send_1),
                                    ],
                                  ),
                          ),
                        ].addPadding(const EdgeInsets.symmetric(vertical: 4)),
                      ),
                    ),
                  ].addPadding(const EdgeInsets.symmetric(vertical: 10)),
                )
              : DiscoverServersWidget(
                  serverCredentials: accounts.map((e) => e.credentials).toList(),
                  onPressed: (server) {
                    serverTextController.text = server.address;
                    _parseUrl(server.address);
                    retrieveListOfUsers();
                  },
                ),
        )
      ].addPadding(const EdgeInsets.symmetric(vertical: 8)),
    );
  }
}
