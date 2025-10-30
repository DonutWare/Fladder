// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trick_play_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrickPlayModel {
  int get width;
  int get height;
  int get tileWidth;
  int get tileHeight;
  int get thumbnailCount;
  Duration get interval;
  List<String> get images;

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrickPlayModelCopyWith<TrickPlayModel> get copyWith =>
      _$TrickPlayModelCopyWithImpl<TrickPlayModel>(
          this as TrickPlayModel, _$identity);

  /// Serializes this TrickPlayModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'TrickPlayModel(width: $width, height: $height, tileWidth: $tileWidth, tileHeight: $tileHeight, thumbnailCount: $thumbnailCount, interval: $interval, images: $images)';
  }
}

/// @nodoc
abstract mixin class $TrickPlayModelCopyWith<$Res> {
  factory $TrickPlayModelCopyWith(
          TrickPlayModel value, $Res Function(TrickPlayModel) _then) =
      _$TrickPlayModelCopyWithImpl;
  @useResult
  $Res call(
      {int width,
      int height,
      int tileWidth,
      int tileHeight,
      int thumbnailCount,
      Duration interval,
      List<String> images});
}

/// @nodoc
class _$TrickPlayModelCopyWithImpl<$Res>
    implements $TrickPlayModelCopyWith<$Res> {
  _$TrickPlayModelCopyWithImpl(this._self, this._then);

  final TrickPlayModel _self;
  final $Res Function(TrickPlayModel) _then;

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? tileWidth = null,
    Object? tileHeight = null,
    Object? thumbnailCount = null,
    Object? interval = null,
    Object? images = null,
  }) {
    return _then(_self.copyWith(
      width: null == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      tileWidth: null == tileWidth
          ? _self.tileWidth
          : tileWidth // ignore: cast_nullable_to_non_nullable
              as int,
      tileHeight: null == tileHeight
          ? _self.tileHeight
          : tileHeight // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailCount: null == thumbnailCount
          ? _self.thumbnailCount
          : thumbnailCount // ignore: cast_nullable_to_non_nullable
              as int,
      interval: null == interval
          ? _self.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
      images: null == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TrickPlayModel].
extension TrickPlayModelPatterns on TrickPlayModel {
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
    TResult Function(_TrickPlayModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrickPlayModel() when $default != null:
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
    TResult Function(_TrickPlayModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrickPlayModel():
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
    TResult? Function(_TrickPlayModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrickPlayModel() when $default != null:
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
    TResult Function(int width, int height, int tileWidth, int tileHeight,
            int thumbnailCount, Duration interval, List<String> images)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrickPlayModel() when $default != null:
        return $default(
            _that.width,
            _that.height,
            _that.tileWidth,
            _that.tileHeight,
            _that.thumbnailCount,
            _that.interval,
            _that.images);
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
    TResult Function(int width, int height, int tileWidth, int tileHeight,
            int thumbnailCount, Duration interval, List<String> images)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrickPlayModel():
        return $default(
            _that.width,
            _that.height,
            _that.tileWidth,
            _that.tileHeight,
            _that.thumbnailCount,
            _that.interval,
            _that.images);
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
    TResult? Function(int width, int height, int tileWidth, int tileHeight,
            int thumbnailCount, Duration interval, List<String> images)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrickPlayModel() when $default != null:
        return $default(
            _that.width,
            _that.height,
            _that.tileWidth,
            _that.tileHeight,
            _that.thumbnailCount,
            _that.interval,
            _that.images);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TrickPlayModel extends TrickPlayModel {
  _TrickPlayModel(
      {required this.width,
      required this.height,
      required this.tileWidth,
      required this.tileHeight,
      required this.thumbnailCount,
      required this.interval,
      final List<String> images = const []})
      : _images = images,
        super._();
  factory _TrickPlayModel.fromJson(Map<String, dynamic> json) =>
      _$TrickPlayModelFromJson(json);

  @override
  final int width;
  @override
  final int height;
  @override
  final int tileWidth;
  @override
  final int tileHeight;
  @override
  final int thumbnailCount;
  @override
  final Duration interval;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrickPlayModelCopyWith<_TrickPlayModel> get copyWith =>
      __$TrickPlayModelCopyWithImpl<_TrickPlayModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrickPlayModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'TrickPlayModel(width: $width, height: $height, tileWidth: $tileWidth, tileHeight: $tileHeight, thumbnailCount: $thumbnailCount, interval: $interval, images: $images)';
  }
}

/// @nodoc
abstract mixin class _$TrickPlayModelCopyWith<$Res>
    implements $TrickPlayModelCopyWith<$Res> {
  factory _$TrickPlayModelCopyWith(
          _TrickPlayModel value, $Res Function(_TrickPlayModel) _then) =
      __$TrickPlayModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int width,
      int height,
      int tileWidth,
      int tileHeight,
      int thumbnailCount,
      Duration interval,
      List<String> images});
}

/// @nodoc
class __$TrickPlayModelCopyWithImpl<$Res>
    implements _$TrickPlayModelCopyWith<$Res> {
  __$TrickPlayModelCopyWithImpl(this._self, this._then);

  final _TrickPlayModel _self;
  final $Res Function(_TrickPlayModel) _then;

  /// Create a copy of TrickPlayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? tileWidth = null,
    Object? tileHeight = null,
    Object? thumbnailCount = null,
    Object? interval = null,
    Object? images = null,
  }) {
    return _then(_TrickPlayModel(
      width: null == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      tileWidth: null == tileWidth
          ? _self.tileWidth
          : tileWidth // ignore: cast_nullable_to_non_nullable
              as int,
      tileHeight: null == tileHeight
          ? _self.tileHeight
          : tileHeight // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailCount: null == thumbnailCount
          ? _self.thumbnailCount
          : thumbnailCount // ignore: cast_nullable_to_non_nullable
              as int,
      interval: null == interval
          ? _self.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
      images: null == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
