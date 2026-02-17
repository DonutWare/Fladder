import 'dart:async';
import 'dart:developer';

import 'package:chopper/chopper.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/last_seen_notifications_model.dart';

const String updateTaskName = 'nl.jknaapen.fladder.update_notifications_check';
const String updateTaskNameDebug = 'nl.jknaapen.fladder.update_notifications_check_debug';

class NotificationHelpers {
  static String buildDetailsDeepLink(String id) => 'fladder:///details?id=${Uri.encodeComponent(id)}';

  static List<LastSeenModel> replaceOrAppendLastSeen(List<LastSeenModel> servers, LastSeenModel saved) {
    final exists = servers.any((s) => s.userId == saved.userId);
    if (exists) return servers.map((s) => s.userId == saved.userId ? saved : s).toList();
    return [...servers, saved];
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

      List<dto.BaseItemDto> newItems = [];

      api = dto.JellyfinOpenApi.create(
        baseUrl: Uri.parse(trimmed),
        interceptors: [
          _WorkerAuthInterceptor(token),
        ],
      );

      if (includeHiddenViews) {
        final viewsResp = await api.userViewsGet(userId: userId, includeHidden: true);
        if (!viewsResp.isSuccessful || viewsResp.body == null || (viewsResp.body?.items?.isEmpty ?? true)) {
          log('No views returned for user $userId while includeHiddenViews=true; falling back to single latest call');
          final resp = await api.usersUserIdItemsLatestGet(
            userId: userId,
            enableUserData: false,
            enableImages: false,
            imageTypeLimit: 0,
            fields: [
              dto.ItemFields.originaltitle,
              dto.ItemFields.datecreated,
              dto.ItemFields.datelastmediaadded,
            ],
            limit: limit,
          );
          if (!resp.isSuccessful || resp.body == null) return [];
          return resp.body!.reversed.toList();
        }

        final parentIds = viewsResp.body!.items!
            .map((v) => v.id)
            .whereType<String>()
            .toList(growable: false)
            .where((id) => id.isNotEmpty)
            .toList(growable: false);

        if (parentIds.isEmpty) {
          final resp = await api.usersUserIdItemsLatestGet(
            userId: userId,
            enableUserData: false,
            enableImages: false,
            imageTypeLimit: 0,
            fields: [
              dto.ItemFields.originaltitle,
              dto.ItemFields.datecreated,
              dto.ItemFields.datelastmediaadded,
              dto.ItemFields.originaltitle,
              dto.ItemFields.datecreated,
              dto.ItemFields.datelastmediaadded,
              dto.ItemFields.datelastrefreshed,
              dto.ItemFields.datelastsaved,
            ],
            limit: limit,
          );
          if (!resp.isSuccessful || resp.body == null) return [];
          return resp.body!.reversed.toList();
        }

        final effectiveLimit = limit < 10 ? 10 : limit;
        final perViewLimit = (effectiveLimit / parentIds.length).ceil().clamp(1, effectiveLimit);

        final List<dto.BaseItemDto> allItems = [];
        for (final parentId in parentIds) {
          try {
            final resp = await api.usersUserIdItemsLatestGet(
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
              limit: perViewLimit,
            );

            if (resp.isSuccessful && resp.body != null) {
              allItems.addAll(
                resp.body!,
              );
            }
          } catch (e) {
            log('Error fetching latest items for view $parentId: $e');
            continue;
          }
        }

        final unique = <String, dto.BaseItemDto>{};
        for (final it in allItems) {
          if (it.id != null && !unique.containsKey(it.id)) unique[it.id!] = it;
        }

        newItems = (unique.values.toList()
              ..sort((a, b) {
                final aDate = a.dateLastMediaAdded ?? a.dateCreated ?? DateTime.fromMillisecondsSinceEpoch(0);
                final bDate = b.dateLastMediaAdded ?? b.dateCreated ?? DateTime.fromMillisecondsSinceEpoch(0);
                return bDate.compareTo(aDate);
              }))
            .toList();
      } else {
        final resp = await api.usersUserIdItemsLatestGet(
          userId: userId,
          enableUserData: false,
          enableImages: false,
          imageTypeLimit: 0,
          fields: [
            dto.ItemFields.originaltitle,
            dto.ItemFields.datecreated,
            dto.ItemFields.datelastmediaadded,
          ],
          limit: limit,
        );

        newItems = resp.body ?? [];
      }

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
