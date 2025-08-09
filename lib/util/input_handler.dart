import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/key_combinations.dart';
import 'package:fladder/screens/settings/widgets/key_listener.dart';

class InputHandler<T> extends ConsumerStatefulWidget {
  final bool autoFocus;
  final KeyEventResult Function(FocusNode node, KeyEvent event)? onKeyEvent;
  final bool Function(T result)? keyMapResult;
  final Map<T, KeyCombination>? keyMap;
  final Widget child;
  const InputHandler({
    required this.child,
    this.autoFocus = true,
    this.onKeyEvent,
    this.keyMapResult,
    this.keyMap,
    super.key,
  });

  @override
  ConsumerState<InputHandler> createState() => _InputHandlerState<T>();
}

class _InputHandlerState<T> extends ConsumerState<InputHandler<T>> {
  final focusNode = FocusNode();

  LogicalKeyboardKey? pressedModifier;

  @override
  void initState() {
    super.initState();
    // Focus on start
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.autoFocus,
      focusNode: focusNode,
      onFocusChange: (value) {
        if (!focusNode.hasFocus && widget.autoFocus) {
          focusNode.requestFocus();
        }
      },
      onKeyEvent: widget.onKeyEvent ?? (node, event) => _onKey(event),
      child: widget.child,
    );
  }

  KeyEventResult _onKey(KeyEvent value) {
    if (ref.read(keyListeningProvider)) return KeyEventResult.ignored;

    final keyMap = widget.keyMap?.entries.nonNulls.toList() ?? [];
    if (value is KeyDownEvent || value is KeyRepeatEvent) {
      if (KeyCombination.modifierKeys.contains(value.logicalKey)) {
        pressedModifier = value.logicalKey;
      }

      for (var entry in keyMap) {
        final hotKey = entry.key;
        final keyCombination = entry.value;

        bool isMainKeyPressed = value.logicalKey == keyCombination.key;
        bool isModifierKeyPressed = pressedModifier == keyCombination.modifier;

        bool isAltKeyPressed = value.logicalKey == keyCombination.altKey;

        bool isAltModifierKeyPressed = pressedModifier == keyCombination.altModifier;

        if ((isMainKeyPressed && isModifierKeyPressed) || isAltKeyPressed && isAltModifierKeyPressed) {
          if (widget.keyMapResult?.call(hotKey) ?? false) {
            return KeyEventResult.handled;
          } else {
            return KeyEventResult.ignored;
          }
        }
      }
    } else if (value is KeyUpEvent) {
      if (KeyCombination.modifierKeys.contains(value.logicalKey)) {
        pressedModifier = null;
      }
    }
    return KeyEventResult.ignored;
  }
}
