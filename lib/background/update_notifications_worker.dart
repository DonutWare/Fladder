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
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/services/notification_service.dart';
import 'package:fladder/util/notification_helpers.dart';

const String updateNotificationName = 'fladder_update_notification';
const String updateTaskName = 'fladder_update_notifications_check';
const String updateTaskNameDebug = 'fladder_update_notifications_check_debug2';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (taskName, inputData) async {
      try {
        switch (taskName) {
          case updateTaskName:
            return await performHeadlessUpdateCheck();
          case updateTaskNameDebug:
            return await performHeadlessUpdateCheck(debug: true);
          default:
            log("Unknown task: $taskName");
            return false;
        }
      } catch (e) {
        log("Error executing task '$taskName': $e");
        return false;
      }
    },
  );
}

@pragma('vm:entry-point')
Future<bool> performHeadlessUpdateCheck({int limit = 25, bool debug = false}) async {
  try {
    await NotificationService.init();

    final prefs = await SharedPreferences.getInstance();
    final savedAccounts = prefs.getStringList(SharedKeys.loginCredentialsKey) ?? [];
    if (savedAccounts.isEmpty) return true;

    Locale workerLocale = const Locale('en');
    try {
      final clientSettingsJson = prefs.getString(SharedKeys.clientSettingsKey);
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
      return false;
    }

    final l10n = await AppLocalizations.delegate.load(workerLocale);

    final accounts = savedAccounts
        .map((e) {
          try {
            return AccountModel.fromJson(jsonDecode(e) as Map<String, dynamic>);
          } catch (e) {
            log('Error parsing account JSON: $e');
            return false;
          }
        })
        .whereType<AccountModel>()
        .where((element) => element.updateNotificationsEnabled)
        .toList();

    var lastSeenSnapshot = LastSeenNotificationsModel.fromJson(
      (prefs.getString(SharedKeys.lastSeenNotificationsKey) != null)
          ? jsonDecode(prefs.getString(SharedKeys.lastSeenNotificationsKey)!)
          : {},
    );

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

        log("Fetched ${items.length} items for account ${acc.id} (${acc.credentials.serverName}), checking against last seen data");

        final userKey = acc.id;
        final prevEntry = lastSeenSnapshot.lastSeen.firstWhere((s) => s.userId == userKey,
            orElse: () => LastSeenModel(userId: userKey, lastSeenIds: items.map((e) => e.id).toList()));
        final prevIds = prevEntry.lastSeenIds;

        log("Fetched ${items.length} items for account ${acc.id}. Previous seen IDs count: ${prevIds.length}");

        if (prevIds.isEmpty) {
          final merged = items.map((e) => e.id).toList();
          final saved = LastSeenModel(userId: userKey, lastSeenIds: merged.take(limit).toList());
          lastSeenSnapshot =
              lastSeenSnapshot.copyWith(lastSeen: replaceOrAppendLastSeen(lastSeenSnapshot.lastSeen, saved));
          if (!debug) continue;
        }

        final unseen = debug ? items.take(limit).toList() : items.where((i) => !prevIds.contains(i.id)).toList();
        log("Account ${acc.id}: ${unseen.length} new items found (debug mode: $debug)");

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
        return false;
      }
    }

    await prefs.setString(SharedKeys.lastSeenNotificationsKey, jsonEncode(lastSeenSnapshot.toJson()));

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
  } catch (e) {
    log('Error fetching latest items: $e');
    return [];
  }
}
