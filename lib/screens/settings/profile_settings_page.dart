import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/password_reset_dialog.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/authenticate_button_options.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/util/localization_helper.dart';

@RoutePage()
class ProfileSettingsPage extends ConsumerStatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends ConsumerState<ProfileSettingsPage> {
  Future<void> _showSeerrLocalLoginDialog() async {
    final user = ref.read(userProvider);
    final serverUrl = user?.seerrCredentials?.serverUrl ?? '';
    if (serverUrl.trim().isEmpty) {
      fladderSnackbar(context, title: 'Set Seerr server first');
      return;
    }

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seerr Local Login'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Login')),
        ],
      ),
    );

    if (result != true) return;

    try {
      final cookie = await ref
          .read(seerrApiProvider)
          .authenticateLocal(email: emailController.text.trim(), password: passwordController.text);
      ref.read(userProvider.notifier).setSeerrSessionCookie(cookie);
      fladderSnackbar(context, title: 'Seerr session saved');
    } catch (e) {
      fladderSnackbar(context, title: e.toString());
    }
  }

  Future<void> _showSeerrJellyfinLoginDialog() async {
    final user = ref.read(userProvider);
    final serverUrl = user?.seerrCredentials?.serverUrl ?? '';
    if (serverUrl.trim().isEmpty) {
      fladderSnackbar(context, title: 'Set Seerr server first');
      return;
    }

    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seerr Jellyfin Login'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Login')),
        ],
      ),
    );

    if (result != true) return;

    try {
      final cookie = await ref
          .read(seerrApiProvider)
          .authenticateJellyfin(username: usernameController.text.trim(), password: passwordController.text);
      ref.read(userProvider.notifier).setSeerrSessionCookie(cookie);
      fladderSnackbar(context, title: 'Seerr session saved');
    } catch (e) {
      fladderSnackbar(context, title: e.toString());
    }
  }

  Future<void> _testSeerr() async {
    try {
      final response = await ref.read(seerrApiProvider).status();
      if (response.isSuccessful) {
        final version = response.body?.version ?? 'OK';
        fladderSnackbar(context, title: 'Seerr: $version');
      } else {
        fladderSnackbarResponse(context, response);
      }
    } catch (e) {
      fladderSnackbar(context, title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return SettingsScaffold(
      label: context.localized.settingsProfileTitle,
      items: [
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.settingsSecurity),
          [
            SettingsListTile(
              label: Text(context.localized.settingSecurityApplockTitle),
              subLabel: Text(user?.authMethod.name(context) ?? ""),
              onTap: () => showAuthOptionsDialogue(
                context,
                user!,
                (newUser) {
                  ref.read(userProvider.notifier).updateUser(newUser);
                },
              ),
            ),
            SettingsListTile(
              label: Text(context.localized.password),
              onTap: () => openPasswordResetDialog(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.advanced),
          [
            SettingsListTile(
              label: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  if (user?.credentials.localUrl?.isNotEmpty == true)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: ref.watch(localConnectionAvailableProvider)
                            ? Colors.greenAccent
                            : Theme.of(context).colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(context.localized.settingsLocalUrlTitle),
                ],
              ),
              subLabel: Text(user?.credentials.localUrl ?? "-"),
              onTap: () {
                openSimpleTextInput(
                  context,
                  user?.credentials.localUrl,
                  (value) => ref.read(userProvider.notifier).setLocalURL(value),
                  context.localized.settingsLocalUrlSetTitle,
                  context.localized.settingsLocalUrlSetDesc,
                );
              },
            ),
            SettingsListTile(
              label: const Text('Seerr server'),
              subLabel: Text(
                  user?.seerrCredentials?.serverUrl.isNotEmpty == true ? user?.seerrCredentials?.serverUrl ?? "" : "-"),
              onTap: () {
                openSimpleTextInput(
                  context,
                  user?.seerrCredentials?.serverUrl,
                  (value) => ref.read(userProvider.notifier).setSeerrServerUrl(value),
                  'Seerr server',
                  'Set the Seerr server URL used for requests.',
                  keyboardType: TextInputType.url,
                  placeHolder: 'https://seerr.example.com',
                );
              },
            ),
            SettingsListTile(
              label: const Text('Seerr API key'),
              subLabel: Text((user?.seerrCredentials?.apiKey.isNotEmpty == true) ? 'Configured' : '-'),
              onTap: () {
                openSimpleTextInput(
                  context,
                  user?.seerrCredentials?.apiKey,
                  (value) => ref.read(userProvider.notifier).setSeerrApiKey(value),
                  'Seerr API key',
                  'Paste your Seerr API key. Requests will authenticate using X-Api-Key.',
                  keyboardType: TextInputType.visiblePassword,
                  placeHolder: 'API key',
                );
              },
            ),
            SettingsListTile(
              label: const Text('Seerr authenticate (local)'),
              subLabel: Text((user?.seerrCredentials?.sessionCookie.isNotEmpty == true) ? 'Session configured' : '-'),
              onTap: _showSeerrLocalLoginDialog,
            ),
            SettingsListTile(
              label: const Text('Seerr authenticate (Jellyfin)'),
              subLabel: Text((user?.seerrCredentials?.sessionCookie.isNotEmpty == true) ? 'Session configured' : '-'),
              onTap: _showSeerrJellyfinLoginDialog,
            ),
            SettingsListTile(
              label: const Text('Test Seerr connection'),
              onTap: _testSeerr,
            ),
          ],
        ),
      ],
    );
  }
}
