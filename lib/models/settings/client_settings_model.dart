import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/util/custom_color_themes.dart';

part 'client_settings_model.freezed.dart';
part 'client_settings_model.g.dart';

@freezed
class ClientSettingsModel with _$ClientSettingsModel {
  const ClientSettingsModel._();
  factory ClientSettingsModel({
    String? syncPath,
    @Default(Vector2(x: 0, y: 0)) Vector2 position,
    @Default(Vector2(x: 1280, y: 720)) Vector2 size,
    @Default(Duration(seconds: 30)) Duration? timeOut,
    Duration? nextUpDateCutoff,
    @Default(ThemeMode.system) ThemeMode themeMode,
    ColorThemes? themeColor,
    @Default(false) bool amoledBlack,
    @Default(false) bool blurPlaceHolders,
    @Default(false) bool blurUpcomingEpisodes,
    @LocaleConvert() Locale? selectedLocale,
    @Default(true) bool enableMediaKeys,
    @Default(1.0) double posterSize,
    @Default(false) bool pinchPosterZoom,
    @Default(false) bool mouseDragSupport,
    int? libraryPageSize,
  }) = _ClientSettingsModel;

  factory ClientSettingsModel.fromJson(Map<String, dynamic> json) => _$ClientSettingsModelFromJson(json);

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
