// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_segments_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MediaSegmentsModel _$MediaSegmentsModelFromJson(Map<String, dynamic> json) {
  return _MediaSegmentsModel.fromJson(json);
}

/// @nodoc
mixin _$MediaSegmentsModel {
  List<MediaSegment> get segments => throw _privateConstructorUsedError;

  /// Serializes this MediaSegmentsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$MediaSegmentsModelImpl extends _MediaSegmentsModel {
  _$MediaSegmentsModelImpl({final List<MediaSegment> segments = const []})
      : _segments = segments,
        super._();

  factory _$MediaSegmentsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaSegmentsModelImplFromJson(json);

  final List<MediaSegment> _segments;
  @override
  @JsonKey()
  List<MediaSegment> get segments {
    if (_segments is EqualUnmodifiableListView) return _segments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

  @override
  String toString() {
    return 'MediaSegmentsModel(segments: $segments)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaSegmentsModelImplToJson(
      this,
    );
  }
}

abstract class _MediaSegmentsModel extends MediaSegmentsModel {
  factory _MediaSegmentsModel({final List<MediaSegment> segments}) =
      _$MediaSegmentsModelImpl;
  _MediaSegmentsModel._() : super._();

  factory _MediaSegmentsModel.fromJson(Map<String, dynamic> json) =
      _$MediaSegmentsModelImpl.fromJson;

  @override
  List<MediaSegment> get segments;
}

MediaSegment _$MediaSegmentFromJson(Map<String, dynamic> json) {
  return _MediaSegment.fromJson(json);
}

/// @nodoc
mixin _$MediaSegment {
  MediaSegmentType get type => throw _privateConstructorUsedError;
  Duration get start => throw _privateConstructorUsedError;
  Duration get end => throw _privateConstructorUsedError;

  /// Serializes this MediaSegment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$MediaSegmentImpl extends _MediaSegment {
  _$MediaSegmentImpl(
      {required this.type, required this.start, required this.end})
      : super._();

  factory _$MediaSegmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaSegmentImplFromJson(json);

  @override
  final MediaSegmentType type;
  @override
  final Duration start;
  @override
  final Duration end;

  @override
  String toString() {
    return 'MediaSegment(type: $type, start: $start, end: $end)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaSegmentImplToJson(
      this,
    );
  }
}

abstract class _MediaSegment extends MediaSegment {
  factory _MediaSegment(
      {required final MediaSegmentType type,
      required final Duration start,
      required final Duration end}) = _$MediaSegmentImpl;
  _MediaSegment._() : super._();

  factory _MediaSegment.fromJson(Map<String, dynamic> json) =
      _$MediaSegmentImpl.fromJson;

  @override
  MediaSegmentType get type;
  @override
  Duration get start;
  @override
  Duration get end;
}
