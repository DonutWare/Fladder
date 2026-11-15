import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HoverWidget extends ConsumerStatefulWidget {
  final Size size;
  final Widget Function(bool visible) child;
  const HoverWidget({
    this.size = Size.infinite,
    required this.child,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends ConsumerState<HoverWidget> {
  bool hovering = false;

  void setHovering(bool value) => setState(() => hovering = value);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setHovering(true),
      onExit: (event) => setHovering(false),
      child: widget.child(hovering),
    );
  }
}
