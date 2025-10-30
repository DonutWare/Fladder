import 'package:flutter/material.dart';

class SimpleOverflowWidget extends StatefulWidget {
  const SimpleOverflowWidget({
    super.key,
    required this.children,
    required this.overflowBuilder,
    this.axis = Axis.horizontal,
  });

  final List<Widget> children;
  final Widget Function(int remaining) overflowBuilder;
  final Axis axis;

  @override
  State<SimpleOverflowWidget> createState() => _SimpleOverflowWidgetState();
}

class _SimpleOverflowWidgetState extends State<SimpleOverflowWidget> {
  int _remaining = 0;

  @override
  Widget build(BuildContext context) {
    final overflowChild = _remaining != 0 ? widget.overflowBuilder(_remaining) : const SizedBox.shrink();

    final List<Widget> layoutChildren = [];
    for (int i = 0; i < widget.children.length; i++) {
      layoutChildren.add(
        LayoutId(
          id: i,
          child: widget.children[i],
        ),
      );
    }

    layoutChildren.add(
      LayoutId(
        id: 'overflow',
        child: overflowChild,
      ),
    );

    return CustomMultiChildLayout(
      delegate: _OverflowDelegate(
        axis: widget.axis,
        childCount: widget.children.length,
        onLayoutCalculated: (int newRemaining) {
          if (_remaining != newRemaining) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _remaining = newRemaining;
                });
              }
            });
          }
        },
      ),
      children: layoutChildren,
    );
  }
}

class _OverflowDelegate extends MultiChildLayoutDelegate {
  _OverflowDelegate({
    required this.axis,
    required this.childCount,
    required this.onLayoutCalculated,
  });

  final Axis axis;
  final int childCount;
  final void Function(int) onLayoutCalculated;
  static const Offset _offscreen = Offset(-9999, -9999);

  @override
  void performLayout(Size size) {
    final double maxSpace = (axis == Axis.horizontal ? size.width : size.height);
    double usedSpace = 0.0;
    int visibleCount = 0;

    final BoxConstraints overflowConstraints =
        (axis == Axis.horizontal) ? BoxConstraints(maxHeight: size.height) : BoxConstraints(maxWidth: size.width);

    double overflowSpace = 0.0;
    Size? overflowSize;

    if (hasChild('overflow')) {
      overflowSize = layoutChild('overflow', overflowConstraints);
      overflowSpace = (axis == Axis.horizontal ? overflowSize.width : overflowSize.height);
    }

    bool isOverflowing = false;

    for (int i = 0; i < childCount; i++) {
      if (!hasChild(i)) continue;

      final Size childSize = layoutChild(i, overflowConstraints);

      if (isOverflowing) {
        positionChild(i, _offscreen);
        continue;
      }

      final double childSpace = (axis == Axis.horizontal ? childSize.width : childSize.height);

      final int potentialRemaining = childCount - i;
      final double spaceToReserve = (potentialRemaining > 1) ? overflowSpace : 0.0;

      if (usedSpace + childSpace + spaceToReserve > maxSpace) {
        isOverflowing = true;
        positionChild(i, _offscreen);
        continue;
      }

      final Offset offset;
      if (axis == Axis.horizontal) {
        offset = Offset(usedSpace, (size.height - childSize.height) / 2);
      } else {
        offset = Offset((size.width - childSize.width) / 2, usedSpace);
      }

      positionChild(i, offset);
      usedSpace += childSpace;
      visibleCount++;
    }

    final int newRemaining = childCount - visibleCount;

    if (hasChild('overflow')) {
      if (newRemaining > 0 && overflowSize != null) {
        final Offset offset = (axis == Axis.horizontal)
            ? Offset(usedSpace, (size.height - overflowSize.height) / 2)
            : Offset((size.width - overflowSize.width) / 2, usedSpace);
        positionChild('overflow', offset);
      } else {
        positionChild('overflow', _offscreen);
      }
    }

    onLayoutCalculated(newRemaining);
  }

  @override
  bool shouldRelayout(_OverflowDelegate oldDelegate) {
    return oldDelegate.axis != axis || oldDelegate.childCount != childCount;
  }
}
