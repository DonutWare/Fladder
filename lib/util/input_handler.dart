import 'package:flutter/material.dart';

class InputHandler extends StatefulWidget {
  final bool autoFocus;
  final KeyEventResult Function(FocusNode node, KeyEvent event)? onKeyEvent;
  final Widget child;
  const InputHandler({
    required this.child,
    this.autoFocus = true,
    this.onKeyEvent,
    super.key,
  });

  @override
  State<InputHandler> createState() => _InputHandlerState();
}

class _InputHandlerState extends State<InputHandler> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.autoFocus,
      focusNode: focusNode,
      onFocusChange: (value) {
        if (!focusNode.hasFocus) {
          focusNode.requestFocus();
        }
      },
      onKeyEvent: widget.onKeyEvent,
      child: widget.child,
    );
  }
}
