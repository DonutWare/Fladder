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
  void initState() {
    super.initState();
    //Focus on start
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
      onKeyEvent: widget.onKeyEvent,
      child: widget.child,
    );
  }
}
