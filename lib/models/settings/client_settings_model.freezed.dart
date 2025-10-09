// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientSettingsModel implements DiagnosticableTreeMixin {
  String? get syncPath;
  Vector2 get position;
  Vector2 get size;
  Duration? get timeOut;
  Duration? get nextUpDateCutoff;
  ThemeMode get themeMode;
  ColorThemes? get themeColor;
  bool get deriveColorsFromItem;
  bool get amoledBlack;
  bool get blurPlaceHolders;
  bool get blurUpcomingEpisodes;
  @LocaleConvert()
  Locale? get selectedLocale;
  bool get enableMediaKeys;
  double get posterSize;
  bool get pinchPosterZoom;
  bool get mouseDragSupport;
  bool get requireWifi;
  bool get showAllCollectionTypes;
  int get maxConcurrentDownloads;
  DynamicSchemeVariant get schemeVariant;
  BackgroundType get backgroundImage;
  bool get checkForUpdates;
  bool get usePosterForLibrary;
  bool get useSystemIME;
  String? get lastViewedUpdate;
  int? get libraryPageSize;
  Map<GlobalHotKeys, KeyCombination> get shortcuts;

  /// Create a copy of ClientSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientSettingsModelCopyWith<ClientSettingsModel> get copyWith =>
      _$ClientSettingsModelCopyWithImpl<ClientSettingsModel>(
          this as ClientSettingsModel, _$identity);

  /// Serializes this ClientSettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ClientSettingsModel'))
      ..add(DiagnosticsProperty('syncPath', syncPath))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('timeOut', timeOut))
      ..add(DiagnosticsProperty('nextUpDateCutoff', nextUpDateCutoff))
      ..add(DiagnosticsProperty('themeMode', themeMode))
      ..add(DiagnosticsProperty('themeColor', themeColor))
      ..add(DiagnosticsProperty('deriveColorsFromItem', deriveColorsFromItem))
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
      ..add(
          DiagnosticsProperty('maxConcurrentDownloads', maxConcurrentDownloads))
      ..add(DiagnosticsProperty('schemeVariant', schemeVariant))
      ..add(DiagnosticsProperty('backgroundImage', backgroundImage))
      ..add(DiagnosticsProperty('checkForUpdates', checkForUpdates))
      ..add(DiagnosticsProperty('usePosterForLibrary', usePosterForLibrary))
      ..add(DiagnosticsProperty('useSystemIME', useSystemIME))
      ..add(DiagnosticsProperty('lastViewedUpdate', lastViewedUpdate))
      ..add(DiagnosticsProperty('libraryPageSize', libraryPageSize))
      ..add(DiagnosticsProperty('shortcuts', shortcuts));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientSettingsModel(syncPath: $syncPath, position: $position, size: $size, timeOut: $timeOut, nextUpDateCutoff: $nextUpDateCutoff, themeMode: $themeMode, themeColor: $themeColor, deriveColorsFromItem: $deriveColorsFromItem, amoledBlack: $amoledBlack, blurPlaceHolders: $blurPlaceHolders, blurUpcomingEpisodes: $blurUpcomingEpisodes, selectedLocale: $selectedLocale, enableMediaKeys: $enableMediaKeys, posterSize: $posterSize, pinchPosterZoom: $pinchPosterZoom, mouseDragSupport: $mouseDragSupport, requireWifi: $requireWifi, showAllCollectionTypes: $showAllCollectionTypes, maxConcurrentDownloads: $maxConcurrentDownloads, schemeVariant: $schemeVariant, backgroundImage: $backgroundImage, checkForUpdates: $checkForUpdates, usePosterForLibrary: $usePosterForLibrary, useSystemIME: $useSystemIME, lastViewedUpdate: $lastViewedUpdate, libraryPageSize: $libraryPageSize, shortcuts: $shortcuts)';
  }
}

