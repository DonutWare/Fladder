import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fladder/theme.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

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
  final double focusPosition;

  const FocusProvider({
    super.key,
    this.hasFocus = false,
    this.autoFocus = false,
    this.focusPosition = 0.5,
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

  static double focusPositionOf(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<FocusProvider>();
    return widget?.focusPosition ?? 0.5;
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
  const FocusButton({
    this.child,
    this.overlays = const [],
    this.onTap,
    this.onLongPress,
    this.onSecondaryTapDown,
    this.darkOverlay = true,
    super.key,
  });

  @override
  State<FocusButton> createState() => FocusButtonState();
}

class FocusButtonState extends State<FocusButton> {
  FocusNode focusNode = FocusNode();
  bool onFocused = false;
  bool onHover = false;
  Timer? _longPressTimer;
  bool _longPressTriggered = false;
  bool _keyDownActive = false;

  static const Duration _kLongPressTimeout = Duration(milliseconds: 500);

  bool _handleKey(KeyEvent event) {
    if (!onFocused && !onHover && !focusNode.hasFocus) return false;

    if (acceptKeys.contains(event.logicalKey)) {
      if (event is KeyDownEvent) {
        if (_keyDownActive) return true;
        _keyDownActive = true;
        _startLongPressTimer();
      } else if (event is KeyUpEvent) {
        if (!_keyDownActive) return false;
        if (_longPressTriggered) {
          _resetKeyState();
          return true;
        }
        _cancelLongPressTimer();
        _keyDownActive = false;
        widget.onTap?.call();
      }
    }
    return false;
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
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKey);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FocusProvider.autoFocusOf(context)) {
        focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _resetKeyState();
    HardwareKeyboard.instance.removeHandler(_handleKey);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onFocused = FocusProvider.of(context);
    return Focus(
      focusNode: focusNode,
      onFocusChange: (value) {
        if (value) {
          context.ensureVisible();
        }
        setState(() {
          onHover = value;
        });
      },
      child: InkWell(
        canRequestFocus: false,
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onSecondaryTapDown: widget.onSecondaryTapDown,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) => setState(() => onHover = true),
          onExit: (event) => setState(() => onHover = false),
          child: ExcludeFocus(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: FladderTheme.smallShape.borderRadius,
                  child: widget.child,
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: onFocused || onHover ? 1 : 0,
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
