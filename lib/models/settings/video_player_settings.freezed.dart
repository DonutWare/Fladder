// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_player_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoPlayerSettingsModel implements DiagnosticableTreeMixin {
  double? get screenBrightness;
  BoxFit get videoFit;
  bool get fillScreen;
  bool get hardwareAccel;
  bool get useLibass;
  bool get enableTunneling;
  int get bufferSize;
  PlayerOptions? get playerOptions;
  double get internalVolume;
  Set<DeviceOrientation>? get allowedOrientations;
  AutoNextType get nextVideoType;
  Bitrate get maxHomeBitrate;
  Bitrate get maxInternetBitrate;
  String? get audioDevice;
  Map<MediaSegmentType, SegmentSkip> get segmentSkipSettings;
  Map<VideoHotKeys, KeyCombination> get hotKeys;
  Screensaver get screensaver;

  /// Create a copy of VideoPlayerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VideoPlayerSettingsModelCopyWith<VideoPlayerSettingsModel> get copyWith =>
      _$VideoPlayerSettingsModelCopyWithImpl<VideoPlayerSettingsModel>(
          this as VideoPlayerSettingsModel, _$identity);

  /// Serializes this VideoPlayerSettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'VideoPlayerSettingsModel'))
      ..add(DiagnosticsProperty('screenBrightness', screenBrightness))
      ..add(DiagnosticsProperty('videoFit', videoFit))
      ..add(DiagnosticsProperty('fillScreen', fillScreen))
      ..add(DiagnosticsProperty('hardwareAccel', hardwareAccel))
      ..add(DiagnosticsProperty('useLibass', useLibass))
      ..add(DiagnosticsProperty('enableTunneling', enableTunneling))
      ..add(DiagnosticsProperty('bufferSize', bufferSize))
      ..add(DiagnosticsProperty('playerOptions', playerOptions))
      ..add(DiagnosticsProperty('internalVolume', internalVolume))
      ..add(DiagnosticsProperty('allowedOrientations', allowedOrientations))
      ..add(DiagnosticsProperty('nextVideoType', nextVideoType))
      ..add(DiagnosticsProperty('maxHomeBitrate', maxHomeBitrate))
      ..add(DiagnosticsProperty('maxInternetBitrate', maxInternetBitrate))
      ..add(DiagnosticsProperty('audioDevice', audioDevice))
      ..add(DiagnosticsProperty('segmentSkipSettings', segmentSkipSettings))
      ..add(DiagnosticsProperty('hotKeys', hotKeys))
      ..add(DiagnosticsProperty('screensaver', screensaver));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoPlayerSettingsModel(screenBrightness: $screenBrightness, videoFit: $videoFit, fillScreen: $fillScreen, hardwareAccel: $hardwareAccel, useLibass: $useLibass, enableTunneling: $enableTunneling, bufferSize: $bufferSize, playerOptions: $playerOptions, internalVolume: $internalVolume, allowedOrientations: $allowedOrientations, nextVideoType: $nextVideoType, maxHomeBitrate: $maxHomeBitrate, maxInternetBitrate: $maxInternetBitrate, audioDevice: $audioDevice, segmentSkipSettings: $segmentSkipSettings, hotKeys: $hotKeys, screensaver: $screensaver)';
  }
}

/// @nodoc
abstract mixin class $VideoPlayerSettingsModelCopyWith<$Res> {
  factory $VideoPlayerSettingsModelCopyWith(VideoPlayerSettingsModel value,
          $Res Function(VideoPlayerSettingsModel) _then) =
      _$VideoPlayerSettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {double? screenBrightness,
      BoxFit videoFit,
      bool fillScreen,
      bool hardwareAccel,
      bool useLibass,
      bool enableTunneling,
      int bufferSize,
      PlayerOptions? playerOptions,
      double internalVolume,
      Set<DeviceOrientation>? allowedOrientations,
      AutoNextType nextVideoType,
      Bitrate maxHomeBitrate,
      Bitrate maxInternetBitrate,
      String? audioDevice,
      Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
      Map<VideoHotKeys, KeyCombination> hotKeys,
      Screensaver screensaver});
}

