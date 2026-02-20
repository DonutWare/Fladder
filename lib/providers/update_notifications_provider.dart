import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
import 'dart:isolate';
import 'dart:ui';

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
  return (!kIsWeb && !leanBackMode) &&
      (Platform.isAndroid || Platform.isIOS || Platform.isWindows || Platform.isMacOS || Platform.isLinux);
});

final updateNotificationsProvider = Provider<UpdateNotifications>((ref) => UpdateNotifications(ref));

final notificationsProvider = StateProvider<LastSeenNotificationsModel>((ref) {
  return const LastSeenNotificationsModel();
});

class UpdateNotifications {
  UpdateNotifications(this.ref) {
    registerBackgroundTask();
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      startWorkerListener();
    }

    ref.onDispose(() {
      _desktopTimer?.cancel();
      _desktopTimer = null;
      stopWorkerListener();
    });
  }

  final Ref ref;
  Timer? _desktopTimer;
  ReceivePort? _workerReceivePort;

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
      if (kIsWeb) return;
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        _desktopTimer?.cancel();
        _desktopTimer = Timer.periodic(interval, (_) {
          performHeadlessUpdateCheck();
        });
        await performHeadlessUpdateCheck();
        return;
      }

      await Workmanager().registerPeriodicTask(
        updateTaskName,
        updateTaskName,
        frequency: interval,
        existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
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
      _desktopTimer?.cancel();
      _desktopTimer = null;
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        await Workmanager().cancelByUniqueName(updateTaskName);
      }
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
        _desktopTimer?.cancel();
        _desktopTimer = null;
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          await Workmanager().cancelByUniqueName(updateTaskName);
        }
        return;
      }
    } catch (e) {
      log('Error unregistering background task: $e');
    }
  }

  //Used for debug purposes, to trigger the background task immediately and show a notification for any new items
  Future<void> executeBackgroundTask() async {
    try {
      if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
        await performHeadlessUpdateCheck(debug: true);
        return;
      } else {
        await Workmanager().registerOneOffTask(
          updateTaskNameDebug,
          updateTaskNameDebug,
          existingWorkPolicy: ExistingWorkPolicy.replace,
          constraints: Constraints(
            networkType: NetworkType.connected,
          ),
        );
      }
    } catch (e) {
      log('Error executing background task: $e');
    }
  }

  Future<void> cancelAllTasks() async {
    _desktopTimer?.cancel();
    _desktopTimer = null;
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await Workmanager().cancelAll();
    }
  }

  void startWorkerListener() {
    if (_workerReceivePort != null) return;
    _workerReceivePort = ReceivePort();
    IsolateNameServer.removePortNameMapping(updateWorkerPortName);
    IsolateNameServer.registerPortWithName(_workerReceivePort!.sendPort, updateWorkerPortName);
    _workerReceivePort?.listen(_updateProvider);
  }

  void _updateProvider(dynamic value) {
    final lastSeenStore = LastSeenNotificationsModel.fromJson(jsonDecode(value));
    try {
      ref.read(notificationsProvider.notifier).state = lastSeenStore;
    } catch (e) {
      log('Error updating notifications from worker: $e');
    }
  }

  void stopWorkerListener() {
    if (_workerReceivePort == null) return;
    IsolateNameServer.removePortNameMapping(updateWorkerPortName);
    _workerReceivePort?.close();
    _workerReceivePort = null;
  }
}
