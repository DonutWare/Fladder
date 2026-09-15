// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';

part 'home_settings_model.freezed.dart';
part 'home_settings_model.g.dart';

@Freezed(copyWith: true)
abstract class HomeSettingsModel with _$HomeSettingsModel {
  const HomeSettingsModel._();

  factory HomeSettingsModel({
    @Default({...LayoutMode.values}) Set<LayoutMode> screenLayouts,
    @Default({...ViewSize.values}) Set<ViewSize> layoutStates,
    @Default(HomeBanner.carousel) HomeBanner homeBanner,
    @Default(HomeCarouselSettings.combined) HomeCarouselSettings carouselSettings,
    @JsonKey(unknownEnumValue: HomeNextUp.separate) @Default(HomeNextUp.separate) HomeNextUp nextUp,
  }) = _HomeSettingsModel;

  static HomeSettingsModel defaultModel() {
    return HomeSettingsModel(
      homeBanner: leanBackMode ? HomeBanner.tvSliderBanner : HomeBanner.carousel,
    );
  }

  factory HomeSettingsModel.fromJson(Map<String, dynamic> json) => _$HomeSettingsModelFromJson(json);
}

T selectAvailableOrSmaller<T>(T value, Set<T> availableOptions, List<T> allOptions) {
  if (availableOptions.contains(value)) {
    return value;
  }

  int index = allOptions.indexOf(value);

  for (int i = index - 1; i >= 0; i--) {
    if (availableOptions.contains(allOptions[i])) {
      return allOptions[i];
    }
  }

  return availableOptions.first;
}

enum HomeBanner {
  hide,
  carousel,
  banner,
  detailedBanner,
  tvSliderBanner;

  const HomeBanner();

  String label(BuildContext context) => switch (this) {
        HomeBanner.hide => context.localized.hide,
        HomeBanner.carousel => context.localized.homeBannerCarousel,
        HomeBanner.banner => context.localized.homeBannerSlideshow,
        HomeBanner.detailedBanner => context.localized.homeBannerDetailed,
        HomeBanner.tvSliderBanner => context.localized.homeBannerTV,
      };
}

enum HomeCarouselSettings {
  nextUp,
  cont,
  combined,
  ;

  const HomeCarouselSettings();

  String label(BuildContext context) => switch (this) {
        HomeCarouselSettings.nextUp => context.localized.nextUp,
        HomeCarouselSettings.cont => context.localized.settingsContinue,
        HomeCarouselSettings.combined => context.localized.combined,
      };
}

enum HomeNextUp {
  nextUp,
  cont,
  combined,
  separate,
  ;

  const HomeNextUp();

  String label(BuildContext context) => switch (this) {
        HomeNextUp.nextUp => context.localized.nextUp,
        HomeNextUp.cont => context.localized.settingsContinue,
        HomeNextUp.combined => context.localized.combined,
        HomeNextUp.separate => context.localized.separate,
      };
}

enum DashboardSorting {
  liveTV,
  nextUp,
  libraries,
  filters;

  const DashboardSorting();

  static Map<DashboardSorting, bool> get defaultSorting => {
        for (final sorting in DashboardSorting.values) sorting: false,
      };

  String label(BuildContext context) => switch (this) {
        DashboardSorting.liveTV => context.localized.liveTV,
        DashboardSorting.nextUp => context.localized.nextUp,
        DashboardSorting.libraries => context.localized.library(2),
        DashboardSorting.filters => context.localized.filter(2),
      };
}
