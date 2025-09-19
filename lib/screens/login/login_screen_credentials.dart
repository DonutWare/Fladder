import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/screens/login/login_code_dialog.dart';
import 'package:fladder/screens/login/login_user_grid.dart';
import 'package:fladder/screens/login/widgets/discover_servers_widget.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/screens/shared/passcode_input.dart';
import 'package:fladder/util/auth_service.dart';
import 'package:fladder/util/localization_helper.dart';

class LoginScreenCredentials extends ConsumerStatefulWidget {
  const LoginScreenCredentials({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenCredentialsState();
}

class _LoginScreenCredentialsState extends ConsumerState<LoginScreenCredentials> {
  late final TextEditingController serverTextController = TextEditingController(text: '');
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool loggingIn = false;

  @override
  Widget build(BuildContext context) {
    final existingUsers = ref.watch(authProvider.select((value) => value.accounts));
    final otherCredentials = existingUsers.map((e) => e.credentials).toList();
    final serverCredentials = ref.watch(authProvider.select((value) => value.serverLoginModel));
    final users = serverCredentials?.accounts ?? [];
    final provider = ref.read(authProvider.notifier);
    final loading = ref.watch(authProvider.select((value) => value.loading));
    final hasBaseUrl = ref.watch(authProvider.select((value) => value.hasBaseUrl));
    final urlError = ref.watch(authProvider.select((value) => value.errorMessage));
    final hasQuickConnect = ref.watch(authProvider.select((value) => value.serverLoginModel?.hasQuickConnect ?? false));

    ref.listen(
      authProvider.select((value) => value.serverLoginModel),
      (previous, next) {
        if (next?.tempCredentials.server.isNotEmpty == true) {
          serverTextController.text = next?.tempCredentials.server ?? "";
        }
      },
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            if (existingUsers.isNotEmpty)
              IconButton.filledTonal(
                onPressed: () => provider.goUserSelect(),
                iconSize: 28,
                icon: const Icon(
                  IconsaxPlusLinear.arrow_left_2,
                ),
              ),
            if (!hasBaseUrl)
              Flexible(
                child: OutlinedTextField(
                  controller: serverTextController,
                  onChanged: (value) => provider.tryParseUrl(value),
                  onSubmitted: (value) => provider.setServer(value),
                  autoFillHints: const [AutofillHints.url],
                  keyboardType: TextInputType.url,
                  autocorrect: false,
                  textInputAction: TextInputAction.go,
                  label: context.localized.server,
                  errorText: urlError,
                ),
              ),
            Tooltip(
              message: context.localized.retrievePublicListOfUsers,
              waitDuration: const Duration(seconds: 1),
              child: IconButton.filled(
                onPressed: () => provider.setServer(serverTextController.text),
                iconSize: 28,
                icon: const Icon(
                  IconsaxPlusLinear.refresh,
                ),
              ),
            ),
          ],
        ),
        if (serverCredentials == null)
          DiscoverServersWidget(
            serverCredentials: otherCredentials,
            onPressed: (info) => provider.setServer(info.address),
          )
        else ...[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
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
                            setState(() {});
                          },
                        ),
                ),
              AutofillGroup(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    Flexible(
                      child: OutlinedTextField(
                        controller: usernameController,
                        autoFillHints: const [AutofillHints.username],
                        textInputAction: TextInputAction.next,
                        autocorrect: false,
                        onChanged: (value) => setState(() {}),
                        label: context.localized.userName,
                      ),
                    ),
                    Flexible(
                      child: OutlinedTextField(
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
                    ),
                    const Divider(
                      indent: 32,
                      endIndent: 32,
                    ),
                    FilledButton(
                      onPressed: enterCredentialsTryLogin,
                      child: loggingIn
                          ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.inversePrimary, strokeCap: StrokeCap.round),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(context.localized.login),
                                const SizedBox(width: 8),
                                const Icon(IconsaxPlusBold.send_1),
                              ],
                            ),
                    ),
                    if (hasQuickConnect)
                      FilledButton(
                        onPressed: () async {
                          final result = await ref.read(jellyApiProvider).quickConnectInitiate();
                          if (result.body != null) {
                            await openLoginCodeDialog(
                              context,
                              quickConnectInfo: result.body!,
                              onAuthenticated: (context, secret) async {
                                context.pop();
                                if (secret.isNotEmpty) {
                                  await loginUsingSecret(secret);
                                }
                              },
                            );
                          } else {
                            fladderSnackbar(context, title: context.localized.quickConnectPostFailed);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(context.localized.quickConnectLoginUsingCode),
                            const SizedBox(width: 8),
                            const Icon(IconsaxPlusBold.scan_barcode),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (serverCredentials.serverMessage?.isEmpty == false) ...[
                const Divider(),
                Text(
                  serverCredentials.serverMessage ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }

  Future<void> Function()? get enterCredentialsTryLogin => emptyFields() ? null : () => loginUsingCredentials();

  Future<void> loginUsingCredentials() async {
    setState(() {
      loggingIn = true;
    });
    final response = await ref.read(authProvider.notifier).authenticateByName(
          usernameController.text,
          passwordController.text,
        );
    if (response?.isSuccessful == false) {
      fladderSnackbar(context,
          title:
              "(${response?.base.statusCode}) ${response?.base.reasonPhrase ?? context.localized.somethingWentWrongPasswordCheck}");
    } else if (response?.body != null) {
      loggedInGoToHome(context, ref);
    }
    setState(() {
      loggingIn = false;
    });
  }

  Future<void> loginUsingSecret(String secret) async {
    setState(() {
      loggingIn = true;
    });
    final response = await ref.read(authProvider.notifier).authenticateUsingSecret(secret);
    if (response?.isSuccessful == false) {
      fladderSnackbar(context,
          title:
              "(${response?.base.statusCode}) ${response?.base.reasonPhrase ?? context.localized.somethingWentWrongPasswordCheck}");
    } else if (response?.body != null) {
      loggedInGoToHome(context, ref);
    }
    setState(() {
      loggingIn = false;
    });
  }

  bool emptyFields() => usernameController.text.isEmpty;
}

void loggedInGoToHome(BuildContext context, WidgetRef ref) {
  ref.read(lockScreenActiveProvider.notifier).update((state) => false);
  if (context.mounted) {
    context.router.replaceAll([const DashboardRoute()]);
  }
}

Future<void> _handleLogin(BuildContext context, AccountModel user, WidgetRef ref) async {
  await ref.read(authProvider.notifier).switchUser();
  await ref.read(sharedUtilityProvider).updateAccountInfo(user.copyWith(
        lastUsed: DateTime.now(),
      ));
  ref.read(userProvider.notifier).updateUser(user.copyWith(lastUsed: DateTime.now()));

  loggedInGoToHome(context, ref);
}

void tapLoggedInAccount(BuildContext context, AccountModel user, WidgetRef ref) async {
  Future<void> loginFunction() => _handleLogin(context, user, ref);
  switch (user.authMethod) {
    case Authentication.autoLogin:
      loginFunction();
      break;
    case Authentication.biometrics:
      final authenticated = await AuthService.authenticateUser(context, user);
      if (authenticated) {
        loginFunction();
      }
      break;
    case Authentication.passcode:
      if (context.mounted) {
        showPassCodeDialog(context, (newPin) {
          if (newPin == user.localPin) {
            loginFunction();
          } else {
            fladderSnackbar(context, title: context.localized.incorrectPinTryAgain);
          }
        });
      }
      break;
    case Authentication.none:
      loginFunction();
      break;
  }
}
