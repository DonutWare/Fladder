import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/shared/media/poster_widget.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/sticky_header_text.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_body.dart';
import 'package:fladder/widgets/navigation_scaffold/components/side_navigation_bar.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/focus_row.dart';

class HorizontalList<T> extends ConsumerStatefulWidget {
  final bool autoFocus;
  final String? label;
  final List<Widget> titleActions;
  final VerticalDirection? titleActionsPosition;
  final Function()? onLabelClick;
  final String? subtext;
  final List<T> items;
  final int? startIndex;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Function(int index)? onFocused;
  final bool scrollToEnd;
  final EdgeInsets contentPadding;
  final double? dominantRatio;
  final double? height;
  final bool shrinkWrap;
  final double Function(int index)? itemWidthBuilder;
  final ValueChanged<bool>? onFocusChange;

  const HorizontalList({
    this.autoFocus = false,
    required this.items,
    required this.itemBuilder,
    this.onFocused,
    this.startIndex,
    this.height,
    this.label,
    this.titleActions = const [],
    this.titleActionsPosition = VerticalDirection.up,
    this.onLabelClick,
    this.scrollToEnd = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.subtext,
    this.shrinkWrap = false,
    this.dominantRatio,
    this.itemWidthBuilder,
    this.onFocusChange,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HorizontalListState();
}

class _HorizontalListState extends ConsumerState<HorizontalList> with TickerProviderStateMixin {
  final FocusNode parentNode = FocusNode();
  FocusNode? lastFocused;
  final GlobalKey _firstItemKey = GlobalKey();
  final GlobalKey _listViewKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final contentPadding = 8.0;
  double? contentWidth;
  double? _firstItemWidth;
  bool hasFocus = false;

  AnimationController? _scrollAnimation;

  @override
  void initState() {
    super.initState();
    _measureFirstItem();
  }

  @override
  void didUpdateWidget(covariant HorizontalList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.height != widget.height) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureFirstItem();
      });
    }
  }

  @override
  void dispose() {
    _scrollAnimation?.dispose();
    super.dispose();
  }

  void _measureFirstItem() {
    if (_firstItemWidth != null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemContext = _firstItemKey.currentContext;
      if (itemContext != null) {
        final box = itemContext.findRenderObject() as RenderBox;
        _firstItemWidth = box.size.width;
        _scrollToPosition(widget.startIndex ?? 0);
      }

      if ((FocusProvider.autoFocusOf(context) || widget.autoFocus) &&
          AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad) {
        final nodesOnSameRow = _nodesInRow(parentNode);
        nodesOnSameRow[widget.startIndex ?? 0].requestFocus();
      }
    });
  }

  final Duration scrollMinDuration = const Duration(milliseconds: 75);
  final Duration scrollMaxDuration = const Duration(milliseconds: 275);

  Duration _durationForInterval(int? intervalMillis) {
    if (intervalMillis == null) return scrollMaxDuration;

    const minInterval = 50;
    const maxInterval = 300;

    final clamped = intervalMillis.clamp(minInterval, maxInterval);
    final t = (clamped - minInterval) / (maxInterval - minInterval);
    final minMs = scrollMinDuration.inMilliseconds;
    final maxMs = scrollMaxDuration.inMilliseconds;
    final ms = (minMs + t * (maxMs - minMs)).round();
    return Duration(milliseconds: ms);
  }

  double _cumulativeOffset(int index) {
    final widthBuilder = widget.itemWidthBuilder;
    if (widthBuilder == null) {
      return index * ((_firstItemWidth ?? 0) + contentPadding);
    }
    double offset = 0;
    for (var i = 0; i < index; i++) {
      offset += widthBuilder(i) + contentPadding;
    }
    return offset;
  }

  Future<void> _scrollToPosition(int index, {Duration? duration, bool instant = false}) async {
    if (_firstItemWidth == null || !_scrollController.hasClients) return;

    final target = _cumulativeOffset(index).clamp(0, _scrollController.position.maxScrollExtent);

    _scrollAnimation?.stop();

    if (instant) {
      if (_scrollController.hasClients) _scrollController.jumpTo(target.toDouble());
      return;
    }

    final controller = AnimationController(
      vsync: this,
      duration: duration ?? scrollMaxDuration,
    );

    _scrollAnimation = controller;

    final tween = Tween<double>(
      begin: _scrollController.offset,
      end: target.toDouble(),
    );

    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.addListener(() {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(tween.evaluate(animation));
      }
    });

    await controller.forward();

    if (_scrollAnimation == controller) _scrollAnimation = null;
    controller.dispose();
  }

  void _scrollToStart() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> _scrollToEnd() async {
    final offset = (_firstItemWidth ?? 200) * widget.items.length + 200;
    _scrollController.animateTo(
      math.min(offset, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasPointer = AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer;
    final titleBarWidget = Padding(
      padding: widget.contentPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.label != null)
                  Flexible(
                    child: ExcludeFocus(
                      child: StickyHeaderText(
                        label: widget.label ?? "",
                        onClick: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad ? null : widget.onLabelClick,
                      ),
                    ),
                  ),
                if (widget.subtext != null)
                  Flexible(
                    child: ExcludeFocus(
                      child: Text(
                        widget.subtext!,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                      ),
                    ),
                  ),
                ...widget.titleActions
              ],
            ),
          ),
          if (widget.items.length > 1)
            ExcludeFocus(
              child: Card(
                elevation: 5,
                color: Theme.of(context).colorScheme.surface,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (hasPointer)
                      GestureDetector(
                        onLongPress: () => _scrollToStart(),
                        child: IconButton(
                            onPressed: () {
                              _scrollController.animateTo(
                                  _scrollController.offset + -(MediaQuery.of(context).size.width / 1.75),
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut);
                            },
                            icon: const Icon(
                              IconsaxPlusLinear.arrow_left_1,
                              size: 20,
                            )),
                      ),
                    if (widget.startIndex != null)
                      IconButton(
                          tooltip: "Scroll to current",
                          onPressed: () => _scrollToPosition(widget.startIndex!),
                          icon: const Icon(
                            Icons.circle,
                            size: 16,
                          )),
                    if (hasPointer)
                      GestureDetector(
                        onLongPress: () => _scrollToEnd(),
                        child: IconButton(
                            onPressed: () {
                              _scrollController.animateTo(
                                  _scrollController.offset + (MediaQuery.of(context).size.width / 1.75),
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut);
                            },
                            icon: const Icon(
                              IconsaxPlusLinear.arrow_right_3,
                              size: 20,
                            )),
                      ),
                  ],
                ),
              ),
            ),
        ].addPadding(const EdgeInsets.symmetric(horizontal: 6)),
      ),
    );
    final hasLabel = widget.label != null || widget.titleActions.isNotEmpty;
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          if (hasLabel && widget.titleActionsPosition == VerticalDirection.up) titleBarWidget,
          FocusRow(
            focusNode: parentNode,
            traversalPolicy: HorizontalRailFocus(
              parentNode: parentNode,
              scrollController: _scrollController,
              firstItemWidth: _firstItemWidth ?? 250,
              onFocused: (node, {int? intervalMillis}) {
                lastFocused = node;
                final correctIndex = _getCorrectIndexForNode(node);
                if (correctIndex != -1) {
                  widget.onFocused?.call(correctIndex);
                  final duration = _durationForInterval(intervalMillis);
                  _scrollToPosition(correctIndex, duration: duration);
                }
              },
            ),
            onFocusChange: (value) {
              widget.onFocusChange?.call(value);
              if (value && hasFocus != value) {
                hasFocus = value;
                final nodesOnSameRow = _nodesInRow(parentNode);
                final currentNode = nodesOnSameRow.contains(lastFocused)
                    ? lastFocused
                    : _firstFullyVisibleNode(context, nodesOnSameRow);

                if (currentNode != null) {
                  lastFocused = currentNode;
                  final correctIndex = _getCorrectIndexForNode(currentNode);

                  if (widget.onFocused != null) {
                    if (correctIndex != -1) {
                      widget.onFocused!(correctIndex);
                    }
                  } else {
                    context.ensureVisible();
                  }
                  currentNode.requestFocus();
                }
              } else {
                hasFocus = false;
              }
            },
            onGroupFocused: (groupNode) {
              final nodesOnSameRow = _nodesInRow(parentNode);
              final currentNode =
                  nodesOnSameRow.contains(lastFocused) ? lastFocused : _firstFullyVisibleNode(context, nodesOnSameRow);

              if (currentNode != null) {
                lastFocused = currentNode;
                final correctIndex = _getCorrectIndexForNode(currentNode);
                if (widget.onFocused != null) {
                  if (correctIndex != -1) widget.onFocused!(correctIndex);
                } else {
                  context.ensureVisible();
                }
                currentNode.requestFocus();
              }
            },
            child: SizedBox(
              height: widget.height ??
                  ((AdaptiveLayout.poster(context).size *
                              ref.watch(clientSettingsProvider.select((value) => value.posterSize))) /
                          math.pow((widget.dominantRatio ?? 1.0), 0.55)) *
                      0.72,
              child: ListView.separated(
                key: _listViewKey,
                controller: _scrollController,
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                padding: widget.contentPadding,
                cacheExtent: _firstItemWidth ?? 250,
                itemBuilder: (context, index) => index == widget.items.length
                    ? PosterPlaceHolder(
                        onTap: widget.onLabelClick ?? () {},
                        aspectRatio: widget.dominantRatio ?? AdaptiveLayout.poster(context).ratio,
                      )
                    : Container(
                        key: index == 0 ? _firstItemKey : null,
                        child: widget.itemBuilder(context, index),
                      ),
                separatorBuilder: (context, index) => SizedBox(width: contentPadding),
                itemCount: widget.onLabelClick != null && AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad
                    ? widget.items.length + 1
                    : widget.items.length,
              ),
            ),
          ),
          if (hasLabel && widget.titleActionsPosition == VerticalDirection.down) titleBarWidget,
        ],
      ),
    );
  }

  int _getCorrectIndexForNode(FocusNode node) {
    if (!mounted || _firstItemWidth == null || !_scrollController.hasClients || node.context == null) return -1;

    final scrollableContext = _listViewKey.currentContext;
    if (scrollableContext == null || !scrollableContext.mounted) return -1;

    final scrollableBox = scrollableContext.findRenderObject() as RenderBox?;
    final itemBox = node.context!.findRenderObject() as RenderBox?;
    if (scrollableBox == null || itemBox == null) return -1;

    final dx = itemBox.localToGlobal(Offset.zero, ancestor: scrollableBox).dx;
    final offset = dx + _scrollController.offset - widget.contentPadding.left;

    if (widget.itemWidthBuilder != null) {
      double cumulative = 0;
      for (var i = 0; i < widget.items.length; i++) {
        final w = widget.itemWidthBuilder!(i);
        if (offset < cumulative + w + contentPadding / 2) return i;
        cumulative += w + contentPadding;
      }
      return widget.items.length - 1;
    }

    final totalItemWidth = _firstItemWidth! + contentPadding;
    final index = ((offset + totalItemWidth / 2) ~/ totalItemWidth).clamp(0, widget.items.length - 1);

    return index;
  }
}