/// @nodoc
class _$VideoPlayerSettingsModelCopyWithImpl<$Res>
    implements $VideoPlayerSettingsModelCopyWith<$Res> {
  _$VideoPlayerSettingsModelCopyWithImpl(this._self, this._then);

  final VideoPlayerSettingsModel _self;
  final $Res Function(VideoPlayerSettingsModel) _then;

  /// Create a copy of VideoPlayerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screenBrightness = freezed,
    Object? videoFit = null,
    Object? fillScreen = null,
    Object? hardwareAccel = null,
    Object? useLibass = null,
    Object? enableTunneling = null,
    Object? bufferSize = null,
    Object? playerOptions = freezed,
    Object? internalVolume = null,
    Object? allowedOrientations = freezed,
    Object? nextVideoType = null,
    Object? maxHomeBitrate = null,
    Object? maxInternetBitrate = null,
    Object? audioDevice = freezed,
    Object? segmentSkipSettings = null,
    Object? hotKeys = null,
    Object? screensaver = null,
  }) {
    return _then(_self.copyWith(
      screenBrightness: freezed == screenBrightness
          ? _self.screenBrightness
          : screenBrightness // ignore: cast_nullable_to_non_nullable
              as double?,
      videoFit: null == videoFit
          ? _self.videoFit
          : videoFit // ignore: cast_nullable_to_non_nullable
              as BoxFit,
      fillScreen: null == fillScreen
          ? _self.fillScreen
          : fillScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      hardwareAccel: null == hardwareAccel
          ? _self.hardwareAccel
          : hardwareAccel // ignore: cast_nullable_to_non_nullable
              as bool,
      useLibass: null == useLibass
          ? _self.useLibass
          : useLibass // ignore: cast_nullable_to_non_nullable
              as bool,
      enableTunneling: null == enableTunneling
          ? _self.enableTunneling
          : enableTunneling // ignore: cast_nullable_to_non_nullable
              as bool,
      bufferSize: null == bufferSize
          ? _self.bufferSize
          : bufferSize // ignore: cast_nullable_to_non_nullable
              as int,
      playerOptions: freezed == playerOptions
          ? _self.playerOptions
          : playerOptions // ignore: cast_nullable_to_non_nullable
              as PlayerOptions?,
      internalVolume: null == internalVolume
          ? _self.internalVolume
          : internalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      allowedOrientations: freezed == allowedOrientations
          ? _self.allowedOrientations
          : allowedOrientations // ignore: cast_nullable_to_non_nullable
              as Set<DeviceOrientation>?,
      nextVideoType: null == nextVideoType
          ? _self.nextVideoType
          : nextVideoType // ignore: cast_nullable_to_non_nullable
              as AutoNextType,
      maxHomeBitrate: null == maxHomeBitrate
          ? _self.maxHomeBitrate
          : maxHomeBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
      maxInternetBitrate: null == maxInternetBitrate
          ? _self.maxInternetBitrate
          : maxInternetBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
      audioDevice: freezed == audioDevice
          ? _self.audioDevice
          : audioDevice // ignore: cast_nullable_to_non_nullable
              as String?,
      segmentSkipSettings: null == segmentSkipSettings
          ? _self.segmentSkipSettings
          : segmentSkipSettings // ignore: cast_nullable_to_non_nullable
              as Map<MediaSegmentType, SegmentSkip>,
      hotKeys: null == hotKeys
          ? _self.hotKeys
          : hotKeys // ignore: cast_nullable_to_non_nullable
              as Map<VideoHotKeys, KeyCombination>,
      screensaver: null == screensaver
          ? _self.screensaver
          : screensaver // ignore: cast_nullable_to_non_nullable
              as Screensaver,
    ));
  }
}

