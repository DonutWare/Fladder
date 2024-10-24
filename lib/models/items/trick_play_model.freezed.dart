// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trick_play_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrickPlayModel _$TrickPlayModelFromJson(Map<String, dynamic> json) {
  return _TrickPlayModel.fromJson(json);
}

/// @nodoc
mixin _$TrickPlayModel {
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  int get tileWidth => throw _privateConstructorUsedError;
  int get tileHeight => throw _privateConstructorUsedError;
  int get thumbnailCount => throw _privateConstructorUsedError;
  Duration get interval => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;

  /// Serializes this TrickPlayModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrickPlayModelCopyWith<TrickPlayModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrickPlayModelCopyWith<$Res> {
  factory $TrickPlayModelCopyWith(
          TrickPlayModel value, $Res Function(TrickPlayModel) then) =
      _$TrickPlayModelCopyWithImpl<$Res, TrickPlayModel>;
  @useResult
  $Res call(
      {int width,
      int height,
      int tileWidth,
      int tileHeight,
      int thumbnailCount,
      Duration interval,
      List<String> images});
}

/// @nodoc
class _$TrickPlayModelCopyWithImpl<$Res, $Val extends TrickPlayModel>
    implements $TrickPlayModelCopyWith<$Res> {
  _$TrickPlayModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? tileWidth = null,
    Object? tileHeight = null,
    Object? thumbnailCount = null,
    Object? interval = null,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      tileWidth: null == tileWidth
          ? _value.tileWidth
          : tileWidth // ignore: cast_nullable_to_non_nullable
              as int,
      tileHeight: null == tileHeight
          ? _value.tileHeight
          : tileHeight // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailCount: null == thumbnailCount
          ? _value.thumbnailCount
          : thumbnailCount // ignore: cast_nullable_to_non_nullable
              as int,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrickPlayModelImplCopyWith<$Res>
    implements $TrickPlayModelCopyWith<$Res> {
  factory _$$TrickPlayModelImplCopyWith(_$TrickPlayModelImpl value,
          $Res Function(_$TrickPlayModelImpl) then) =
      __$$TrickPlayModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int width,
      int height,
      int tileWidth,
      int tileHeight,
      int thumbnailCount,
      Duration interval,
      List<String> images});
}

/// @nodoc
class __$$TrickPlayModelImplCopyWithImpl<$Res>
    extends _$TrickPlayModelCopyWithImpl<$Res, _$TrickPlayModelImpl>
    implements _$$TrickPlayModelImplCopyWith<$Res> {
  __$$TrickPlayModelImplCopyWithImpl(
      _$TrickPlayModelImpl _value, $Res Function(_$TrickPlayModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? tileWidth = null,
    Object? tileHeight = null,
    Object? thumbnailCount = null,
    Object? interval = null,
    Object? images = null,
  }) {
    return _then(_$TrickPlayModelImpl(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      tileWidth: null == tileWidth
          ? _value.tileWidth
          : tileWidth // ignore: cast_nullable_to_non_nullable
              as int,
      tileHeight: null == tileHeight
          ? _value.tileHeight
          : tileHeight // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailCount: null == thumbnailCount
          ? _value.thumbnailCount
          : thumbnailCount // ignore: cast_nullable_to_non_nullable
              as int,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrickPlayModelImpl extends _TrickPlayModel {
  _$TrickPlayModelImpl(
      {required this.width,
      required this.height,
      required this.tileWidth,
      required this.tileHeight,
      required this.thumbnailCount,
      required this.interval,
      final List<String> images = const []})
      : _images = images,
        super._();

  factory _$TrickPlayModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrickPlayModelImplFromJson(json);

  @override
  final int width;
  @override
  final int height;
  @override
  final int tileWidth;
  @override
  final int tileHeight;
  @override
  final int thumbnailCount;
  @override
  final Duration interval;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'TrickPlayModel(width: $width, height: $height, tileWidth: $tileWidth, tileHeight: $tileHeight, thumbnailCount: $thumbnailCount, interval: $interval, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrickPlayModelImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.tileWidth, tileWidth) ||
                other.tileWidth == tileWidth) &&
            (identical(other.tileHeight, tileHeight) ||
                other.tileHeight == tileHeight) &&
            (identical(other.thumbnailCount, thumbnailCount) ||
                other.thumbnailCount == thumbnailCount) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      width,
      height,
      tileWidth,
      tileHeight,
      thumbnailCount,
      interval,
      const DeepCollectionEquality().hash(_images));

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrickPlayModelImplCopyWith<_$TrickPlayModelImpl> get copyWith =>
      __$$TrickPlayModelImplCopyWithImpl<_$TrickPlayModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrickPlayModelImplToJson(
      this,
    );
  }
}

abstract class _TrickPlayModel extends TrickPlayModel {
  factory _TrickPlayModel(
      {required final int width,
      required final int height,
      required final int tileWidth,
      required final int tileHeight,
      required final int thumbnailCount,
      required final Duration interval,
      final List<String> images}) = _$TrickPlayModelImpl;
  _TrickPlayModel._() : super._();

  factory _TrickPlayModel.fromJson(Map<String, dynamic> json) =
      _$TrickPlayModelImpl.fromJson;

  @override
  int get width;
  @override
  int get height;
  @override
  int get tileWidth;
  @override
  int get tileHeight;
  @override
  int get thumbnailCount;
  @override
  Duration get interval;
  @override
  List<String> get images;

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrickPlayModelImplCopyWith<_$TrickPlayModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
