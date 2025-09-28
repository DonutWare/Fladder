import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/sticky_header_text.dart';
import 'package:fladder/widgets/navigation_scaffold/components/side_navigation_bar.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class HorizontalList<T> extends ConsumerStatefulWidget {
  final bool autoFocus;
  final String? label;
  final List<Widget> titleActions;
  final Function()? onLabelClick;
  final String? subtext;
  final List<T> items;
  final int? startIndex;
  final Widget Function(BuildContext context, int index, int selected) itemBuilder;
  final Function(int index)? onFocused;
  final bool scrollToEnd;
  final EdgeInsets contentPadding;
  final double? dominantRatio;
  final double? height;
  final bool shrinkWrap;
  const HorizontalList({
    this.autoFocus = false,
    required this.items,
    required this.itemBuilder,
    this.onFocused,
    this.startIndex,
    this.height,
    this.label,
    this.titleActions = const [],
    this.onLabelClick,
    this.scrollToEnd = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.subtext,
    this.shrinkWrap = false,
    this.dominantRatio,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HorizontalListState();
}

class _HorizontalListState extends ConsumerState<HorizontalList> {
  final FocusNode parentNode = FocusNode();
  late int currentIndex = 0;
  final GlobalKey _firstItemKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final contentPadding = 8.0;
  double? contentWidth;
  double? _firstItemWidth;
  bool hasFocus = false;

  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _initFocusNodes();
    _measureFirstItem();
  }

  void _measureFirstItem() {
    if (_firstItemWidth != null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _firstItemKey.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        _firstItemWidth = box.size.width;
        _scrollToPosition(widget.startIndex ?? 0);
      }
    });
  }

  void _initFocusNodes() {
    _focusNodes = List.generate(widget.items.length, (i) {
      final node = FocusNode();
      node.addListener(() {
        if (node.hasFocus) {
          _scrollToPosition(i);
          widget.onFocused?.call(i);
        }
      });
      return node;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.autoFocus) {
        _focusNodes[currentIndex].requestFocus();
        context.ensureVisible();
      }
    });
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    parentNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(HorizontalList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      for (var node in _focusNodes) {
        node.dispose();
      }
      _initFocusNodes();

      if (currentIndex >= widget.items.length) {
        currentIndex = widget.items.isEmpty ? 0 : widget.items.length - 1;
      }

      if (widget.items.isNotEmpty && parentNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _focusNodes[currentIndex].requestFocus();
        });
      }
    }
  }

  Future<void> _scrollToPosition(int index) async {
    if (_firstItemWidth == null) return;

    final offset = index * (_firstItemWidth! + contentPadding);
    final clamped = math.min(offset, _scrollController.position.maxScrollExtent);

    await _scrollController.animateTo(
      clamped,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
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
    final hasPointer = AdaptiveLayout.of(context).inputDevice == InputDevice.pointer;
    return Focus(
      focusNode: parentNode,
      onFocusChange: (value) {
        if (value) {
          _focusNodes[currentIndex].requestFocus();
          context.ensureVisible();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
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
                              onClick: widget.onLabelClick,
                            ),
                          ),
                        ),
                      if (widget.subtext != null)
                        Flexible(
                          child: ExcludeFocus(
                            child: Opacity(
                              opacity: 0.5,
                              child: Text(
                                widget.subtext!,
                                style: Theme.of(context).textTheme.titleMedium,
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
                                onPressed: () {
                                  _scrollToPosition(widget.startIndex!);
                                },
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
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: widget.height ??
                ((AdaptiveLayout.poster(context).size *
                            ref.watch(clientSettingsProvider.select((value) => value.posterSize))) /
                        math.pow((widget.dominantRatio ?? 1.0), 0.55)) *
                    0.72,
            child: FocusTraversalGroup(
              policy: HorizontalRailFocus(
                  parentNode: parentNode,
                  size: _focusNodes.length,
                  current: currentIndex,
                  onChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                    _focusNodes[value].requestFocus();
                  }),
              child: ExcludeFocusTraversal(
                child: ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: widget.contentPadding,
                  itemBuilder: (context, index) {
                    return FocusProvider(
                      focusNode: _focusNodes[index],
                      hasFocus: hasFocus && index == currentIndex,
                      key: index == 0 ? _firstItemKey : null,
                      child: widget.itemBuilder(context, index, hasFocus ? currentIndex : -1),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: contentPadding),
                  itemCount: widget.items.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalRailFocus extends WidgetOrderTraversalPolicy {
  final FocusNode parentNode;
  final int size;
  final int current;
  final Function(int value) onChanged;
  HorizontalRailFocus({
    required this.parentNode,
    required this.size,
    required this.current,
    required this.onChanged,
  });

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    if (direction == TraversalDirection.left) {
      if (current <= 0) {
        navBarNode.requestFocus();
        return true;
      } else {
        onChanged(math.max(current - 1, 0));
        return true;
      }
    } else if (direction == TraversalDirection.right) {
      if (current >= size) {
        return super.inDirection(parentNode, direction);
      } else {
        onChanged(math.min(current + 1, size - 1));
        return true;
      }
    }
    //Force focus on the parent when not navigating in the list
    parentNode.requestFocus();
    return super.inDirection(parentNode, direction);
  }
}
