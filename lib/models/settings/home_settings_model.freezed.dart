// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeSettingsModel _$HomeSettingsModelFromJson(Map<String, dynamic> json) {
  return _HomeSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$HomeSettingsModel {
  HomeBanner get homeBanner => throw _privateConstructorUsedError;
  HomeCarouselSettings get carouselSettings =>
      throw _privateConstructorUsedError;
  HomeNextUp get nextUp => throw _privateConstructorUsedError;

  /// Serializes this HomeSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeSettingsModelCopyWith<HomeSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeSettingsModelCopyWith<$Res> {
  factory $HomeSettingsModelCopyWith(
          HomeSettingsModel value, $Res Function(HomeSettingsModel) then) =
      _$HomeSettingsModelCopyWithImpl<$Res, HomeSettingsModel>;
  @useResult
  $Res call(
      {HomeBanner homeBanner,
      HomeCarouselSettings carouselSettings,
      HomeNextUp nextUp});
}

/// @nodoc
class _$HomeSettingsModelCopyWithImpl<$Res, $Val extends HomeSettingsModel>
    implements $HomeSettingsModelCopyWith<$Res> {
  _$HomeSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeBanner = null,
    Object? carouselSettings = null,
    Object? nextUp = null,
  }) {
    return _then(_value.copyWith(
      homeBanner: null == homeBanner
          ? _value.homeBanner
          : homeBanner // ignore: cast_nullable_to_non_nullable
              as HomeBanner,
      carouselSettings: null == carouselSettings
          ? _value.carouselSettings
          : carouselSettings // ignore: cast_nullable_to_non_nullable
              as HomeCarouselSettings,
      nextUp: null == nextUp
          ? _value.nextUp
          : nextUp // ignore: cast_nullable_to_non_nullable
              as HomeNextUp,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeSettingsModelImplCopyWith<$Res>
    implements $HomeSettingsModelCopyWith<$Res> {
  factory _$$HomeSettingsModelImplCopyWith(_$HomeSettingsModelImpl value,
          $Res Function(_$HomeSettingsModelImpl) then) =
      __$$HomeSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HomeBanner homeBanner,
      HomeCarouselSettings carouselSettings,
      HomeNextUp nextUp});
}

/// @nodoc
class __$$HomeSettingsModelImplCopyWithImpl<$Res>
    extends _$HomeSettingsModelCopyWithImpl<$Res, _$HomeSettingsModelImpl>
    implements _$$HomeSettingsModelImplCopyWith<$Res> {
  __$$HomeSettingsModelImplCopyWithImpl(_$HomeSettingsModelImpl _value,
      $Res Function(_$HomeSettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeBanner = null,
    Object? carouselSettings = null,
    Object? nextUp = null,
  }) {
    return _then(_$HomeSettingsModelImpl(
      homeBanner: null == homeBanner
          ? _value.homeBanner
          : homeBanner // ignore: cast_nullable_to_non_nullable
              as HomeBanner,
      carouselSettings: null == carouselSettings
          ? _value.carouselSettings
          : carouselSettings // ignore: cast_nullable_to_non_nullable
              as HomeCarouselSettings,
      nextUp: null == nextUp
          ? _value.nextUp
          : nextUp // ignore: cast_nullable_to_non_nullable
              as HomeNextUp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeSettingsModelImpl implements _HomeSettingsModel {
  _$HomeSettingsModelImpl(
      {this.homeBanner = HomeBanner.carousel,
      this.carouselSettings = HomeCarouselSettings.combined,
      this.nextUp = HomeNextUp.separate});

  factory _$HomeSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeSettingsModelImplFromJson(json);

  @override
  @JsonKey()
  final HomeBanner homeBanner;
  @override
  @JsonKey()
  final HomeCarouselSettings carouselSettings;
  @override
  @JsonKey()
  final HomeNextUp nextUp;

  @override
  String toString() {
    return 'HomeSettingsModel(homeBanner: $homeBanner, carouselSettings: $carouselSettings, nextUp: $nextUp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeSettingsModelImpl &&
            (identical(other.homeBanner, homeBanner) ||
                other.homeBanner == homeBanner) &&
            (identical(other.carouselSettings, carouselSettings) ||
                other.carouselSettings == carouselSettings) &&
            (identical(other.nextUp, nextUp) || other.nextUp == nextUp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, homeBanner, carouselSettings, nextUp);

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeSettingsModelImplCopyWith<_$HomeSettingsModelImpl> get copyWith =>
      __$$HomeSettingsModelImplCopyWithImpl<_$HomeSettingsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _HomeSettingsModel implements HomeSettingsModel {
  factory _HomeSettingsModel(
      {final HomeBanner homeBanner,
      final HomeCarouselSettings carouselSettings,
      final HomeNextUp nextUp}) = _$HomeSettingsModelImpl;

  factory _HomeSettingsModel.fromJson(Map<String, dynamic> json) =
      _$HomeSettingsModelImpl.fromJson;

  @override
  HomeBanner get homeBanner;
  @override
  HomeCarouselSettings get carouselSettings;
  @override
  HomeNextUp get nextUp;

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeSettingsModelImplCopyWith<_$HomeSettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
