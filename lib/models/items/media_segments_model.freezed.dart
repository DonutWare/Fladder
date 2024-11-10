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

  /// Create a copy of MediaSegmentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaSegmentsModelCopyWith<MediaSegmentsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaSegmentsModelCopyWith<$Res> {
  factory $MediaSegmentsModelCopyWith(
          MediaSegmentsModel value, $Res Function(MediaSegmentsModel) then) =
      _$MediaSegmentsModelCopyWithImpl<$Res, MediaSegmentsModel>;
  @useResult
  $Res call({List<MediaSegment> segments});
}

/// @nodoc
class _$MediaSegmentsModelCopyWithImpl<$Res, $Val extends MediaSegmentsModel>
    implements $MediaSegmentsModelCopyWith<$Res> {
  _$MediaSegmentsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaSegmentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? segments = null,
  }) {
    return _then(_value.copyWith(
      segments: null == segments
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<MediaSegment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaSegmentsModelImplCopyWith<$Res>
    implements $MediaSegmentsModelCopyWith<$Res> {
  factory _$$MediaSegmentsModelImplCopyWith(_$MediaSegmentsModelImpl value,
          $Res Function(_$MediaSegmentsModelImpl) then) =
      __$$MediaSegmentsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MediaSegment> segments});
}

/// @nodoc
class __$$MediaSegmentsModelImplCopyWithImpl<$Res>
    extends _$MediaSegmentsModelCopyWithImpl<$Res, _$MediaSegmentsModelImpl>
    implements _$$MediaSegmentsModelImplCopyWith<$Res> {
  __$$MediaSegmentsModelImplCopyWithImpl(_$MediaSegmentsModelImpl _value,
      $Res Function(_$MediaSegmentsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaSegmentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? segments = null,
  }) {
    return _then(_$MediaSegmentsModelImpl(
      segments: null == segments
          ? _value._segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<MediaSegment>,
    ));
  }
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaSegmentsModelImpl &&
            const DeepCollectionEquality().equals(other._segments, _segments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_segments));

  /// Create a copy of MediaSegmentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaSegmentsModelImplCopyWith<_$MediaSegmentsModelImpl> get copyWith =>
      __$$MediaSegmentsModelImplCopyWithImpl<_$MediaSegmentsModelImpl>(
          this, _$identity);

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

  /// Create a copy of MediaSegmentsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaSegmentsModelImplCopyWith<_$MediaSegmentsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
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

  /// Create a copy of MediaSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaSegmentCopyWith<MediaSegment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaSegmentCopyWith<$Res> {
  factory $MediaSegmentCopyWith(
          MediaSegment value, $Res Function(MediaSegment) then) =
      _$MediaSegmentCopyWithImpl<$Res, MediaSegment>;
  @useResult
  $Res call({MediaSegmentType type, Duration start, Duration end});
}

/// @nodoc
class _$MediaSegmentCopyWithImpl<$Res, $Val extends MediaSegment>
    implements $MediaSegmentCopyWith<$Res> {
  _$MediaSegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MediaSegmentType,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Duration,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaSegmentImplCopyWith<$Res>
    implements $MediaSegmentCopyWith<$Res> {
  factory _$$MediaSegmentImplCopyWith(
          _$MediaSegmentImpl value, $Res Function(_$MediaSegmentImpl) then) =
      __$$MediaSegmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MediaSegmentType type, Duration start, Duration end});
}

/// @nodoc
class __$$MediaSegmentImplCopyWithImpl<$Res>
    extends _$MediaSegmentCopyWithImpl<$Res, _$MediaSegmentImpl>
    implements _$$MediaSegmentImplCopyWith<$Res> {
  __$$MediaSegmentImplCopyWithImpl(
      _$MediaSegmentImpl _value, $Res Function(_$MediaSegmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$MediaSegmentImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MediaSegmentType,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Duration,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaSegmentImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, start, end);

  /// Create a copy of MediaSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaSegmentImplCopyWith<_$MediaSegmentImpl> get copyWith =>
      __$$MediaSegmentImplCopyWithImpl<_$MediaSegmentImpl>(this, _$identity);

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

  /// Create a copy of MediaSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaSegmentImplCopyWith<_$MediaSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
