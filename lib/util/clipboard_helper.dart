import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/localization_helper.dart';

extension ClipboardHelper on BuildContext {
  Future<void> copyToClipboard(String value, {String? customMessage}) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (mounted) {
      FladderSnack.show(
        customMessage ?? localized.copiedToClipboard,
        context: this,
      );
    }
  }
}
