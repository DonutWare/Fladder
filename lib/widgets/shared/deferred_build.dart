import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Builds [builder] only once this widget comes within [lookAhead] viewports of the scroll view
/// it lives in, showing a [placeholderHeight] tall box until then. Once built it stays built.
///
/// Meant for shrink-wrapped lists and grids inside a [SingleChildScrollView], which otherwise lay
/// out every child up front. Scroll views that don't scroll themselves (a `NeverScrollableScrollPhysics`
/// list inside the page) are skipped when looking for the viewport to measure against.
class DeferredBuild extends StatefulWidget {
  final double placeholderHeight;
  final WidgetBuilder builder;
  final double lookAhead;

  const DeferredBuild({
    required this.placeholderHeight,
    required this.builder,
    this.lookAhead = 1.5,
    super.key,
  });

  @override
  State<DeferredBuild> createState() => _DeferredBuildState();
}

class _DeferredBuildState extends State<DeferredBuild> {
  ScrollableState? _scrollable;
  bool _built = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_built) return;
    final scrollable = _scrollingAncestor(context);
    if (scrollable != _scrollable) {
      _scrollable?.position.removeListener(_check);
      _scrollable = scrollable;
      _scrollable?.position.addListener(_check);
    }
    SchedulerBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void dispose() {
    _scrollable?.position.removeListener(_check);
    super.dispose();
  }

  static ScrollableState? _scrollingAncestor(BuildContext context) {
    var scrollable = Scrollable.maybeOf(context, axis: Axis.vertical);
    while (scrollable != null && scrollable.widget.physics is NeverScrollableScrollPhysics) {
      scrollable = Scrollable.maybeOf(scrollable.context, axis: Axis.vertical);
    }
    return scrollable;
  }

  void _check() {
    if (_built || !mounted) return;
    final box = context.findRenderObject();
    final viewport = _scrollable?.context.findRenderObject();
    if (box is! RenderBox || !box.hasSize || viewport is! RenderBox || !viewport.hasSize) return;
    final top = box.localToGlobal(Offset.zero, ancestor: viewport).dy;
    final reach = viewport.size.height * widget.lookAhead;
    if (top > viewport.size.height + reach || top + box.size.height < -reach) return;
    _scrollable?.position.removeListener(_check);
    setState(() => _built = true);
  }

  @override
  Widget build(BuildContext context) {
    return _built ? widget.builder(context) : SizedBox(height: widget.placeholderHeight);
  }
}
