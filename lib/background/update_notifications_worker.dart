import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' show Locale, IsolateNameServer;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/last_seen_notifications_model.dart';
import 'package:fladder/models/notification_model.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/services/notification_service.dart';
import 'package:fladder/util/notification_helpers.dart';

const String updateTaskName = 'nl.jknaapen.fladder.update_notifications_check';
const String updateTaskNameDebug = 'nl.jknaapen.fladder.update_notifications_check_debug';
const String updateWorkerPortName = 'fladder_notification_update_worker_port';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (taskName, inputData) async {
      log("Launching background task: $taskName with inputData: $inputData");
      try {
        switch (taskName) {
          case updateTaskName:
            return await performHeadlessUpdateCheck() != null;
          case updateTaskNameDebug:
            return await performHeadlessUpdateCheck(debug: true) != null;
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
Future<LastSeenNotificationsModel?> performHeadlessUpdateCheck(
    {int limit = 50, bool debug = false, bool includeHiddenViews = false}) async {
  try {
    final currentDate = DateTime.now();
    log("Starting background update check at $currentDate (debug: $debug, includeHiddenViews: $includeHiddenViews)");

    final prefs = await SharedPreferences.getInstance();
    final sharedHelper = SharedHelper(sharedPreferences: prefs);

    final accounts = sharedHelper
        .getAccounts()
        .where((element) => element.updateNotificationsEnabled || element.seerrRequestsEnabled)
        .toList();
    if (accounts.isEmpty) return null;

    Locale workerLocale = const Locale('en');
    try {
      final clientSettingsJson = sharedHelper.clientSettings;
      workerLocale = clientSettingsJson.selectedLocale ?? workerLocale;
    } catch (e) {
      log('Error loading client locale for notifications: $e');
    }

    final l10n = await AppLocalizations.delegate.load(workerLocale);

    var lastSeenStore = sharedHelper.lastSeenNotifications;

    for (final account in accounts) {
      final baseUrl =
          account.credentials.url.isNotEmpty ? account.credentials.url : (account.credentials.localUrl ?? '');
      if (baseUrl.isEmpty && !(account.seerrRequestsEnabled && account.seerrCredentials?.isConfigured == true)) {
        continue;
      }

      try {
        final useHidden = includeHiddenViews || account.includeHiddenViews;

        final lastUpdateCheck = lastSeenStore.updatedAt ?? DateTime.now();

        final List<NotificationModel> accountNotifications = [];

        if (account.updateNotificationsEnabled) {
          final newNotifications = await _fetchAndNotifyLatestItemsForAccount(
            account,
            l10n,
            limit,
            useHidden,
            debug,
            lastUpdateCheck,
          );
          accountNotifications.addAll(newNotifications);
        }

        if (account.seerrRequestsEnabled && account.seerrCredentials?.isConfigured == true) {
          final seerrNotifications = await _fetchAndNotifySeerrRequestsForAccount(
            account,
            l10n,
            10,
            debug,
            lastUpdateCheck,
          );
          accountNotifications.addAll(seerrNotifications);
        }

        if (accountNotifications.isNotEmpty) {
          lastSeenStore = lastSeenStore.copyWith(
            lastSeen: NotificationHelpers.replaceOrAppendLastSeen(
              lastSeenStore.lastSeen,
              LastSeenModel(userId: account.id, lastNotifications: accountNotifications),
            ),
          );
        }
      } catch (e) {
        log('Error fetching latest items for account ${account.id}: $e');
        continue;
      }
    }

    lastSeenStore = lastSeenStore.copyWith(
      updatedAt: currentDate,
    );

    await sharedHelper.setLastSeenNotifications(lastSeenStore);

    try {
      final sendPort = IsolateNameServer.lookupPortByName(updateWorkerPortName);
      if (sendPort != null) {
        sendPort.send(jsonEncode(lastSeenStore.toJson()));
      }
    } catch (e) {
      log('Error sending worker update to main isolate: $e');
    }

    log("Background update completed successfully ${lastSeenStore.updatedAt}");
    return lastSeenStore;
  } catch (e) {
    log("Error during background update check: $e");
    return null;
  }
}

Future<List<NotificationModel>> _fetchAndNotifyLatestItemsForAccount(
  AccountModel account,
  AppLocalizations l10n,
  int limit,
  bool includeHiddenViews,
  bool debug,
  DateTime lastUpdateCheck,
) async {
  try {
    final baseUrl = account.credentials.url.isNotEmpty ? account.credentials.url : (account.credentials.localUrl ?? '');
    if (baseUrl.isEmpty) return [];

    final dtoItems = await NotificationHelpers.fetchLatestItems(
      baseUrl,
      account.id,
      account.credentials.token,
      limit,
      includeHiddenViews: includeHiddenViews,
      since: debug ? lastUpdateCheck.subtract(const Duration(days: 3)) : lastUpdateCheck,
    );

    final items = dtoItems.map((d) => ItemBaseModel.fromBaseDto(d, null)).toList();
    if (items.isEmpty) return [];

    final newNotifications = NotificationModel.createList(items, l10n);

    final serverName =
        account.credentials.serverName.isNotEmpty ? account.credentials.serverName : account.credentials.serverId;
    final summaryText = l10n.notificationNewItems(newNotifications.length);

    await NotificationService.showGroupedNotifications(
      account.id,
      serverName,
      newNotifications,
      summaryText,
    );

    log("Fetched ${items.length} items for account ${account.id} (${account.credentials.serverName}), checking against last seen data");

    return newNotifications;
  } catch (e) {
    log('Error fetching latest items for account ${account.id}: $e');
    return [];
  }
}

Future<List<NotificationModel>> _fetchAndNotifySeerrRequestsForAccount(
  AccountModel account,
  AppLocalizations l10n,
  int limit,
  bool debug,
  DateTime lastUpdateCheck,
) async {
  try {
    final seerrCredentials = account.seerrCredentials;
    if (seerrCredentials == null || !seerrCredentials.isConfigured) return [];

    final seerrBase = seerrCredentials.serverUrl.endsWith('/')
        ? seerrCredentials.serverUrl.substring(0, seerrCredentials.serverUrl.length - 1)
        : seerrCredentials.serverUrl;

    final seerrApi = NotificationHelpers.createSeerrClient(seerrCredentials);

    final newRequests = await NotificationHelpers.fetchSeerrRequests(
      seerrApi,
      seerrBase,
      lastUpdateCheck,
      debug,
      limit,
      seerrCredentials,
    );

    if (newRequests.isEmpty) return [];

    final List<NotificationModel> seerrNotifications = [];

    for (final request in newRequests) {
      try {
        final tmdbId = request.media?.tmdbId;
        String? title;
        String? image;
        String? payload;

        if (tmdbId != null) {
          final mediaTypeRaw = (request.media?.mediaType ?? '').toLowerCase();
          if (mediaTypeRaw.contains('tv')) {
            final detailsResp = await seerrApi.getTvDetails(tmdbId);
            if (detailsResp.isSuccessful && detailsResp.body != null) {
              final SeerrTvDetails details = detailsResp.body!;
              title = details.name;
              image = details.posterUrl;
              payload = NotificationHelpers.buildSeerrDeepLink('tvshow', tmdbId);
            }
          } else {
            final detailsResp = await seerrApi.getMovieDetails(tmdbId);
            if (detailsResp.isSuccessful && detailsResp.body != null) {
              final SeerrMovieDetails details = detailsResp.body!;
              title = details.title;
              image = details.posterUrl;
              payload = NotificationHelpers.buildSeerrDeepLink('movie', tmdbId);
            }
          }
        }

        final notif = NotificationModel.fromSeerrRequest(
          request,
          l10n,
          title: title,
          image: image,
          detailedPayload: payload,
        );
        if (notif != null) seerrNotifications.add(notif);
      } catch (e) {
        log('Error fetching Seerr request parent items ${request.id}: $e');
        final fallback = NotificationModel.fromSeerrRequest(request, l10n);
        if (fallback != null) seerrNotifications.add(fallback);
      }
    }

    final serverName = seerrCredentials.serverUrl;
    final summaryText = l10n.notificationNewRequests(seerrNotifications.length);

    await NotificationService.showGroupedNotifications(
      '${account.id}_seerr',
      serverName,
      seerrNotifications,
      summaryText,
    );

    return seerrNotifications;
  } catch (e) {
    log('Error fetching Seerr requests for account ${account.id}: $e');
    return [];
  }
}
