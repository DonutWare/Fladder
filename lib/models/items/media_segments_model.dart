import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;

part 'media_segments_model.freezed.dart';
part 'media_segments_model.g.dart';

@freezed
class MediaSegmentsModel with _$MediaSegmentsModel {
  const MediaSegmentsModel._();

  factory MediaSegmentsModel({
    @Default([]) List<MediaSegment> segments,
  }) = _MediaSegmentsModel;

  factory MediaSegmentsModel.fromJson(Map<String, dynamic> json) => _$MediaSegmentsModelFromJson(json);

  MediaSegment? get intro => segments.firstWhereOrNull((element) => element.type == MediaSegmentType.intro);
  MediaSegment? get outro => segments.firstWhereOrNull((element) => element.type == MediaSegmentType.outro);
}

@freezed
class MediaSegment with _$MediaSegment {
  const MediaSegment._();

  factory MediaSegment({
    required MediaSegmentType type,
    required Duration start,
    required Duration end,
  }) = _MediaSegment;

  factory MediaSegment.fromJson(Map<String, dynamic> json) => _$MediaSegmentFromJson(json);

  bool inRange(Duration position) => (position.compareTo(start) >= 0 && position.compareTo(end) <= 0);
}

enum MediaSegmentType {
  unknown,
  commercial,
  preview,
  recap,
  outro,
  intro;

  Color get color => switch (this) {
        MediaSegmentType.unknown => Colors.black,
        MediaSegmentType.commercial => Colors.purpleAccent,
        MediaSegmentType.preview => Colors.deepOrangeAccent,
        MediaSegmentType.recap => Colors.lightBlueAccent,
        MediaSegmentType.outro => Colors.yellowAccent,
        MediaSegmentType.intro => Colors.greenAccent,
      };

  static MediaSegmentType fromDto(dto.MediaSegmentType? value) {
    return switch (value) {
      dto.MediaSegmentType.swaggerGeneratedUnknown => MediaSegmentType.unknown,
      dto.MediaSegmentType.unknown => MediaSegmentType.unknown,
      dto.MediaSegmentType.commercial => MediaSegmentType.commercial,
      dto.MediaSegmentType.preview => MediaSegmentType.preview,
      dto.MediaSegmentType.recap => MediaSegmentType.recap,
      dto.MediaSegmentType.outro => MediaSegmentType.outro,
      dto.MediaSegmentType.intro => MediaSegmentType.intro,
      null => MediaSegmentType.unknown,
    };
  }
}

extension MediaSegmentExtension on dto.MediaSegmentDto {
  MediaSegment get toSegment => MediaSegment(
        type: MediaSegmentType.fromDto(type),
        start: _durationToMilliseconds(startTicks ?? 0),
        end: _durationToMilliseconds(endTicks ?? 0),
      );
}

Duration _durationToMilliseconds(num milliseconds) => Duration(milliseconds: (milliseconds ~/ 10000));
