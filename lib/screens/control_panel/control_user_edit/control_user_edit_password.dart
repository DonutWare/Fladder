import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
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
                      fladderSnackbar(
                        context,
                        title: context.localized.passwordResetSuccess,
                      );
                    } else {
                      fladderSnackbar(
                        context,
                        title: context.localized.passwordResetFailed,
                      );
                    }
                    await context.refreshData();
                  },
                  child: Text(context.localized.resetPassword),
                ),
                FilledButtonAwait(
                  onPressed: () async {
                    if (newPasswordController.text != confirmPasswordController.text) {
                      fladderSnackbar(
                        context,
                        title: context.localized.passwordMismatch,
                      );
                      return;
                    }
                    final success = await ref.read(controlUsersProvider.notifier).setUserPassword(
                          current: currentPasswordController.text,
                          newPassword: newPasswordController.text,
                          confirmPassword: confirmPasswordController.text,
                        );
                    if (success) {
                      fladderSnackbar(
                        context,
                        title: context.localized.passwordChangeSuccess,
                      );
                      currentPasswordController.clear();
                      newPasswordController.clear();
                      confirmPasswordController.clear();
                    } else {
                      fladderSnackbar(
                        context,
                        title: context.localized.passwordChangeFailed,
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
