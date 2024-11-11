// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_segments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaSegmentsModelImpl _$$MediaSegmentsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MediaSegmentsModelImpl(
      segments: (json['segments'] as List<dynamic>?)
              ?.map((e) => MediaSegment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MediaSegmentsModelImplToJson(
        _$MediaSegmentsModelImpl instance) =>
    <String, dynamic>{
      'segments': instance.segments,
    };

_$MediaSegmentImpl _$$MediaSegmentImplFromJson(Map<String, dynamic> json) =>
    _$MediaSegmentImpl(
      type: $enumDecode(_$MediaSegmentTypeEnumMap, json['type']),
      start: Duration(microseconds: (json['start'] as num).toInt()),
      end: Duration(microseconds: (json['end'] as num).toInt()),
    );

Map<String, dynamic> _$$MediaSegmentImplToJson(_$MediaSegmentImpl instance) =>
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
