import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/models/settings/key_combinations.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/src/directory_bookmark.g.dart';
import 'package:fladder/util/custom_color_themes.dart';
import 'package:fladder/util/localization_helper.dart';

part 'client_settings_model.freezed.dart';
part 'client_settings_model.g.dart';

enum GlobalHotKeys {
  search,
  exit,
  toggleSideBar;

  const GlobalHotKeys();

  String label(BuildContext context) {
    return switch (this) {
      GlobalHotKeys.search => context.localized.search,
      GlobalHotKeys.exit => context.localized.exitFladderTitle,
      GlobalHotKeys.toggleSideBar => context.localized.toggleSidebar,
    };
  }
}

enum BackgroundType {
  disabled,
  enabled,
  blurred;

  const BackgroundType();

  double get opacityValues => switch (this) {
        BackgroundType.disabled => 1.0,
        BackgroundType.enabled => 0.75,
        BackgroundType.blurred => 0.75,
      };

  String label(BuildContext context) {
    return switch (this) {
      BackgroundType.disabled => context.localized.off,
      BackgroundType.enabled => context.localized.enabled,
      BackgroundType.blurred => context.localized.blurred,
    };
  }
}

@Freezed(copyWith: true)
abstract class ClientSettingsModel with _$ClientSettingsModel {
  const ClientSettingsModel._();

  factory ClientSettingsModel({
    String? syncPath,
    @Default(Vector2(x: 0, y: 0)) Vector2 position,
    @Default(Vector2(x: 1280, y: 720)) Vector2 size,
    @Default(Duration(seconds: 30)) Duration? timeOut,
    Duration? nextUpDateCutoff,
    @Default(Duration(hours: 1)) Duration updateNotificationsInterval,
    @Default(ThemeMode.system) ThemeMode themeMode,
    ColorThemes? themeColor,
    @Default(true) bool deriveColorsFromItem,
    @Default(false) bool amoledBlack,
    @Default(true) bool blurPlaceHolders,
    @Default(false) bool blurUpcomingEpisodes,
    @LocaleConvert() Locale? selectedLocale,
    @Default(true) bool enableMediaKeys,
    @Default(1.0) double posterSize,
    @Default(false) bool pinchPosterZoom,
    @Default(false) bool mouseDragSupport,
    @Default(true) bool requireWifi,
    @Default(false) bool expandSideBar,
    @Default(false) bool showAllCollectionTypes,
    @Default(2) int maxConcurrentDownloads,
    @Default(DynamicSchemeVariant.rainbow) DynamicSchemeVariant schemeVariant,
    @Default(BackgroundType.blurred) BackgroundType backgroundImage,
    @Default(false) bool enableBlurEffects,
    @Default(true) bool checkForUpdates,
    @Default(false) bool usePosterForLibrary,
    @Default(false) bool useSystemIME,
    @Default(false) bool useTVExpandedLayout,
    String? lastViewedUpdate,
    int? libraryPageSize,
    @Default({}) Map<GlobalHotKeys, KeyCombination> shortcuts,
  }) = _ClientSettingsModel;

  static ClientSettingsModel defaultModel() {
    return ClientSettingsModel(
      blurPlaceHolders: leanBackMode ? false : true,
      backgroundImage: leanBackMode ? BackgroundType.disabled : BackgroundType.blurred,
      themeMode: leanBackMode ? ThemeMode.dark : ThemeMode.system,
      enableBlurEffects: leanBackMode ? false : true,
      useTVExpandedLayout: false,
    );
  }

  Future<String?> getSavePath() async {
    if (kIsWeb && syncPath == null) return null;
    if (Platform.isMacOS) {
      return await DirectoryBookmark().resolveDirectory(syncPathKey);
    }
    return syncPath;
  }

  factory ClientSettingsModel.fromJson(Map<String, dynamic> json) => _$ClientSettingsModelFromJson(json);

  Map<GlobalHotKeys, KeyCombination> get currentShortcuts =>
      _defaultGlobalHotKeys.map((key, value) => MapEntry(key, shortcuts[key] ?? value));

  Map<GlobalHotKeys, KeyCombination> get defaultShortCuts => _defaultGlobalHotKeys;

  Brightness statusBarBrightness(BuildContext context) {
    return switch (themeMode) {
      ThemeMode.dark => Brightness.light,
      ThemeMode.light => Brightness.dark,
      _ => MediaQuery.of(context).platformBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
    };
  }
}

class LocaleConvert implements JsonConverter<Locale?, String?> {
  const LocaleConvert();

  @override
  Locale? fromJson(String? json) {
    if (json == null) return null;
    final parts = json.split('_');
    if (parts.length == 1) {
      return Locale(parts[0]);
    } else if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    } else {
      log("Invalid Locale format");
      return null;
    }
  }

  @override
  String? toJson(Locale? object) {
    if (object == null) return null;
    if (object.countryCode == null || object.countryCode?.isEmpty == true) {
      return object.languageCode;
    }
    return '${object.languageCode}_${object.countryCode}';
  }
}

class Vector2 {
  final double x;
  final double y;
  const Vector2({
    required this.x,
    required this.y,
  });

  Vector2 copyWith({
    double? x,
    double? y,
  }) {
    return Vector2(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
    };
  }

  factory Vector2.fromMap(Map<String, dynamic> map) {
    return Vector2(
      x: map['x'] as double,
      y: map['y'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vector2.fromJson(String source) => Vector2.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Vector2.fromSize(Size size) => Vector2(x: size.width, y: size.height);

  @override
  String toString() => 'Vector2(x: $x, y: $y)';

  @override
  bool operator ==(covariant Vector2 other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  static Vector2 fromPosition(Offset windowPosition) => Vector2(x: windowPosition.dx, y: windowPosition.dy);
}

Map<GlobalHotKeys, KeyCombination> get _defaultGlobalHotKeys => {
      for (var hotKey in GlobalHotKeys.values)
        hotKey: switch (hotKey) {
          GlobalHotKeys.toggleSideBar => KeyCombination(key: LogicalKeyboardKey.keyQ),
          GlobalHotKeys.search =>
            KeyCombination(key: LogicalKeyboardKey.keyK, modifier: LogicalKeyboardKey.controlLeft),
          GlobalHotKeys.exit => KeyCombination(key: LogicalKeyboardKey.keyQ, modifier: LogicalKeyboardKey.controlLeft),
        },
    };
