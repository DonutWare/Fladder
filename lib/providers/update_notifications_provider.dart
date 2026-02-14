import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/account_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/last_seen_notifications_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/services/notification_service.dart';

const deeplinkBaseScheme = 'fladder://';

const detailsDeeplinkPrefix = '$deeplinkBaseScheme/details?id=';

final supportsNotificationsProvider = Provider.autoDispose<bool>((ref) {
  final leanBackMode = ref.watch(argumentsStateProvider.select((value) => value.leanBackMode));
  return (!kIsWeb && !leanBackMode) && (Platform.isAndroid || Platform.isIOS);
});

final updateNotificationsProvider = Provider<UpdateNotifications>((ref) => UpdateNotifications(ref));

class UpdateNotifications {
  UpdateNotifications(this.ref) {
    ref.onDispose(_cancelDebugTimer);
  }

  final Ref ref;

  /// Debug-only in-app timer used when interval < 15 minutes (kDebugMode only)
  Timer? _debugTimer;

  Future<LastSeenNotificationsModel> checkAllAccountsForNewItems({bool ignorePreference = false}) async {
    final shared = ref.read(sharedUtilityProvider);
    final accounts = shared.getAccounts().where((element) => element.updateNotificationsEnabled).toList();

    LastSeenNotificationsModel oldLastSeen = ref.read(sharedUtilityProvider).getLastSeenNotifications();
    LastSeenNotificationsModel newLastSeen = const LastSeenNotificationsModel();

    for (final acc in accounts) {
      final baseUrl = acc.credentials.url.isNotEmpty ? acc.credentials.url : (acc.credentials.localUrl ?? '');
      if (baseUrl.isEmpty) continue;

      try {
        final api = createJellyfinApiForAccount(ref, normalizeUrl(baseUrl), acc.credentials.header(ref));
        final items = await _fetchLatestForApi(api, acc.id, limit: 50);

        log('Fetched ${items.length} latest items for account ${acc.name} (${acc.credentials.serverName})');

        if (items.isEmpty) continue;

        final userKey = acc.id;
        final prevEntry = oldLastSeen.lastSeen.firstWhere((element) => element.userId == userKey,
            orElse: () => LastSeenModel(userId: userKey, lastSeenIds: []));

        final prevIds = prevEntry.lastSeenIds;

        log('Previous snapshot for account ${acc.name} (${acc.credentials.serverName}): ${prevIds.length} items');

        final unseen = items.where((i) => !prevIds.contains(i.id)).toList();

        log('Found ${unseen.length} new items for account ${acc.name} (${acc.credentials.serverName})');

        final updatedModel = LastSeenModel(userId: userKey, lastSeenIds: unseen.map((e) => e.id).toList());
        newLastSeen = newLastSeen.copyWithUpdatedServer(updatedModel);

        try {
          final preview = items.take(5).where((i) => i.name.isNotEmpty).toList();
          final previewTitles = <String>[];
          final previewBodies = <String?>[];
          final previewPayloads = <String?>[];
          for (final it in preview) {
            final pair = _notificationTitleBodyForItem(it, padSeasonEpisode: false);
            if (pair.key.isNotEmpty) {
              previewTitles.add(pair.key);
              previewBodies.add(pair.value);
              previewPayloads.add('$detailsDeeplinkPrefix${Uri.encodeComponent(it.id)}');
            }
          }

          final serverName =
              acc.credentials.serverName.isNotEmpty ? acc.credentials.serverName : acc.credentials.serverId;
          await NotificationService.showGroupedNotifications(
              acc.id, serverName, previewTitles, previewBodies, previewPayloads);
        } catch (_) {}
      } catch (e) {
        log('Error checking for new items for account ${acc.name}: $e');
      }
    }

    await ref.read(sharedUtilityProvider).setLastSeenNotifications(newLastSeen);
    return newLastSeen;
  }

  Future<List<ItemBaseModel>> _fetchLatestForApi(JellyfinOpenApi apiClient, String userId, {int limit = 50}) async {
    try {
      final resp = await apiClient.usersUserIdItemsLatestGet(
        userId: userId,
        limit: limit,
        enableUserData: false,
        enableImages: false,
        imageTypeLimit: 0,
        fields: [ItemFields.originaltitle, ItemFields.datecreated, ItemFields.datelastmediaadded],
      );

      final list = resp.body?.map((dto) => ItemBaseModel.fromBaseDto(dto, ref)).toList() ?? [];
      return list;
    } catch (e) {
      log('Error fetching latest items for user $userId: $e');
      return [];
    }
  }

