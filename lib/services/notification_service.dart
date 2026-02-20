import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:fladder/models/notification_model.dart';

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static const String _channelId = 'fladder_updates';
  static const String _channelName = 'Update notifications';
  static const String _channelDesc = 'Notifications for newly added items';

  static final StreamController<String?> _selectNotificationController = StreamController<String?>.broadcast();
  static Stream<String?> get notificationTapStream => _selectNotificationController.stream;

  @pragma('vm:entry-point')
  static void _backgroundNotificationHandler(NotificationResponse resp) {
    _selectNotificationController.add(resp.payload);
  }

  static Future<void> init() async {
    if (kIsWeb) return;

    const android = AndroidInitializationSettings('ic_notification');
    final darwin = const DarwinInitializationSettings();
    final linux = const LinuxInitializationSettings(defaultActionName: 'Open notification');
    final windows = const WindowsInitializationSettings(
      appName: 'Fladder',
      appUserModelId: 'nl.jknaapen.fladder',
      guid: 'd49b0314-ee7a-4626-bf79-97cdb8a991bb',
    );

    await _plugin.initialize(
      settings: InitializationSettings(
        android: android,
        iOS: darwin,
        macOS: darwin,
        linux: linux,
        windows: windows,
      ),
      onDidReceiveNotificationResponse: (NotificationResponse resp) {
        _selectNotificationController.add(resp.payload);
      },
      onDidReceiveBackgroundNotificationResponse: _notificationBackgroundEntryPoint,
    );

    if (!kIsWeb && Platform.isAndroid) {
      final channel = const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDesc,
        importance: Importance.defaultImportance,
      );
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  static Future<String?> getInitialNotificationPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    return details?.notificationResponse?.payload;
  }

  static Future<bool> requestPermission() async {
    if (kIsWeb) return false;

    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      if (status.isGranted) return true;
      final res = await Permission.notification.request();
      return res.isGranted;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      final iosImpl = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      final result = await iosImpl?.requestPermissions(alert: true, badge: true, sound: true);
      return result ?? true;
    }

    if (Platform.isLinux || Platform.isWindows) {
      return true;
    }

    return false;
  }

  static Future<void> showNewItemsNotification(String title, String body) async {
    final androidDetails = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const iosDetails = DarwinNotificationDetails();
    final linuxDetails = const LinuxNotificationDetails(defaultActionName: 'Open notification');
    final windowsDetails = const WindowsNotificationDetails();

    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
        linux: linuxDetails,
        windows: windowsDetails,
      ),
    );
  }

  static Future<void> showGroupedNotifications(
    String groupId,
    String groupTitle,
    List<NotificationModel> notifications,
    String? summaryText,
  ) async {
    if (notifications.isEmpty) return;

    final baseId = DateTime.now().millisecond;
    final groupKey = 'fladder_group_$groupId';

    if (notifications.length == 1) {
      final single = notifications.first;

      final androidSummary = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        styleInformation: InboxStyleInformation(
          [single.subtitle ?? single.title],
          contentTitle: single.title,
          summaryText: summaryText ?? '${notifications.length} new item',
        ),
        subText: (summaryText?.isNotEmpty == true) ? summaryText : groupTitle,
        groupKey: groupKey,
        setAsGroupSummary: true,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        groupAlertBehavior: GroupAlertBehavior.summary,
      );

      final iosSummary = DarwinNotificationDetails(threadIdentifier: groupKey);
      final linuxSummary = const LinuxNotificationDetails(defaultActionName: 'Open notification');
      final windowsSummary = const WindowsNotificationDetails();

      await _plugin.show(
        id: baseId,
        title: single.title,
        body: (summaryText?.isNotEmpty == true)
            ? ((single.subtitle?.isNotEmpty == true) ? '${single.subtitle}' : summaryText!)
            : (single.subtitle ?? ''),
        payload: single.payLoad,
        notificationDetails: NotificationDetails(
          android: androidSummary,
          iOS: iosSummary,
          linux: linuxSummary,
          windows: windowsSummary,
        ),
      );

      return;
    }

    final futures = <Future<void>>[];
    for (var i = 0; i < notifications.length; i++) {
      final childId = baseId + 1 + i;
      final notification = notifications[i];
      final androidChild = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        groupKey: groupKey,
        groupAlertBehavior: GroupAlertBehavior.summary,
      );
      final iosChild = DarwinNotificationDetails(threadIdentifier: groupKey);
      final linuxChild = const LinuxNotificationDetails(defaultActionName: 'Open notification');
      final windowsChild = const WindowsNotificationDetails();
      futures.add(_plugin.show(
        id: childId,
        title: notification.title,
        body: notification.subtitle,
        payload: notification.payLoad,
        notificationDetails: NotificationDetails(
          android: androidChild,
          iOS: iosChild,
          linux: linuxChild,
          windows: windowsChild,
        ),
      ));
    }

    await Future.wait(futures);

    final androidSummary = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      styleInformation: InboxStyleInformation(
        notifications.map((n) => n.title).toList(),
        contentTitle: groupTitle,
        summaryText: summaryText ?? '${notifications.length} new items',
      ),
      groupKey: groupKey,
      setAsGroupSummary: true,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      groupAlertBehavior: GroupAlertBehavior.summary,
    );

    final iosSummary = DarwinNotificationDetails(threadIdentifier: groupKey);
    final linuxSummary = const LinuxNotificationDetails(defaultActionName: 'Open notification');
    final windowsSummary = const WindowsNotificationDetails();

    await _plugin.show(
      id: baseId,
      title: groupTitle,
      body: summaryText ?? '${notifications.length} new item(s)',
      notificationDetails: NotificationDetails(
        android: androidSummary,
        iOS: iosSummary,
        linux: linuxSummary,
        windows: windowsSummary,
      ),
    );
  }
}

@pragma('vm:entry-point')
void _notificationBackgroundEntryPoint(NotificationResponse response) {
  NotificationService._backgroundNotificationHandler(response);
}
