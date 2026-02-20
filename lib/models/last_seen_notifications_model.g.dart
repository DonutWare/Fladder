// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_seen_notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LastSeenNotificationsModel _$LastSeenNotificationsModelFromJson(
        Map<String, dynamic> json) =>
    _LastSeenNotificationsModel(
      lastSeen: (json['lastSeen'] as List<dynamic>?)
              ?.map((e) => LastSeenModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LastSeenNotificationsModelToJson(
        _LastSeenNotificationsModel instance) =>
    <String, dynamic>{
      'lastSeen': instance.lastSeen,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_LastSeenModel _$LastSeenModelFromJson(Map<String, dynamic> json) =>
    _LastSeenModel(
      userId: json['userId'] as String,
      lastNotifications: (json['lastNotifications'] as List<dynamic>?)
              ?.map(
                  (e) => NotificationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NotificationModel>[],
    );

Map<String, dynamic> _$LastSeenModelToJson(_LastSeenModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'lastNotifications': instance.lastNotifications,
    };
