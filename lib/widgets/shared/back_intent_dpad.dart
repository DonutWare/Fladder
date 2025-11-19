import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_helper.dart';

class BackIntentDpad extends StatelessWidget {
  final Widget child;
  const BackIntentDpad({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.touch) {
      return child;
    }
    return Focus(
      canRequestFocus: false,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is! KeyDownEvent) {
          return KeyEventResult.ignored;
        }

        if (event.logicalKey == LogicalKeyboardKey.backspace) {
          if (isEditableTextFocused()) {
            return KeyEventResult.ignored;
          } else {
            context.maybePop();
            return KeyEventResult.handled;
          }
        }

        return KeyEventResult.ignored;
      },
      child: child,
    );
  }
}

class BackIntent extends Intent {
  const BackIntent();
}
