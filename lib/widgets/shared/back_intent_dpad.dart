import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

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
          if (_isEditableTextFocused()) {
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

  bool _isEditableTextFocused() {
    final focus = FocusManager.instance.primaryFocus;
    if (focus == null) return false;
    final ctx = focus.context;
    if (ctx == null) return false;

    if (ctx.widget is EditableText) return true;
    return ctx.findAncestorWidgetOfExactType<EditableText>() != null;
  }
}

class BackIntent extends Intent {
  const BackIntent();
}
