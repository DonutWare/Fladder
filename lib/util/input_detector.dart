import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class InputDetector extends StatefulWidget {
  final bool isDesktop;
  final bool htpcMode;
  final Widget Function(InputDevice input) child;

  const InputDetector({
    super.key,
    required this.isDesktop,
    required this.htpcMode,
    required this.child,
  });

  @override
  State<InputDetector> createState() => _InputDetectorState();
}

class _InputDetectorState extends State<InputDetector> {
  late InputDevice _currentInput = widget.htpcMode
      ? InputDevice.dPad
      : (widget.isDesktop || kIsWeb)
          ? InputDevice.pointer
          : InputDevice.touch;

  @override
  void initState() {
    super.initState();
    _startListeningToKeyboard();
  }

  void _startListeningToKeyboard() {
    ServicesBinding.instance.keyboard.addHandler(_handleKeyPress);
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_handleKeyPress);
    super.dispose();
  }

  bool _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (_isEditableTextFocused() &&
          (event.logicalKey == LogicalKeyboardKey.arrowUp ||
              event.logicalKey == LogicalKeyboardKey.arrowDown ||
              event.logicalKey == LogicalKeyboardKey.arrowLeft ||
              event.logicalKey == LogicalKeyboardKey.arrowRight)) {
        return false;
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
          event.logicalKey == LogicalKeyboardKey.arrowDown ||
          event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.arrowRight ||
          event.logicalKey == LogicalKeyboardKey.select) {
        _updateInputDevice(InputDevice.dPad);
      }
    }
    return false;
  }

  bool _isEditableTextFocused() {
    final focus = FocusManager.instance.primaryFocus;
    if (focus == null) return false;
    final ctx = focus.context;
    if (ctx == null) return false;

    if (ctx.widget is EditableText) return true;
    return ctx.findAncestorWidgetOfExactType<EditableText>() != null;
  }

  void _handlePointerEvent(PointerEvent event) {
    if (event is PointerDownEvent) {
      if (event.kind == PointerDeviceKind.touch) {
        _updateInputDevice(InputDevice.touch);
      } else if (event.kind == PointerDeviceKind.mouse) {
        _updateInputDevice(InputDevice.pointer);
      }
    }
  }

  void _updateInputDevice(InputDevice device) {
    if (_currentInput != device) {
      setState(() {
        _currentInput = device;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _handlePointerEvent,
      behavior: HitTestBehavior.translucent,
      child: Builder(
        builder: (context) => widget.child(_currentInput),
      ),
    );
  }
}
