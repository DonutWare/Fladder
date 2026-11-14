import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/jellyfin_websocket_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/util/refresh_state.dart';

class PullToRefresh extends ConsumerStatefulWidget {
  final GlobalKey<RefreshIndicatorState>? refreshKey;
  final double? displacement;
  final bool refreshOnStart;
  final bool autoFocus;
  final bool contextRefresh;
  final String? serverUpdateItemId;
  final Future<void> Function()? onRefresh;
  final Widget Function(BuildContext context) child;
  const PullToRefresh({
    required this.child,
    this.displacement,
    this.autoFocus = true,
    this.refreshOnStart = true,
    this.contextRefresh = true,
    this.serverUpdateItemId,
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
  Timer? _serverUpdateTimer;
  DateTime? _lastRefreshStart;
  bool _refreshing = false;

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
  void dispose() {
    _serverUpdateTimer?.cancel();
    focusNode.dispose();
    super.dispose();
  }

  void _handleWebSocketEvent(JellyfinWebSocketEvent event) {
    final id = widget.serverUpdateItemId;
    if (id == null) return;
    final affected = switch (event) {
      JellyfinUserDataChanged() =>
        event.isForUser(ref.read(userProvider)?.id) && event.userDataByItemId.containsKey(id),
      JellyfinLibraryChanged() => event.affectedIds.contains(id),
      JellyfinWebSocketReconnected() => true,
    };
    if (!affected) return;
    final eventTime = DateTime.now();
    _serverUpdateTimer?.cancel();
    _serverUpdateTimer = Timer(const Duration(milliseconds: 750), () {
      final lastRefreshStart = _lastRefreshStart;
      final recentlyRefreshed =
          lastRefreshStart != null && eventTime.difference(lastRefreshStart) < const Duration(milliseconds: 1500);
      if (_refreshing || recentlyRefreshed) return;
      refreshKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.serverUpdateItemId != null) {
      ref.listen(jellyfinWebSocketProvider, (previous, next) {
        next.whenData(_handleWebSocketEvent);
      });
    }
    return RefreshState(
      refreshKey: refreshKey,
      refreshAble: widget.contextRefresh,
      child: Focus(
        focusNode: focusNode,
        autofocus: true,
        skipTraversal: true,
        descendantsAreFocusable: true,
        descendantsAreTraversable: true,
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
            ? RefreshIndicator(
                displacement: widget.displacement ?? 80 + MediaQuery.of(context).viewPadding.top,
                key: refreshKey,
                onRefresh: () {
                  _lastRefreshStart = DateTime.now();
                  _refreshing = true;
                  return widget.onRefresh!().whenComplete(() => _refreshing = false);
                },
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Builder(
                  builder: (context) => widget.child(context),
                ),
              )
            : widget.child(context),
      ),
    );
  }
}
