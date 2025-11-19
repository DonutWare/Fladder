import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:macos_window_utils/macos/ns_window_button_type.dart';
import 'package:macos_window_utils/window_manipulator.dart';

void toggleMacTrafficLights(bool enable) {
  if (kIsWeb || !Platform.isMacOS) return;
  final height = enable ? 10.0 : 15.0;
  final initOffset = 20.0;
  List<NSWindowButtonType> buttons = [
    NSWindowButtonType.closeButton,
    NSWindowButtonType.miniaturizeButton,
    NSWindowButtonType.zoomButton,
  ];
  for (var i = 0; i < buttons.length; i++) {
    final button = buttons[i];
    WindowManipulator.overrideStandardWindowButtonPosition(
      buttonType: button,
      offset: Offset((i * 23) + initOffset, height),
    );
  }
  if (enable) {
    WindowManipulator.disableMiniaturizeButton();
  }
}

// Disabled for now too buggy
// void toggleMacControlsVisibility(bool enable) {
//   if (kIsWeb || !Platform.isMacOS) return;
//   if (enable) {
//     WindowManipulator.showCloseButton();
//     WindowManipulator.showMiniaturizeButton();
//     WindowManipulator.showZoomButton();
//   } else {
//     WindowManipulator.hideCloseButton();
//     WindowManipulator.hideMiniaturizeButton();
//     WindowManipulator.hideZoomButton();
//   }
// }
