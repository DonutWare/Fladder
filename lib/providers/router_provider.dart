import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/routes/auto_router.dart';

/// Provider for the global AutoRouter instance
/// Set from main.dart after initialization
final routerProvider = StateProvider<AutoRouter?>((ref) => null);

/// Get the navigator key from the router for pushing routes without context
GlobalKey<NavigatorState>? getNavigatorKey(Ref ref) {
  return ref.read(routerProvider)?.navigatorKey;
}
