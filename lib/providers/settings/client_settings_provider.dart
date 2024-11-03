import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/client_settings_model.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/util/custom_color_themes.dart';
import 'package:fladder/util/debouncer.dart';

final clientSettingsProvider = StateNotifierProvider<ClientSettingsNotifier, ClientSettingsModel>((ref) {
  return ClientSettingsNotifier(ref);
});

class ClientSettingsNotifier extends StateNotifier<ClientSettingsModel> {
  ClientSettingsNotifier(this.ref) : super(ClientSettingsModel());

  final Ref ref;

  final Debouncer _debouncer = Debouncer(const Duration(seconds: 1));

  @override
  set state(ClientSettingsModel value) {
    super.state = value;
    _debouncer.run(() => ref.read(sharedUtilityProvider).clientSettings = state);
  }

  void setWindowPosition(Offset windowPosition) =>
      state = state.copyWith(position: Vector2.fromPosition(windowPosition));

  void setWindowSize(Size windowSize) => state = state.copyWith(size: Vector2.fromSize(windowSize));

  void setThemeMode(ThemeMode? themeMode) {
    if (themeMode == null) return;
    state = state.copyWith(themeMode: themeMode);
  }

  void setThemeColor(ColorThemes? themeColor) => state = state.copyWith(themeColor: themeColor);

  void setAmoledBlack(bool? value) => state = state.copyWith(amoledBlack: value ?? false);

  void setBlurPlaceholders(bool value) => state = state.copyWith(blurPlaceHolders: value);

  void setTimeOut(Duration? duration) => state = state.copyWith(timeOut: duration);

  void setBlurEpisodes(bool value) => state = state.copyWith(blurUpcomingEpisodes: value);

  void setMediaKeys(bool value) => state = state.copyWith(enableMediaKeys: value);

  void setPosterSize(double value) => state = state.copyWith(posterSize: value.clamp(0.5, 1.5));

  void addPosterSize(double value) => state = state.copyWith(posterSize: (state.posterSize + value).clamp(0.5, 1.5));

  void setSyncPath(String? path) => state = state.copyWith(syncPath: path);

  void update(Function(ClientSettingsModel current) value) => state = value(state);

  void setSchemeVariant(DynamicSchemeVariant? type) =>
      state = state.copyWith(schemeVariant: type ?? state.schemeVariant);

  void setRequireWifi(bool value) => state = state.copyWith(requireWifi: value);
}
