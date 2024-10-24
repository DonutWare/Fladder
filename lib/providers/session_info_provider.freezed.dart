// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_info_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionInfoModel _$SessionInfoModelFromJson(Map<String, dynamic> json) {
  return _SessionInfoModel.fromJson(json);
}

/// @nodoc
mixin _$SessionInfoModel {
  String? get playbackModel => throw _privateConstructorUsedError;
  TranscodingInfo? get transCodeInfo => throw _privateConstructorUsedError;

  /// Serializes this SessionInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionInfoModelCopyWith<SessionInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionInfoModelCopyWith<$Res> {
  factory $SessionInfoModelCopyWith(
          SessionInfoModel value, $Res Function(SessionInfoModel) then) =
      _$SessionInfoModelCopyWithImpl<$Res, SessionInfoModel>;
  @useResult
  $Res call({String? playbackModel, TranscodingInfo? transCodeInfo});
}

/// @nodoc
class _$SessionInfoModelCopyWithImpl<$Res, $Val extends SessionInfoModel>
    implements $SessionInfoModelCopyWith<$Res> {
  _$SessionInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playbackModel = freezed,
    Object? transCodeInfo = freezed,
  }) {
    return _then(_value.copyWith(
      playbackModel: freezed == playbackModel
          ? _value.playbackModel
          : playbackModel // ignore: cast_nullable_to_non_nullable
              as String?,
      transCodeInfo: freezed == transCodeInfo
          ? _value.transCodeInfo
          : transCodeInfo // ignore: cast_nullable_to_non_nullable
              as TranscodingInfo?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionInfoModelImplCopyWith<$Res>
    implements $SessionInfoModelCopyWith<$Res> {
  factory _$$SessionInfoModelImplCopyWith(_$SessionInfoModelImpl value,
          $Res Function(_$SessionInfoModelImpl) then) =
      __$$SessionInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? playbackModel, TranscodingInfo? transCodeInfo});
}

/// @nodoc
class __$$SessionInfoModelImplCopyWithImpl<$Res>
    extends _$SessionInfoModelCopyWithImpl<$Res, _$SessionInfoModelImpl>
    implements _$$SessionInfoModelImplCopyWith<$Res> {
  __$$SessionInfoModelImplCopyWithImpl(_$SessionInfoModelImpl _value,
      $Res Function(_$SessionInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playbackModel = freezed,
    Object? transCodeInfo = freezed,
  }) {
    return _then(_$SessionInfoModelImpl(
      playbackModel: freezed == playbackModel
          ? _value.playbackModel
          : playbackModel // ignore: cast_nullable_to_non_nullable
              as String?,
      transCodeInfo: freezed == transCodeInfo
          ? _value.transCodeInfo
          : transCodeInfo // ignore: cast_nullable_to_non_nullable
              as TranscodingInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionInfoModelImpl extends _SessionInfoModel {
  _$SessionInfoModelImpl({this.playbackModel, this.transCodeInfo}) : super._();

  factory _$SessionInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionInfoModelImplFromJson(json);

  @override
  final String? playbackModel;
  @override
  final TranscodingInfo? transCodeInfo;

  @override
  String toString() {
    return 'SessionInfoModel(playbackModel: $playbackModel, transCodeInfo: $transCodeInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionInfoModelImpl &&
            (identical(other.playbackModel, playbackModel) ||
                other.playbackModel == playbackModel) &&
            (identical(other.transCodeInfo, transCodeInfo) ||
                other.transCodeInfo == transCodeInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, playbackModel, transCodeInfo);

  /// Create a copy of SessionInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionInfoModelImplCopyWith<_$SessionInfoModelImpl> get copyWith =>
      __$$SessionInfoModelImplCopyWithImpl<_$SessionInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionInfoModelImplToJson(
      this,
    );
  }
}

abstract class _SessionInfoModel extends SessionInfoModel {
  factory _SessionInfoModel(
      {final String? playbackModel,
      final TranscodingInfo? transCodeInfo}) = _$SessionInfoModelImpl;
  _SessionInfoModel._() : super._();

  factory _SessionInfoModel.fromJson(Map<String, dynamic> json) =
      _$SessionInfoModelImpl.fromJson;

  @override
  String? get playbackModel;
  @override
  TranscodingInfo? get transCodeInfo;

  /// Create a copy of SessionInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionInfoModelImplCopyWith<_$SessionInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