/// @nodoc
abstract mixin class $ClientSettingsModelCopyWith<$Res> {
  factory $ClientSettingsModelCopyWith(
          ClientSettingsModel value, $Res Function(ClientSettingsModel) _then) =
      _$ClientSettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {String? syncPath,
      Vector2 position,
      Vector2 size,
      Duration? timeOut,
      Duration? nextUpDateCutoff,
      ThemeMode themeMode,
      ColorThemes? themeColor,
      bool deriveColorsFromItem,
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
      int maxConcurrentDownloads,
      DynamicSchemeVariant schemeVariant,
      BackgroundType backgroundImage,
      bool checkForUpdates,
      bool usePosterForLibrary,
      bool useSystemIME,
      String? lastViewedUpdate,
      int? libraryPageSize,
      Map<GlobalHotKeys, KeyCombination> shortcuts});
}

/// @nodoc
class _$ClientSettingsModelCopyWithImpl<$Res>
    implements $ClientSettingsModelCopyWith<$Res> {
  _$ClientSettingsModelCopyWithImpl(this._self, this._then);

  final ClientSettingsModel _self;
  final $Res Function(ClientSettingsModel) _then;

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
    Object? deriveColorsFromItem = null,
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
    Object? maxConcurrentDownloads = null,
    Object? schemeVariant = null,
    Object? backgroundImage = null,
    Object? checkForUpdates = null,
    Object? usePosterForLibrary = null,
    Object? useSystemIME = null,
    Object? lastViewedUpdate = freezed,
    Object? libraryPageSize = freezed,
    Object? shortcuts = null,
  }) {
    return _then(_self.copyWith(
      syncPath: freezed == syncPath
          ? _self.syncPath
          : syncPath // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as Vector2,
      timeOut: freezed == timeOut
          ? _self.timeOut
          : timeOut // ignore: cast_nullable_to_non_nullable
              as Duration?,
      nextUpDateCutoff: freezed == nextUpDateCutoff
          ? _self.nextUpDateCutoff
          : nextUpDateCutoff // ignore: cast_nullable_to_non_nullable
              as Duration?,
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      themeColor: freezed == themeColor
          ? _self.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as ColorThemes?,
      deriveColorsFromItem: null == deriveColorsFromItem
          ? _self.deriveColorsFromItem
          : deriveColorsFromItem // ignore: cast_nullable_to_non_nullable
              as bool,
      amoledBlack: null == amoledBlack
          ? _self.amoledBlack
          : amoledBlack // ignore: cast_nullable_to_non_nullable
              as bool,
      blurPlaceHolders: null == blurPlaceHolders
          ? _self.blurPlaceHolders
          : blurPlaceHolders // ignore: cast_nullable_to_non_nullable
              as bool,
      blurUpcomingEpisodes: null == blurUpcomingEpisodes
          ? _self.blurUpcomingEpisodes
          : blurUpcomingEpisodes // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedLocale: freezed == selectedLocale
          ? _self.selectedLocale
          : selectedLocale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      enableMediaKeys: null == enableMediaKeys
          ? _self.enableMediaKeys
          : enableMediaKeys // ignore: cast_nullable_to_non_nullable
              as bool,
      posterSize: null == posterSize
          ? _self.posterSize
          : posterSize // ignore: cast_nullable_to_non_nullable
              as double,
      pinchPosterZoom: null == pinchPosterZoom
          ? _self.pinchPosterZoom
          : pinchPosterZoom // ignore: cast_nullable_to_non_nullable
              as bool,
      mouseDragSupport: null == mouseDragSupport
          ? _self.mouseDragSupport
          : mouseDragSupport // ignore: cast_nullable_to_non_nullable
              as bool,
      requireWifi: null == requireWifi
          ? _self.requireWifi
          : requireWifi // ignore: cast_nullable_to_non_nullable
              as bool,
      showAllCollectionTypes: null == showAllCollectionTypes
          ? _self.showAllCollectionTypes
          : showAllCollectionTypes // ignore: cast_nullable_to_non_nullable
              as bool,
      maxConcurrentDownloads: null == maxConcurrentDownloads
          ? _self.maxConcurrentDownloads
          : maxConcurrentDownloads // ignore: cast_nullable_to_non_nullable
              as int,
      schemeVariant: null == schemeVariant
          ? _self.schemeVariant
          : schemeVariant // ignore: cast_nullable_to_non_nullable
              as DynamicSchemeVariant,
      backgroundImage: null == backgroundImage
          ? _self.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as BackgroundType,
      checkForUpdates: null == checkForUpdates
          ? _self.checkForUpdates
          : checkForUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      usePosterForLibrary: null == usePosterForLibrary
          ? _self.usePosterForLibrary
          : usePosterForLibrary // ignore: cast_nullable_to_non_nullable
              as bool,
      useSystemIME: null == useSystemIME
          ? _self.useSystemIME
          : useSystemIME // ignore: cast_nullable_to_non_nullable
              as bool,
      lastViewedUpdate: freezed == lastViewedUpdate
          ? _self.lastViewedUpdate
          : lastViewedUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
      libraryPageSize: freezed == libraryPageSize
          ? _self.libraryPageSize
          : libraryPageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      shortcuts: null == shortcuts
          ? _self.shortcuts
          : shortcuts // ignore: cast_nullable_to_non_nullable
              as Map<GlobalHotKeys, KeyCombination>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientSettingsModel].
extension ClientSettingsModelPatterns on ClientSettingsModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ClientSettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientSettingsModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ClientSettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientSettingsModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ClientSettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientSettingsModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String? syncPath,
            Vector2 position,
            Vector2 size,
            Duration? timeOut,
            Duration? nextUpDateCutoff,
            ThemeMode themeMode,
            ColorThemes? themeColor,
            bool deriveColorsFromItem,
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
            int maxConcurrentDownloads,
            DynamicSchemeVariant schemeVariant,
            BackgroundType backgroundImage,
            bool checkForUpdates,
            bool usePosterForLibrary,
            bool useSystemIME,
            String? lastViewedUpdate,
            int? libraryPageSize,
            Map<GlobalHotKeys, KeyCombination> shortcuts)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientSettingsModel() when $default != null:
        return $default(
            _that.syncPath,
            _that.position,
            _that.size,
            _that.timeOut,
            _that.nextUpDateCutoff,
            _that.themeMode,
            _that.themeColor,
            _that.deriveColorsFromItem,
            _that.amoledBlack,
            _that.blurPlaceHolders,
            _that.blurUpcomingEpisodes,
            _that.selectedLocale,
            _that.enableMediaKeys,
            _that.posterSize,
            _that.pinchPosterZoom,
            _that.mouseDragSupport,
            _that.requireWifi,
            _that.showAllCollectionTypes,
            _that.maxConcurrentDownloads,
            _that.schemeVariant,
            _that.backgroundImage,
            _that.checkForUpdates,
            _that.usePosterForLibrary,
            _that.useSystemIME,
            _that.lastViewedUpdate,
            _that.libraryPageSize,
            _that.shortcuts);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String? syncPath,
            Vector2 position,
            Vector2 size,
            Duration? timeOut,
            Duration? nextUpDateCutoff,
            ThemeMode themeMode,
            ColorThemes? themeColor,
            bool deriveColorsFromItem,
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
            int maxConcurrentDownloads,
            DynamicSchemeVariant schemeVariant,
            BackgroundType backgroundImage,
            bool checkForUpdates,
            bool usePosterForLibrary,
            bool useSystemIME,
            String? lastViewedUpdate,
            int? libraryPageSize,
            Map<GlobalHotKeys, KeyCombination> shortcuts)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientSettingsModel():
        return $default(
            _that.syncPath,
            _that.position,
            _that.size,
            _that.timeOut,
            _that.nextUpDateCutoff,
            _that.themeMode,
            _that.themeColor,
            _that.deriveColorsFromItem,
            _that.amoledBlack,
            _that.blurPlaceHolders,
            _that.blurUpcomingEpisodes,
            _that.selectedLocale,
            _that.enableMediaKeys,
            _that.posterSize,
            _that.pinchPosterZoom,
            _that.mouseDragSupport,
            _that.requireWifi,
            _that.showAllCollectionTypes,
            _that.maxConcurrentDownloads,
            _that.schemeVariant,
            _that.backgroundImage,
            _that.checkForUpdates,
            _that.usePosterForLibrary,
            _that.useSystemIME,
            _that.lastViewedUpdate,
            _that.libraryPageSize,
            _that.shortcuts);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String? syncPath,
            Vector2 position,
            Vector2 size,
            Duration? timeOut,
            Duration? nextUpDateCutoff,
            ThemeMode themeMode,
            ColorThemes? themeColor,
            bool deriveColorsFromItem,
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
            int maxConcurrentDownloads,
            DynamicSchemeVariant schemeVariant,
            BackgroundType backgroundImage,
            bool checkForUpdates,
            bool usePosterForLibrary,
            bool useSystemIME,
            String? lastViewedUpdate,
            int? libraryPageSize,
            Map<GlobalHotKeys, KeyCombination> shortcuts)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientSettingsModel() when $default != null:
        return $default(
            _that.syncPath,
            _that.position,
            _that.size,
            _that.timeOut,
            _that.nextUpDateCutoff,
            _that.themeMode,
            _that.themeColor,
            _that.deriveColorsFromItem,
            _that.amoledBlack,
            _that.blurPlaceHolders,
            _that.blurUpcomingEpisodes,
            _that.selectedLocale,
            _that.enableMediaKeys,
            _that.posterSize,
            _that.pinchPosterZoom,
            _that.mouseDragSupport,
            _that.requireWifi,
            _that.showAllCollectionTypes,
            _that.maxConcurrentDownloads,
            _that.schemeVariant,
            _that.backgroundImage,
            _that.checkForUpdates,
            _that.usePosterForLibrary,
            _that.useSystemIME,
            _that.lastViewedUpdate,
            _that.libraryPageSize,
            _that.shortcuts);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientSettingsModel extends ClientSettingsModel
    with DiagnosticableTreeMixin {
  _ClientSettingsModel(
      {this.syncPath,
      this.position = const Vector2(x: 0, y: 0),
      this.size = const Vector2(x: 1280, y: 720),
      this.timeOut = const Duration(seconds: 30),
      this.nextUpDateCutoff,
      this.themeMode = ThemeMode.system,
      this.themeColor,
      this.deriveColorsFromItem = true,
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
      this.maxConcurrentDownloads = 2,
      this.schemeVariant = DynamicSchemeVariant.rainbow,
      this.backgroundImage = BackgroundType.blurred,
      this.checkForUpdates = true,
      this.usePosterForLibrary = false,
      this.useSystemIME = false,
      this.lastViewedUpdate,
      this.libraryPageSize,
      final Map<GlobalHotKeys, KeyCombination> shortcuts = const {}})
      : _shortcuts = shortcuts,
        super._();
  factory _ClientSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$ClientSettingsModelFromJson(json);

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
  final bool deriveColorsFromItem;
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
  final int maxConcurrentDownloads;
  @override
  @JsonKey()
  final DynamicSchemeVariant schemeVariant;
  @override
  @JsonKey()
  final BackgroundType backgroundImage;
  @override
  @JsonKey()
  final bool checkForUpdates;
  @override
  @JsonKey()
  final bool usePosterForLibrary;
  @override
  @JsonKey()
  final bool useSystemIME;
  @override
  final String? lastViewedUpdate;
  @override
  final int? libraryPageSize;
  final Map<GlobalHotKeys, KeyCombination> _shortcuts;
  @override
  @JsonKey()
  Map<GlobalHotKeys, KeyCombination> get shortcuts {
    if (_shortcuts is EqualUnmodifiableMapView) return _shortcuts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_shortcuts);
  }

  /// Create a copy of ClientSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientSettingsModelCopyWith<_ClientSettingsModel> get copyWith =>
      __$ClientSettingsModelCopyWithImpl<_ClientSettingsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientSettingsModelToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ClientSettingsModel'))
      ..add(DiagnosticsProperty('syncPath', syncPath))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('timeOut', timeOut))
      ..add(DiagnosticsProperty('nextUpDateCutoff', nextUpDateCutoff))
      ..add(DiagnosticsProperty('themeMode', themeMode))
      ..add(DiagnosticsProperty('themeColor', themeColor))
      ..add(DiagnosticsProperty('deriveColorsFromItem', deriveColorsFromItem))
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
      ..add(
          DiagnosticsProperty('maxConcurrentDownloads', maxConcurrentDownloads))
      ..add(DiagnosticsProperty('schemeVariant', schemeVariant))
      ..add(DiagnosticsProperty('backgroundImage', backgroundImage))
      ..add(DiagnosticsProperty('checkForUpdates', checkForUpdates))
      ..add(DiagnosticsProperty('usePosterForLibrary', usePosterForLibrary))
      ..add(DiagnosticsProperty('useSystemIME', useSystemIME))
      ..add(DiagnosticsProperty('lastViewedUpdate', lastViewedUpdate))
      ..add(DiagnosticsProperty('libraryPageSize', libraryPageSize))
      ..add(DiagnosticsProperty('shortcuts', shortcuts));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientSettingsModel(syncPath: $syncPath, position: $position, size: $size, timeOut: $timeOut, nextUpDateCutoff: $nextUpDateCutoff, themeMode: $themeMode, themeColor: $themeColor, deriveColorsFromItem: $deriveColorsFromItem, amoledBlack: $amoledBlack, blurPlaceHolders: $blurPlaceHolders, blurUpcomingEpisodes: $blurUpcomingEpisodes, selectedLocale: $selectedLocale, enableMediaKeys: $enableMediaKeys, posterSize: $posterSize, pinchPosterZoom: $pinchPosterZoom, mouseDragSupport: $mouseDragSupport, requireWifi: $requireWifi, showAllCollectionTypes: $showAllCollectionTypes, maxConcurrentDownloads: $maxConcurrentDownloads, schemeVariant: $schemeVariant, backgroundImage: $backgroundImage, checkForUpdates: $checkForUpdates, usePosterForLibrary: $usePosterForLibrary, useSystemIME: $useSystemIME, lastViewedUpdate: $lastViewedUpdate, libraryPageSize: $libraryPageSize, shortcuts: $shortcuts)';
  }
}

