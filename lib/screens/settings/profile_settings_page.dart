import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/seerr_credentials_model.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/seerr_user_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/password_reset_dialog.dart';
import 'package:fladder/screens/settings/widgets/seerr_connection_dialog.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/authenticate_button_options.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/localization_helper.dart';

@RoutePage()
class ProfileSettingsPage extends ConsumerStatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends ConsumerState<ProfileSettingsPage> {
  String _seerrStatusLabel(
    BuildContext context,
    SeerrCredentialsModel? credentials,
    SeerrUserModel? seerrUser,
  ) {
    if (credentials == null || credentials.serverUrl.isEmpty) return context.localized.seerrNotConfigured;

    if (credentials.sessionCookie.isNotEmpty || credentials.apiKey.isNotEmpty) {
      if (seerrUser == null) {
        return context.localized.seerrLoadingUser;
      }
      final displayName =
          seerrUser.displayName ?? seerrUser.username ?? seerrUser.email ?? context.localized.seerrUnknownUser;
      return context.localized.loggedInAs(displayName);
    }

    return context.localized.none;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final seerrUser = ref.watch(seerrUserProvider);
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
              subLabel: Text(user?.credentials.localUrl ?? context.localized.none),
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
              label: Text(context.localized.seerr),
              subLabel: Text(_seerrStatusLabel(context, user?.seerrCredentials, seerrUser)),
              onTap: () => showSeerrConnectionDialog(context),
            ),
          ],
        ),
      ],
    );
  }
}
