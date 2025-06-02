import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PullToRefresh extends ConsumerStatefulWidget {
  final GlobalKey<RefreshIndicatorState>? refreshKey;
  final double? displacement;
  final bool refreshOnStart;
  final bool autoFocus;
  final bool contextRefresh;
  final Future<void> Function()? onRefresh;
  final Widget child;
  const PullToRefresh({
    required this.child,
    this.displacement,
    this.autoFocus = true,
    this.refreshOnStart = true,
    this.contextRefresh = true,
    required this.onRefresh,
    this.refreshKey,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PullToRefreshState();
}

class _PullToRefreshState extends ConsumerState<PullToRefresh> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final FocusNode focusNode = FocusNode();

  GlobalKey<RefreshIndicatorState> get refreshKey {
    return (widget.refreshKey ?? _refreshIndicatorKey);
  }

  @override
  void initState() {
    super.initState();
    if (widget.refreshOnStart) {
      Future.microtask(
        () => refreshKey.currentState?.show(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((AdaptiveLayout.of(context).isDesktop || kIsWeb) && widget.autoFocus) {
      focusNode.requestFocus();
    }
    return RefreshState(
      refreshKey: refreshKey,
      refreshAble: widget.contextRefresh,
      child: Focus(
        focusNode: focusNode,
        autofocus: true,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.f5) {
              refreshKey.currentState?.show();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          }
          return KeyEventResult.ignored;
        },
        child: widget.onRefresh != null
            ? RefreshIndicator.adaptive(
                displacement: widget.displacement ?? 80 + MediaQuery.of(context).viewPadding.top,
                key: refreshKey,
                onRefresh: widget.onRefresh!,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: widget.child,
              )
            : widget.child,
      ),
    );
  }
}
