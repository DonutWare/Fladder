import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'package:fladder/background/update_notifications_worker.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/shared_provider.dart';

final supportsNotificationsProvider = Provider.autoDispose<bool>((ref) {
  final leanBackMode = ref.watch(argumentsStateProvider.select((value) => value.leanBackMode));
  return (!kIsWeb && !leanBackMode) && (Platform.isAndroid || Platform.isIOS);
});

final updateNotificationsProvider = Provider<UpdateNotifications>((ref) => UpdateNotifications(ref));

class UpdateNotifications {
  UpdateNotifications(this.ref);

  final Ref ref;

  Future<void> registerBackgroundTask() async {
    final accounts = ref.read(sharedUtilityProvider).getAccounts().where((a) => a.updateNotificationsEnabled).toList();
    if (accounts.isEmpty) {
      await unregisterBackgroundTask();
      return;
    }

    final interval = ref.read(clientSettingsProvider).updateNotificationsInterval;

    try {
      await Workmanager().registerPeriodicTask(
        updateNotificationName,
        updateTaskName,
        frequency: interval,
        existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
        constraints: Constraints(networkType: NetworkType.connected),
      );
    } catch (e) {
      log('Error registering background task: $e');
    }
  }

  Future<void> unregisterBackgroundTask() async {
    try {
      await Workmanager().cancelByUniqueName(updateNotificationName);
    } catch (e) {
      log('Error unregistering background task: $e');
    }
  }

  //Used for debug purposes, to trigger the background task immediately and show a notification if there are new items since the last check
  Future<void> executeBackgroundTask() async {
    try {
      await Workmanager().registerOneOffTask(
        updateNotificationNameDebug,
        updateTaskNameDebug,
        constraints: Constraints(networkType: NetworkType.connected),
      );
    } catch (e) {
      log('Error executing background task: $e');
    }
  }
}
