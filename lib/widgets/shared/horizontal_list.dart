import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter/rendering.dart';

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
  final BuildContext? revealContext;
  final double trailingSpace;
  final double revealAlignment;

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
    this.revealContext,
    this.trailingSpace = 0,
    this.revealAlignment = 0.5,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HorizontalListState();
}

class _HorizontalListState extends ConsumerState<HorizontalList> {
  final FocusNode parentNode = RailFocusNode();
  FocusNode? lastFocused;
  final GlobalKey _firstItemKey = GlobalKey();
  final GlobalKey _listViewKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final contentPadding = 8.0;
  double? _firstItemWidth;
  bool hasFocus = false;

  static DateTime? _lastVerticalEntry;
  static _HorizontalListState? _lastRevealed;

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
    if (_lastRevealed == this) _lastRevealed = null;
    parentNode.dispose();
    _scrollController.dispose();
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
          AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad &&
          FocusProvider.canAutoFocus(context)) {
        final nodesOnSameRow = _nodesInRow(parentNode);
        final initialNode = _nodeForItemIndex(context, nodesOnSameRow, widget.startIndex ?? 0);
        initialNode?.requestFocus();
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

  double? _liveOffsetFor(FocusNode node) {
    final listBox = _listViewKey.currentContext?.findRenderObject() as RenderBox?;
    final itemBox = node.context?.findRenderObject() as RenderBox?;
    if (listBox == null || itemBox == null || !listBox.attached || !itemBox.attached) return null;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final itemStart = itemBox.localToGlobal(Offset.zero, ancestor: listBox).dx;
    final leading = isRtl ? listBox.size.width - itemStart - itemBox.size.width : itemStart;
    final startPadding = isRtl ? widget.contentPadding.right : widget.contentPadding.left;
    return _scrollController.offset + leading - startPadding;
  }

  void _scrollToPosition(int index, {FocusNode? node, Duration? duration}) {
    _firstItemWidth ??= (_firstItemKey.currentContext?.findRenderObject() as RenderBox?)?.size.width;
    if (_firstItemWidth == null || !_scrollController.hasClients) return;
    final target = widget.itemWidthBuilder == null && node != null
        ? _liveOffsetFor(node) ?? _cumulativeOffset(index)
        : _cumulativeOffset(index);
    final position = _scrollController.position;
    _scrollController.animateTo(
      target.clamp(position.minScrollExtent, position.maxScrollExtent),
      duration: duration ?? scrollMaxDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  bool _focusPreviousOffscreen(FocusNode node) {
    final index = _getCorrectIndexForNode(node);
    if (index <= 0) return false;
    final targetIndex = index - 1;
    _scrollController.jumpTo(_cumulativeOffset(targetIndex).clamp(0, _scrollController.position.maxScrollExtent));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final target = _nodesInRow(parentNode).where((n) => _getCorrectIndexForNode(n) == targetIndex).firstOrNull;
      if (target == null) return;
      lastFocused = target;
      target.requestFocus();
      widget.onFocused?.call(targetIndex);
    });
    return true;
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

  void _onRailFocusChange(bool value) {
    widget.onFocusChange?.call(value);
    if (!value) {
      hasFocus = false;
      return;
    }
    if (hasFocus || AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad) return;
    hasFocus = true;

    final nodesOnSameRow = _nodesInRow(parentNode);
    final primary = FocusManager.instance.primaryFocus;
    final currentNode = primary != parentNode && nodesOnSameRow.contains(primary)
        ? primary
        : nodesOnSameRow.contains(lastFocused)
            ? lastFocused
            : _firstFullyVisibleNode(
                context, _listViewKey.currentContext?.findRenderObject() as RenderBox?, nodesOnSameRow);
    if (currentNode == null) return;

    lastFocused = currentNode;
    if (primary != currentNode) currentNode.requestFocus();

    final correctIndex = _getCorrectIndexForNode(currentNode);
    if (correctIndex != -1) {
      if (correctIndex < widget.items.length) widget.onFocused?.call(correctIndex);
      _scrollToPosition(correctIndex, node: currentNode);
    }

    final now = DateTime.now();
    final interval = _lastVerticalEntry == null ? null : now.difference(_lastVerticalEntry!).inMilliseconds;
    _lastVerticalEntry = now;
    _revealVertically(_durationForInterval(interval));
  }

  void _revealVertically(Duration duration) {
    final previous = _lastRevealed;
    _lastRevealed = this;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !hasFocus) return;
      final revealContext = widget.revealContext ?? context;
      final box = revealContext.findRenderObject();
      if (box is! RenderBox || !box.attached) return;
      final scrollable = Scrollable.maybeOf(revealContext, axis: Axis.vertical);
      final viewport = RenderAbstractViewport.maybeOf(box);
      if (scrollable == null || viewport == null) return;
      final collapse = previous != null && previous != this && previous.mounted ? previous._pendingCollapse(box) : 0.0;
      final position = scrollable.position;
      final target = viewport.getOffsetToReveal(box, widget.revealAlignment).offset - collapse;
      position.animateTo(
        target.clamp(position.minScrollExtent, math.max(position.minScrollExtent, position.maxScrollExtent - collapse)),
        duration: duration,
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  double _pendingCollapse(RenderBox below) {
    final revealBox = widget.revealContext?.findRenderObject();
    final railBox = context.findRenderObject();
    if (revealBox is! RenderBox || railBox is! RenderBox || !revealBox.attached || !railBox.attached) return 0;
    if (revealBox.localToGlobal(Offset.zero).dy >= below.localToGlobal(Offset.zero).dy) return 0;
    return math.max(0, revealBox.size.height - railBox.size.height);
  }

  @override
  Widget build(BuildContext context) {
    final isDpad = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad;
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
          FocusTraversalGroup(
            policy: HorizontalRailFocus(
              parentNode: parentNode,
              focusPreviousOffscreen: _focusPreviousOffscreen,
              onFocused: (node, {int? intervalMillis}) {
                lastFocused = node;
                final correctIndex = _getCorrectIndexForNode(node);
                if (correctIndex != -1) {
                  if (correctIndex < widget.items.length) widget.onFocused?.call(correctIndex);
                  final duration = _durationForInterval(intervalMillis);
                  _scrollToPosition(correctIndex, node: node, duration: duration);
                }
              },
            ),
            child: Focus(
              focusNode: parentNode,
              descendantsAreTraversable: !isDpad,
              onFocusChange: _onRailFocusChange,
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
                  padding: widget.contentPadding.add(EdgeInsetsDirectional.only(end: widget.trailingSpace)),
                  scrollCacheExtent: ScrollCacheExtent.pixels(_firstItemWidth ?? 250),
                  itemBuilder: (context, index) => _RailItem(
                    key: index == 0 ? _firstItemKey : null,
                    index: index,
                    child: index == widget.items.length
                        ? PosterPlaceHolder(
                            onTap: widget.onLabelClick ?? () {},
                            aspectRatio: widget.dominantRatio ?? AdaptiveLayout.poster(context).ratio,
                          )
                        : widget.itemBuilder(context, index),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: contentPadding),
                  itemCount: widget.onLabelClick != null && AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad
                      ? widget.items.length + 1
                      : widget.items.length,
                ),
              ),
            ),
          ),
          if (hasLabel && widget.titleActionsPosition == VerticalDirection.down) titleBarWidget,
        ],
      ),
    );
  }

  int _getCorrectIndexForNode(FocusNode node) => node.context?.findAncestorWidgetOfExactType<_RailItem>()?.index ?? -1;
}

