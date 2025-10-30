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
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.backspace): const BackIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          BackIntent: CallbackAction<BackIntent>(
            onInvoke: (intent) async {
              final navigator = await context.maybePop();
              if (navigator) {
                return true;
              } else {
                return false;
              }
            },
          ),
        },
        child: child,
      ),
    );
  }
}

class BackIntent extends Intent {
  const BackIntent();
}
