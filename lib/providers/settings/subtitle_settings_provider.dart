import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/src/video_player_helper.g.dart' as pigeon;

final subtitleSettingsProvider = StateNotifierProvider<SubtitleSettingsNotifier, SubtitleSettingsModel>((ref) {
  return SubtitleSettingsNotifier(ref);
});

class SubtitleSettingsNotifier extends StateNotifier<SubtitleSettingsModel> {
  SubtitleSettingsNotifier(this.ref) : super(const SubtitleSettingsModel());

  final Ref ref;

  @override
  set state(SubtitleSettingsModel value) {
    super.state = value;
    ref.read(sharedUtilityProvider).subtitleSettings = value;
    if (!kIsWeb && Platform.isAndroid) {
      pigeon.VideoPlayerApi().setSubtitleSettings(
        pigeon.SubtitleSettings(
          fontSize: state.fontSize,
          fontWeight: state.fontWeight.value.toInt(),
          verticalOffset: state.verticalOffset,
          color: state.color.toARGB32(),
          outlineColor: state.outlineColor.toARGB32(),
          outlineSize: state.outlineSize,
          backgroundColor: state.backGroundColor.toARGB32(),
          shadow: state.shadow,
        ),
      );
    }
  }

  void setFontSize(double value) => state = state.copyWith(fontSize: value);

  void setVerticalOffset(double value) => state = state.copyWith(verticalOffset: value);

  void setSubColor(Color color) => state = state.copyWith(color: color);

  void setOutlineColor(Color e) => state = state.copyWith(outlineColor: e);

  SubtitleSettingsModel setOutlineThickness(double value) => state = state.copyWith(outlineSize: value);

  void resetSettings({SubtitleSettingsModel? value}) => state = value ?? const SubtitleSettingsModel();

  void setFontWeight(FontWeight? value) => state = state.copyWith(fontWeight: value);

  SubtitleSettingsModel setBackGroundOpacity(double value) =>
      state = state.copyWith(backGroundColor: state.backGroundColor.withValues(alpha: value));

  SubtitleSettingsModel setShadowIntensity(double value) => state = state.copyWith(shadow: value);

  SubtitleSettingsModel setBackgroundColor(Color color) =>
      state = state.copyWith(backGroundColor: color.withValues(alpha: state.backGroundColor.a));
}
