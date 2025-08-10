import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/extensions/duration.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/util/localization_helper.dart';

part 'media_segments_model.freezed.dart';
part 'media_segments_model.g.dart';

@freezed
abstract class MediaSegmentsModel with _$MediaSegmentsModel {
  const MediaSegmentsModel._();

  factory MediaSegmentsModel({
    @Default([]) List<MediaSegment> segments,
  }) = _MediaSegmentsModel;

  factory MediaSegmentsModel.fromJson(Map<String, dynamic> json) => _$MediaSegmentsModelFromJson(json);

  MediaSegment? atPosition(Duration position) => segments.firstWhereOrNull((element) => element.inRange(position));

  MediaSegment? get intro => segments.firstWhereOrNull((element) => element.type == MediaSegmentType.intro);
  MediaSegment? get outro => segments.firstWhereOrNull((element) => element.type == MediaSegmentType.outro);
}

@freezed
abstract class MediaSegment with _$MediaSegment {
  const MediaSegment._();

  factory MediaSegment({
    required MediaSegmentType type,
    required Duration start,
    required Duration end,
  }) = _MediaSegment;

  factory MediaSegment.fromJson(Map<String, dynamic> json) => _$MediaSegmentFromJson(json);

  bool inRange(Duration position) => (position.compareTo(start) >= 0 && position.compareTo(end) <= 0);

  SegmentVisibility visibility(Duration position, {bool force = false}) {
    if (force) return SegmentVisibility.visible;
    var difference = (position - start);
    if (difference > const Duration(minutes: 1, seconds: 30)) return SegmentVisibility.hidden;
    Duration clamp = ((end - start) * 0.20).clamp(Duration.zero, const Duration(minutes: 1));
    return difference < clamp ? SegmentVisibility.visible : SegmentVisibility.partially;
  }
}

enum SegmentVisibility {
  hidden,
  partially,
  visible;
}

const Map<MediaSegmentType, SegmentSkip> defaultSegmentSkipValues = {
  MediaSegmentType.commercial: SegmentSkip.askToSkip,
  MediaSegmentType.preview: SegmentSkip.askToSkip,
  MediaSegmentType.recap: SegmentSkip.askToSkip,
  MediaSegmentType.outro: SegmentSkip.askToSkip,
  MediaSegmentType.intro: SegmentSkip.askToSkip,
};

enum SegmentSkip {
  none,
  askToSkip,
  skip;

  const SegmentSkip();

  String label(BuildContext context) => switch (this) {
        SegmentSkip.none => context.localized.segmentActionNone,
        SegmentSkip.askToSkip => context.localized.segmentActionAskToSkip,
        SegmentSkip.skip => context.localized.segmentActionSkip,
      };
}

enum MediaSegmentType {
  unknown,
  commercial,
  preview,
  recap,
  outro,
  intro;

  String label(BuildContext context) {
    return switch (this) {
      MediaSegmentType.unknown => context.localized.mediaSegmentUnknown,
      MediaSegmentType.commercial => context.localized.mediaSegmentCommercial,
      MediaSegmentType.preview => context.localized.mediaSegmentPreview,
      MediaSegmentType.recap => context.localized.mediaSegmentRecap,
      MediaSegmentType.outro => context.localized.mediaSegmentOutro,
      MediaSegmentType.intro => context.localized.mediaSegmentIntro,
    };
  }

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
