import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/last_seen_notifications_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/shared_provider.dart';

final supportsNotificationsProvider = Provider.autoDispose<bool>((ref) {
  final leanBackMode = ref.watch(argumentsStateProvider.select((value) => value.leanBackMode));
  return (!kIsWeb && !leanBackMode) && (Platform.isAndroid || Platform.isIOS);
});

final updateNotificationsProvider = Provider<UpdateNotifications>((ref) => UpdateNotifications(ref));

class UpdateNotifications {
  UpdateNotifications(this.ref);
  final Ref ref;

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
}

extension _LastSeenNotificationsModelX on LastSeenNotificationsModel {
  LastSeenNotificationsModel copyWithUpdatedServer(LastSeenModel updatedModel) {
    final others = lastSeen.where((element) => element.userId != updatedModel.userId).toList();
    return copyWith(lastSeen: [...others, updatedModel], updatedAt: DateTime.now());
  }
}
