import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class HideOnScroll extends ConsumerStatefulWidget {
  final Widget? child;
  final ScrollController? controller;
  final double height;
  final Widget? Function(bool visible)? visibleBuilder;
  final Duration duration;
  final bool canHide;
  final bool forceHide;
  const HideOnScroll({
    this.child,
    this.controller,
    this.height = kBottomNavigationBarHeight,
    this.visibleBuilder,
    this.duration = const Duration(milliseconds: 200),
    this.canHide = true,
    this.forceHide = false,
    super.key,
  }) : assert(child != null || visibleBuilder != null);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HideOnScrollState();
}

class _HideOnScrollState extends ConsumerState<HideOnScroll> {
  late final ScrollController scrollController = widget.controller ?? ScrollController();
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    if (widget.controller == null) {
      scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (!widget.canHide) {
      if (!isVisible) {
        setState(() => isVisible = true);
      }
      return;
    }
    final position = scrollController.position;
    final direction = position.userScrollDirection;

    bool newVisible;
    if (position.atEdge && position.pixels >= position.maxScrollExtent) {
      // Always show when scrolled to bottom
      newVisible = true;
    } else {
      newVisible = direction == ScrollDirection.forward;
    }

    if (newVisible != isVisible) {
      setState(() => isVisible = newVisible);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visibleBuilder != null) {
      return widget.visibleBuilder!(isVisible) ?? const SizedBox();
    }

    if (widget.child == null) return const SizedBox();

    if (AdaptiveLayout.viewSizeOf(context) == ViewSize.desktop) {
      return widget.child!;
    }

    return AnimatedAlign(
      alignment: const Alignment(0, -1),
      heightFactor: widget.forceHide
          ? 0
          : !isVisible && widget.canHide
              ? 0.0
              : 1.0,
      duration: widget.duration,
      child: Wrap(
        children: [widget.child!],
      ),
    );
  }
}
