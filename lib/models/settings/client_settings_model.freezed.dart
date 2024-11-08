// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientSettingsModel _$ClientSettingsModelFromJson(Map<String, dynamic> json) {
  return _ClientSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$ClientSettingsModel {
  String? get syncPath => throw _privateConstructorUsedError;
  Vector2 get position => throw _privateConstructorUsedError;
  Vector2 get size => throw _privateConstructorUsedError;
  Duration? get timeOut => throw _privateConstructorUsedError;
  Duration? get nextUpDateCutoff => throw _privateConstructorUsedError;
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  ColorThemes? get themeColor => throw _privateConstructorUsedError;
  bool get amoledBlack => throw _privateConstructorUsedError;
  bool get blurPlaceHolders => throw _privateConstructorUsedError;
  bool get blurUpcomingEpisodes => throw _privateConstructorUsedError;
  @LocaleConvert()
  Locale? get selectedLocale => throw _privateConstructorUsedError;
  bool get enableMediaKeys => throw _privateConstructorUsedError;
  double get posterSize => throw _privateConstructorUsedError;
  bool get pinchPosterZoom => throw _privateConstructorUsedError;
  bool get mouseDragSupport => throw _privateConstructorUsedError;
  bool get requireWifi => throw _privateConstructorUsedError;
  bool get showAllCollectionTypes => throw _privateConstructorUsedError;
  DynamicSchemeVariant get schemeVariant => throw _privateConstructorUsedError;
  int? get libraryPageSize => throw _privateConstructorUsedError;

  /// Serializes this ClientSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClientSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientSettingsModelCopyWith<ClientSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientSettingsModelCopyWith<$Res> {
  factory $ClientSettingsModelCopyWith(
          ClientSettingsModel value, $Res Function(ClientSettingsModel) then) =
      _$ClientSettingsModelCopyWithImpl<$Res, ClientSettingsModel>;
  @useResult
  $Res call(
      {String? syncPath,
      Vector2 position,
      Vector2 size,
      Duration? timeOut,
      Duration? nextUpDateCutoff,
      ThemeMode themeMode,
      ColorThemes? themeColor,
      bool amoledBlack,
      bool blurPlaceHolders,
      bool blurUpcomingEpisodes,
      @LocaleConvert() Locale? selectedLocale,
      bool enableMediaKeys,
      double posterSize,
      bool pinchPosterZoom,
      bool mouseDragSupport,
      bool requireWifi,
      bool showAllCollectionTypes,
      DynamicSchemeVariant schemeVariant,
      int? libraryPageSize});
}

