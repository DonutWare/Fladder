// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_tv_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveTvModel {
  DateTime get startDate;
  DateTime get endDate;
  List<ChannelModel> get channels;
  Set<String> get loadedChannelIds;
  Set<String> get loadingChannelIds;

  /// Create a copy of LiveTvModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LiveTvModelCopyWith<LiveTvModel> get copyWith =>
      _$LiveTvModelCopyWithImpl<LiveTvModel>(this as LiveTvModel, _$identity);

  @override
  String toString() {
    return 'LiveTvModel(startDate: $startDate, endDate: $endDate, channels: $channels, loadedChannelIds: $loadedChannelIds, loadingChannelIds: $loadingChannelIds)';
  }
}

/// @nodoc
abstract mixin class $LiveTvModelCopyWith<$Res> {
  factory $LiveTvModelCopyWith(
          LiveTvModel value, $Res Function(LiveTvModel) _then) =
      _$LiveTvModelCopyWithImpl;
  @useResult
  $Res call(
      {DateTime startDate,
      DateTime endDate,
      List<ChannelModel> channels,
      Set<String> loadedChannelIds,
      Set<String> loadingChannelIds});
}

/// @nodoc
class _$LiveTvModelCopyWithImpl<$Res> implements $LiveTvModelCopyWith<$Res> {
  _$LiveTvModelCopyWithImpl(this._self, this._then);

  final LiveTvModel _self;
  final $Res Function(LiveTvModel) _then;

  /// Create a copy of LiveTvModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? channels = null,
    Object? loadedChannelIds = null,
    Object? loadingChannelIds = null,
  }) {
    return _then(_self.copyWith(
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      channels: null == channels
          ? _self.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<ChannelModel>,
      loadedChannelIds: null == loadedChannelIds
          ? _self.loadedChannelIds
          : loadedChannelIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      loadingChannelIds: null == loadingChannelIds
          ? _self.loadingChannelIds
          : loadingChannelIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LiveTvModel].
extension LiveTvModelPatterns on LiveTvModel {
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
    TResult Function(_LiveTvModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LiveTvModel() when $default != null:
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
    TResult Function(_LiveTvModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveTvModel():
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
    TResult? Function(_LiveTvModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveTvModel() when $default != null:
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
            DateTime startDate,
            DateTime endDate,
            List<ChannelModel> channels,
            Set<String> loadedChannelIds,
            Set<String> loadingChannelIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LiveTvModel() when $default != null:
        return $default(_that.startDate, _that.endDate, _that.channels,
            _that.loadedChannelIds, _that.loadingChannelIds);
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
            DateTime startDate,
            DateTime endDate,
            List<ChannelModel> channels,
            Set<String> loadedChannelIds,
            Set<String> loadingChannelIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveTvModel():
        return $default(_that.startDate, _that.endDate, _that.channels,
            _that.loadedChannelIds, _that.loadingChannelIds);
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
            DateTime startDate,
            DateTime endDate,
            List<ChannelModel> channels,
            Set<String> loadedChannelIds,
            Set<String> loadingChannelIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveTvModel() when $default != null:
        return $default(_that.startDate, _that.endDate, _that.channels,
            _that.loadedChannelIds, _that.loadingChannelIds);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LiveTvModel implements LiveTvModel {
  _LiveTvModel(
      {required this.startDate,
      required this.endDate,
      final List<ChannelModel> channels = const [],
      final Set<String> loadedChannelIds = const {},
      final Set<String> loadingChannelIds = const {}})
      : _channels = channels,
        _loadedChannelIds = loadedChannelIds,
        _loadingChannelIds = loadingChannelIds;

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final List<ChannelModel> _channels;
  @override
  @JsonKey()
  List<ChannelModel> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  final Set<String> _loadedChannelIds;
  @override
  @JsonKey()
  Set<String> get loadedChannelIds {
    if (_loadedChannelIds is EqualUnmodifiableSetView) return _loadedChannelIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_loadedChannelIds);
  }

  final Set<String> _loadingChannelIds;
  @override
  @JsonKey()
  Set<String> get loadingChannelIds {
    if (_loadingChannelIds is EqualUnmodifiableSetView)
      return _loadingChannelIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_loadingChannelIds);
  }

  /// Create a copy of LiveTvModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LiveTvModelCopyWith<_LiveTvModel> get copyWith =>
      __$LiveTvModelCopyWithImpl<_LiveTvModel>(this, _$identity);

  @override
  String toString() {
    return 'LiveTvModel(startDate: $startDate, endDate: $endDate, channels: $channels, loadedChannelIds: $loadedChannelIds, loadingChannelIds: $loadingChannelIds)';
  }
}

/// @nodoc
abstract mixin class _$LiveTvModelCopyWith<$Res>
    implements $LiveTvModelCopyWith<$Res> {
  factory _$LiveTvModelCopyWith(
          _LiveTvModel value, $Res Function(_LiveTvModel) _then) =
      __$LiveTvModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {DateTime startDate,
      DateTime endDate,
      List<ChannelModel> channels,
      Set<String> loadedChannelIds,
      Set<String> loadingChannelIds});
}

/// @nodoc
class __$LiveTvModelCopyWithImpl<$Res> implements _$LiveTvModelCopyWith<$Res> {
  __$LiveTvModelCopyWithImpl(this._self, this._then);

  final _LiveTvModel _self;
  final $Res Function(_LiveTvModel) _then;

  /// Create a copy of LiveTvModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? channels = null,
    Object? loadedChannelIds = null,
    Object? loadingChannelIds = null,
  }) {
    return _then(_LiveTvModel(
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      channels: null == channels
          ? _self._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<ChannelModel>,
      loadedChannelIds: null == loadedChannelIds
          ? _self._loadedChannelIds
          : loadedChannelIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      loadingChannelIds: null == loadingChannelIds
          ? _self._loadingChannelIds
          : loadingChannelIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

// dart format on
