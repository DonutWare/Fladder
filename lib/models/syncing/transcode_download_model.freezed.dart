// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcode_download_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranscodeDownloadModel {
  bool get enabled;
  VideoCodec get videoCodec;
  AudioCodec get audioCodec;
  MaxHeight get maxHeight;
  VideoContainer get container;
  Bitrate get maxBitrate;

  /// Create a copy of TranscodeDownloadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TranscodeDownloadModelCopyWith<TranscodeDownloadModel> get copyWith =>
      _$TranscodeDownloadModelCopyWithImpl<TranscodeDownloadModel>(
          this as TranscodeDownloadModel, _$identity);

  /// Serializes this TranscodeDownloadModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'TranscodeDownloadModel(enabled: $enabled, videoCodec: $videoCodec, audioCodec: $audioCodec, maxHeight: $maxHeight, container: $container, maxBitrate: $maxBitrate)';
  }
}

/// @nodoc
abstract mixin class $TranscodeDownloadModelCopyWith<$Res> {
  factory $TranscodeDownloadModelCopyWith(TranscodeDownloadModel value,
          $Res Function(TranscodeDownloadModel) _then) =
      _$TranscodeDownloadModelCopyWithImpl;
  @useResult
  $Res call(
      {bool enabled,
      VideoCodec videoCodec,
      AudioCodec audioCodec,
      MaxHeight maxHeight,
      VideoContainer container,
      Bitrate maxBitrate});
}

/// @nodoc
class _$TranscodeDownloadModelCopyWithImpl<$Res>
    implements $TranscodeDownloadModelCopyWith<$Res> {
  _$TranscodeDownloadModelCopyWithImpl(this._self, this._then);

  final TranscodeDownloadModel _self;
  final $Res Function(TranscodeDownloadModel) _then;

  /// Create a copy of TranscodeDownloadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? videoCodec = null,
    Object? audioCodec = null,
    Object? maxHeight = null,
    Object? container = null,
    Object? maxBitrate = null,
  }) {
    return _then(_self.copyWith(
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      videoCodec: null == videoCodec
          ? _self.videoCodec
          : videoCodec // ignore: cast_nullable_to_non_nullable
              as VideoCodec,
      audioCodec: null == audioCodec
          ? _self.audioCodec
          : audioCodec // ignore: cast_nullable_to_non_nullable
              as AudioCodec,
      maxHeight: null == maxHeight
          ? _self.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as MaxHeight,
      container: null == container
          ? _self.container
          : container // ignore: cast_nullable_to_non_nullable
              as VideoContainer,
      maxBitrate: null == maxBitrate
          ? _self.maxBitrate
          : maxBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
    ));
  }
}

/// Adds pattern-matching-related methods to [TranscodeDownloadModel].
extension TranscodeDownloadModelPatterns on TranscodeDownloadModel {
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
    TResult Function(_TranscodeDownloadModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TranscodeDownloadModel() when $default != null:
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
    TResult Function(_TranscodeDownloadModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TranscodeDownloadModel():
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
    TResult? Function(_TranscodeDownloadModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TranscodeDownloadModel() when $default != null:
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
    TResult Function(bool enabled, VideoCodec videoCodec, AudioCodec audioCodec,
            MaxHeight maxHeight, VideoContainer container, Bitrate maxBitrate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TranscodeDownloadModel() when $default != null:
        return $default(_that.enabled, _that.videoCodec, _that.audioCodec,
            _that.maxHeight, _that.container, _that.maxBitrate);
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
    TResult Function(bool enabled, VideoCodec videoCodec, AudioCodec audioCodec,
            MaxHeight maxHeight, VideoContainer container, Bitrate maxBitrate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TranscodeDownloadModel():
        return $default(_that.enabled, _that.videoCodec, _that.audioCodec,
            _that.maxHeight, _that.container, _that.maxBitrate);
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
            bool enabled,
            VideoCodec videoCodec,
            AudioCodec audioCodec,
            MaxHeight maxHeight,
            VideoContainer container,
            Bitrate maxBitrate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TranscodeDownloadModel() when $default != null:
        return $default(_that.enabled, _that.videoCodec, _that.audioCodec,
            _that.maxHeight, _that.container, _that.maxBitrate);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TranscodeDownloadModel extends TranscodeDownloadModel {
  _TranscodeDownloadModel(
      {this.enabled = false,
      required this.videoCodec,
      required this.audioCodec,
      required this.maxHeight,
      required this.container,
      required this.maxBitrate})
      : super._();
  factory _TranscodeDownloadModel.fromJson(Map<String, dynamic> json) =>
      _$TranscodeDownloadModelFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  final VideoCodec videoCodec;
  @override
  final AudioCodec audioCodec;
  @override
  final MaxHeight maxHeight;
  @override
  final VideoContainer container;
  @override
  final Bitrate maxBitrate;

  /// Create a copy of TranscodeDownloadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TranscodeDownloadModelCopyWith<_TranscodeDownloadModel> get copyWith =>
      __$TranscodeDownloadModelCopyWithImpl<_TranscodeDownloadModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TranscodeDownloadModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'TranscodeDownloadModel(enabled: $enabled, videoCodec: $videoCodec, audioCodec: $audioCodec, maxHeight: $maxHeight, container: $container, maxBitrate: $maxBitrate)';
  }
}

/// @nodoc
abstract mixin class _$TranscodeDownloadModelCopyWith<$Res>
    implements $TranscodeDownloadModelCopyWith<$Res> {
  factory _$TranscodeDownloadModelCopyWith(_TranscodeDownloadModel value,
          $Res Function(_TranscodeDownloadModel) _then) =
      __$TranscodeDownloadModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool enabled,
      VideoCodec videoCodec,
      AudioCodec audioCodec,
      MaxHeight maxHeight,
      VideoContainer container,
      Bitrate maxBitrate});
}

/// @nodoc
class __$TranscodeDownloadModelCopyWithImpl<$Res>
    implements _$TranscodeDownloadModelCopyWith<$Res> {
  __$TranscodeDownloadModelCopyWithImpl(this._self, this._then);

  final _TranscodeDownloadModel _self;
  final $Res Function(_TranscodeDownloadModel) _then;

  /// Create a copy of TranscodeDownloadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enabled = null,
    Object? videoCodec = null,
    Object? audioCodec = null,
    Object? maxHeight = null,
    Object? container = null,
    Object? maxBitrate = null,
  }) {
    return _then(_TranscodeDownloadModel(
      enabled: null == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      videoCodec: null == videoCodec
          ? _self.videoCodec
          : videoCodec // ignore: cast_nullable_to_non_nullable
              as VideoCodec,
      audioCodec: null == audioCodec
          ? _self.audioCodec
          : audioCodec // ignore: cast_nullable_to_non_nullable
              as AudioCodec,
      maxHeight: null == maxHeight
          ? _self.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as MaxHeight,
      container: null == container
          ? _self.container
          : container // ignore: cast_nullable_to_non_nullable
              as VideoContainer,
      maxBitrate: null == maxBitrate
          ? _self.maxBitrate
          : maxBitrate // ignore: cast_nullable_to_non_nullable
              as Bitrate,
    ));
  }
}

// dart format on