FocusNode? _firstFullyVisibleNode(
  BuildContext context,
  RenderBox? viewportBox,
  List<FocusNode> nodes,
) {
  if (nodes.isEmpty) return null;
  final isRtl = Directionality.of(context) == TextDirection.rtl;
  if (viewportBox == null || !viewportBox.attached) return isRtl ? nodes.lastOrNull : nodes.firstOrNull;
  final viewportSize = viewportBox.size;

  for (final node in isRtl ? nodes.reversed : nodes) {
    final renderObj = node.context?.findRenderObject();
    if (renderObj is RenderBox) {
      final topLeft = renderObj.localToGlobal(Offset.zero, ancestor: viewportBox);
      final bottomRight = renderObj.localToGlobal(renderObj.size.bottomRight(Offset.zero), ancestor: viewportBox);

      final nodeRect = Rect.fromPoints(topLeft, bottomRight);

      final fullyVisible = nodeRect.left >= 0 && nodeRect.right <= viewportSize.width;

      if (fullyVisible) {
        return node;
      }
    }
  }

  return isRtl ? nodes.lastOrNull : nodes.firstOrNull;
}

FocusNode? _nodeForItemIndex(BuildContext context, List<FocusNode> nodes, int index) {
  if (nodes.isEmpty) return null;

  final maxIndex = nodes.length - 1;
  final clampedIndex = index.clamp(0, maxIndex);
  final isRtl = Directionality.of(context) == TextDirection.rtl;
  final visualIndex = isRtl ? nodes.length - 1 - clampedIndex : clampedIndex;

  return nodes[visualIndex];
}

