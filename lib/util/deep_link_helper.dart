import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart' show DeepLink, PageRouteInfo;

import 'package:fladder/routes/auto_router.gr.dart';

FutureOr<DeepLink> deepLinkBuilder(Uri? payload) {
  final route = payloadToRoute(payload);
  if (route != null) {
    return DeepLink.path(pageRouteInfoToPath(route));
  }
  return DeepLink.defaultPath;
}

PageRouteInfo? payloadToRoute(Uri? payload) {
  if (payload == null) return null;
  if (payload.path.contains('/seerr')) {
    final segments = payload.pathSegments;
    if (segments.length >= 3) {
      final mediaType = segments[1];
      final tmdbId = int.tryParse(segments[2]);
      if (tmdbId != null) return SeerrDetailsRoute(mediaType: mediaType, tmdbId: tmdbId);
    }
    return const SeerrRoute();
  }
  if (payload.path.contains('/details')) {
    return DetailsRoute(id: payload.queryParameters['id']!);
  }
  return null;
}

String pageRouteInfoToPath(PageRouteInfo route) {
  try {
    return switch (route) {
      DetailsRoute() => '/details?id=${route.queryParams.get('id')}',
      _ => '/',
    };
  } catch (e) {
    log("Failed to convert route to path: $e");
    return route.routeName;
  }
}
