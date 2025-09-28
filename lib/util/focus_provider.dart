import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';

final acceptKeys = {
  LogicalKeyboardKey.space,
  LogicalKeyboardKey.enter,
  LogicalKeyboardKey.accept,
  LogicalKeyboardKey.select,
  LogicalKeyboardKey.gameButtonA,
};

class FocusProvider extends InheritedWidget {
  final bool hasFocus;
  final bool autoFocus;
  final FocusNode? focusNode;

  const FocusProvider({
    super.key,
    this.hasFocus = false,
    this.autoFocus = false,
    this.focusNode,
    required super.child,
  });

  static bool of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<FocusProvider>();
    return widget?.hasFocus ?? false;
  }

  static bool autoFocusOf(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<FocusProvider>();
    return widget?.autoFocus ?? false;
  }

  static FocusNode? focusNodeOf(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<FocusProvider>();
    return widget?.focusNode;
  }

  @override
  bool updateShouldNotify(FocusProvider oldWidget) {
    return oldWidget.hasFocus != hasFocus;
  }
}

class FocusButton extends StatefulWidget {
  final Widget? child;
  final List<Widget> overlays;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function(TapDownDetails)? onSecondaryTapDown;
  final bool darkOverlay;
  final Function(bool focus)? onFocusChanged;

  const FocusButton({
    this.child,
    this.overlays = const [],
    this.onTap,
    this.onLongPress,
    this.onSecondaryTapDown,
    this.darkOverlay = true,
    this.onFocusChanged,
    super.key,
  });

  @override
  State<FocusButton> createState() => FocusButtonState();
}

class FocusButtonState extends State<FocusButton> {
  bool onHover = false;
  Timer? _longPressTimer;
  bool _longPressTriggered = false;
  bool _keyDownActive = false;

  static const Duration _kLongPressTimeout = Duration(milliseconds: 500);

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (!node.hasFocus) return KeyEventResult.ignored;

    if (acceptKeys.contains(event.logicalKey)) {
      if (event is KeyDownEvent) {
        if (_keyDownActive) return KeyEventResult.ignored;
        _keyDownActive = true;
        _startLongPressTimer();
      } else if (event is KeyUpEvent) {
        if (!_keyDownActive) return KeyEventResult.ignored;
        if (_longPressTriggered) {
          _resetKeyState();

          return KeyEventResult.ignored;
        }
        _cancelLongPressTimer();
        _keyDownActive = false;
        widget.onTap?.call();
      }
    }
    return KeyEventResult.ignored;
  }

  void _startLongPressTimer() {
    _longPressTriggered = false;
    _longPressTimer?.cancel();
    _longPressTimer = Timer(_kLongPressTimeout, () {
      _longPressTriggered = true;
      widget.onLongPress?.call();
      _resetKeyState();
    });
  }

  void _cancelLongPressTimer() {
    _longPressTimer?.cancel();
    _longPressTimer = null;
  }

  void _resetKeyState() {
    _cancelLongPressTimer();
    _keyDownActive = false;
    _longPressTriggered = false;
  }

  @override
  void dispose() {
    _resetKeyState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusProvider.focusNodeOf(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => onHover = true),
      onExit: (event) => setState(() => onHover = false),
      hitTestBehavior: HitTestBehavior.translucent,
      child: Focus(
        focusNode: focusNode,
        onFocusChange: (value) {
          widget.onFocusChanged?.call(value);
          if (value) {
            lastMainFocus = focusNode;
          }
          setState(() {
            onHover = value;
          });
        },
        onKeyEvent: _handleKey,
        child: ExcludeFocus(
          child: FlatButton(
            onTap: widget.onTap,
            onSecondaryTapDown: widget.onSecondaryTapDown,
            onLongPress: widget.onLongPress,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: FladderTheme.smallShape.borderRadius,
                  child: widget.child,
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: onHover ? 1 : 0,
                    duration: const Duration(milliseconds: 125),
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.darkOverlay ? Colors.black.withValues(alpha: 0.35) : Colors.transparent,
                        border: Border.all(width: 3, color: Theme.of(context).colorScheme.primaryFixed),
                        borderRadius: FladderTheme.smallShape.borderRadius,
                      ),
                      child: Stack(
                        children: widget.overlays,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