/// Adds pattern-matching-related methods to [VideoPlayerSettingsModel].
extension VideoPlayerSettingsModelPatterns on VideoPlayerSettingsModel {
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
    TResult Function(_VideoPlayerSettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerSettingsModel() when $default != null:
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
    TResult Function(_VideoPlayerSettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerSettingsModel():
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
    TResult? Function(_VideoPlayerSettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerSettingsModel() when $default != null:
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
            double? screenBrightness,
            BoxFit videoFit,
            bool fillScreen,
            bool hardwareAccel,
            bool useLibass,
            bool enableTunneling,
            int bufferSize,
            PlayerOptions? playerOptions,
            double internalVolume,
            Set<DeviceOrientation>? allowedOrientations,
            AutoNextType nextVideoType,
            Bitrate maxHomeBitrate,
            Bitrate maxInternetBitrate,
            String? audioDevice,
            Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
            Map<VideoHotKeys, KeyCombination> hotKeys,
            Screensaver screensaver)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerSettingsModel() when $default != null:
        return $default(
            _that.screenBrightness,
            _that.videoFit,
            _that.fillScreen,
            _that.hardwareAccel,
            _that.useLibass,
            _that.enableTunneling,
            _that.bufferSize,
            _that.playerOptions,
            _that.internalVolume,
            _that.allowedOrientations,
            _that.nextVideoType,
            _that.maxHomeBitrate,
            _that.maxInternetBitrate,
            _that.audioDevice,
            _that.segmentSkipSettings,
            _that.hotKeys,
            _that.screensaver);
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
            double? screenBrightness,
            BoxFit videoFit,
            bool fillScreen,
            bool hardwareAccel,
            bool useLibass,
            bool enableTunneling,
            int bufferSize,
            PlayerOptions? playerOptions,
            double internalVolume,
            Set<DeviceOrientation>? allowedOrientations,
            AutoNextType nextVideoType,
            Bitrate maxHomeBitrate,
            Bitrate maxInternetBitrate,
            String? audioDevice,
            Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
            Map<VideoHotKeys, KeyCombination> hotKeys,
            Screensaver screensaver)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerSettingsModel():
        return $default(
            _that.screenBrightness,
            _that.videoFit,
            _that.fillScreen,
            _that.hardwareAccel,
            _that.useLibass,
            _that.enableTunneling,
            _that.bufferSize,
            _that.playerOptions,
            _that.internalVolume,
            _that.allowedOrientations,
            _that.nextVideoType,
            _that.maxHomeBitrate,
            _that.maxInternetBitrate,
            _that.audioDevice,
            _that.segmentSkipSettings,
            _that.hotKeys,
            _that.screensaver);
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
            double? screenBrightness,
            BoxFit videoFit,
            bool fillScreen,
            bool hardwareAccel,
            bool useLibass,
            bool enableTunneling,
            int bufferSize,
            PlayerOptions? playerOptions,
            double internalVolume,
            Set<DeviceOrientation>? allowedOrientations,
            AutoNextType nextVideoType,
            Bitrate maxHomeBitrate,
            Bitrate maxInternetBitrate,
            String? audioDevice,
            Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
            Map<VideoHotKeys, KeyCombination> hotKeys,
            Screensaver screensaver)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerSettingsModel() when $default != null:
        return $default(
            _that.screenBrightness,
            _that.videoFit,
            _that.fillScreen,
            _that.hardwareAccel,
            _that.useLibass,
            _that.enableTunneling,
            _that.bufferSize,
            _that.playerOptions,
            _that.internalVolume,
            _that.allowedOrientations,
            _that.nextVideoType,
            _that.maxHomeBitrate,
            _that.maxInternetBitrate,
            _that.audioDevice,
            _that.segmentSkipSettings,
            _that.hotKeys,
            _that.screensaver);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VideoPlayerSettingsModel extends VideoPlayerSettingsModel
    with DiagnosticableTreeMixin {
  _VideoPlayerSettingsModel(
      {this.screenBrightness,
      this.videoFit = BoxFit.contain,
      this.fillScreen = false,
      this.hardwareAccel = true,
      this.useLibass = false,
      this.enableTunneling = false,
      this.bufferSize = 32,
      this.playerOptions,
      this.internalVolume = 100,
      final Set<DeviceOrientation>? allowedOrientations,
      this.nextVideoType = AutoNextType.smart,
      this.maxHomeBitrate = Bitrate.original,
      this.maxInternetBitrate = Bitrate.original,
      this.audioDevice,
      final Map<MediaSegmentType, SegmentSkip> segmentSkipSettings =
          defaultSegmentSkipValues,
      final Map<VideoHotKeys, KeyCombination> hotKeys = const {},
      this.screensaver = Screensaver.logo})
      : _allowedOrientations = allowedOrientations,
        _segmentSkipSettings = segmentSkipSettings,
        _hotKeys = hotKeys,
        super._();
  factory _VideoPlayerSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$VideoPlayerSettingsModelFromJson(json);

  @override
  final double? screenBrightness;
  @override
  @JsonKey()
  final BoxFit videoFit;
  @override
  @JsonKey()
  final bool fillScreen;
  @override
  @JsonKey()
  final bool hardwareAccel;
  @override
  @JsonKey()
  final bool useLibass;
  @override
  @JsonKey()
  final bool enableTunneling;
  @override
  @JsonKey()
  final int bufferSize;
  @override
  final PlayerOptions? playerOptions;
  @override
  @JsonKey()
  final double internalVolume;
  final Set<DeviceOrientation>? _allowedOrientations;
  @override
  Set<DeviceOrientation>? get allowedOrientations {
    final value = _allowedOrientations;
    if (value == null) return null;
    if (_allowedOrientations is EqualUnmodifiableSetView)
      return _allowedOrientations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  @JsonKey()
  final AutoNextType nextVideoType;
  @override
  @JsonKey()
  final Bitrate maxHomeBitrate;
  @override
  @JsonKey()
  final Bitrate maxInternetBitrate;
  @override
  final String? audioDevice;
  final Map<MediaSegmentType, SegmentSkip> _segmentSkipSettings;
  @override
  @JsonKey()
  Map<MediaSegmentType, SegmentSkip> get segmentSkipSettings {
    if (_segmentSkipSettings is EqualUnmodifiableMapView)
      return _segmentSkipSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_segmentSkipSettings);
  }

  final Map<VideoHotKeys, KeyCombination> _hotKeys;
  @override
  @JsonKey()
  Map<VideoHotKeys, KeyCombination> get hotKeys {
    if (_hotKeys is EqualUnmodifiableMapView) return _hotKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_hotKeys);
  }

