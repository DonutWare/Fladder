import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart' show DeepLink, PageRouteInfo;

import 'package:fladder/routes/auto_router.gr.dart';

const String deepLinkScheme = 'fladder';

FutureOr<DeepLink> deepLinkBuilder(Uri? payload) {
  final route = payloadToRoute(payload);
  if (route != null) {
    return DeepLink.path(pageRouteInfoToPath(route));
  }
  return DeepLink.defaultPath;
}

class DeepLinkTarget {
  const DeepLinkTarget({
    required this.route,
    this.itemId,
    this.userId,
    this.serverId,
  });

  final PageRouteInfo route;

  final String? itemId;

  final String? userId;
  final String? serverId;

  bool get requiresUser => route is! LoginRoute;

  static DeepLinkTarget? parse(Uri? uri) {
    if (uri == null) return null;

    final segments = [
      if (uri.scheme == deepLinkScheme && uri.host.isNotEmpty) uri.host,
      ...uri.pathSegments.where((segment) => segment.isNotEmpty),
    ];
    final start = segments.indexWhere(_knownRoots.contains);
    if (start == -1) return null;

    final args = segments.sublist(start + 1);
    final query = uri.queryParameters;
    String? optional(String key) => query[key]?.isNotEmpty == true ? query[key] : null;

    final userId = optional('userId');
    final serverId = optional('serverId');

    switch (segments[start]) {
      case 'login':
        return DeepLinkTarget(route: LoginRoute(authLink: optional('authLink')));
      case 'details':
        final id = optional('id');
        if (id == null) return null;
        return DeepLinkTarget(route: DetailsRoute(id: id), itemId: id, userId: userId, serverId: serverId);
      case 'seerr':
        final mediaType = args.isNotEmpty ? args[0] : optional('mediaType');
        final tmdbId = int.tryParse((args.length > 1 ? args[1] : optional('tmdbId')) ?? '');
        if (mediaType == null || tmdbId == null) {
          return DeepLinkTarget(route: const SeerrRoute(), userId: userId, serverId: serverId);
        }
        return DeepLinkTarget(
          route: SeerrDetailsRoute(mediaType: mediaType, tmdbId: tmdbId),
          userId: userId,
          serverId: serverId,
        );
    }
    return null;
  }

  static const _knownRoots = {'login', 'details', 'seerr'};
}

/// Builds a `fladder://<path>?<query>` link, `path` being e.g. `details` or `seerr/movie/123`.
String buildDeepLink(String path, [Map<String, String?> queryParameters = const {}]) {
  final query = {
    for (final entry in queryParameters.entries)
      if (entry.value?.isNotEmpty == true) entry.key: entry.value!,
  };
  final link = '$deepLinkScheme://$path';
  return query.isEmpty ? link : '$link?${Uri(queryParameters: query).query}';
}

class AuthLinkData {
  final String serverUrl;
  final String? seerrUrl;
  final String userName;
  final String? password;

  AuthLinkData({
    required this.serverUrl,
    this.seerrUrl,
    required this.userName,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'server': serverUrl,
        if (seerrUrl != null) 'seerr': seerrUrl,
        'userName': userName,
        if (password != null && password!.isNotEmpty) 'password': password,
      };

  factory AuthLinkData.fromJson(Map<String, dynamic> json) => AuthLinkData(
        serverUrl: json['server'] as String,
        seerrUrl: json['seerr'] as String?,
        userName: json['userName'] as String,
        password: json['password'] as String?,
      );

  static AuthLinkData? parse(String encoded) {
    String removeUrlPrefix = encoded.trim().replaceFirst(RegExp(r'^fladder:\/\/\/?login\?authLink='), '');
    try {
      final pad = removeUrlPrefix.length % 4;
      if (pad != 0) {
        removeUrlPrefix = removeUrlPrefix.padRight(removeUrlPrefix.length + (4 - pad), '=');
      }
      final bytes = base64Url.decode(removeUrlPrefix);
      final jsonStr = utf8.decode(bytes);
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return AuthLinkData.fromJson(map);
    } catch (e) {
      log("Failed to parse auth link data: $e");
      return null;
    }
  }

  @override
  String toString() {
    return 'AuthLinkData(serverUrl: $serverUrl, seerrUrl: $seerrUrl, userName: $userName, password: ${password != null ? "****" : null})';
  }
}

String encodeAuthLink(AuthLinkData data) {
  final jsonStr = jsonEncode(data.toJson());
  final bytes = utf8.encode(jsonStr);
  var encoded = base64Url.encode(bytes);
  encoded = encoded.replaceAll('=', '');
  return encoded;
}

String buildAuthUrl(AuthLinkData data) {
  final payload = encodeAuthLink(data);
  return '$deepLinkScheme://login?authLink=$payload';
}

PageRouteInfo? payloadToRoute(Uri? payload) => DeepLinkTarget.parse(payload)?.route;

String pageRouteInfoToPath(PageRouteInfo route) {
  try {
    return switch (route) {
      DetailsRoute() => '/details?id=${route.queryParams.get('id')}',
      SeerrDetailsRoute(:final args) => '/seerr/${args?.mediaType}/${args?.tmdbId}',
      SeerrRoute() => '/seerr',
      LoginRoute() => '/login?authLink=${route.queryParams.get('authLink')}',
      _ => '/',
    };
  } catch (e) {
    log("Failed to convert route to path: $e");
    return route.routeName;
  }
}
