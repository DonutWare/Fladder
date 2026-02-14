import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

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
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = const DarwinInitializationSettings();

    await _plugin.initialize(
      settings: InitializationSettings(android: android, iOS: ios, macOS: null),
      onDidReceiveNotificationResponse: (NotificationResponse resp) {
        _selectNotificationController.add(resp.payload);
      },
      onDidReceiveBackgroundNotificationResponse: _notificationBackgroundEntryPoint,
    );

    if (!kIsWeb && Platform.isAndroid) {
      final channel = const AndroidNotificationChannel(_channelId, _channelName,
          description: _channelDesc, importance: Importance.defaultImportance);
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

    return false;
  }

  static Future<void> showNewItemsNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const iosDetails = DarwinNotificationDetails();

    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }

  static Future<void> showGroupedNotifications(String groupId, String groupTitle, List<String> itemTitles,
      [List<String?>? itemBodies, List<String?>? itemPayloads]) async {
    if (itemTitles.isEmpty) return;

    itemBodies ??= List<String?>.filled(itemTitles.length, null);
    itemPayloads ??= List<String?>.filled(itemTitles.length, null);

    final baseId = groupId.hashCode & 0x7fffffff;

    final groupKey = 'fladder_group_$groupId';

    for (var i = 0; i < itemTitles.length; i++) {
      final childId = baseId + 1 + i;
      final androidChild = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        groupKey: groupKey,
      );
      final iosChild = DarwinNotificationDetails(threadIdentifier: groupKey);
      await _plugin.show(
        id: childId,
        title: itemTitles[i],
        body: itemBodies.elementAtOrNull(i),
        payload: itemPayloads.elementAtOrNull(i),
        notificationDetails: NotificationDetails(android: androidChild, iOS: iosChild),
      );
    }

    final inboxLines = itemTitles.take(5).toList();
    final androidSummary = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      styleInformation:
          InboxStyleInformation(inboxLines, contentTitle: groupTitle, summaryText: '${itemTitles.length} new items'),
      groupKey: groupKey,
      setAsGroupSummary: true,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    final iosSummary = DarwinNotificationDetails(threadIdentifier: groupKey);

    await _plugin.show(
      id: baseId,
      title: groupTitle,
      body: '${itemTitles.length} new item(s)',
      notificationDetails: NotificationDetails(android: androidSummary, iOS: iosSummary),
      payload: "/details?id=a9b8b3b4d20b8061b0a30aa17ba53459",
    );
  }
}

@pragma('vm:entry-point')
void _notificationBackgroundEntryPoint(NotificationResponse response) {
  NotificationService._backgroundNotificationHandler(response);
}