  @override
  @JsonKey()
  final Screensaver screensaver;

  /// Create a copy of VideoPlayerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VideoPlayerSettingsModelCopyWith<_VideoPlayerSettingsModel> get copyWith =>
      __$VideoPlayerSettingsModelCopyWithImpl<_VideoPlayerSettingsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VideoPlayerSettingsModelToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'VideoPlayerSettingsModel'))
      ..add(DiagnosticsProperty('screenBrightness', screenBrightness))
      ..add(DiagnosticsProperty('videoFit', videoFit))
      ..add(DiagnosticsProperty('fillScreen', fillScreen))
      ..add(DiagnosticsProperty('hardwareAccel', hardwareAccel))
      ..add(DiagnosticsProperty('useLibass', useLibass))
      ..add(DiagnosticsProperty('enableTunneling', enableTunneling))
      ..add(DiagnosticsProperty('bufferSize', bufferSize))
      ..add(DiagnosticsProperty('playerOptions', playerOptions))
      ..add(DiagnosticsProperty('internalVolume', internalVolume))
      ..add(DiagnosticsProperty('allowedOrientations', allowedOrientations))
      ..add(DiagnosticsProperty('nextVideoType', nextVideoType))
      ..add(DiagnosticsProperty('maxHomeBitrate', maxHomeBitrate))
      ..add(DiagnosticsProperty('maxInternetBitrate', maxInternetBitrate))
      ..add(DiagnosticsProperty('audioDevice', audioDevice))
      ..add(DiagnosticsProperty('segmentSkipSettings', segmentSkipSettings))
      ..add(DiagnosticsProperty('hotKeys', hotKeys))
      ..add(DiagnosticsProperty('screensaver', screensaver));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoPlayerSettingsModel(screenBrightness: $screenBrightness, videoFit: $videoFit, fillScreen: $fillScreen, hardwareAccel: $hardwareAccel, useLibass: $useLibass, enableTunneling: $enableTunneling, bufferSize: $bufferSize, playerOptions: $playerOptions, internalVolume: $internalVolume, allowedOrientations: $allowedOrientations, nextVideoType: $nextVideoType, maxHomeBitrate: $maxHomeBitrate, maxInternetBitrate: $maxInternetBitrate, audioDevice: $audioDevice, segmentSkipSettings: $segmentSkipSettings, hotKeys: $hotKeys, screensaver: $screensaver)';
  }
}

