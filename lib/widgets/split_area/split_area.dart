import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:fladder/util/list_padding.dart';

class Area {
  final double initialArea;
  final double maxArea;
  final double minArea;

  final BoxConstraints constraints;

  Area({
    required this.initialArea,
    this.maxArea = 0.85,
    this.minArea = 0.3,
    this.constraints = const BoxConstraints(),
  })  : assert(initialArea > 0, 'Area must be greater than 0'),
        assert(
          initialArea < 1,
          'Area must be less than 1',
        );
}

class SplitArea extends StatefulWidget {
  final List<Area> areas;
  final List<Widget> children;
  final Axis axis;
  const SplitArea({
    super.key,
    required this.areas,
    required this.children,
    required this.axis,
  }) : assert(areas.length >= children.length, "Areas count must be greater than or equal to children count");

  @override
  State<SplitArea> createState() => _SplitAreaState();
}

class _SplitAreaState extends State<SplitArea> {
  final currentAreas = <double>[];

  @override
  void initState() {
    super.initState();
    currentAreas.addAll(widget.areas.map((e) => e.initialArea));
  }

  @override
  void didUpdateWidget(covariant SplitArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.areas.length != widget.areas.length) {
      currentAreas.clear();
      currentAreas.addAll(widget.areas.map((e) => e.initialArea));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (currentAreas.length != widget.areas.length) {
      currentAreas.clear();
      currentAreas.addAll(widget.areas.map((e) => e.initialArea));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: widget.children
              .mapIndexed(
                (index, child) => Expanded(
                  flex: (currentAreas[index] * 1000).toInt(),
                  child: child,
                ),
              )
              .toList()
              .addInBetweenIndexed(
                (index) => DragHandle(
                  onDrag: (delta) {
                    final totalSize = widget.axis == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;
                    if (totalSize <= 0) return;

                    final deltaPercent = delta / totalSize;

                    final areaIndex = index;
                    final nextAreaIndex = index + 1;

                    final area = widget.areas[areaIndex];
                    final nextArea = widget.areas[nextAreaIndex];

                    final currentVal = currentAreas[areaIndex];
                    final nextVal = currentAreas[nextAreaIndex];

                    double allowedDelta = deltaPercent;

                    if (deltaPercent > 0) {
                      final maxGrow = area.maxArea - currentVal;
                      final maxShrink = nextVal - nextArea.minArea;
                      allowedDelta = deltaPercent.clamp(0.0, maxGrow < maxShrink ? maxGrow : maxShrink);
                    } else {
                      final maxShrink = currentVal - area.minArea;
                      final maxGrow = nextArea.maxArea - nextVal;
                      allowedDelta = deltaPercent.clamp(-(maxShrink < maxGrow ? maxShrink : maxGrow), 0.0);
                    }

                    if (allowedDelta != 0.0) {
                      setState(() {
                        currentAreas[areaIndex] += allowedDelta;
                        currentAreas[nextAreaIndex] -= allowedDelta;
                      });
                    }
                  },
                ),
              ),
        );
      },
    );
  }
}

class DragHandle extends StatefulWidget {
  final Function(double delta)? onDrag;
  const DragHandle({required this.onDrag, super.key});

  @override
  State<DragHandle> createState() => _DragHandleState();
}

class _DragHandleState extends State<DragHandle> {
  bool hover = false;
  bool dragging = false;
  @override
  Widget build(BuildContext context) {
    final duration = const Duration(milliseconds: 250);
    final width = 10.0;
    final isActive = hover || dragging;
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: (_) => setState(() => dragging = true),
        onHorizontalDragEnd: (_) => setState(() => dragging = false),
        onHorizontalDragUpdate: (details) => widget.onDrag?.call(details.delta.dx),
        child: AnimatedContainer(
          duration: duration,
          width: width * (isActive ? 0.8 : 0.65),
          height: double.infinity,
          color: Colors.transparent,
          child: Center(
            child: AnimatedContainer(
              duration: duration,
              width: width * 0.5,
              height: 64,
              decoration: BoxDecoration(
                color: (dragging ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface)
                    .withAlpha(isActive ? 255 : 0),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
