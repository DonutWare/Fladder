import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

import 'package:auto_route/auto_route.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_helper.dart';

final backKeys = {
  LogicalKeyboardKey.backspace,
  LogicalKeyboardKey.escape,
  LogicalKeyboardKey.goBack,
  LogicalKeyboardKey.browserBack,
  LogicalKeyboardKey.gameButtonB,
};

class BackIntentDpad extends StatelessWidget {
  final Widget child;
  const BackIntentDpad({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.touch) {
      return child;
    }
    return Listener(
      onPointerDown: (event) {
        if ((event.buttons & kBackMouseButton) != 0) {
          if (!isEditableTextFocused()) {
            context.maybePop();
          }
        }
      },
      child: Focus(
        canRequestFocus: false,
        onKeyEvent: (FocusNode node, KeyEvent event) {
          if (event is! KeyDownEvent) {
            return KeyEventResult.ignored;
          }

          if (!backKeys.contains(event.logicalKey)) {
            return KeyEventResult.ignored;
          }

          if (isEditableTextFocused()) {
            if (event.logicalKey == LogicalKeyboardKey.backspace) {
              return KeyEventResult.ignored;
            }
            FocusManager.instance.primaryFocus?.unfocus();
            return KeyEventResult.handled;
          }

          context.maybePop();
          return KeyEventResult.handled;
        },
        child: child,
      ),
    );
  }
}

class BackIntent extends Intent {
  const BackIntent();
}