FocusNode? _firstFullyVisibleNode(
  BuildContext context,
  List<FocusNode> nodes,
) {
  if (nodes.isEmpty) return null;

  final scrollable = Scrollable.of(context);

  final viewportBox = scrollable.context.findRenderObject() as RenderBox;
  final viewportSize = viewportBox.size;

  for (final node in nodes) {
    final renderObj = node.context?.findRenderObject();
    if (renderObj is RenderBox) {
      final topLeft = renderObj.localToGlobal(Offset.zero, ancestor: viewportBox);
      final bottomRight = renderObj.localToGlobal(renderObj.size.bottomRight(Offset.zero), ancestor: viewportBox);

      final nodeRect = Rect.fromPoints(topLeft, bottomRight);

      final fullyVisible = nodeRect.left >= 0 &&
          nodeRect.right <= viewportSize.width &&
          nodeRect.top >= 0 &&
          nodeRect.bottom <= viewportSize.height;

      if (fullyVisible) {
        return node;
      }
    }
  }

  return nodes.firstOrNull;
}

List<FocusNode> _nodesInRow(FocusNode parentNode) {
  return parentNode.descendants.where((n) => n.canRequestFocus && n.context != null).toList()
    ..sort((a, b) => a.rect.left.compareTo(b.rect.left));
}

