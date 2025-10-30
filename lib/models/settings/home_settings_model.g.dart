// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeSettingsModel _$HomeSettingsModelFromJson(Map<String, dynamic> json) =>
    _HomeSettingsModel(
      screenLayouts: (json['screenLayouts'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$LayoutModeEnumMap, e))
              .toSet() ??
          const {...LayoutMode.values},
      layoutStates: (json['layoutStates'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ViewSizeEnumMap, e))
              .toSet() ??
          const {...ViewSize.values},
      homeBanner:
          $enumDecodeNullable(_$HomeBannerEnumMap, json['homeBanner']) ??
              HomeBanner.carousel,
      carouselSettings: $enumDecodeNullable(
              _$HomeCarouselSettingsEnumMap, json['carouselSettings']) ??
          HomeCarouselSettings.combined,
      nextUp: $enumDecodeNullable(_$HomeNextUpEnumMap, json['nextUp']) ??
          HomeNextUp.separate,
    );

Map<String, dynamic> _$HomeSettingsModelToJson(_HomeSettingsModel instance) =>
    <String, dynamic>{
      'screenLayouts':
          instance.screenLayouts.map((e) => _$LayoutModeEnumMap[e]!).toList(),
      'layoutStates':
          instance.layoutStates.map((e) => _$ViewSizeEnumMap[e]!).toList(),
      'homeBanner': _$HomeBannerEnumMap[instance.homeBanner]!,
      'carouselSettings':
          _$HomeCarouselSettingsEnumMap[instance.carouselSettings]!,
      'nextUp': _$HomeNextUpEnumMap[instance.nextUp]!,
    };

const _$LayoutModeEnumMap = {
  LayoutMode.single: 'single',
  LayoutMode.dual: 'dual',
};

const _$ViewSizeEnumMap = {
  ViewSize.phone: 'phone',
  ViewSize.tablet: 'tablet',
  ViewSize.desktop: 'desktop',
  ViewSize.television: 'television',
};

const _$HomeBannerEnumMap = {
  HomeBanner.hide: 'hide',
  HomeBanner.carousel: 'carousel',
  HomeBanner.banner: 'banner',
  HomeBanner.detailedBanner: 'detailedBanner',
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
