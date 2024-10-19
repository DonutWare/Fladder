import 'package:flutter/material.dart';

import 'package:fladder/util/adaptive_layout.dart';

Future<void> showDialogAdaptive(
    {required BuildContext context, required Widget Function(BuildContext context) builder}) {
  if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer) {
    return showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => Dialog(
        child: builder(context),
      ),
    );
  } else {
    return showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => Dialog.fullscreen(
        child: builder(context),
      ),
    );
  }
}
