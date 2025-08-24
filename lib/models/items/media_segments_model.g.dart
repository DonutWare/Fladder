// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_segments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MediaSegmentsModel _$MediaSegmentsModelFromJson(Map<String, dynamic> json) =>
    _MediaSegmentsModel(
      segments: (json['segments'] as List<dynamic>?)
              ?.map((e) => MediaSegment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MediaSegmentsModelToJson(_MediaSegmentsModel instance) =>
    <String, dynamic>{
      'segments': instance.segments,
    };

_MediaSegment _$MediaSegmentFromJson(Map<String, dynamic> json) =>
    _MediaSegment(
      type: $enumDecode(_$MediaSegmentTypeEnumMap, json['type']),
      start: Duration(microseconds: (json['start'] as num).toInt()),
      end: Duration(microseconds: (json['end'] as num).toInt()),
    );

Map<String, dynamic> _$MediaSegmentToJson(_MediaSegment instance) =>
    <String, dynamic>{
      'type': _$MediaSegmentTypeEnumMap[instance.type]!,
      'start': instance.start.inMicroseconds,
      'end': instance.end.inMicroseconds,
    };

const _$MediaSegmentTypeEnumMap = {
  MediaSegmentType.unknown: 'unknown',
  MediaSegmentType.commercial: 'commercial',
  MediaSegmentType.preview: 'preview',
  MediaSegmentType.recap: 'recap',
  MediaSegmentType.outro: 'outro',
  MediaSegmentType.intro: 'intro',
};
