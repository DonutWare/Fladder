import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/authenticate_button_options.dart';
import 'package:fladder/util/localization_helper.dart';

@RoutePage()
class SecuritySettingsPage extends ConsumerStatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends ConsumerState<SecuritySettingsPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return SettingsScaffold(
      label: context.localized.settingsProfileTitle,
      items: [
        ...settingsListGroup(context, SettingsLabelDivider(label: context.localized.settingSecurityApplockTitle), [
          SettingsListTile(
            label: Text(context.localized.settingSecurityApplockTitle),
            subLabel: Text(user?.authMethod.name(context) ?? ""),
            onTap: () => showAuthOptionsDialogue(context, user!, (newUser) {
              ref.read(userProvider.notifier).updateUser(newUser);
            }),
          ),
        ]),
      ],
    );
  }
}