/// @nodoc
class _$ClientSettingsModelCopyWithImpl<$Res, $Val extends ClientSettingsModel>
    implements $ClientSettingsModelCopyWith<$Res> {
  _$ClientSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? syncPath = freezed,
    Object? position = null,
    Object? size = null,
    Object? timeOut = freezed,
    Object? nextUpDateCutoff = freezed,
    Object? themeMode = null,
    Object? themeColor = freezed,
    Object? amoledBlack = null,
    Object? blurPlaceHolders = null,
    Object? blurUpcomingEpisodes = null,
    Object? selectedLocale = freezed,
    Object? enableMediaKeys = null,
    Object? posterSize = null,
    Object? pinchPosterZoom = null,
    Object? mouseDragSupport = null,
    Object? requireWifi = null,
    Object? showAllCollectionTypes = null,
    Object? schemeVariant = null,
    Object? libraryPageSize = freezed,
  }) {
    return _then(_value.copyWith(
      syncPath: freezed == syncPath
          ? _value.syncPath
          : syncPath // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Vector2,
      timeOut: freezed == timeOut
          ? _value.timeOut
          : timeOut // ignore: cast_nullable_to_non_nullable
              as Duration?,
      nextUpDateCutoff: freezed == nextUpDateCutoff
          ? _value.nextUpDateCutoff
          : nextUpDateCutoff // ignore: cast_nullable_to_non_nullable
              as Duration?,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      themeColor: freezed == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as ColorThemes?,
      amoledBlack: null == amoledBlack
          ? _value.amoledBlack
          : amoledBlack // ignore: cast_nullable_to_non_nullable
              as bool,
      blurPlaceHolders: null == blurPlaceHolders
          ? _value.blurPlaceHolders
          : blurPlaceHolders // ignore: cast_nullable_to_non_nullable
              as bool,
      blurUpcomingEpisodes: null == blurUpcomingEpisodes
          ? _value.blurUpcomingEpisodes
          : blurUpcomingEpisodes // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedLocale: freezed == selectedLocale
          ? _value.selectedLocale
          : selectedLocale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      enableMediaKeys: null == enableMediaKeys
          ? _value.enableMediaKeys
          : enableMediaKeys // ignore: cast_nullable_to_non_nullable
              as bool,
      posterSize: null == posterSize
          ? _value.posterSize
          : posterSize // ignore: cast_nullable_to_non_nullable
              as double,
      pinchPosterZoom: null == pinchPosterZoom
          ? _value.pinchPosterZoom
          : pinchPosterZoom // ignore: cast_nullable_to_non_nullable
              as bool,
      mouseDragSupport: null == mouseDragSupport
          ? _value.mouseDragSupport
          : mouseDragSupport // ignore: cast_nullable_to_non_nullable
              as bool,
      requireWifi: null == requireWifi
          ? _value.requireWifi
          : requireWifi // ignore: cast_nullable_to_non_nullable
              as bool,
      showAllCollectionTypes: null == showAllCollectionTypes
          ? _value.showAllCollectionTypes
          : showAllCollectionTypes // ignore: cast_nullable_to_non_nullable
              as bool,
      schemeVariant: null == schemeVariant
          ? _value.schemeVariant
          : schemeVariant // ignore: cast_nullable_to_non_nullable
              as DynamicSchemeVariant,
      libraryPageSize: freezed == libraryPageSize
          ? _value.libraryPageSize
          : libraryPageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientSettingsModelImplCopyWith<$Res>
    implements $ClientSettingsModelCopyWith<$Res> {
  factory _$$ClientSettingsModelImplCopyWith(_$ClientSettingsModelImpl value,
          $Res Function(_$ClientSettingsModelImpl) then) =
      __$$ClientSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? syncPath,
      Vector2 position,
      Vector2 size,
      Duration? timeOut,
      Duration? nextUpDateCutoff,
      ThemeMode themeMode,
      ColorThemes? themeColor,
      bool amoledBlack,
      bool blurPlaceHolders,
      bool blurUpcomingEpisodes,
      @LocaleConvert() Locale? selectedLocale,
      bool enableMediaKeys,
      double posterSize,
      bool pinchPosterZoom,
      bool mouseDragSupport,
      bool requireWifi,
      bool showAllCollectionTypes,
      DynamicSchemeVariant schemeVariant,
      int? libraryPageSize});
}

/// @nodoc
class __$$ClientSettingsModelImplCopyWithImpl<$Res>
    extends _$ClientSettingsModelCopyWithImpl<$Res, _$ClientSettingsModelImpl>
    implements _$$ClientSettingsModelImplCopyWith<$Res> {
  __$$ClientSettingsModelImplCopyWithImpl(_$ClientSettingsModelImpl _value,
      $Res Function(_$ClientSettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClientSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? syncPath = freezed,
    Object? position = null,
    Object? size = null,
    Object? timeOut = freezed,
    Object? nextUpDateCutoff = freezed,
    Object? themeMode = null,
    Object? themeColor = freezed,
    Object? amoledBlack = null,
    Object? blurPlaceHolders = null,
    Object? blurUpcomingEpisodes = null,
    Object? selectedLocale = freezed,
    Object? enableMediaKeys = null,
    Object? posterSize = null,
    Object? pinchPosterZoom = null,
    Object? mouseDragSupport = null,
    Object? requireWifi = null,
    Object? showAllCollectionTypes = null,
    Object? schemeVariant = null,
    Object? libraryPageSize = freezed,
  }) {
    return _then(_$ClientSettingsModelImpl(
      syncPath: freezed == syncPath
          ? _value.syncPath
          : syncPath // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Vector2,
      timeOut: freezed == timeOut
          ? _value.timeOut
          : timeOut // ignore: cast_nullable_to_non_nullable
              as Duration?,
      nextUpDateCutoff: freezed == nextUpDateCutoff
          ? _value.nextUpDateCutoff
          : nextUpDateCutoff // ignore: cast_nullable_to_non_nullable
              as Duration?,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      themeColor: freezed == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as ColorThemes?,
      amoledBlack: null == amoledBlack
          ? _value.amoledBlack
          : amoledBlack // ignore: cast_nullable_to_non_nullable
              as bool,
      blurPlaceHolders: null == blurPlaceHolders
          ? _value.blurPlaceHolders
          : blurPlaceHolders // ignore: cast_nullable_to_non_nullable
              as bool,
      blurUpcomingEpisodes: null == blurUpcomingEpisodes
          ? _value.blurUpcomingEpisodes
          : blurUpcomingEpisodes // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedLocale: freezed == selectedLocale
          ? _value.selectedLocale
          : selectedLocale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      enableMediaKeys: null == enableMediaKeys
          ? _value.enableMediaKeys
          : enableMediaKeys // ignore: cast_nullable_to_non_nullable
              as bool,
      posterSize: null == posterSize
          ? _value.posterSize
          : posterSize // ignore: cast_nullable_to_non_nullable
              as double,
      pinchPosterZoom: null == pinchPosterZoom
          ? _value.pinchPosterZoom
          : pinchPosterZoom // ignore: cast_nullable_to_non_nullable
              as bool,
      mouseDragSupport: null == mouseDragSupport
          ? _value.mouseDragSupport
          : mouseDragSupport // ignore: cast_nullable_to_non_nullable
              as bool,
      requireWifi: null == requireWifi
          ? _value.requireWifi
          : requireWifi // ignore: cast_nullable_to_non_nullable
              as bool,
      showAllCollectionTypes: null == showAllCollectionTypes
          ? _value.showAllCollectionTypes
          : showAllCollectionTypes // ignore: cast_nullable_to_non_nullable
              as bool,
      schemeVariant: null == schemeVariant
          ? _value.schemeVariant
          : schemeVariant // ignore: cast_nullable_to_non_nullable
              as DynamicSchemeVariant,
      libraryPageSize: freezed == libraryPageSize
          ? _value.libraryPageSize
          : libraryPageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientSettingsModelImpl extends _ClientSettingsModel
    with DiagnosticableTreeMixin {
  _$ClientSettingsModelImpl(
      {this.syncPath,
      this.position = const Vector2(x: 0, y: 0),
      this.size = const Vector2(x: 1280, y: 720),
      this.timeOut = const Duration(seconds: 30),
      this.nextUpDateCutoff,
      this.themeMode = ThemeMode.system,
      this.themeColor,
      this.amoledBlack = false,
      this.blurPlaceHolders = true,
      this.blurUpcomingEpisodes = false,
      @LocaleConvert() this.selectedLocale,
      this.enableMediaKeys = true,
      this.posterSize = 1.0,
      this.pinchPosterZoom = false,
      this.mouseDragSupport = false,
      this.requireWifi = true,
      this.showAllCollectionTypes = false,
      this.schemeVariant = DynamicSchemeVariant.tonalSpot,
      this.libraryPageSize})
      : super._();

  factory _$ClientSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientSettingsModelImplFromJson(json);

  @override
  final String? syncPath;
  @override
  @JsonKey()
  final Vector2 position;
  @override
  @JsonKey()
  final Vector2 size;
  @override
  @JsonKey()
  final Duration? timeOut;
  @override
  final Duration? nextUpDateCutoff;
  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  final ColorThemes? themeColor;
  @override
  @JsonKey()
  final bool amoledBlack;
  @override
  @JsonKey()
  final bool blurPlaceHolders;
  @override
  @JsonKey()
  final bool blurUpcomingEpisodes;
  @override
  @LocaleConvert()
  final Locale? selectedLocale;
  @override
  @JsonKey()
  final bool enableMediaKeys;
  @override
  @JsonKey()
  final double posterSize;
  @override
  @JsonKey()
  final bool pinchPosterZoom;
  @override
  @JsonKey()
  final bool mouseDragSupport;
  @override
  @JsonKey()
  final bool requireWifi;
  @override
  @JsonKey()
  final bool showAllCollectionTypes;
  @override
  @JsonKey()
  final DynamicSchemeVariant schemeVariant;
  @override
  final int? libraryPageSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientSettingsModel(syncPath: $syncPath, position: $position, size: $size, timeOut: $timeOut, nextUpDateCutoff: $nextUpDateCutoff, themeMode: $themeMode, themeColor: $themeColor, amoledBlack: $amoledBlack, blurPlaceHolders: $blurPlaceHolders, blurUpcomingEpisodes: $blurUpcomingEpisodes, selectedLocale: $selectedLocale, enableMediaKeys: $enableMediaKeys, posterSize: $posterSize, pinchPosterZoom: $pinchPosterZoom, mouseDragSupport: $mouseDragSupport, requireWifi: $requireWifi, showAllCollectionTypes: $showAllCollectionTypes, schemeVariant: $schemeVariant, libraryPageSize: $libraryPageSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClientSettingsModel'))
      ..add(DiagnosticsProperty('syncPath', syncPath))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('timeOut', timeOut))
      ..add(DiagnosticsProperty('nextUpDateCutoff', nextUpDateCutoff))
      ..add(DiagnosticsProperty('themeMode', themeMode))
      ..add(DiagnosticsProperty('themeColor', themeColor))
      ..add(DiagnosticsProperty('amoledBlack', amoledBlack))
      ..add(DiagnosticsProperty('blurPlaceHolders', blurPlaceHolders))
      ..add(DiagnosticsProperty('blurUpcomingEpisodes', blurUpcomingEpisodes))
      ..add(DiagnosticsProperty('selectedLocale', selectedLocale))
      ..add(DiagnosticsProperty('enableMediaKeys', enableMediaKeys))
      ..add(DiagnosticsProperty('posterSize', posterSize))
      ..add(DiagnosticsProperty('pinchPosterZoom', pinchPosterZoom))
      ..add(DiagnosticsProperty('mouseDragSupport', mouseDragSupport))
      ..add(DiagnosticsProperty('requireWifi', requireWifi))
      ..add(
          DiagnosticsProperty('showAllCollectionTypes', showAllCollectionTypes))
      ..add(DiagnosticsProperty('schemeVariant', schemeVariant))
      ..add(DiagnosticsProperty('libraryPageSize', libraryPageSize));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientSettingsModelImpl &&
            (identical(other.syncPath, syncPath) ||
                other.syncPath == syncPath) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.timeOut, timeOut) || other.timeOut == timeOut) &&
            (identical(other.nextUpDateCutoff, nextUpDateCutoff) ||
                other.nextUpDateCutoff == nextUpDateCutoff) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor) &&
            (identical(other.amoledBlack, amoledBlack) ||
                other.amoledBlack == amoledBlack) &&
            (identical(other.blurPlaceHolders, blurPlaceHolders) ||
                other.blurPlaceHolders == blurPlaceHolders) &&
            (identical(other.blurUpcomingEpisodes, blurUpcomingEpisodes) ||
                other.blurUpcomingEpisodes == blurUpcomingEpisodes) &&
            (identical(other.selectedLocale, selectedLocale) ||
                other.selectedLocale == selectedLocale) &&
            (identical(other.enableMediaKeys, enableMediaKeys) ||
                other.enableMediaKeys == enableMediaKeys) &&
            (identical(other.posterSize, posterSize) ||
                other.posterSize == posterSize) &&
            (identical(other.pinchPosterZoom, pinchPosterZoom) ||
                other.pinchPosterZoom == pinchPosterZoom) &&
            (identical(other.mouseDragSupport, mouseDragSupport) ||
                other.mouseDragSupport == mouseDragSupport) &&
            (identical(other.requireWifi, requireWifi) ||
                other.requireWifi == requireWifi) &&
            (identical(other.showAllCollectionTypes, showAllCollectionTypes) ||
                other.showAllCollectionTypes == showAllCollectionTypes) &&
            (identical(other.schemeVariant, schemeVariant) ||
                other.schemeVariant == schemeVariant) &&
            (identical(other.libraryPageSize, libraryPageSize) ||
                other.libraryPageSize == libraryPageSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        syncPath,
        position,
        size,
        timeOut,
        nextUpDateCutoff,
        themeMode,
        themeColor,
        amoledBlack,
        blurPlaceHolders,
        blurUpcomingEpisodes,
        selectedLocale,
        enableMediaKeys,
        posterSize,
        pinchPosterZoom,
        mouseDragSupport,
        requireWifi,
        showAllCollectionTypes,
        schemeVariant,
        libraryPageSize
      ]);

  /// Create a copy of ClientSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientSettingsModelImplCopyWith<_$ClientSettingsModelImpl> get copyWith =>
      __$$ClientSettingsModelImplCopyWithImpl<_$ClientSettingsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _ClientSettingsModel extends ClientSettingsModel {
  factory _ClientSettingsModel(
      {final String? syncPath,
      final Vector2 position,
      final Vector2 size,
      final Duration? timeOut,
      final Duration? nextUpDateCutoff,
      final ThemeMode themeMode,
      final ColorThemes? themeColor,
      final bool amoledBlack,
      final bool blurPlaceHolders,
      final bool blurUpcomingEpisodes,
      @LocaleConvert() final Locale? selectedLocale,
      final bool enableMediaKeys,
      final double posterSize,
      final bool pinchPosterZoom,
      final bool mouseDragSupport,
      final bool requireWifi,
      final bool showAllCollectionTypes,
      final DynamicSchemeVariant schemeVariant,
      final int? libraryPageSize}) = _$ClientSettingsModelImpl;
  _ClientSettingsModel._() : super._();

  factory _ClientSettingsModel.fromJson(Map<String, dynamic> json) =
      _$ClientSettingsModelImpl.fromJson;

  @override
  String? get syncPath;
  @override
  Vector2 get position;
  @override
  Vector2 get size;
  @override
  Duration? get timeOut;
  @override
  Duration? get nextUpDateCutoff;
  @override
  ThemeMode get themeMode;
  @override
  ColorThemes? get themeColor;
  @override
  bool get amoledBlack;
  @override
  bool get blurPlaceHolders;
  @override
  bool get blurUpcomingEpisodes;
  @override
  @LocaleConvert()
  Locale? get selectedLocale;
  @override
  bool get enableMediaKeys;
  @override
  double get posterSize;
  @override
  bool get pinchPosterZoom;
  @override
  bool get mouseDragSupport;
  @override
  bool get requireWifi;
  @override
  bool get showAllCollectionTypes;
  @override
  DynamicSchemeVariant get schemeVariant;
  @override
  int? get libraryPageSize;

  /// Create a copy of ClientSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientSettingsModelImplCopyWith<_$ClientSettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
