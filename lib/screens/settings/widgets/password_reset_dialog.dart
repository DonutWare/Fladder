import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/control_panel/control_users_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';

Future<void> openPasswordResetDialog(BuildContext context) {
  return showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const PasswordResetDialog(),
  );
}

class PasswordResetDialog extends ConsumerStatefulWidget {
  const PasswordResetDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends ConsumerState<PasswordResetDialog> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controlUserProvider = ref.read(controlUsersProvider.notifier);
    final currentUser = ref.watch(userProvider);
    final hasConfiguredPassword = currentUser?.hasConfiguredPassword ?? false;
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.localized.resetPassword,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 6,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hasConfiguredPassword)
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(child: Text(context.localized.currentPassword)),
                            Flexible(
                              child: OutlinedTextField(
                                controller: currentPasswordController,
                              ),
                            )
                          ],
                        ),
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(child: Text(context.localized.newPassword)),
                          Flexible(
                            child: OutlinedTextField(
                              controller: newPasswordController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(child: Text(context.localized.confirmPassword)),
                          Flexible(
                            child: OutlinedTextField(
                              controller: confirmPasswordController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(context.localized.cancel),
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
                      final responseMessage = await controlUserProvider.setUserPassword(
                        ref.read(userProvider)?.id,
                        current: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                      if (responseMessage == null) {
                        fladderSnackbar(
                          context,
                          title: context.localized.passwordChangeSuccess,
                        );
                        Navigator.of(context).pop();
                      } else {
                        fladderSnackbar(
                          context,
                          title: responseMessage,
                        );
                      }
                    },
                    child: Text(context.localized.savePassword),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
