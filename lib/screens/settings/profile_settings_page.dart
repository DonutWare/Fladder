import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/authenticate_button_options.dart';
import 'package:fladder/screens/shared/input_fields.dart';
import 'package:fladder/util/localization_helper.dart';

@RoutePage()
class ProfileSettingsPage extends ConsumerStatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends ConsumerState<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return SettingsScaffold(
      label: context.localized.settingsProfileTitle,
      items: [
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.settingSecurityApplockTitle),
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
          ],
        ),
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
          ],
        ),
      ],
    );
  }
}
