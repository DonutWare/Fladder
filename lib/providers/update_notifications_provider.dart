import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'package:fladder/background/update_notifications_worker.dart';
import 'package:fladder/models/last_seen_notifications_model.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/shared_provider.dart';

final supportsNotificationsProvider = Provider.autoDispose<bool>((ref) {
  final leanBackMode = ref.watch(argumentsStateProvider.select((value) => value.leanBackMode));
  return (!kIsWeb && !leanBackMode) && Platform.isAndroid || Platform.isIOS;
});

final updateNotificationsProvider = Provider<UpdateNotifications>((ref) => UpdateNotifications(ref));

final notificationsProvider = StateProvider<LastSeenNotificationsModel>((ref) => const LastSeenNotificationsModel());

class UpdateNotifications {
  UpdateNotifications(this.ref);

  final Ref ref;

  Future<void> registerBackgroundTask() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final accounts = ref
        .read(sharedUtilityProvider)
        .getAccounts()
        .where((a) => a.updateNotificationsEnabled || a.seerrRequestsEnabled)
        .toList();
    if (accounts.isEmpty) {
      await unregisterBackgroundTask();
      return;
    }

    final interval = ref.read(clientSettingsProvider).updateNotificationsInterval;

    try {
      await Workmanager().registerPeriodicTask(
        updateTaskName,
        updateTaskName,
        frequency: interval,
        existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
        inputData: <String, dynamic>{
          'frequency': interval.inMinutes,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      log('Error registering background task: $e');
    }
  }

  Future<void> unregisterBackgroundTask() async {
    try {
      await Workmanager().cancelByUniqueName(updateTaskName);
    } catch (e) {
      log('Error unregistering background task: $e');
    }
  }

  Future<void> conditionallyUnregisterBackgroundTask() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final accounts = ref
          .read(sharedUtilityProvider)
          .getAccounts()
          .where((a) => a.updateNotificationsEnabled || a.seerrRequestsEnabled)
          .toList();
      if (accounts.isEmpty) {
        log('No accounts have update notifications enabled, unregistering background task');
        await Workmanager().cancelByUniqueName(updateTaskName);
        return;
      }
    } catch (e) {
      log('Error unregistering background task: $e');
    }
  }

  //Used for debug purposes, to trigger the background task immediately and show a notification for any new items
  Future<void> executeBackgroundTask() async {
    try {
      // performHeadlessUpdateCheck(
      //   debug: true,
      // );
      await Workmanager().registerOneOffTask(
        updateTaskNameDebug,
        updateTaskNameDebug,
        existingWorkPolicy: ExistingWorkPolicy.replace,
        constraints: Constraints(networkType: NetworkType.connected),
      );
    } catch (e) {
      log('Error executing background task: $e');
    }
  }

  Future<void> cancelAllTasks() => Workmanager().cancelAll();
}
