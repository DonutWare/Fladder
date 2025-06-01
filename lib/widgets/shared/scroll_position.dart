import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ScrollState {
  top,
  middle,
  bottom,
}

class ScrollStatePosition extends ConsumerStatefulWidget {
  final ScrollController? controller;
  final Widget Function(ScrollState state) positionBuilder;

  const ScrollStatePosition({
    this.controller,
    required this.positionBuilder,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScrollStatePositionState();
}

class _ScrollStatePositionState extends ConsumerState<ScrollStatePosition> {
  late final ScrollController _scrollController = widget.controller ?? ScrollController();
  ScrollState _scrollState = ScrollState.top;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    final newState = () {
      if (position.pixels == 0) return ScrollState.top;
      if (position.pixels >= position.maxScrollExtent) return ScrollState.bottom;
      return ScrollState.middle;
    }();

    if (newState != _scrollState) {
      setState(() {
        _scrollState = newState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.positionBuilder(_scrollState);
  }
}
