// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intro_skip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IntroOutSkipModel _$IntroOutSkipModelFromJson(Map<String, dynamic> json) {
  return _IntroOutSkipModel.fromJson(json);
}

/// @nodoc
mixin _$IntroOutSkipModel {
  IntroSkipModel? get intro => throw _privateConstructorUsedError;
  IntroSkipModel? get credits => throw _privateConstructorUsedError;

  /// Serializes this IntroOutSkipModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntroOutSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntroOutSkipModelCopyWith<IntroOutSkipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntroOutSkipModelCopyWith<$Res> {
  factory $IntroOutSkipModelCopyWith(
          IntroOutSkipModel value, $Res Function(IntroOutSkipModel) then) =
      _$IntroOutSkipModelCopyWithImpl<$Res, IntroOutSkipModel>;
  @useResult
  $Res call({IntroSkipModel? intro, IntroSkipModel? credits});

  $IntroSkipModelCopyWith<$Res>? get intro;
  $IntroSkipModelCopyWith<$Res>? get credits;
}

/// @nodoc
class _$IntroOutSkipModelCopyWithImpl<$Res, $Val extends IntroOutSkipModel>
    implements $IntroOutSkipModelCopyWith<$Res> {
  _$IntroOutSkipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntroOutSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intro = freezed,
    Object? credits = freezed,
  }) {
    return _then(_value.copyWith(
      intro: freezed == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as IntroSkipModel?,
      credits: freezed == credits
          ? _value.credits
          : credits // ignore: cast_nullable_to_non_nullable
              as IntroSkipModel?,
    ) as $Val);
  }

  /// Create a copy of IntroOutSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntroSkipModelCopyWith<$Res>? get intro {
    if (_value.intro == null) {
      return null;
    }

    return $IntroSkipModelCopyWith<$Res>(_value.intro!, (value) {
      return _then(_value.copyWith(intro: value) as $Val);
    });
  }

  /// Create a copy of IntroOutSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntroSkipModelCopyWith<$Res>? get credits {
    if (_value.credits == null) {
      return null;
    }

    return $IntroSkipModelCopyWith<$Res>(_value.credits!, (value) {
      return _then(_value.copyWith(credits: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IntroOutSkipModelImplCopyWith<$Res>
    implements $IntroOutSkipModelCopyWith<$Res> {
  factory _$$IntroOutSkipModelImplCopyWith(_$IntroOutSkipModelImpl value,
          $Res Function(_$IntroOutSkipModelImpl) then) =
      __$$IntroOutSkipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IntroSkipModel? intro, IntroSkipModel? credits});

  @override
  $IntroSkipModelCopyWith<$Res>? get intro;
  @override
  $IntroSkipModelCopyWith<$Res>? get credits;
}

/// @nodoc
class __$$IntroOutSkipModelImplCopyWithImpl<$Res>
    extends _$IntroOutSkipModelCopyWithImpl<$Res, _$IntroOutSkipModelImpl>
    implements _$$IntroOutSkipModelImplCopyWith<$Res> {
  __$$IntroOutSkipModelImplCopyWithImpl(_$IntroOutSkipModelImpl _value,
      $Res Function(_$IntroOutSkipModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntroOutSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intro = freezed,
    Object? credits = freezed,
  }) {
    return _then(_$IntroOutSkipModelImpl(
      intro: freezed == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as IntroSkipModel?,
      credits: freezed == credits
          ? _value.credits
          : credits // ignore: cast_nullable_to_non_nullable
              as IntroSkipModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntroOutSkipModelImpl extends _IntroOutSkipModel {
  _$IntroOutSkipModelImpl({this.intro, this.credits}) : super._();

  factory _$IntroOutSkipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntroOutSkipModelImplFromJson(json);

  @override
  final IntroSkipModel? intro;
  @override
  final IntroSkipModel? credits;

  @override
  String toString() {
    return 'IntroOutSkipModel(intro: $intro, credits: $credits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntroOutSkipModelImpl &&
            (identical(other.intro, intro) || other.intro == intro) &&
            (identical(other.credits, credits) || other.credits == credits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, intro, credits);

  /// Create a copy of IntroOutSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntroOutSkipModelImplCopyWith<_$IntroOutSkipModelImpl> get copyWith =>
      __$$IntroOutSkipModelImplCopyWithImpl<_$IntroOutSkipModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntroOutSkipModelImplToJson(
      this,
    );
  }
}

abstract class _IntroOutSkipModel extends IntroOutSkipModel {
  factory _IntroOutSkipModel(
      {final IntroSkipModel? intro,
      final IntroSkipModel? credits}) = _$IntroOutSkipModelImpl;
  _IntroOutSkipModel._() : super._();

  factory _IntroOutSkipModel.fromJson(Map<String, dynamic> json) =
      _$IntroOutSkipModelImpl.fromJson;

  @override
  IntroSkipModel? get intro;
  @override
  IntroSkipModel? get credits;

  /// Create a copy of IntroOutSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntroOutSkipModelImplCopyWith<_$IntroOutSkipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntroSkipModel _$IntroSkipModelFromJson(Map<String, dynamic> json) {
  return _IntroSkipModel.fromJson(json);
}

/// @nodoc
mixin _$IntroSkipModel {
  @JsonKey(name: "EpisodeId")
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "Valid")
  bool get valid => throw _privateConstructorUsedError;
  @JsonKey(
      name: "IntroStart",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration get start => throw _privateConstructorUsedError;
  @JsonKey(
      name: "IntroEnd",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration get end => throw _privateConstructorUsedError;
  @JsonKey(
      name: "ShowSkipPromptAt",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration get showTime => throw _privateConstructorUsedError;
  @JsonKey(
      name: "HideSkipPromptAt",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration get hideTime => throw _privateConstructorUsedError;

  /// Serializes this IntroSkipModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntroSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntroSkipModelCopyWith<IntroSkipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntroSkipModelCopyWith<$Res> {
  factory $IntroSkipModelCopyWith(
          IntroSkipModel value, $Res Function(IntroSkipModel) then) =
      _$IntroSkipModelCopyWithImpl<$Res, IntroSkipModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "EpisodeId") String id,
      @JsonKey(name: "Valid") bool valid,
      @JsonKey(
          name: "IntroStart",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      Duration start,
      @JsonKey(
          name: "IntroEnd",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      Duration end,
      @JsonKey(
          name: "ShowSkipPromptAt",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      Duration showTime,
      @JsonKey(
          name: "HideSkipPromptAt",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      Duration hideTime});
}

/// @nodoc
class _$IntroSkipModelCopyWithImpl<$Res, $Val extends IntroSkipModel>
    implements $IntroSkipModelCopyWith<$Res> {
  _$IntroSkipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntroSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? valid = null,
    Object? start = null,
    Object? end = null,
    Object? showTime = null,
    Object? hideTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Duration,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Duration,
      showTime: null == showTime
          ? _value.showTime
          : showTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      hideTime: null == hideTime
          ? _value.hideTime
          : hideTime // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntroSkipModelImplCopyWith<$Res>
    implements $IntroSkipModelCopyWith<$Res> {
  factory _$$IntroSkipModelImplCopyWith(_$IntroSkipModelImpl value,
          $Res Function(_$IntroSkipModelImpl) then) =
      __$$IntroSkipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "EpisodeId") String id,
      @JsonKey(name: "Valid") bool valid,
      @JsonKey(
          name: "IntroStart",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      Duration start,
      @JsonKey(
          name: "IntroEnd",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      Duration end,
      @JsonKey(
          name: "ShowSkipPromptAt",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      Duration showTime,
      @JsonKey(
          name: "HideSkipPromptAt",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      Duration hideTime});
}

/// @nodoc
class __$$IntroSkipModelImplCopyWithImpl<$Res>
    extends _$IntroSkipModelCopyWithImpl<$Res, _$IntroSkipModelImpl>
    implements _$$IntroSkipModelImplCopyWith<$Res> {
  __$$IntroSkipModelImplCopyWithImpl(
      _$IntroSkipModelImpl _value, $Res Function(_$IntroSkipModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntroSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? valid = null,
    Object? start = null,
    Object? end = null,
    Object? showTime = null,
    Object? hideTime = null,
  }) {
    return _then(_$IntroSkipModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Duration,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Duration,
      showTime: null == showTime
          ? _value.showTime
          : showTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      hideTime: null == hideTime
          ? _value.hideTime
          : hideTime // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntroSkipModelImpl implements _IntroSkipModel {
  _$IntroSkipModelImpl(
      {@JsonKey(name: "EpisodeId") required this.id,
      @JsonKey(name: "Valid") required this.valid,
      @JsonKey(
          name: "IntroStart",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      required this.start,
      @JsonKey(
          name: "IntroEnd",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      required this.end,
      @JsonKey(
          name: "ShowSkipPromptAt",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      required this.showTime,
      @JsonKey(
          name: "HideSkipPromptAt",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      required this.hideTime});

  factory _$IntroSkipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntroSkipModelImplFromJson(json);

  @override
  @JsonKey(name: "EpisodeId")
  final String id;
  @override
  @JsonKey(name: "Valid")
  final bool valid;
  @override
  @JsonKey(
      name: "IntroStart",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  final Duration start;
  @override
  @JsonKey(
      name: "IntroEnd",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  final Duration end;
  @override
  @JsonKey(
      name: "ShowSkipPromptAt",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  final Duration showTime;
  @override
  @JsonKey(
      name: "HideSkipPromptAt",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  final Duration hideTime;

  @override
  String toString() {
    return 'IntroSkipModel(id: $id, valid: $valid, start: $start, end: $end, showTime: $showTime, hideTime: $hideTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntroSkipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.valid, valid) || other.valid == valid) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.showTime, showTime) ||
                other.showTime == showTime) &&
            (identical(other.hideTime, hideTime) ||
                other.hideTime == hideTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, valid, start, end, showTime, hideTime);

  /// Create a copy of IntroSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntroSkipModelImplCopyWith<_$IntroSkipModelImpl> get copyWith =>
      __$$IntroSkipModelImplCopyWithImpl<_$IntroSkipModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntroSkipModelImplToJson(
      this,
    );
  }
}

abstract class _IntroSkipModel implements IntroSkipModel {
  factory _IntroSkipModel(
      {@JsonKey(name: "EpisodeId") required final String id,
      @JsonKey(name: "Valid") required final bool valid,
      @JsonKey(
          name: "IntroStart",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      required final Duration start,
      @JsonKey(
          name: "IntroEnd",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      required final Duration end,
      @JsonKey(
          name: "ShowSkipPromptAt",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      required final Duration showTime,
      @JsonKey(
          name: "HideSkipPromptAt",
          fromJson: _durationFromMilliseconds,
          toJson: _durationToMilliseconds)
      required final Duration hideTime}) = _$IntroSkipModelImpl;

  factory _IntroSkipModel.fromJson(Map<String, dynamic> json) =
      _$IntroSkipModelImpl.fromJson;

  @override
  @JsonKey(name: "EpisodeId")
  String get id;
  @override
  @JsonKey(name: "Valid")
  bool get valid;
  @override
  @JsonKey(
      name: "IntroStart",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration get start;
  @override
  @JsonKey(
      name: "IntroEnd",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration get end;
  @override
  @JsonKey(
      name: "ShowSkipPromptAt",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration get showTime;
  @override
  @JsonKey(
      name: "HideSkipPromptAt",
      fromJson: _durationFromMilliseconds,
      toJson: _durationToMilliseconds)
  Duration get hideTime;

  /// Create a copy of IntroSkipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntroSkipModelImplCopyWith<_$IntroSkipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