/// @nodoc
abstract mixin class _$VideoPlayerSettingsModelCopyWith<$Res>
    implements $VideoPlayerSettingsModelCopyWith<$Res> {
  factory _$VideoPlayerSettingsModelCopyWith(_VideoPlayerSettingsModel value,
          $Res Function(_VideoPlayerSettingsModel) _then) =
      __$VideoPlayerSettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double? screenBrightness,
      BoxFit videoFit,
      bool fillScreen,
      bool hardwareAccel,
      bool useLibass,
      bool enableTunneling,
      int bufferSize,
      PlayerOptions? playerOptions,
      double internalVolume,
      Set<DeviceOrientation>? allowedOrientations,
      AutoNextType nextVideoType,
      Bitrate maxHomeBitrate,
      Bitrate maxInternetBitrate,
      String? audioDevice,
      Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
      Map<VideoHotKeys, KeyCombination> hotKeys,
      Screensaver screensaver});
}

/// @nodoc
class __$VideoPlayerSettingsModelCopyWithImpl<$Res>
    implements _$VideoPlayerSettingsModelCopyWith<$Res> {
  __$VideoPlayerSettingsModelCopyWithImpl(this._self, this._then);

  final _VideoPlayerSettingsModel _self;
  final $Res Function(_VideoPlayerSettingsModel) _then;

  /// Create a copy of VideoPlayerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? screenBrightness = freezed,
    Object? videoFit = null,
    Object? fillScreen = null,
    Object? hardwareAccel = null,
    Object? useLibass = null,
    Object? enableTunneling = null,
    Object? bufferSize = null,
    Object? playerOptions = freezed,
    Object? internalVolume = null,
    Object? allowedOrientations = freezed,
    Object? nextVideoType = null,
    Object? maxHomeBitrate = null,
    Object? maxInternetBitrate = null,
    Object? audioDevice = freezed,
    Object? segmentSkipSettings = null,
    Object? hotKeys = null,
    Object? screensaver = null,
  }) {
    return _then(_VideoPlayerSettingsModel(
      screenBrightness: freezed == screenBrightness
          ? _self.screenBrightness
          : screenBrightness // ignore: cast_nullable_to_non_nullable
              as double?,
      videoFit: null == videoFit
          ? _self.videoFit
          : videoFit // ignore: cast_nullable_to_non_nullable
              as BoxFit,
      fillScreen: null == fillScreen
          ? _self.fillScreen
          : fillScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      hardwareAccel: null == hardwareAccel
          ? _self.hardwareAccel
          : hardwareAccel // ignore: cast_nullable_to_non_nullable
              as bool,
      useLibass: null == useLibass
          ? _self.useLibass
          : useLibass // ignore: cast_nullable_to_non_nullable
              as bool,
      enableTunneling: null == enableTunneling
          ? _self.enableTunneling
          : enableTunneling // ignore: cast_nullable_to_non_nullable
              as bool,
      bufferSize: null == bufferSize
          ? _self.bufferSize
          : bufferSize // ignore: cast_nullable_to_non_nullable
              as int,
      playerOptions: freezed == playerOptions
          ? _self.playerOptions
          : playerOptions // ignore: cast_nullable_to_non_nullable
              as PlayerOptions?,
      internalVolume: null == internalVolume
          ? _self.internalVolume
          : internalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      allowedOrientations: freezed == allowedOrientations
          ? _self._allowedOrientations
          : allowedOrientations // ignore: cast_nullable_to_non_nullable
              as Set<DeviceOrientation>?,
      nextVideoType: null == nextVideoType
          ? _self.nextVideoType
          : nextVideoType // ignore: cast_nullable_to_non_nullable
              as AutoNextType,
      maxHomeBitrate: null == maxHomeBitrate
          ? _self.maxHomeBitrate
          : maxHomeBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
      maxInternetBitrate: null == maxInternetBitrate
          ? _self.maxInternetBitrate
          : maxInternetBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
      audioDevice: freezed == audioDevice
          ? _self.audioDevice
          : audioDevice // ignore: cast_nullable_to_non_nullable
              as String?,
      segmentSkipSettings: null == segmentSkipSettings
          ? _self._segmentSkipSettings
          : segmentSkipSettings // ignore: cast_nullable_to_non_nullable
              as Map<MediaSegmentType, SegmentSkip>,
      hotKeys: null == hotKeys
          ? _self._hotKeys
          : hotKeys // ignore: cast_nullable_to_non_nullable
              as Map<VideoHotKeys, KeyCombination>,
      screensaver: null == screensaver
          ? _self.screensaver
          : screensaver // ignore: cast_nullable_to_non_nullable
              as Screensaver,
    ));
  }
}

// dart format on
