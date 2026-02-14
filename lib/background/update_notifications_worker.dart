import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/last_seen_notifications_model.dart';
import 'package:fladder/services/notification_service.dart';

const String _kAccountsKey = 'loginCredentialsKey';
const String _kServerLastSeenKey = 'serverLastSeen';
const String _kTaskName = 'fladder_update_notifications_check';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      switch (task) {
        case _kTaskName:
          await performHeadlessUpdateCheck();
          break;
        default:
          break;
      }
    } catch (_) {}
    return Future.value(true);
  });
}

/// Headless worker: fetch latest items for saved accounts and show native notifications.
@pragma('vm:entry-point')
Future<bool> performHeadlessUpdateCheck({bool ignorePreference = false, int limit = 50}) async {
  try {
    await NotificationService.init();

    final prefs = await SharedPreferences.getInstance();
    final savedAccounts = prefs.getStringList(_kAccountsKey) ?? [];
    if (savedAccounts.isEmpty) return true;

    final accounts = savedAccounts
        .map((e) {
          try {
            return AccountModel.fromJson(jsonDecode(e) as Map<String, dynamic>);
          } catch (_) {
            return null;
          }
        })
        .whereType<AccountModel>()
        .toList();

    var lastSeenSnapshot = LastSeenNotificationsModel.fromJson(
        (prefs.getString(_kServerLastSeenKey) != null) ? jsonDecode(prefs.getString(_kServerLastSeenKey)!) : {});

    bool changed = false;

    for (final acc in accounts) {
      if (!ignorePreference && acc.updateNotificationsEnabled == false) continue;

      final baseUrl = acc.credentials.url.isNotEmpty ? acc.credentials.url : (acc.credentials.localUrl ?? '');
      if (baseUrl.isEmpty) continue;

      try {
        final dtoItems = await _fetchLatestItems(baseUrl, acc.id, acc.credentials.token, limit);
        final items = dtoItems.map((d) => ItemBaseModel.fromBaseDto(d, null)).toList();
        final unique = _uniqueById(items);
        if (unique.isEmpty) continue;

        final userKey = acc.id;
        final prevEntry = lastSeenSnapshot.lastSeen
            .firstWhere((s) => s.userId == userKey, orElse: () => LastSeenModel(userId: userKey, lastSeenIds: []));
        final prevIds = prevEntry.lastSeenIds;

        if (prevIds.isEmpty) {
          // first-run baseline: set snapshot but do not notify
          final merged = unique.map((e) => e.id).toList();
          final saved = LastSeenModel(userId: userKey, lastSeenIds: merged.take(limit).toList());
          lastSeenSnapshot = lastSeenSnapshot.copyWith(lastSeen: _replaceOrAppend(lastSeenSnapshot.lastSeen, saved));
          changed = true;
          continue;
        }

        final unseen = unique.where((i) => !prevIds.contains(i.id)).toList();
        if (unseen.isNotEmpty) {
          // build merged snapshot: newest-first, dedupe, cap
          final newIdsOrdered = [
            ...unseen.map((e) => e.id),
            ...prevIds,
          ];
          final deduped = <String>[];
          for (final id in newIdsOrdered) {
            if (id.isEmpty) continue;
            if (!deduped.contains(id)) deduped.add(id);
          }
          final capped = deduped.take(limit).toList();
          final saved = LastSeenModel(userId: userKey, lastSeenIds: capped);
          lastSeenSnapshot = lastSeenSnapshot.copyWith(lastSeen: _replaceOrAppend(lastSeenSnapshot.lastSeen, saved));
          changed = true;

          final serverName =
              acc.credentials.serverName.isNotEmpty ? acc.credentials.serverName : acc.credentials.serverId;

          final itemTitles = <String>[];
          final itemBodies = <String?>[];
          final itemPayloads = <String?>[];
          for (final m in unseen) {
            final name = m.name.isNotEmpty ? m.name : 'Unknown';

            if (m is EpisodeModel) {
              final seriesName = m.seriesName ?? name;
              final season = m.season;
              final episode = m.episode;
              itemTitles.add(seriesName);
              itemBodies.add('S${season}E$episode - $name');
              itemPayloads.add('/details?id=${Uri.encodeComponent(m.id)}');
            } else if (m.type == FladderItemType.movie) {
              final productionYear = m.overview.productionYear ?? m.overview.yearAired;
              itemTitles.add(productionYear != null ? '$name (${productionYear.toString()})' : name);
              itemBodies.add(null);
              itemPayloads.add('/details?id=${Uri.encodeComponent(m.id)}');
            } else if (m.type == FladderItemType.series) {
              itemTitles.add(name);
              itemBodies.add('New episodes added');
              itemPayloads.add('/details?id=${Uri.encodeComponent(m.id)}');
            } else {
              itemTitles.add(name);
              itemBodies.add(null);
              itemPayloads.add('/details?id=${Uri.encodeComponent(m.id)}');
            }
          }

          await NotificationService.showGroupedNotifications(acc.id, serverName, itemTitles, itemBodies, itemPayloads);
        }
      } catch (_) {
        // ignore per-account failures
      }
    }

    if (changed) {
      await prefs.setString(_kServerLastSeenKey, jsonEncode(lastSeenSnapshot.toJson()));
    }

    return true;
  } catch (e) {
    return false;
  }
}

List<ItemBaseModel> _uniqueById(List<ItemBaseModel> items) {
  final seen = <String>{};
  final out = <ItemBaseModel>[];
  for (final i in items) {
    final id = i.id;
    if (id.isEmpty) continue;
    if (seen.add(id)) out.add(i);
  }
  return out;
}

Future<List<dto.BaseItemDto>> _fetchLatestItems(String baseUrl, String userId, String token, int limit) async {
  try {
    final trimmed = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    final url =
        '$trimmed/Users/$userId/Items/Latest?Limit=$limit&EnableUserData=false&EnableImages=false&ImageTypeLimit=0&Fields=OriginalTitle,DateCreated,DateLastMediaAdded';
    final uri = Uri.parse(url);
    final headers = {'Authorization': 'MediaBrowser Token="$token"'};
    final resp = await http.get(uri, headers: headers).timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) return [];
    final body = jsonDecode(resp.body);
    if (body is List) {
      return body
          .whereType<Map<String, dynamic>>()
          .map((m) => dto.BaseItemDto.fromJson(Map<String, dynamic>.from(m)))
          .toList();
    }
    return [];
  } catch (_) {
    return [];
  }
}

List<LastSeenModel> _replaceOrAppend(List<LastSeenModel> servers, LastSeenModel saved) {
  final exists = servers.any((s) => s.userId == saved.userId);
  if (exists) return servers.map((s) => s.userId == saved.userId ? saved : s).toList();
  return [...servers, saved];
}
