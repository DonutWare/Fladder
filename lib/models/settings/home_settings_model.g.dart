// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeSettingsModelImpl _$$HomeSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeSettingsModelImpl(
      homeBanner:
          $enumDecodeNullable(_$HomeBannerEnumMap, json['homeBanner']) ??
              HomeBanner.carousel,
      carouselSettings: $enumDecodeNullable(
              _$HomeCarouselSettingsEnumMap, json['carouselSettings']) ??
          HomeCarouselSettings.combined,
      nextUp: $enumDecodeNullable(_$HomeNextUpEnumMap, json['nextUp']) ??
          HomeNextUp.separate,
    );

Map<String, dynamic> _$$HomeSettingsModelImplToJson(
        _$HomeSettingsModelImpl instance) =>
    <String, dynamic>{
      'homeBanner': _$HomeBannerEnumMap[instance.homeBanner]!,
      'carouselSettings':
          _$HomeCarouselSettingsEnumMap[instance.carouselSettings]!,
      'nextUp': _$HomeNextUpEnumMap[instance.nextUp]!,
    };

const _$HomeBannerEnumMap = {
  HomeBanner.hide: 'hide',
  HomeBanner.carousel: 'carousel',
  HomeBanner.banner: 'banner',
};

const _$HomeCarouselSettingsEnumMap = {
  HomeCarouselSettings.nextUp: 'nextUp',
  HomeCarouselSettings.cont: 'cont',
  HomeCarouselSettings.combined: 'combined',
};

const _$HomeNextUpEnumMap = {
  HomeNextUp.off: 'off',
  HomeNextUp.nextUp: 'nextUp',
  HomeNextUp.cont: 'cont',
  HomeNextUp.combined: 'combined',
  HomeNextUp.separate: 'separate',
};
