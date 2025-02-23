import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/localization_helper.dart';

extension ClipboardHelper on BuildContext {
  Future<void> copyToClipboard(String value, {String? customMessage}) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (mounted) {
      fladderSnackbar(
        this,
        title: customMessage ?? localized.copiedToClipboard,
      );
    }
  }
}
