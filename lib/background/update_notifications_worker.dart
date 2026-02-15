import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' show Locale;

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/last_seen_notifications_model.dart';
import 'package:fladder/services/notification_service.dart';
import 'package:fladder/util/notification_helpers.dart';

const String _kAccountsKey = 'loginCredentialsKey';
const String _kServerLastSeenKey = 'serverLastSeen';
const String updateNotificationName = 'fladder_update_notification';
const String updateNotificationNameDebug = 'fladder_update_notificationDebug';
const String updateTaskName = 'fladder_update_notifications_check';
const String updateTaskNameDebug = 'fladder_update_notifications_check_debug';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      switch (task) {
        case updateTaskName:
          await performHeadlessUpdateCheck();
          break;
        case updateTaskNameDebug:
          await performHeadlessUpdateCheck(debug: true);
        default:
          break;
      }
    } catch (e) {
      log("Error in background task '$task': $e");
    }
    return Future.value(true);
  });
}

@pragma('vm:entry-point')
Future<bool> performHeadlessUpdateCheck({int limit = 50, bool debug = false}) async {
  try {
    await NotificationService.init();

    final prefs = await SharedPreferences.getInstance();
    final savedAccounts = prefs.getStringList(_kAccountsKey) ?? [];
    if (savedAccounts.isEmpty) return true;

    Locale workerLocale = const Locale('en');
    try {
      final clientSettingsJson = prefs.getString('clientSettings');
      if (clientSettingsJson != null && clientSettingsJson.isNotEmpty) {
        final map = jsonDecode(clientSettingsJson) as Map<String, dynamic>;
        final sel = map['selectedLocale'] as String?;
        if (sel != null && sel.isNotEmpty) {
          final parts = sel.split('_');
          workerLocale = parts.length == 2 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
        }
      }
    } catch (e) {
      log('Error loading client locale for notifications: $e');
    }

    final l10n = await AppLocalizations.delegate.load(workerLocale);

    final accounts = savedAccounts
        .map((e) {
          try {
            return AccountModel.fromJson(jsonDecode(e) as Map<String, dynamic>);
          } catch (e) {
            log('Error parsing account JSON: $e');
            return null;
          }
        })
        .whereType<AccountModel>()
        .where((element) => element.updateNotificationsEnabled)
        .toList();

    var lastSeenSnapshot = LastSeenNotificationsModel.fromJson(
        (prefs.getString(_kServerLastSeenKey) != null) ? jsonDecode(prefs.getString(_kServerLastSeenKey)!) : {});

    if (debug) {
      log("Debug mode enabled for update notifications check - showing all items as new");
    }

    for (final acc in accounts) {
      final baseUrl = acc.credentials.url.isNotEmpty ? acc.credentials.url : (acc.credentials.localUrl ?? '');
      if (baseUrl.isEmpty) continue;

      try {
        final dtoItems = await _fetchLatestItems(baseUrl, acc.id, acc.credentials.token, limit);
        final items = dtoItems.map((d) => ItemBaseModel.fromBaseDto(d, null)).toList();
        if (items.isEmpty) continue;

        final userKey = acc.id;
        final prevEntry = lastSeenSnapshot.lastSeen
            .firstWhere((s) => s.userId == userKey, orElse: () => LastSeenModel(userId: userKey, lastSeenIds: []));
        final prevIds = prevEntry.lastSeenIds;

        if (prevIds.isEmpty) {
          final merged = items.map((e) => e.id).toList();
          final saved = LastSeenModel(userId: userKey, lastSeenIds: merged.take(limit).toList());
          lastSeenSnapshot =
              lastSeenSnapshot.copyWith(lastSeen: replaceOrAppendLastSeen(lastSeenSnapshot.lastSeen, saved));
          if (!debug) continue;
        }

        final unseen = debug ? items.take(5).toList() : items.where((i) => !prevIds.contains(i.id)).toList();
        if (unseen.isNotEmpty) {
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
          lastSeenSnapshot =
              lastSeenSnapshot.copyWith(lastSeen: replaceOrAppendLastSeen(lastSeenSnapshot.lastSeen, saved));

          final serverName =
              acc.credentials.serverName.isNotEmpty ? acc.credentials.serverName : acc.credentials.serverId;

          final itemTitles = <String>[];
          final itemBodies = <String?>[];
          final itemPayloads = <String?>[];
          for (final m in unseen) {
            final pair = notificationTitleBodyForItem(m, l10n);
            final title = pair.key.isNotEmpty ? pair.key : (m.name.isNotEmpty ? m.name : l10n.unknown);
            itemTitles.add(title);
            itemBodies.add(pair.value);
            itemPayloads.add(buildDetailsDeepLink(m.id));
          }

          final summaryText = l10n.notificationNewItems(itemTitles.length);
          await NotificationService.showGroupedNotifications(
            acc.id,
            serverName,
            itemTitles,
            itemBodies,
            itemPayloads,
            summaryText,
          );
        }
      } catch (e) {
        log('Error fetching latest items for account ${acc.id}: $e');
      }
    }

    await prefs.setString(_kServerLastSeenKey, jsonEncode(lastSeenSnapshot.toJson()));

    log("Update notifications check completed successfully");
    return true;
  } catch (e) {
    log("Error during update notifications check: $e");
    return false;
  }
}

Future<List<dto.BaseItemDto>> _fetchLatestItems(String baseUrl, String userId, String token, int limit) async {
  try {
    final trimmed = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    final url = buildLatestItemsUrl(trimmed, userId, limit);
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
