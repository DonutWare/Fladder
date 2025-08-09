// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_player_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoPlayerSettingsModel _$VideoPlayerSettingsModelFromJson(
    Map<String, dynamic> json) {
  return _VideoPlayerSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$VideoPlayerSettingsModel {
  double? get screenBrightness => throw _privateConstructorUsedError;
  BoxFit get videoFit => throw _privateConstructorUsedError;
  bool get fillScreen => throw _privateConstructorUsedError;
  bool get hardwareAccel => throw _privateConstructorUsedError;
  bool get useLibass => throw _privateConstructorUsedError;
  int get bufferSize => throw _privateConstructorUsedError;
  PlayerOptions? get playerOptions => throw _privateConstructorUsedError;
  double get internalVolume => throw _privateConstructorUsedError;
  Set<DeviceOrientation>? get allowedOrientations =>
      throw _privateConstructorUsedError;
  AutoNextType get nextVideoType => throw _privateConstructorUsedError;
  Bitrate get maxHomeBitrate => throw _privateConstructorUsedError;
  Bitrate get maxInternetBitrate => throw _privateConstructorUsedError;
  String? get audioDevice => throw _privateConstructorUsedError;
  Map<MediaSegmentType, SegmentSkip> get segmentSkipSettings =>
      throw _privateConstructorUsedError;
  Map<VideoHotKeys, KeyCombination> get hotKeys =>
      throw _privateConstructorUsedError;

  /// Serializes this VideoPlayerSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoPlayerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoPlayerSettingsModelCopyWith<VideoPlayerSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoPlayerSettingsModelCopyWith<$Res> {
  factory $VideoPlayerSettingsModelCopyWith(VideoPlayerSettingsModel value,
          $Res Function(VideoPlayerSettingsModel) then) =
      _$VideoPlayerSettingsModelCopyWithImpl<$Res, VideoPlayerSettingsModel>;
  @useResult
  $Res call(
      {double? screenBrightness,
      BoxFit videoFit,
      bool fillScreen,
      bool hardwareAccel,
      bool useLibass,
      int bufferSize,
      PlayerOptions? playerOptions,
      double internalVolume,
      Set<DeviceOrientation>? allowedOrientations,
      AutoNextType nextVideoType,
      Bitrate maxHomeBitrate,
      Bitrate maxInternetBitrate,
      String? audioDevice,
      Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
      Map<VideoHotKeys, KeyCombination> hotKeys});
}

/// @nodoc
class _$VideoPlayerSettingsModelCopyWithImpl<$Res,
        $Val extends VideoPlayerSettingsModel>
    implements $VideoPlayerSettingsModelCopyWith<$Res> {
  _$VideoPlayerSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
  }) {
    return _then(_value.copyWith(
      screenBrightness: freezed == screenBrightness
          ? _value.screenBrightness
          : screenBrightness // ignore: cast_nullable_to_non_nullable
              as double?,
      videoFit: null == videoFit
          ? _value.videoFit
          : videoFit // ignore: cast_nullable_to_non_nullable
              as BoxFit,
      fillScreen: null == fillScreen
          ? _value.fillScreen
          : fillScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      hardwareAccel: null == hardwareAccel
          ? _value.hardwareAccel
          : hardwareAccel // ignore: cast_nullable_to_non_nullable
              as bool,
      useLibass: null == useLibass
          ? _value.useLibass
          : useLibass // ignore: cast_nullable_to_non_nullable
              as bool,
      bufferSize: null == bufferSize
          ? _value.bufferSize
          : bufferSize // ignore: cast_nullable_to_non_nullable
              as int,
      playerOptions: freezed == playerOptions
          ? _value.playerOptions
          : playerOptions // ignore: cast_nullable_to_non_nullable
              as PlayerOptions?,
      internalVolume: null == internalVolume
          ? _value.internalVolume
          : internalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      allowedOrientations: freezed == allowedOrientations
          ? _value.allowedOrientations
          : allowedOrientations // ignore: cast_nullable_to_non_nullable
              as Set<DeviceOrientation>?,
      nextVideoType: null == nextVideoType
          ? _value.nextVideoType
          : nextVideoType // ignore: cast_nullable_to_non_nullable
              as AutoNextType,
      maxHomeBitrate: null == maxHomeBitrate
          ? _value.maxHomeBitrate
          : maxHomeBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
      maxInternetBitrate: null == maxInternetBitrate
          ? _value.maxInternetBitrate
          : maxInternetBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
      audioDevice: freezed == audioDevice
          ? _value.audioDevice
          : audioDevice // ignore: cast_nullable_to_non_nullable
              as String?,
      segmentSkipSettings: null == segmentSkipSettings
          ? _value.segmentSkipSettings
          : segmentSkipSettings // ignore: cast_nullable_to_non_nullable
              as Map<MediaSegmentType, SegmentSkip>,
      hotKeys: null == hotKeys
          ? _value.hotKeys
          : hotKeys // ignore: cast_nullable_to_non_nullable
              as Map<VideoHotKeys, KeyCombination>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoPlayerSettingsModelImplCopyWith<$Res>
    implements $VideoPlayerSettingsModelCopyWith<$Res> {
  factory _$$VideoPlayerSettingsModelImplCopyWith(
          _$VideoPlayerSettingsModelImpl value,
          $Res Function(_$VideoPlayerSettingsModelImpl) then) =
      __$$VideoPlayerSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? screenBrightness,
      BoxFit videoFit,
      bool fillScreen,
      bool hardwareAccel,
      bool useLibass,
      int bufferSize,
      PlayerOptions? playerOptions,
      double internalVolume,
      Set<DeviceOrientation>? allowedOrientations,
      AutoNextType nextVideoType,
      Bitrate maxHomeBitrate,
      Bitrate maxInternetBitrate,
      String? audioDevice,
      Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
      Map<VideoHotKeys, KeyCombination> hotKeys});
}

/// @nodoc
class __$$VideoPlayerSettingsModelImplCopyWithImpl<$Res>
    extends _$VideoPlayerSettingsModelCopyWithImpl<$Res,
        _$VideoPlayerSettingsModelImpl>
    implements _$$VideoPlayerSettingsModelImplCopyWith<$Res> {
  __$$VideoPlayerSettingsModelImplCopyWithImpl(
      _$VideoPlayerSettingsModelImpl _value,
      $Res Function(_$VideoPlayerSettingsModelImpl) _then)
      : super(_value, _then);

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
  }) {
    return _then(_$VideoPlayerSettingsModelImpl(
      screenBrightness: freezed == screenBrightness
          ? _value.screenBrightness
          : screenBrightness // ignore: cast_nullable_to_non_nullable
              as double?,
      videoFit: null == videoFit
          ? _value.videoFit
          : videoFit // ignore: cast_nullable_to_non_nullable
              as BoxFit,
      fillScreen: null == fillScreen
          ? _value.fillScreen
          : fillScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      hardwareAccel: null == hardwareAccel
          ? _value.hardwareAccel
          : hardwareAccel // ignore: cast_nullable_to_non_nullable
              as bool,
      useLibass: null == useLibass
          ? _value.useLibass
          : useLibass // ignore: cast_nullable_to_non_nullable
              as bool,
      bufferSize: null == bufferSize
          ? _value.bufferSize
          : bufferSize // ignore: cast_nullable_to_non_nullable
              as int,
      playerOptions: freezed == playerOptions
          ? _value.playerOptions
          : playerOptions // ignore: cast_nullable_to_non_nullable
              as PlayerOptions?,
      internalVolume: null == internalVolume
          ? _value.internalVolume
          : internalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      allowedOrientations: freezed == allowedOrientations
          ? _value._allowedOrientations
          : allowedOrientations // ignore: cast_nullable_to_non_nullable
              as Set<DeviceOrientation>?,
      nextVideoType: null == nextVideoType
          ? _value.nextVideoType
          : nextVideoType // ignore: cast_nullable_to_non_nullable
              as AutoNextType,
      maxHomeBitrate: null == maxHomeBitrate
          ? _value.maxHomeBitrate
          : maxHomeBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
      maxInternetBitrate: null == maxInternetBitrate
          ? _value.maxInternetBitrate
          : maxInternetBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
      audioDevice: freezed == audioDevice
          ? _value.audioDevice
          : audioDevice // ignore: cast_nullable_to_non_nullable
              as String?,
      segmentSkipSettings: null == segmentSkipSettings
          ? _value._segmentSkipSettings
          : segmentSkipSettings // ignore: cast_nullable_to_non_nullable
              as Map<MediaSegmentType, SegmentSkip>,
      hotKeys: null == hotKeys
          ? _value._hotKeys
          : hotKeys // ignore: cast_nullable_to_non_nullable
              as Map<VideoHotKeys, KeyCombination>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoPlayerSettingsModelImpl extends _VideoPlayerSettingsModel
    with DiagnosticableTreeMixin {
  _$VideoPlayerSettingsModelImpl(
      {this.screenBrightness,
      this.videoFit = BoxFit.contain,
      this.fillScreen = false,
      this.hardwareAccel = true,
      this.useLibass = false,
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
      final Map<VideoHotKeys, KeyCombination> hotKeys = const {}})
      : _allowedOrientations = allowedOrientations,
        _segmentSkipSettings = segmentSkipSettings,
        _hotKeys = hotKeys,
        super._();

  factory _$VideoPlayerSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoPlayerSettingsModelImplFromJson(json);

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoPlayerSettingsModel(screenBrightness: $screenBrightness, videoFit: $videoFit, fillScreen: $fillScreen, hardwareAccel: $hardwareAccel, useLibass: $useLibass, bufferSize: $bufferSize, playerOptions: $playerOptions, internalVolume: $internalVolume, allowedOrientations: $allowedOrientations, nextVideoType: $nextVideoType, maxHomeBitrate: $maxHomeBitrate, maxInternetBitrate: $maxInternetBitrate, audioDevice: $audioDevice, segmentSkipSettings: $segmentSkipSettings, hotKeys: $hotKeys)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VideoPlayerSettingsModel'))
      ..add(DiagnosticsProperty('screenBrightness', screenBrightness))
      ..add(DiagnosticsProperty('videoFit', videoFit))
      ..add(DiagnosticsProperty('fillScreen', fillScreen))
      ..add(DiagnosticsProperty('hardwareAccel', hardwareAccel))
      ..add(DiagnosticsProperty('useLibass', useLibass))
      ..add(DiagnosticsProperty('bufferSize', bufferSize))
      ..add(DiagnosticsProperty('playerOptions', playerOptions))
      ..add(DiagnosticsProperty('internalVolume', internalVolume))
      ..add(DiagnosticsProperty('allowedOrientations', allowedOrientations))
      ..add(DiagnosticsProperty('nextVideoType', nextVideoType))
      ..add(DiagnosticsProperty('maxHomeBitrate', maxHomeBitrate))
      ..add(DiagnosticsProperty('maxInternetBitrate', maxInternetBitrate))
      ..add(DiagnosticsProperty('audioDevice', audioDevice))
      ..add(DiagnosticsProperty('segmentSkipSettings', segmentSkipSettings))
      ..add(DiagnosticsProperty('hotKeys', hotKeys));
  }

  /// Create a copy of VideoPlayerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoPlayerSettingsModelImplCopyWith<_$VideoPlayerSettingsModelImpl>
      get copyWith => __$$VideoPlayerSettingsModelImplCopyWithImpl<
          _$VideoPlayerSettingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoPlayerSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _VideoPlayerSettingsModel extends VideoPlayerSettingsModel {
  factory _VideoPlayerSettingsModel(
          {final double? screenBrightness,
          final BoxFit videoFit,
          final bool fillScreen,
          final bool hardwareAccel,
          final bool useLibass,
          final int bufferSize,
          final PlayerOptions? playerOptions,
          final double internalVolume,
          final Set<DeviceOrientation>? allowedOrientations,
          final AutoNextType nextVideoType,
          final Bitrate maxHomeBitrate,
          final Bitrate maxInternetBitrate,
          final String? audioDevice,
          final Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
          final Map<VideoHotKeys, KeyCombination> hotKeys}) =
      _$VideoPlayerSettingsModelImpl;
  _VideoPlayerSettingsModel._() : super._();

  factory _VideoPlayerSettingsModel.fromJson(Map<String, dynamic> json) =
      _$VideoPlayerSettingsModelImpl.fromJson;

  @override
  double? get screenBrightness;
  @override
  BoxFit get videoFit;
  @override
  bool get fillScreen;
  @override
  bool get hardwareAccel;
  @override
  bool get useLibass;
  @override
  int get bufferSize;
  @override
  PlayerOptions? get playerOptions;
  @override
  double get internalVolume;
  @override
  Set<DeviceOrientation>? get allowedOrientations;
  @override
  AutoNextType get nextVideoType;
  @override
  Bitrate get maxHomeBitrate;
  @override
  Bitrate get maxInternetBitrate;
  @override
  String? get audioDevice;
  @override
  Map<MediaSegmentType, SegmentSkip> get segmentSkipSettings;
  @override
  Map<VideoHotKeys, KeyCombination> get hotKeys;

  /// Create a copy of VideoPlayerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoPlayerSettingsModelImplCopyWith<_$VideoPlayerSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
