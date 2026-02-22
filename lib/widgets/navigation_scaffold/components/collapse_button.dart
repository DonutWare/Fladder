import 'package:flutter/material.dart';

class CollapseButton extends StatefulWidget {
  final Widget? label;
  final Widget icon;
  final bool keepVisible;
  final Function() onPressed;
  const CollapseButton({
    required this.label,
    required this.icon,
    this.keepVisible = false,
    required this.onPressed,
    super.key,
  });

  @override
  State<CollapseButton> createState() => _CollapseButtonState();
}

class _CollapseButtonState extends State<CollapseButton> {
  bool hovering = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        hoverColor: Colors.transparent,
        onTap: widget.onPressed,
        onHover: (value) {
          setState(() {
            hovering = value;
          });
        },
        onFocusChange: (value) {
          setState(() {
            hovering = value;
          });
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: hovering ? 1 : 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.label != null) widget.label!,
              if (widget.keepVisible)
                widget.icon
              else
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: hovering ? 1.0 : 0.0,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 200),
                    offset: hovering ? Offset.zero : const Offset(-1, 0),
                    child: widget.icon,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
