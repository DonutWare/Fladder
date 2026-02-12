import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/auth_provider.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/login/lock_screen.dart';
import 'package:fladder/screens/login/login_code_dialog.dart';
import 'package:fladder/screens/login/login_user_grid.dart';
import 'package:fladder/screens/login/widgets/advanced_login_options_dialog.dart';
import 'package:fladder/screens/login/widgets/discover_servers_widget.dart';
import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
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
  void dispose() {
    serverTextController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    focusNode.dispose();
    super.dispose();
  }

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
        if (next?.tempCredentials.url.isNotEmpty == true) {
          serverTextController.text = next?.tempCredentials.url ?? "";
        }
      },
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            if (existingUsers.isNotEmpty)
              IconButton.filledTonal(
                onPressed: () => provider.goUserSelect(),
                iconSize: 36,
                icon: const Icon(
                  IconsaxPlusLinear.arrow_left_2,
                ),
              ),
            if (!hasBaseUrl)
              Expanded(
                child: OutlinedTextField(
                  controller: serverTextController,
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
                iconSize: 36,
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Flexible(
                    child: AutofillGroup(
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
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 32,
                    endIndent: 32,
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: FilledButton(
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
                      ),
                      IconButton.filledTonal(
                        onPressed: () async {
                          final tempSeerrUrl = ref.read(authProvider.select((value) => value.tempSeerrUrl));
                          final result = await showAdvancedLoginOptionsDialog(
                            context,
                            initialSeerrUrl: tempSeerrUrl,
                          );
                          if (result != null) {
                            ref.read(authProvider.notifier).setTempSeerrUrl(result);
                          }
                        },
                        icon: const Icon(IconsaxPlusLinear.setting_3),
                      ),
                    ],
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
                          FladderSnack.show(context.localized.quickConnectPostFailed, context: context);
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
              if (serverCredentials.serverMessage?.isEmpty == false) ...[
                const Divider(),
                SelectableText(
                  serverCredentials.serverMessage ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
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
      FladderSnack.show(
          "(${response?.base.statusCode}) ${response?.base.reasonPhrase ?? context.localized.somethingWentWrongPasswordCheck}",
          context: context);
      setState(() {
        loggingIn = false;
      });
      return;
    }

    if (response?.body == null) {
      setState(() {
        loggingIn = false;
      });
      return;
    }

    final tempSeerrUrl = ref.read(authProvider.select((value) => value.tempSeerrUrl));
    if (tempSeerrUrl != null && tempSeerrUrl.isNotEmpty) {
      await _tryAuthenticateSeerr(tempSeerrUrl);
    }

    if (context.mounted) {
      await loggedInGoToHome(context, ref);
    }
  }

  Future<void> _tryAuthenticateSeerr(String seerrUrl) async {
    try {
      final username = usernameController.text.trim();
      final password = passwordController.text;

      ref.read(userProvider.notifier).setSeerrServerUrl(seerrUrl);

      final tempCookie = ref.read(authProvider.select((value) => value.tempSeerrSessionCookie));
      final cookie = tempCookie ??
          await ref.read(seerrApiProvider).authenticateJellyfin(
                username: username,
                password: password,
              );

      ref.read(userProvider.notifier).setSeerrSessionCookie(cookie);
      ref.read(userProvider.notifier).setSeerrApiKey('');
      ref.read(authProvider.notifier).setTempSeerrSessionCookie(null);

      if (context.mounted) {
        FladderSnack.show(context.localized.seerrLoggedIn, context: context);
      }
    } catch (e) {
      if (context.mounted) {
        FladderSnack.show(
          "${context.localized.seerrAuthenticateLocal}: ${e.toString()}",
          context: context,
        );
      }
    }
  }

  Future<void> loginUsingSecret(String secret) async {
    setState(() {
      loggingIn = true;
    });
    final response = await ref.read(authProvider.notifier).authenticateUsingSecret(secret);
    if (response?.isSuccessful == false) {
      FladderSnack.showResponse(response: response);
    } else if (response?.body != null) {
      loggedInGoToHome(context, ref);
    }
    setState(() {
      loggingIn = false;
    });
  }

  bool emptyFields() => usernameController.text.isEmpty;
}

Future<void> loggedInGoToHome(BuildContext context, WidgetRef ref) async {
  ref.read(lockScreenActiveProvider.notifier).update((state) => false);
  if (context.mounted) {
    await context.router.replaceAll([const DashboardRoute()]);
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
            FladderSnack.show(context.localized.incorrectPinTryAgain, context: context);
          }
        });
      }
      break;
    case Authentication.none:
      loginFunction();
      break;
  }
}
