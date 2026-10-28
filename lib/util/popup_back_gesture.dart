import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fladder/util/back_gesture_arbiter.dart';
import 'package:fladder/util/frontmost_route.dart';

class PopupBackGestureObserver extends NavigatorObserver {
  PopupBackGestureObserver() {
    _PopupBackGestureHandler.ensureObserving();
  }

  List<PopupRoute<dynamic>> get _routes => _PopupBackGestureHandler.routes;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PopupRoute) _routes.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) => _routes.remove(route);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) => _routes.remove(route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _routes.remove(oldRoute);
    if (newRoute is PopupRoute) _routes.add(newRoute);
  }
}

class _PopupBackGestureHandler with WidgetsBindingObserver {
  static final _PopupBackGestureHandler _instance = _PopupBackGestureHandler._();
  static final List<PopupRoute<dynamic>> routes = [];

  _PopupBackGestureHandler._() {
    BackGestureArbiter.add(this);
  }

  static void ensureObserving() => _instance;

  PopupRoute<dynamic>? _activeRoute;

  bool _canHandle(PopupRoute<dynamic> route) {
    final navigatorContext = route.navigator?.context;
    return route.isCurrent &&
        !route.willHandlePopInternally &&
        route.popDisposition == RoutePopDisposition.pop &&
        navigatorContext != null &&
        isFrontmostRoute(navigatorContext);
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    final route = routes.reversed.where(_canHandle).firstOrNull;
    if (route == null) return false;
    _activeRoute = route;
    route.handleStartBackGesture(progress: 1 - backEvent.progress);
    return true;
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) =>
      _activeRoute?.handleUpdateBackGestureProgress(progress: 1 - backEvent.progress);

  @override
  void handleCancelBackGesture() {
    _activeRoute?.handleCancelBackGesture();
    _activeRoute = null;
  }

  @override
  void handleCommitBackGesture() {
    final route = _activeRoute;
    _activeRoute = null;
    if (route == null || !route.isCurrent) return;
    route.navigator?.didStopUserGesture();
    route.navigator?.pop();
  }
}