class RailFocusNode extends FocusNode {}

class _RailItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _RailItem({required this.index, required this.child, super.key});

  @override
  Widget build(BuildContext context) => child;
}

void railAwareRequestFocus(
  FocusNode node, {
  ScrollPositionAlignmentPolicy? alignmentPolicy,
  double? alignment,
  Duration? duration,
  Curve? curve,
}) {
  if (node is RailFocusNode || node.ancestors.any((n) => n is RailFocusNode)) {
    node.requestFocus();
    return;
  }
  FocusTraversalPolicy.defaultTraversalRequestFocusCallback(
    node,
    alignmentPolicy: alignmentPolicy,
    alignment: alignment,
    duration: duration,
    curve: curve,
  );
}

List<FocusNode> _nodesInRow(FocusNode parentNode) {
  return parentNode.descendants.where((n) => n.canRequestFocus && n.context != null).toList()
    ..sort((a, b) => a.rect.center.dx.compareTo(b.rect.center.dx));
}

class HorizontalRailFocus extends WidgetOrderTraversalPolicy {
  final FocusNode parentNode;
  final void Function(FocusNode node, {int? intervalMillis}) onFocused;
  final bool Function(FocusNode node) focusPreviousOffscreen;
  static DateTime? _lastMoveTime;
  static TraversalDirection? _lastDirection;

  HorizontalRailFocus({
    required this.parentNode,
    required this.onFocused,
    required this.focusPreviousOffscreen,
  }) : super(requestFocusCallback: railAwareRequestFocus);

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final isRtl = Directionality.of(currentNode.context!) == TextDirection.rtl;
    final towardsSidebar = isRtl ? TraversalDirection.right : TraversalDirection.left;
    final rowNodes = _nodesInRow(parentNode);
    final index = rowNodes.indexOf(currentNode);
    if (index == -1) return super.inDirection(currentNode, direction);

    if (direction == TraversalDirection.left) {
      if (index == 0) {
        if (direction == towardsSidebar) {
          if (focusPreviousOffscreen(currentNode)) return true;
          lastMainFocus = currentNode;
          if (navBarNode.canRequestFocus && navBarNode.context?.mounted == true) {
            navBarNode.requestFocus();
            return true;
          }
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
      } else if (direction == towardsSidebar) {
        if (focusPreviousOffscreen(currentNode)) return true;
        lastMainFocus = currentNode;
        if (navBarNode.canRequestFocus && navBarNode.context?.mounted == true) {
          navBarNode.requestFocus();
          return true;
        }
      }
      return true;
    }

    final scope = currentNode.nearestScope;
    if (scope != null) invalidateScopeData(scope);
    return super.inDirection(currentNode, direction);
  }
}
