import 'package:flutter/widgets.dart';

bool isFrontmostRoute(BuildContext context) {
  var route = ModalRoute.of(context);
  while (route != null) {
    if (!route.isCurrent) return false;
    final navigatorContext = route.navigator?.context;
    if (navigatorContext == null) return true;
    route = ModalRoute.of(navigatorContext);
  }
  return true;
}
