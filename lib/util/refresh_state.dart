import 'package:flutter/material.dart';

class RefreshState extends InheritedWidget {
  final GlobalKey<RefreshIndicatorState> refreshKey;
  final bool refreshAble;

  const RefreshState({
    super.key,
    required this.refreshKey,
    this.refreshAble = true,
    required super.child,
  });

  Future<void> refresh() async {
    if (refreshAble) return await refreshKey.currentState?.show();
    return;
  }

  static RefreshState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RefreshState>();
  }

  static RefreshState of(BuildContext context) {
    final RefreshState? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(RefreshState oldWidget) {
    return refreshKey != oldWidget.refreshKey;
  }
}

extension RefreshContextExtension on BuildContext {
  Future<void> refreshData() async {
    //Small delay to fix server not updating response based on successful query
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) {
      await RefreshState.maybeOf(this)?.refresh();
    }
  }
}
