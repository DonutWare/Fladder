import 'dart:async';
import 'dart:developer';
import 'dart:ui' show Locale;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/last_seen_notifications_model.dart';
import 'package:fladder/models/notification_model.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/services/notification_service.dart';
import 'package:fladder/util/notification_helpers.dart';

const String updateTaskName = 'nl.jknaapen.fladder.update_notifications_check';
const String updateTaskNameDebug = 'nl.jknaapen.fladder.update_notifications_check_debug';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (taskName, inputData) async {
      log("Launching background task: $taskName with inputData: $inputData");
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
Future<bool> performHeadlessUpdateCheck({int limit = 50, bool debug = false, bool includeHiddenViews = false}) async {
  try {
    await NotificationService.init();

    final currentDate = DateTime.now();
    log("Starting background update check at $currentDate (debug: $debug, includeHiddenViews: $includeHiddenViews)");

    final prefs = await SharedPreferences.getInstance();
    final sharedHelper = SharedHelper(sharedPreferences: prefs);
    final accounts = sharedHelper.getAccounts().where((element) => element.updateNotificationsEnabled).toList();
    if (accounts.isEmpty) return true;

    Locale workerLocale = const Locale('en');
    try {
      final clientSettingsJson = sharedHelper.clientSettings;
      workerLocale = clientSettingsJson.selectedLocale ?? workerLocale;
    } catch (e) {
      log('Error loading client locale for notifications: $e');
    }

    final l10n = await AppLocalizations.delegate.load(workerLocale);

    var lastSeenStore = sharedHelper.getLastSeenNotifications();

    for (final acc in accounts) {
      final baseUrl = acc.credentials.url.isNotEmpty ? acc.credentials.url : (acc.credentials.localUrl ?? '');
      if (baseUrl.isEmpty) continue;

      try {
        final useHidden = includeHiddenViews || acc.includeHiddenViews;

        final lastUpdateCheck = acc.lastUpdateCheck ?? DateTime.now();
        final dtoItems = await NotificationHelpers.fetchLatestItems(
          baseUrl,
          acc.id,
          acc.credentials.token,
          limit,
          includeHiddenViews: useHidden,
          since: debug ? lastUpdateCheck.subtract(const Duration(days: 32)) : lastUpdateCheck,
        );

        final items = dtoItems.map((d) => ItemBaseModel.fromBaseDto(d, null)).toList();
        if (items.isEmpty) continue;

        final newNotifications = NotificationModel.createList(items, l10n);

        final serverName =
            acc.credentials.serverName.isNotEmpty ? acc.credentials.serverName : acc.credentials.serverId;

        final summaryText = l10n.notificationNewItems(newNotifications.length);
        await NotificationService.showGroupedNotifications(
          acc.id,
          serverName,
          newNotifications,
          summaryText,
        );

        log("Fetched ${items.length} items for account ${acc.id} (${acc.credentials.serverName}), checking against last seen data");

        lastSeenStore = lastSeenStore.copyWith(
          lastSeen: NotificationHelpers.replaceOrAppendLastSeen(
            lastSeenStore.lastSeen,
            LastSeenModel(userId: acc.id, lastNotifications: newNotifications),
          ),
        );
      } catch (e) {
        log('Error fetching latest items for account ${acc.id}: $e');
        continue;
      }
    }

    sharedHelper.setLastSeenNotifications(lastSeenStore.copyWith(
      lastSeen: [],
      updatedAt: currentDate,
    ));

    log("Background update completed successfully");
    return true;
  } catch (e) {
    log("Error during background update check: $e");
    return false;
  }
}
