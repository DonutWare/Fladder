import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:macos_window_utils/macos/ns_window_button_type.dart';
import 'package:macos_window_utils/window_manipulator.dart';

Future<void> toggleMacTrafficLights(bool enable) async {
  if (kIsWeb || !Platform.isMacOS) return;

  final verticalOffset = enable ? 0.0 : 12.0;
  final horizontalOffset = enable ? 0.0 : 16.0;
  final buttons = [
    NSWindowButtonType.closeButton,
    NSWindowButtonType.miniaturizeButton,
    NSWindowButtonType.zoomButton,
  ];

  for (var index = 0; index < buttons.length; index++) {
    final button = buttons[index];
    await WindowManipulator.overrideStandardWindowButtonPosition(
      buttonType: button,
      offset: Offset((index * 23) + horizontalOffset, verticalOffset),
    );
  }

  if (enable) {
    await WindowManipulator.disableMiniaturizeButton();
  } else {
    await WindowManipulator.enableMiniaturizeButton();
  }
}
