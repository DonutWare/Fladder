import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/util/localization_helper.dart';

part 'home_settings_model.freezed.dart';
part 'home_settings_model.g.dart';

@freezed
class HomeSettingsModel with _$HomeSettingsModel {
  factory HomeSettingsModel({
    @Default(HomeBanner.carousel) HomeBanner homeBanner,
    @Default(HomeCarouselSettings.combined) HomeCarouselSettings carouselSettings,
    @Default(HomeNextUp.separate) HomeNextUp nextUp,
  }) = _HomeSettingsModel;

  factory HomeSettingsModel.fromJson(Map<String, dynamic> json) => _$HomeSettingsModelFromJson(json);
}

enum HomeBanner {
  hide,
  carousel,
  banner;

  const HomeBanner();

  String label(BuildContext context) => switch (this) {
        HomeBanner.hide => context.localized.hide,
        HomeBanner.carousel => context.localized.homeBannerCarousel,
        HomeBanner.banner => context.localized.homeBannerSlideshow,
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
  off,
  nextUp,
  cont,
  combined,
  separate,
  ;

  const HomeNextUp();

  String label(BuildContext context) => switch (this) {
        HomeNextUp.off => context.localized.hide,
        HomeNextUp.nextUp => context.localized.nextUp,
        HomeNextUp.cont => context.localized.settingsContinue,
        HomeNextUp.combined => context.localized.combined,
        HomeNextUp.separate => context.localized.separate,
      };
}
