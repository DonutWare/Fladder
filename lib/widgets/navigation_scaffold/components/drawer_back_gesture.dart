import 'package:flutter/material.dart';

import 'package:fladder/util/back_gesture_arbiter.dart';
import 'package:fladder/util/frontmost_route.dart';

class DrawerBackGesture extends StatefulWidget {
  final Widget child;
  const DrawerBackGesture({required this.child, super.key});

  @override
  State<DrawerBackGesture> createState() => _DrawerBackGestureState();
}

class _DrawerBackGestureState extends State<DrawerBackGesture>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver, BackGestureProgressState {
  ModalRoute<Object?>? _route;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) const NavigationNotification(canHandlePop: true).dispatch(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context);
  }

  @override
  void dispose() {
    final route = _route;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routeContext = route?.subtreeContext;
      if (route == null || routeContext == null || !routeContext.mounted || !route.isCurrent) return;
      NavigationNotification(canHandlePop: route.popDisposition == RoutePopDisposition.doNotPop).dispatch(routeContext);
    });
    super.dispose();
  }

  @override
  bool get canHandleBackGesture => Scaffold.maybeOf(context)?.isDrawerOpen == true && isFrontmostRoute(context);

  @override
  void handleCommitBackGesture() => Scaffold.maybeOf(context)?.closeDrawer();

  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context) == TextDirection.rtl ? 1 : -1;
    return AnimatedBuilder(
      animation: backProgress,
      builder: (context, child) => FractionalTranslation(
        translation: Offset(direction * backProgress.value, 0),
        child: child,
      ),
      child: widget.child,
    );
  }
}
