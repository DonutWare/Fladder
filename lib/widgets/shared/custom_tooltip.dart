import 'dart:async';

import 'package:flutter/material.dart';

class CustomTooltip extends StatefulWidget {
  final Widget child;
  final Widget? tooltipContent;
  final double offset;
  final TooltipPosition position;
  final Duration showDelay;

  const CustomTooltip({
    required this.child,
    required this.tooltipContent,
    this.offset = 12,
    this.position = TooltipPosition.top,
    this.showDelay = const Duration(milliseconds: 125),
    super.key,
  });

  @override
  CustomTooltipState createState() => CustomTooltipState();
}

enum TooltipPosition { top, bottom, left, right }

class CustomTooltipState extends State<CustomTooltip> {
  OverlayEntry? _overlayEntry;
  Timer? _tooltipTimer;
  final GlobalKey _tooltipKey = GlobalKey();

  void _showTooltip() {
    _tooltipTimer?.cancel();

    _tooltipTimer = Timer(widget.showDelay, () {
      if (_overlayEntry == null) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry!);
      }
    });
  }

  void _hideTooltip() {
    _tooltipTimer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset targetPosition = renderBox.localToGlobal(Offset.zero);
    Size targetSize = renderBox.size;

    return OverlayEntry(
      builder: (context) {
        final tooltipRenderBox = _tooltipKey.currentContext?.findRenderObject() as RenderBox?;
        if (tooltipRenderBox != null) {
          Size tooltipSize = tooltipRenderBox.size;

          Offset tooltipPosition;
          switch (widget.position) {
            case TooltipPosition.top:
              tooltipPosition = Offset(
                targetPosition.dx + (targetSize.width - tooltipSize.width) / 2,
                targetPosition.dy - tooltipSize.height - widget.offset,
              );
              break;
            case TooltipPosition.bottom:
              tooltipPosition = Offset(
                targetPosition.dx + (targetSize.width - tooltipSize.width) / 2,
                targetPosition.dy + targetSize.height + widget.offset,
              );
              break;
            case TooltipPosition.left:
              tooltipPosition = Offset(
                targetPosition.dx - tooltipSize.width - widget.offset,
                targetPosition.dy + (targetSize.height - tooltipSize.height) / 2,
              );
              break;
            case TooltipPosition.right:
              tooltipPosition = Offset(
                targetPosition.dx + targetSize.width + widget.offset,
                targetPosition.dy + (targetSize.height - tooltipSize.height) / 2,
              );
              break;
          }

          return Positioned(
            left: tooltipPosition.dx,
            top: tooltipPosition.dy,
            child: Material(
              color: Colors.transparent,
              child: widget.tooltipContent,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tooltipContent == null) return widget.child;
    return MouseRegion(
      onEnter: (_) => _showTooltip(),
      onExit: (_) => _hideTooltip(),
      child: Stack(
        children: [
          widget.child,
          Positioned(
            left: -1000,
            top: -1000,
            child: Container(
              key: _tooltipKey,
              child: widget.tooltipContent,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tooltipTimer?.cancel();
    _hideTooltip(); // Ensure the tooltip is hidden on dispose
    super.dispose();
  }
}
