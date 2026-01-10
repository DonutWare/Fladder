// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_tv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveTvModel _$LiveTvModelFromJson(Map<String, dynamic> json) => _LiveTvModel(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$LiveTvModelToJson(_LiveTvModel instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