/// @nodoc
abstract mixin class _$ClientSettingsModelCopyWith<$Res>
    implements $ClientSettingsModelCopyWith<$Res> {
  factory _$ClientSettingsModelCopyWith(_ClientSettingsModel value,
          $Res Function(_ClientSettingsModel) _then) =
      __$ClientSettingsModelCopyWithImpl;
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
      bool deriveColorsFromItem,
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
      int maxConcurrentDownloads,
      DynamicSchemeVariant schemeVariant,
      BackgroundType backgroundImage,
      bool checkForUpdates,
      bool usePosterForLibrary,
      bool useSystemIME,
      String? lastViewedUpdate,
      int? libraryPageSize,
      Map<GlobalHotKeys, KeyCombination> shortcuts});
}

/// @nodoc
class __$ClientSettingsModelCopyWithImpl<$Res>
    implements _$ClientSettingsModelCopyWith<$Res> {
  __$ClientSettingsModelCopyWithImpl(this._self, this._then);

  final _ClientSettingsModel _self;
  final $Res Function(_ClientSettingsModel) _then;

  /// Create a copy of ClientSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? syncPath = freezed,
    Object? position = null,
    Object? size = null,
    Object? timeOut = freezed,
    Object? nextUpDateCutoff = freezed,
    Object? themeMode = null,
    Object? themeColor = freezed,
    Object? deriveColorsFromItem = null,
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
    Object? maxConcurrentDownloads = null,
    Object? schemeVariant = null,
    Object? backgroundImage = null,
    Object? checkForUpdates = null,
    Object? usePosterForLibrary = null,
    Object? useSystemIME = null,
    Object? lastViewedUpdate = freezed,
    Object? libraryPageSize = freezed,
    Object? shortcuts = null,
  }) {
    return _then(_ClientSettingsModel(
      syncPath: freezed == syncPath
          ? _self.syncPath
          : syncPath // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as Vector2,
      timeOut: freezed == timeOut
          ? _self.timeOut
          : timeOut // ignore: cast_nullable_to_non_nullable
              as Duration?,
      nextUpDateCutoff: freezed == nextUpDateCutoff
          ? _self.nextUpDateCutoff
          : nextUpDateCutoff // ignore: cast_nullable_to_non_nullable
              as Duration?,
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      themeColor: freezed == themeColor
          ? _self.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as ColorThemes?,
      deriveColorsFromItem: null == deriveColorsFromItem
          ? _self.deriveColorsFromItem
          : deriveColorsFromItem // ignore: cast_nullable_to_non_nullable
              as bool,
      amoledBlack: null == amoledBlack
          ? _self.amoledBlack
          : amoledBlack // ignore: cast_nullable_to_non_nullable
              as bool,
      blurPlaceHolders: null == blurPlaceHolders
          ? _self.blurPlaceHolders
          : blurPlaceHolders // ignore: cast_nullable_to_non_nullable
              as bool,
      blurUpcomingEpisodes: null == blurUpcomingEpisodes
          ? _self.blurUpcomingEpisodes
          : blurUpcomingEpisodes // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedLocale: freezed == selectedLocale
          ? _self.selectedLocale
          : selectedLocale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      enableMediaKeys: null == enableMediaKeys
          ? _self.enableMediaKeys
          : enableMediaKeys // ignore: cast_nullable_to_non_nullable
              as bool,
      posterSize: null == posterSize
          ? _self.posterSize
          : posterSize // ignore: cast_nullable_to_non_nullable
              as double,
      pinchPosterZoom: null == pinchPosterZoom
          ? _self.pinchPosterZoom
          : pinchPosterZoom // ignore: cast_nullable_to_non_nullable
              as bool,
      mouseDragSupport: null == mouseDragSupport
          ? _self.mouseDragSupport
          : mouseDragSupport // ignore: cast_nullable_to_non_nullable
              as bool,
      requireWifi: null == requireWifi
          ? _self.requireWifi
          : requireWifi // ignore: cast_nullable_to_non_nullable
              as bool,
      showAllCollectionTypes: null == showAllCollectionTypes
          ? _self.showAllCollectionTypes
          : showAllCollectionTypes // ignore: cast_nullable_to_non_nullable
              as bool,
      maxConcurrentDownloads: null == maxConcurrentDownloads
          ? _self.maxConcurrentDownloads
          : maxConcurrentDownloads // ignore: cast_nullable_to_non_nullable
              as int,
      schemeVariant: null == schemeVariant
          ? _self.schemeVariant
          : schemeVariant // ignore: cast_nullable_to_non_nullable
              as DynamicSchemeVariant,
      backgroundImage: null == backgroundImage
          ? _self.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as BackgroundType,
      checkForUpdates: null == checkForUpdates
          ? _self.checkForUpdates
          : checkForUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      usePosterForLibrary: null == usePosterForLibrary
          ? _self.usePosterForLibrary
          : usePosterForLibrary // ignore: cast_nullable_to_non_nullable
              as bool,
      useSystemIME: null == useSystemIME
          ? _self.useSystemIME
          : useSystemIME // ignore: cast_nullable_to_non_nullable
              as bool,
      lastViewedUpdate: freezed == lastViewedUpdate
          ? _self.lastViewedUpdate
          : lastViewedUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
      libraryPageSize: freezed == libraryPageSize
          ? _self.libraryPageSize
          : libraryPageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      shortcuts: null == shortcuts
          ? _self._shortcuts
          : shortcuts // ignore: cast_nullable_to_non_nullable
              as Map<GlobalHotKeys, KeyCombination>,
    ));
  }
}

// dart format on
