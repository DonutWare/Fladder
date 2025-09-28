import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/widgets/navigation_scaffold/components/side_navigation_bar.dart';

class GridFocusTraveler extends ConsumerStatefulWidget {
  final int currentIndex;
  final int itemCount;
  final int crossAxisCount;
  final Function(BuildContext context, int selectedIndex, int index) itemBuilder;
  final SliverGridDelegate gridDelegate;

  const GridFocusTraveler({
    this.currentIndex = 0,
    required this.itemCount,
    required this.crossAxisCount,
    required this.itemBuilder,
    required this.gridDelegate,
    super.key,
  });

  @override
  ConsumerState<GridFocusTraveler> createState() => _GridFocusTravelerState();
}

class _GridFocusTravelerState extends ConsumerState<GridFocusTraveler> {
  late int selectedIndex = widget.currentIndex;

  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.itemCount, (index) => FocusNode());
    _focusNodes.mapIndexed(
      (index, element) {
        element.addListener(() {
          if (element.hasFocus) {
            setState(() {
              selectedIndex = index;
            });
          }
        });
      },
    );

    if (!FocusProvider.autoFocusOf(context)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNodes.firstOrNull?.requestFocus();
      });
    }
  }

  @override
  void didUpdateWidget(GridFocusTraveler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      for (var node in _focusNodes) {
        node.dispose();
      }
      _focusNodes = List.generate(widget.itemCount, (index) => FocusNode());
      if (selectedIndex >= widget.itemCount) {
        selectedIndex = widget.itemCount - 1;
        if (selectedIndex >= 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _focusNodes[selectedIndex].requestFocus();
          });
        }
      }
    }
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
      node.removeListener(() {});
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: GridFocusTravelerPolicy(
        itemCount: widget.itemCount,
        current: selectedIndex,
        crossAxisCount: widget.crossAxisCount,
        onChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
          _focusNodes[value].requestFocus();
        },
      ),
      child: SliverGrid.builder(
        gridDelegate: widget.gridDelegate,
        itemCount: widget.itemCount,
        itemBuilder: (context, index) {
          return FocusProvider(
            focusNode: _focusNodes[index],
            child: Builder(
              builder: (context) => widget.itemBuilder(context, selectedIndex, index),
            ),
          );
        },
      ),
    );
  }
}

class GridFocusTravelerPolicy extends ReadingOrderTraversalPolicy {
  final int itemCount;
  final int current;
  final int crossAxisCount;
  final Function(int value) onChanged;
  GridFocusTravelerPolicy({
    required this.itemCount,
    required this.current,
    required this.crossAxisCount,
    required this.onChanged,
  });

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final int row = current ~/ crossAxisCount;
    final int col = current % crossAxisCount;
    final int rowCount = (itemCount / crossAxisCount).ceil();

    int? next;

    switch (direction) {
      case TraversalDirection.left:
        if (col > 0) {
          next = current - 1;
        }
        break;

      case TraversalDirection.right:
        if (col < crossAxisCount - 1 && current + 1 < itemCount) {
          next = current + 1;
        }
        break;

      case TraversalDirection.up:
        if (row > 0) {
          next = current - crossAxisCount;
        }
        break;

      case TraversalDirection.down:
        if (row < rowCount - 1) {
          final candidate = current + crossAxisCount;
          if (candidate < itemCount) {
            next = candidate;
          }
        }
        break;
    }

    if (next != null) {
      onChanged(next);
      return true;
    }

    if (next == null && direction == TraversalDirection.left) {
      navBarNode.requestFocus();
    }

    return super.inDirection(currentNode, direction);
  }
}
