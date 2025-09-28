import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/login/widgets/login_icon.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';

Future<void> openQuickConnectDialog(
  BuildContext context,
) async {
  return showDialog(context: context, builder: (context) => const QuickConnectDialog());
}

class QuickConnectDialog extends ConsumerStatefulWidget {
  const QuickConnectDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuickConnectDialogState();
}

class _QuickConnectDialogState extends ConsumerState<QuickConnectDialog> {
  final controller = TextEditingController();
  bool loading = false;
  String? error;
  String? success;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return AlertDialog(
      title: Text(
        context.localized.quickConnectTitle,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Text(
            context.localized.quickConnectAction,
            textAlign: TextAlign.center,
          ),
          if (user != null) SizedBox(child: LoginIcon(user: user)),
          Flexible(
            child: OutlinedTextField(
              label: context.localized.code,
              controller: controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.go,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    error = null;
                    success = null;
                  });
                }
              },
              onSubmitted: (value) => tryLogin(),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            child: error != null || success != null
                ? Card(
                    key: Key(context.localized.error),
                    color: success == null
                        ? Theme.of(context).colorScheme.errorContainer
                        : Theme.of(context).colorScheme.surfaceContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        success ?? error ?? "",
                        style: TextStyle(
                            color: success == null
                                ? Theme.of(context).colorScheme.onErrorContainer
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  )
                : null,
          ),
          FilledButton(
            onPressed: loading ? null : () => tryLogin(),
            child: loading
                ? const SizedBox.square(
                    child: CircularProgressIndicator(),
                    dimension: 16.0,
                  )
                : Text(context.localized.login),
          )
        ],
      ),
    );
  }

  Future<void> tryLogin() async {
    setState(() {
      error = null;
      loading = true;
    });
    final response = await ref.read(userProvider.notifier).quickConnect(controller.text);
    if (response.isSuccessful) {
      setState(
        () {
          error = null;
          success = context.localized.loggedIn;
        },
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();
    } else {
      if (controller.text.isEmpty) {
        error = context.localized.quickConnectInputACode;
      } else {
        error = context.localized.quickConnectWrongCode;
      }
    }
    loading = false;
    setState(
      () {},
    );
    controller.text = "";
  }
}
