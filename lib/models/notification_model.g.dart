// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      key: json['key'] as String,
      id: json['id'] as String,
      childCount: (json['childCount'] as num?)?.toInt(),
      image: json['image'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      payLoad: json['payLoad'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'id': instance.id,
      'childCount': instance.childCount,
      'image': instance.image,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'payLoad': instance.payLoad,
    };
