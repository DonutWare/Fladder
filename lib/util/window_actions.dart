import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'package:desktop_multi_window/desktop_multi_window.dart';

import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/native_window.dart';

Future<bool> closeCurrentWindow() async {
  final window = currentWindow;
  if (window == null || !window.isClosable) {
    return false;
  }

  window.close();
  return true;
}

Future<void> quitApplication(BuildContext context) async {
  if (kIsWeb) {
    return;
  }

  final windows = await WindowController.getAll();
  if (!context.mounted) {
    return;
  }

  if (windows.length > 1) {
    await showDefaultAlertDialog(
      context,
      context.localized.exitFladderTitle,
      context.localized.quitMultipleWindowsDesc(windows.length),
      (context) => SystemNavigator.pop(),
      context.localized.exit,
      (context) => Navigator.of(context).pop(),
      context.localized.cancel,
    );
    return;
  }

  final closed = await closeCurrentWindow();
  if (!closed && context.mounted) {
    FladderSnack.show(context.localized.somethingWentWrong, context: context);
  }
}