class HorizontalRailFocus extends WidgetOrderTraversalPolicy {
  final FocusNode parentNode;
  final void Function(FocusNode node, {int? intervalMillis}) onFocused;
  final ScrollController scrollController;
  final double firstItemWidth;
  static DateTime? _lastMoveTime;
  static TraversalDirection? _lastDirection;

  HorizontalRailFocus({
    required this.parentNode,
    required this.onFocused,
    required this.scrollController,
    required this.firstItemWidth,
  });

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final rowNodes = _nodesInRow(parentNode);
    final index = rowNodes.indexOf(currentNode);
    if (index == -1) return false;

    if (direction == TraversalDirection.left) {
      if (index == 0) {
        if (scrollController.hasClients && scrollController.offset > firstItemWidth * 0.5) {
          if (scrollController.hasClients) scrollController.jumpTo(0);
          return true;
        }

        lastMainFocus = currentNode;
        if (navBarNode.canRequestFocus && navBarNode.context?.mounted == true) {
          navBarNode.requestFocus();
          return true;
        }
        return false;
      }

      final target = rowNodes[index - 1];
      final now = DateTime.now();
      final interval = _lastMoveTime == null || _lastDirection != TraversalDirection.left
          ? null
          : now.difference(_lastMoveTime!).inMilliseconds;
      _lastMoveTime = now;
      _lastDirection = TraversalDirection.left;

      target.requestFocus();
      onFocused(target, intervalMillis: interval);
      return true;
    }

    if (direction == TraversalDirection.right) {
      if (index < rowNodes.length - 1) {
        final target = rowNodes[index + 1];
        final now = DateTime.now();
        final interval = _lastMoveTime == null || _lastDirection != TraversalDirection.right
            ? null
            : now.difference(_lastMoveTime!).inMilliseconds;
        _lastMoveTime = now;
        _lastDirection = TraversalDirection.right;

        target.requestFocus();
        onFocused(target, intervalMillis: interval);
      }
      return true;
    }

    parentNode.requestFocus();
    return super.inDirection(currentNode, direction);
  }
}
