import 'dart:async';
import 'dart:developer';

import 'package:chopper/chopper.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/last_seen_notifications_model.dart';
import 'package:fladder/models/seerr_credentials_model.dart';
import 'package:fladder/seerr/seerr_chopper_service.dart';
import 'package:fladder/seerr/seerr_json_converter.dart';
import 'package:fladder/seerr/seerr_models.dart';

const String updateTaskName = 'nl.jknaapen.fladder.update_notifications_check';
const String updateTaskNameDebug = 'nl.jknaapen.fladder.update_notifications_check_debug';

class NotificationHelpers {
  static String buildDetailsDeepLink(String id) => 'fladder:///details?id=${Uri.encodeComponent(id)}';

  static String buildSeerrDeepLink(String mediaType, int tmdbId) => 'fladder:///seerr/$mediaType/$tmdbId';

  static List<LastSeenModel> replaceOrAppendLastSeen(List<LastSeenModel> servers, LastSeenModel saved) {
    final exists = servers.any((s) => s.userId == saved.userId);
    if (exists) return servers.map((s) => s.userId == saved.userId ? saved : s).toList();
    return [...servers, saved];
  }

  static SeerrChopperService createSeerrClient(SeerrCredentialsModel credentials) {
    final chopper = ChopperClient(
      baseUrl: Uri.parse(credentials.serverUrl),
      converter: const SeerrJsonConverter(),
      interceptors: [
        _WorkerSeerrAuthInterceptor(
            apiKey: credentials.apiKey.trim(),
            cookie: credentials.sessionCookie.trim(),
            customHeaders: credentials.customHeaders),
        HttpLoggingInterceptor(level: Level.basic),
      ],
    );

    return SeerrChopperService.create(chopper);
  }

  static Future<List<SeerrMediaRequest>> fetchSeerrRequests(
    SeerrChopperService seerrApi,
    String seerrBase,
    DateTime lastUpdateCheck,
    bool debug,
    int limit,
    SeerrCredentialsModel seerrCredentials,
  ) async {
    try {
      final meResp = await seerrApi.getMe();
      if (!meResp.isSuccessful || meResp.body == null) return [];

      final userId = meResp.body!.id;
      final reqResp = await seerrApi.getRequests(take: limit, skip: 0);
      final requests =
          reqResp.isSuccessful && reqResp.body?.results != null ? reqResp.body!.results! : <SeerrMediaRequest>[];

      final since = debug ? lastUpdateCheck.subtract(const Duration(days: 12)) : lastUpdateCheck;

      final newRequests = requests.reversed.where((request) {
        if (request.requestedBy?.id == userId) return false;
        final dateStr = request.updatedAt ?? request.createdAt;
        if (dateStr == null) return false;
        return dateStr.isAfter(since.toLocal());
      }).toList();
      return newRequests;
    } catch (e) {
      log('Error fetching Seerr requests: $e');
      return [];
    }
  }

  static Future<List<dto.BaseItemDto>> fetchLatestItems(
    String baseUrl,
    String userId,
    String token,
    int limit, {
    bool includeHiddenViews = false,
    required DateTime since,
  }) async {
    dto.JellyfinOpenApi? api;
    try {
      final trimmed = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      final lastUpdateDate = since;

      api = dto.JellyfinOpenApi.create(
        baseUrl: Uri.parse(trimmed),
        interceptors: [
          _WorkerAuthInterceptor(token),
        ],
      );

      Future<List<dto.BaseItemDto>> latestGet({String? parentId, required int take}) async {
        final resp = await api!.usersUserIdItemsLatestGet(
          userId: userId,
          parentId: parentId,
          enableUserData: false,
          enableImages: false,
          imageTypeLimit: 0,
          fields: [
            dto.ItemFields.originaltitle,
            dto.ItemFields.datecreated,
            dto.ItemFields.datelastmediaadded,
            dto.ItemFields.datelastrefreshed,
            dto.ItemFields.datelastsaved,
          ],
          limit: take,
        );
        return resp.isSuccessful && resp.body != null ? resp.body! : <dto.BaseItemDto>[];
      }

      if (!includeHiddenViews) {
        final items = await latestGet(
          take: limit,
        );

        return items.reversed.where((element) {
          final itemDate = element.dateLastMediaAdded ?? element.dateCreated;
          if (itemDate == null) return false;
          return itemDate.isAfter(lastUpdateDate);
        }).toList();
      }

      final viewsResp = await api.userViewsGet(userId: userId, includeHidden: true);
      if (!viewsResp.isSuccessful || viewsResp.body == null || (viewsResp.body?.items?.isEmpty ?? true)) {
        log('No views returned for user $userId while includeHiddenViews=true; falling back to single latest call');
        final items = await latestGet(
          take: limit,
        );
        return items.reversed.toList();
      }

      final parentIds = viewsResp.body!.items!
          .map((v) => v.id)
          .whereType<String>()
          .where((id) => id.isNotEmpty)
          .toList(growable: false);

      if (parentIds.isEmpty) {
        final items = await latestGet(
          take: limit,
        );
        return items.reversed.toList();
      }

      final effectiveLimit = limit < 10 ? 10 : limit;
      final perViewLimit = (effectiveLimit / parentIds.length).ceil().clamp(1, effectiveLimit);

      final List<dto.BaseItemDto> allItems = [];
      for (final parentId in parentIds) {
        try {
          final items = await latestGet(
            parentId: parentId,
            take: perViewLimit,
          );
          if (items.isNotEmpty) allItems.addAll(items);
        } catch (e) {
          log('Error fetching latest items for view $parentId: $e');
          continue;
        }
      }

      final unique = <String, dto.BaseItemDto>{};
      for (final item in allItems) {
        if (item.id != null && !unique.containsKey(item.id)) unique[item.id!] = item;
      }

      final newItems = (unique.values.toList()
            ..sort((a, b) {
              final aDate = a.dateLastMediaAdded ?? a.dateCreated ?? DateTime.fromMillisecondsSinceEpoch(0);
              final bDate = b.dateLastMediaAdded ?? b.dateCreated ?? DateTime.fromMillisecondsSinceEpoch(0);
              return bDate.compareTo(aDate);
            }))
          .toList();

      return newItems.reversed.where((element) {
        final itemDate = element.dateLastMediaAdded ?? element.dateCreated;
        if (itemDate == null) return false;
        return itemDate.isAfter(lastUpdateDate);
      }).toList();
    } catch (e) {
      log('Error fetching latest items: $e');
      return [];
    }
  }
}

class _WorkerAuthInterceptor implements Interceptor {
  _WorkerAuthInterceptor(this.token);

  final String token;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final headers = <String, String>{...chain.request.headers};
    headers['Authorization'] = 'MediaBrowser Token="$token"';
    final request = chain.request.copyWith(headers: headers);
    return chain.proceed(request);
  }
}

class _WorkerSeerrAuthInterceptor implements Interceptor {
  _WorkerSeerrAuthInterceptor({required this.apiKey, required this.cookie, required this.customHeaders});

  final String apiKey;
  final String cookie;
  final Map<String, String> customHeaders;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final headers = <String, String>{...chain.request.headers};
    if (apiKey.isNotEmpty) {
      headers['X-Api-Key'] = apiKey;
    } else if (cookie.isNotEmpty) {
      headers['Cookie'] = cookie;
    }
    headers.addAll(customHeaders);
    final request = chain.request.copyWith(headers: headers);
    return chain.proceed(request);
  }
}
