import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';
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
  bool _initializedFocus = false;

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: GridFocusTravelerPolicy(
        navBarNode: navBarNode,
        crossAxisCount: widget.crossAxisCount,
        onChanged: (value) {
          selectedIndex = value;
        },
      ),
      child: Builder(
        builder: (context) {
          if (!_initializedFocus && AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final parent = Focus.of(context);
              final nodes = _childNodes(parent);
              if (nodes.isNotEmpty) {
                nodes.first.requestFocus();
                setState(() {
                  selectedIndex = 0;
                  _initializedFocus = true;
                });
              }
            });
          }

          return SliverGrid.builder(
            gridDelegate: widget.gridDelegate,
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              return FocusProvider(
                child: Builder(
                  builder: (context) => widget.itemBuilder(context, selectedIndex, index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

List<FocusNode> _childNodes(FocusNode node) {
  return node.descendants.where((n) => n.canRequestFocus && n.context != null).toList()
    ..sort((a, b) {
      final dy = a.rect.top.compareTo(b.rect.top);
      return dy != 0 ? dy : a.rect.left.compareTo(b.rect.left);
    });
}

class GridFocusTravelerPolicy extends WidgetOrderTraversalPolicy {
  final int crossAxisCount;
  final Function(int value) onChanged;
  final FocusNode navBarNode;

  GridFocusTravelerPolicy({
    required this.crossAxisCount,
    required this.onChanged,
    required this.navBarNode,
  });

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final parent = currentNode.parent;
    if (parent == null) {
      return super.inDirection(currentNode, direction);
    }

    final nodes = _childNodes(parent);

    final current = nodes.indexOf(currentNode);
    if (current == -1) {
      return super.inDirection(currentNode, direction);
    }

    final itemCount = nodes.length;
    final row = current ~/ crossAxisCount;
    final col = current % crossAxisCount;
    final rowCount = (itemCount / crossAxisCount).ceil();

    int? next;
    switch (direction) {
      case TraversalDirection.left:
        if (col > 0) next = current - 1;
        break;
      case TraversalDirection.right:
        if (col < crossAxisCount - 1 && current + 1 < itemCount) {
          next = current + 1;
        }
        break;
      case TraversalDirection.up:
        if (row > 0) next = current - crossAxisCount;
        break;
      case TraversalDirection.down:
        if (row < rowCount - 1) {
          final candidate = current + crossAxisCount;
          if (candidate < itemCount) next = candidate;
        }
        break;
    }

    if (next != null) {
      final target = nodes[next];
      target.requestFocus();
      onChanged(next);
      return true;
    }

    if (direction == TraversalDirection.left && col == 0) {
      lastMainFocus = currentNode;
      navBarNode.requestFocus();
      return true;
    }

    return super.inDirection(currentNode, direction);
  }
}
