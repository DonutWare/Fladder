import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';

final acceptKeys = {
  LogicalKeyboardKey.enter,
  LogicalKeyboardKey.accept,
  LogicalKeyboardKey.select,
  LogicalKeyboardKey.gameButtonA,
  LogicalKeyboardKey.space,
};

class FocusProvider extends InheritedWidget {
  final bool hasFocus;
  final bool autoFocus;

  const FocusProvider({
    super.key,
    this.hasFocus = false,
    this.autoFocus = false,
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

  @override
  bool updateShouldNotify(FocusProvider oldWidget) {
    return oldWidget.hasFocus != hasFocus;
  }
}

class FocusButton extends StatefulWidget {
  final Widget? child;
  final bool autoFocus;
  final FocusNode? focusNode;
  final List<Widget> focusedOverlays;
  final List<Widget> overlays;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function(TapDownDetails)? onSecondaryTapDown;
  final bool darkOverlay;
  final Function(bool focus)? onFocusChanged;
  final BorderRadiusGeometry? borderRadius;

  const FocusButton({
    this.child,
    this.autoFocus = false,
    this.focusNode,
    this.focusedOverlays = const [],
    this.overlays = const [],
    this.onTap,
    this.onLongPress,
    this.onSecondaryTapDown,
    this.darkOverlay = true,
    this.onFocusChanged,
    this.borderRadius,
    super.key,
  });

  @override
  State<FocusButton> createState() => FocusButtonState();
}

class FocusButtonState extends State<FocusButton> {
  late FocusNode focusNode = widget.focusNode ?? FocusNode();
  ValueNotifier<bool> onHover = ValueNotifier(false);
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
    if (lastMainFocus == focusNode) {
      lastMainFocus = null;
    }
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onHover.value = true,
      onExit: (event) => onHover.value = false,
      child: Focus(
        focusNode: focusNode,
        autofocus: widget.autoFocus,
        onFocusChange: (value) {
          widget.onFocusChanged?.call(value);
          if (value) {
            lastMainFocus = focusNode;
          }
          onHover.value = value;
        },
        onKeyEvent: _handleKey,
        child: ExcludeFocus(
          child: ValueListenableBuilder(
            valueListenable: onHover,
            builder: (context, value, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius ?? FladderTheme.smallShape.borderRadius,
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: widget.borderRadius ?? FladderTheme.smallShape.borderRadius,
                  color: widget.darkOverlay
                      ? Theme.of(context).colorScheme.primaryFixedDim.withValues(alpha: value ? 0.10 : 0.0)
                      : null,
                  border: Border.all(
                    width: value ? 3.5 : 2,
                    color: value ? Theme.of(context).colorScheme.primary : Colors.white.withAlpha(15),
                  ),
                ),
                child: FlatButton(
                  onTap: widget.onTap,
                  onSecondaryTapDown: widget.onSecondaryTapDown,
                  onLongPress: widget.onLongPress,
                  child: Stack(
                    children: [
                      if (widget.child != null) widget.child!,
                    ],
                  ),
                  overlays: [
                    if (widget.overlays.isNotEmpty) ...widget.overlays,
                    if (widget.focusedOverlays.isNotEmpty)
                      AnimatedOpacity(
                        opacity: value ? 1 : 0,
                        duration: const Duration(milliseconds: 250),
                        child: Stack(
                          children: [...widget.focusedOverlays],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
