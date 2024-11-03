// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientSettingsModelImpl _$$ClientSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientSettingsModelImpl(
      syncPath: json['syncPath'] as String?,
      position: json['position'] == null
          ? const Vector2(x: 0, y: 0)
          : Vector2.fromJson(json['position'] as String),
      size: json['size'] == null
          ? const Vector2(x: 1280, y: 720)
          : Vector2.fromJson(json['size'] as String),
      timeOut: json['timeOut'] == null
          ? const Duration(seconds: 30)
          : Duration(microseconds: (json['timeOut'] as num).toInt()),
      nextUpDateCutoff: json['nextUpDateCutoff'] == null
          ? null
          : Duration(microseconds: (json['nextUpDateCutoff'] as num).toInt()),
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      themeColor: $enumDecodeNullable(_$ColorThemesEnumMap, json['themeColor']),
      amoledBlack: json['amoledBlack'] as bool? ?? false,
      blurPlaceHolders: json['blurPlaceHolders'] as bool? ?? true,
      blurUpcomingEpisodes: json['blurUpcomingEpisodes'] as bool? ?? false,
      selectedLocale:
          const LocaleConvert().fromJson(json['selectedLocale'] as String?),
      enableMediaKeys: json['enableMediaKeys'] as bool? ?? true,
      posterSize: (json['posterSize'] as num?)?.toDouble() ?? 1.0,
      pinchPosterZoom: json['pinchPosterZoom'] as bool? ?? false,
      mouseDragSupport: json['mouseDragSupport'] as bool? ?? false,
      requireWifi: json['requireWifi'] as bool? ?? true,
      schemeVariant: $enumDecodeNullable(
              _$DynamicSchemeVariantEnumMap, json['schemeVariant']) ??
          DynamicSchemeVariant.tonalSpot,
      libraryPageSize: (json['libraryPageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ClientSettingsModelImplToJson(
        _$ClientSettingsModelImpl instance) =>
    <String, dynamic>{
      'syncPath': instance.syncPath,
      'position': instance.position,
      'size': instance.size,
      'timeOut': instance.timeOut?.inMicroseconds,
      'nextUpDateCutoff': instance.nextUpDateCutoff?.inMicroseconds,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'themeColor': _$ColorThemesEnumMap[instance.themeColor],
      'amoledBlack': instance.amoledBlack,
      'blurPlaceHolders': instance.blurPlaceHolders,
      'blurUpcomingEpisodes': instance.blurUpcomingEpisodes,
      'selectedLocale': const LocaleConvert().toJson(instance.selectedLocale),
      'enableMediaKeys': instance.enableMediaKeys,
      'posterSize': instance.posterSize,
      'pinchPosterZoom': instance.pinchPosterZoom,
      'mouseDragSupport': instance.mouseDragSupport,
      'requireWifi': instance.requireWifi,
      'schemeVariant': _$DynamicSchemeVariantEnumMap[instance.schemeVariant]!,
      'libraryPageSize': instance.libraryPageSize,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$ColorThemesEnumMap = {
  ColorThemes.fladder: 'fladder',
  ColorThemes.deepOrange: 'deepOrange',
  ColorThemes.amber: 'amber',
  ColorThemes.green: 'green',
  ColorThemes.lightGreen: 'lightGreen',
  ColorThemes.lime: 'lime',
  ColorThemes.cyan: 'cyan',
  ColorThemes.blue: 'blue',
  ColorThemes.lightBlue: 'lightBlue',
  ColorThemes.indigo: 'indigo',
  ColorThemes.deepBlue: 'deepBlue',
  ColorThemes.brown: 'brown',
  ColorThemes.purple: 'purple',
  ColorThemes.deepPurple: 'deepPurple',
  ColorThemes.blueGrey: 'blueGrey',
};

const _$DynamicSchemeVariantEnumMap = {
  DynamicSchemeVariant.tonalSpot: 'tonalSpot',
  DynamicSchemeVariant.fidelity: 'fidelity',
  DynamicSchemeVariant.monochrome: 'monochrome',
  DynamicSchemeVariant.neutral: 'neutral',
  DynamicSchemeVariant.vibrant: 'vibrant',
  DynamicSchemeVariant.expressive: 'expressive',
  DynamicSchemeVariant.content: 'content',
  DynamicSchemeVariant.rainbow: 'rainbow',
  DynamicSchemeVariant.fruitSalad: 'fruitSalad',
};
