import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/key_combinations.dart';
import 'package:fladder/screens/settings/widgets/key_listener.dart';
import 'package:fladder/util/focus_helper.dart';

class InputHandler<T> extends ConsumerStatefulWidget {
  final bool autoFocus;
  final bool listenRawKeyboard;
  final KeyEventResult Function(FocusNode node, KeyEvent event)? onKeyEvent;
  final bool Function(T result)? keyMapResult;
  final Map<T, KeyCombination>? keyMap;
  final Widget child;
  const InputHandler({
    required this.child,
    this.autoFocus = true,
    this.listenRawKeyboard = false,
    this.onKeyEvent,
    this.keyMapResult,
    this.keyMap,
    super.key,
  });

  @override
  ConsumerState<InputHandler> createState() => _InputHandlerState<T>();
}

class _InputHandlerState<T> extends ConsumerState<InputHandler<T>> {
  static final List<_InputHandlerState<dynamic>> _hardwareHandlers = [];
  static bool _hardwareListening = false;

  static bool _handleHardwareKey(KeyEvent event) {
    final inputFieldFocus = isEditableTextFocused();
    if (inputFieldFocus) return false;

    for (final handler in _hardwareHandlers.toList().reversed) {
      if (!handler.mounted) continue;
      final result = handler._onHardwareKey(event);
      if (result == KeyEventResult.handled || result == KeyEventResult.skipRemainingHandlers) {
        return true;
      }
    }
    return false;
  }

  void _registerHardwareKeyboard() {
    _hardwareHandlers.add(this);
    if (!_hardwareListening) {
      HardwareKeyboard.instance.addHandler(_handleHardwareKey);
      _hardwareListening = true;
    }
  }

  void _unregisterHardwareKeyboard() {
    _hardwareHandlers.remove(this);
    if (_hardwareHandlers.isEmpty && _hardwareListening) {
      HardwareKeyboard.instance.removeHandler(_handleHardwareKey);
      _hardwareListening = false;
    }
  }

  final focusNode = FocusNode();

  LogicalKeyboardKey? pressedModifier;

  @override
  void initState() {
    super.initState();
    if (widget.listenRawKeyboard) {
      _registerHardwareKeyboard();
    } else if (widget.autoFocus) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _unregisterHardwareKeyboard();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listenRawKeyboard) {
      return widget.child;
    } else {
      return Focus(
        autofocus: widget.autoFocus,
        focusNode: focusNode,
        skipTraversal: true,
        onFocusChange: (value) {
          final inputFieldFocus = isEditableTextFocused();
          if (!focusNode.hasFocus && widget.autoFocus && !inputFieldFocus) {
            focusNode.requestFocus();
          }
        },
        onKeyEvent: widget.onKeyEvent ?? (node, event) => _onKey(event),
        child: widget.child,
      );
    }
  }

  KeyEventResult _onKey(KeyEvent value) {
    return _handleLogicalKey(
      logicalKey: value.logicalKey,
      isDown: value is KeyDownEvent,
      isRepeat: value is KeyRepeatEvent,
      isUp: value is KeyUpEvent,
    );
  }

  KeyEventResult _onHardwareKey(KeyEvent value) {
    if (!widget.listenRawKeyboard) return KeyEventResult.ignored;
    return _handleLogicalKey(
      logicalKey: value.logicalKey,
      isDown: value is KeyDownEvent,
      isRepeat: value is KeyRepeatEvent,
      isUp: value is KeyUpEvent,
    );
  }

  KeyEventResult _handleLogicalKey({
    required LogicalKeyboardKey logicalKey,
    required bool isDown,
    required bool isRepeat,
    required bool isUp,
  }) {
    if (changingShortCut) return KeyEventResult.ignored;

    final keyMap = widget.keyMap?.entries.nonNulls.toList() ?? [];
    if (isDown || isRepeat) {
      if (KeyCombination.modifierKeys.contains(logicalKey)) {
        pressedModifier = logicalKey;
      }

      for (var entry in keyMap) {
        final hotKey = entry.key;
        final keyCombination = entry.value;

        bool isMainKeyPressed = logicalKey == keyCombination.key;
        bool isModifierKeyPressed = pressedModifier == keyCombination.modifier;

        bool isAltKeyPressed = logicalKey == keyCombination.altKey;

        bool isAltModifierKeyPressed = pressedModifier == keyCombination.altModifier;

        if ((isMainKeyPressed && isModifierKeyPressed) || isAltKeyPressed && isAltModifierKeyPressed) {
          if (widget.keyMapResult?.call(hotKey) ?? false) {
            return KeyEventResult.handled;
          } else {
            return KeyEventResult.ignored;
          }
        }
      }
    } else if (isUp) {
      if (KeyCombination.modifierKeys.contains(logicalKey)) {
        pressedModifier = null;
      }
    }
    return KeyEventResult.ignored;
  }
}
