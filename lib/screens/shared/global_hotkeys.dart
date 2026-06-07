import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/focus_helper.dart';
import 'package:fladder/util/input_handler.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/window_actions.dart';

class GlobalHotkeys extends ConsumerWidget {
  final Widget child;
  final Set<GlobalHotKeys> enabledHotkeys;
  const GlobalHotkeys({
    required this.child,
    required this.enabledHotkeys,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InputHandler(
      autoFocus: false,
      listenRawKeyboard: true,
      ignoreWhenTextFieldFocused: false,
      keyMapResult: (result) {
        if (!enabledHotkeys.contains(result)) return false;

        final inputFocused = isEditableTextFocused();

        switch (result) {
          case GlobalHotKeys.toggleSideBar:
            if (inputFocused) return false;
            ref.read(clientSettingsProvider.notifier).toggleSideBar();
            return true;
          case GlobalHotKeys.search:
            if (inputFocused) return false;
            context.navigateTo(LibrarySearchRoute());
            return true;
          case GlobalHotKeys.closeWindow:
            Future.microtask(() async {
              final closed = await closeCurrentWindow();
              if (!closed && context.mounted) {
                FladderSnack.show(context.localized.somethingWentWrong, context: context);
              }
            });
            return true;
          case GlobalHotKeys.exit:
            Future.microtask(() async {
              await quitApplication(context);
            });
            return true;
        }
      },
      keyMap: ref.watch(clientSettingsProvider.select((value) => value.currentShortcuts)),
      child: child,
    );
  }
}
