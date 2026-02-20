import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';

class ControlUserEditPassword extends ConsumerStatefulWidget {
  const ControlUserEditPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControlUserEditPasswordState();
}

class _ControlUserEditPasswordState extends ConsumerState<ControlUserEditPassword> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hasConfiguredPassword =
        ref.watch(controlUsersProvider.select((value) => value.selectedUser?.hasConfiguredPassword ?? false));

    final currentUser = ref.watch(controlUsersProvider.select((value) => value.selectedUser));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...settingsListGroup(
          context,
          SettingsLabelDivider(label: context.localized.password),
          [
            if (hasConfiguredPassword)
              SettingsListTile(
                label: Text(context.localized.currentPassword),
                trailing: OutlinedTextField(
                  controller: currentPasswordController,
                ),
              ),
            SettingsListTile(
              label: Text(context.localized.newPassword),
              trailing: OutlinedTextField(
                controller: newPasswordController,
              ),
            ),
            SettingsListTile(
              label: Text(context.localized.confirmPassword),
              trailing: OutlinedTextField(
                controller: confirmPasswordController,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4,
              children: [
                FilledButtonAwait.tonal(
                  onPressed: () async {
                    final success = await ref.read(controlUsersProvider.notifier).resetUserPassword();
                    if (success) {
                      FladderSnack.show(
                        context.localized.passwordResetSuccess,
                        context: context,
                      );
                    } else {
                      FladderSnack.show(
                        context.localized.passwordResetFailed,
                        context: context,
                      );
                    }
                    await context.refreshData();
                  },
                  child: Text(context.localized.resetPassword),
                ),
                FilledButtonAwait(
                  onPressed: () async {
                    if (newPasswordController.text != confirmPasswordController.text) {
                      FladderSnack.show(
                        context.localized.passwordMismatch,
                        context: context,
                      );
                      return;
                    }
                    final responseMessage = await ref.read(controlUsersProvider.notifier).setUserPassword(
                          currentUser?.id,
                          current: currentPasswordController.text,
                          newPassword: newPasswordController.text,
                          confirmPassword: confirmPasswordController.text,
                        );
                    if (responseMessage == null) {
                      FladderSnack.show(
                        context.localized.passwordChangeSuccess,
                        context: context,
                      );
                      currentPasswordController.clear();
                      newPasswordController.clear();
                      confirmPasswordController.clear();
                    } else {
                      FladderSnack.show(
                        responseMessage,
                        context: context,
                      );
                    }
                    await context.refreshData();
                  },
                  child: Text(context.localized.savePassword),
                ),
              ],
            ),
          );
        })
      ],
    );
  }
}