  MapEntry<String, String?> _notificationTitleBodyForItem(ItemBaseModel it, {bool padSeasonEpisode = false}) {
    if (it is EpisodeModel) {
      final title = it.seriesName ?? it.name;
      final season = padSeasonEpisode ? it.season.toString().padLeft(2, '0') : it.season.toString();
      final episode = padSeasonEpisode ? it.episode.toString().padLeft(2, '0') : it.episode.toString();
      final body = 'S${season}E$episode - ${it.name}';
      return MapEntry(title, body);
    }

    if (it.type == FladderItemType.movie) {
      final year = it.overview.yearAired;
      final title = (year != null && year > 0) ? '${it.name} ($year)' : it.name;
      return MapEntry(title, null);
    }

    if (it.type == FladderItemType.series) {
      return MapEntry(it.name, 'New episodes added');
    }

    return MapEntry(it.name, null);
  }

  Future<void> registerBackgroundTask() async {
    // cancel any existing debug timer
    _cancelDebugTimer();

    final accounts = ref.read(sharedUtilityProvider).getAccounts().where((a) => a.updateNotificationsEnabled).toList();
    if (accounts.isEmpty) {
      await unregisterBackgroundTask();
      return;
    }

    final interval = ref.read(clientSettingsProvider).updateNotificationsInterval ?? const Duration(hours: 1);

    // In debug mode allow short intervals via an in-app timer (only while app runs)
    if (interval < const Duration(minutes: 15)) {
      _debugTimer = Timer.periodic(interval, (_) async {
        await checkAllAccountsForNewItems();
      });
      return;
    }

    final frequency = interval < const Duration(minutes: 15) ? const Duration(minutes: 15) : interval;

    try {
      await Workmanager().registerPeriodicTask(
        'fladder_update_notifications',
        'fladder_update_notifications_check',
        frequency: frequency,
        existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
        constraints: Constraints(networkType: NetworkType.connected),
      );
    } catch (_) {}
  }

  Future<void> unregisterBackgroundTask() async {
    _cancelDebugTimer();
    try {
      await Workmanager().cancelByUniqueName('fladder_update_notifications');
    } catch (_) {}
  }

  void _cancelDebugTimer() {
    try {
      _debugTimer?.cancel();
      _debugTimer = null;
    } catch (_) {}
  }

  Future<void> debugShowLatestNotificationForActiveUser({int limit = 5}) async {
    final active = ref.read(userProvider);
    if (active == null) return;

    final accounts = ref.read(sharedUtilityProvider).getAccounts();
    AccountModel? account;
    for (final a in accounts) {
      if (a.id == active.id) {
        account = a;
        break;
      }
    }
    if (account == null) return;

    final baseUrl = account.credentials.url.isNotEmpty ? account.credentials.url : (account.credentials.localUrl ?? '');
    if (baseUrl.isEmpty) return;

    try {
      final api = createJellyfinApiForAccount(ref, normalizeUrl(baseUrl), account.credentials.header(ref));
      final items = await _fetchLatestForApi(api, account.id, limit: limit);
      final preview = items.take(limit).where((i) => i.name.isNotEmpty).toList();
      final previewTitles = <String>[];
      final previewBodies = <String?>[];
      final previewPayloads = <String?>[];
      for (final it in preview) {
        final pair = _notificationTitleBodyForItem(it, padSeasonEpisode: true);
        if (pair.key.isNotEmpty) {
          previewTitles.add(pair.key);
          previewBodies.add(pair.value);
          previewPayloads.add('$detailsDeeplinkPrefix${Uri.encodeComponent(it.id)}');
        }
      }

      final serverName =
          account.credentials.serverName.isNotEmpty ? account.credentials.serverName : account.credentials.serverId;
      await NotificationService.showGroupedNotifications(
          account.id, serverName, previewTitles, previewBodies, previewPayloads);
    } catch (_) {}
  }
}

extension _LastSeenNotificationsModelX on LastSeenNotificationsModel {
  LastSeenNotificationsModel copyWithUpdatedServer(LastSeenModel updatedModel) {
    final others = lastSeen.where((element) => element.userId != updatedModel.userId).toList();
    return copyWith(lastSeen: [...others, updatedModel], updatedAt: DateTime.now());
  }
}
