import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class HideOnScroll extends ConsumerStatefulWidget {
  final Widget? child;
  final ScrollController? controller;
  final double height;
  final Widget? Function(bool visible)? visibleBuilder;
  final Duration duration;
  final bool forceHide;
  const HideOnScroll({
    this.child,
    this.controller,
    this.height = kBottomNavigationBarHeight,
    this.visibleBuilder,
    this.duration = const Duration(milliseconds: 200),
    this.forceHide = false,
    super.key,
  }) : assert(child != null || visibleBuilder != null);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HideOnScrollState();
}

class _HideOnScrollState extends ConsumerState<HideOnScroll> {
  late final scrollController = widget.controller ?? ScrollController();
  bool isVisible = true;
  bool atEdge = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listen);
  }

  @override
  void dispose() {
    scrollController.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = scrollController.position.userScrollDirection;

    if (scrollController.offset < scrollController.position.maxScrollExtent) {
      if (direction == ScrollDirection.forward) {
        if (!isVisible) {
          setState(() => isVisible = true);
        }
      } else if (direction == ScrollDirection.reverse) {
        if (isVisible) {
          setState(() => isVisible = false);
        }
      }
    } else {
      setState(() {
        isVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visibleBuilder != null) return widget.visibleBuilder!(isVisible)!;
    if (widget.child == null) return const SizedBox();
    if (AdaptiveLayout.viewSizeOf(context) == ViewSize.desktop) {
      return widget.child!;
    } else {
      return AnimatedAlign(
        alignment: const Alignment(0, -1),
        heightFactor: widget.forceHide
            ? 0
            : isVisible
                ? 1.0
                : 0,
        duration: widget.duration,
        child: Wrap(children: [widget.child!]),
      );
    }
  }
}
