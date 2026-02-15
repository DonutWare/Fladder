// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_tuner_edit_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlTunerEditModel {
  String get url;
  String get friendlyName;
  String get userAgent;
  int get tunerCount;
  int get fallbackBitrateMbps;
  TunerType get selectedType;
  bool get allowFmp4Container;
  bool get allowStreamSharing;
  bool get enableStreamLooping;
  bool get ignoreDts;
  bool get readAtNativeFramerate;
  bool get importFavoritesOnly;
  bool get allowHWTranscoding;
  bool get isEditMode;
  bool get isDiscovering;
  String? get tunerId;
  String? get discoveryError;

  /// Create a copy of ControlTunerEditModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ControlTunerEditModelCopyWith<ControlTunerEditModel> get copyWith =>
      _$ControlTunerEditModelCopyWithImpl<ControlTunerEditModel>(
          this as ControlTunerEditModel, _$identity);

  @override
  String toString() {
    return 'ControlTunerEditModel(url: $url, friendlyName: $friendlyName, userAgent: $userAgent, tunerCount: $tunerCount, fallbackBitrateMbps: $fallbackBitrateMbps, selectedType: $selectedType, allowFmp4Container: $allowFmp4Container, allowStreamSharing: $allowStreamSharing, enableStreamLooping: $enableStreamLooping, ignoreDts: $ignoreDts, readAtNativeFramerate: $readAtNativeFramerate, importFavoritesOnly: $importFavoritesOnly, allowHWTranscoding: $allowHWTranscoding, isEditMode: $isEditMode, isDiscovering: $isDiscovering, tunerId: $tunerId, discoveryError: $discoveryError)';
  }
}

/// @nodoc
abstract mixin class $ControlTunerEditModelCopyWith<$Res> {
  factory $ControlTunerEditModelCopyWith(ControlTunerEditModel value,
          $Res Function(ControlTunerEditModel) _then) =
      _$ControlTunerEditModelCopyWithImpl;
  @useResult
  $Res call(
      {String url,
      String friendlyName,
      String userAgent,
      int tunerCount,
      int fallbackBitrateMbps,
      TunerType selectedType,
      bool allowFmp4Container,
      bool allowStreamSharing,
      bool enableStreamLooping,
      bool ignoreDts,
      bool readAtNativeFramerate,
      bool importFavoritesOnly,
      bool allowHWTranscoding,
      bool isEditMode,
      bool isDiscovering,
      String? tunerId,
      String? discoveryError});
}

/// @nodoc
class _$ControlTunerEditModelCopyWithImpl<$Res>
    implements $ControlTunerEditModelCopyWith<$Res> {
  _$ControlTunerEditModelCopyWithImpl(this._self, this._then);

  final ControlTunerEditModel _self;
  final $Res Function(ControlTunerEditModel) _then;

  /// Create a copy of ControlTunerEditModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? friendlyName = null,
    Object? userAgent = null,
    Object? tunerCount = null,
    Object? fallbackBitrateMbps = null,
    Object? selectedType = null,
    Object? allowFmp4Container = null,
    Object? allowStreamSharing = null,
    Object? enableStreamLooping = null,
    Object? ignoreDts = null,
    Object? readAtNativeFramerate = null,
    Object? importFavoritesOnly = null,
    Object? allowHWTranscoding = null,
    Object? isEditMode = null,
    Object? isDiscovering = null,
    Object? tunerId = freezed,
    Object? discoveryError = freezed,
  }) {
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      friendlyName: null == friendlyName
          ? _self.friendlyName
          : friendlyName // ignore: cast_nullable_to_non_nullable
              as String,
      userAgent: null == userAgent
          ? _self.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      tunerCount: null == tunerCount
          ? _self.tunerCount
          : tunerCount // ignore: cast_nullable_to_non_nullable
              as int,
      fallbackBitrateMbps: null == fallbackBitrateMbps
          ? _self.fallbackBitrateMbps
          : fallbackBitrateMbps // ignore: cast_nullable_to_non_nullable
              as int,
      selectedType: null == selectedType
          ? _self.selectedType
          : selectedType // ignore: cast_nullable_to_non_nullable
              as TunerType,
      allowFmp4Container: null == allowFmp4Container
          ? _self.allowFmp4Container
          : allowFmp4Container // ignore: cast_nullable_to_non_nullable
              as bool,
      allowStreamSharing: null == allowStreamSharing
          ? _self.allowStreamSharing
          : allowStreamSharing // ignore: cast_nullable_to_non_nullable
              as bool,
      enableStreamLooping: null == enableStreamLooping
          ? _self.enableStreamLooping
          : enableStreamLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      ignoreDts: null == ignoreDts
          ? _self.ignoreDts
          : ignoreDts // ignore: cast_nullable_to_non_nullable
              as bool,
      readAtNativeFramerate: null == readAtNativeFramerate
          ? _self.readAtNativeFramerate
          : readAtNativeFramerate // ignore: cast_nullable_to_non_nullable
              as bool,
      importFavoritesOnly: null == importFavoritesOnly
          ? _self.importFavoritesOnly
          : importFavoritesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      allowHWTranscoding: null == allowHWTranscoding
          ? _self.allowHWTranscoding
          : allowHWTranscoding // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _self.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isDiscovering: null == isDiscovering
          ? _self.isDiscovering
          : isDiscovering // ignore: cast_nullable_to_non_nullable
              as bool,
      tunerId: freezed == tunerId
          ? _self.tunerId
          : tunerId // ignore: cast_nullable_to_non_nullable
              as String?,
      discoveryError: freezed == discoveryError
          ? _self.discoveryError
          : discoveryError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ControlTunerEditModel].
extension ControlTunerEditModelPatterns on ControlTunerEditModel {
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
    TResult Function(_ControlTunerEditModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlTunerEditModel() when $default != null:
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
    TResult Function(_ControlTunerEditModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlTunerEditModel():
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
    TResult? Function(_ControlTunerEditModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlTunerEditModel() when $default != null:
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
            String url,
            String friendlyName,
            String userAgent,
            int tunerCount,
            int fallbackBitrateMbps,
            TunerType selectedType,
            bool allowFmp4Container,
            bool allowStreamSharing,
            bool enableStreamLooping,
            bool ignoreDts,
            bool readAtNativeFramerate,
            bool importFavoritesOnly,
            bool allowHWTranscoding,
            bool isEditMode,
            bool isDiscovering,
            String? tunerId,
            String? discoveryError)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlTunerEditModel() when $default != null:
        return $default(
            _that.url,
            _that.friendlyName,
            _that.userAgent,
            _that.tunerCount,
            _that.fallbackBitrateMbps,
            _that.selectedType,
            _that.allowFmp4Container,
            _that.allowStreamSharing,
            _that.enableStreamLooping,
            _that.ignoreDts,
            _that.readAtNativeFramerate,
            _that.importFavoritesOnly,
            _that.allowHWTranscoding,
            _that.isEditMode,
            _that.isDiscovering,
            _that.tunerId,
            _that.discoveryError);
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
            String url,
            String friendlyName,
            String userAgent,
            int tunerCount,
            int fallbackBitrateMbps,
            TunerType selectedType,
            bool allowFmp4Container,
            bool allowStreamSharing,
            bool enableStreamLooping,
            bool ignoreDts,
            bool readAtNativeFramerate,
            bool importFavoritesOnly,
            bool allowHWTranscoding,
            bool isEditMode,
            bool isDiscovering,
            String? tunerId,
            String? discoveryError)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlTunerEditModel():
        return $default(
            _that.url,
            _that.friendlyName,
            _that.userAgent,
            _that.tunerCount,
            _that.fallbackBitrateMbps,
            _that.selectedType,
            _that.allowFmp4Container,
            _that.allowStreamSharing,
            _that.enableStreamLooping,
            _that.ignoreDts,
            _that.readAtNativeFramerate,
            _that.importFavoritesOnly,
            _that.allowHWTranscoding,
            _that.isEditMode,
            _that.isDiscovering,
            _that.tunerId,
            _that.discoveryError);
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
            String url,
            String friendlyName,
            String userAgent,
            int tunerCount,
            int fallbackBitrateMbps,
            TunerType selectedType,
            bool allowFmp4Container,
            bool allowStreamSharing,
            bool enableStreamLooping,
            bool ignoreDts,
            bool readAtNativeFramerate,
            bool importFavoritesOnly,
            bool allowHWTranscoding,
            bool isEditMode,
            bool isDiscovering,
            String? tunerId,
            String? discoveryError)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlTunerEditModel() when $default != null:
        return $default(
            _that.url,
            _that.friendlyName,
            _that.userAgent,
            _that.tunerCount,
            _that.fallbackBitrateMbps,
            _that.selectedType,
            _that.allowFmp4Container,
            _that.allowStreamSharing,
            _that.enableStreamLooping,
            _that.ignoreDts,
            _that.readAtNativeFramerate,
            _that.importFavoritesOnly,
            _that.allowHWTranscoding,
            _that.isEditMode,
            _that.isDiscovering,
            _that.tunerId,
            _that.discoveryError);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ControlTunerEditModel implements ControlTunerEditModel {
  _ControlTunerEditModel(
      {this.url = '',
      this.friendlyName = '',
      this.userAgent = '',
      this.tunerCount = 0,
      this.fallbackBitrateMbps = 30,
      this.selectedType = TunerType.m3u,
      this.allowFmp4Container = false,
      this.allowStreamSharing = true,
      this.enableStreamLooping = false,
      this.ignoreDts = false,
      this.readAtNativeFramerate = false,
      this.importFavoritesOnly = false,
      this.allowHWTranscoding = false,
      this.isEditMode = false,
      this.isDiscovering = false,
      this.tunerId,
      this.discoveryError});

  @override
  @JsonKey()
  final String url;
  @override
  @JsonKey()
  final String friendlyName;
  @override
  @JsonKey()
  final String userAgent;
  @override
  @JsonKey()
  final int tunerCount;
  @override
  @JsonKey()
  final int fallbackBitrateMbps;
  @override
  @JsonKey()
  final TunerType selectedType;
  @override
  @JsonKey()
  final bool allowFmp4Container;
  @override
  @JsonKey()
  final bool allowStreamSharing;
  @override
  @JsonKey()
  final bool enableStreamLooping;
  @override
  @JsonKey()
  final bool ignoreDts;
  @override
  @JsonKey()
  final bool readAtNativeFramerate;
  @override
  @JsonKey()
  final bool importFavoritesOnly;
  @override
  @JsonKey()
  final bool allowHWTranscoding;
  @override
  @JsonKey()
  final bool isEditMode;
  @override
  @JsonKey()
  final bool isDiscovering;
  @override
  final String? tunerId;
  @override
  final String? discoveryError;

  /// Create a copy of ControlTunerEditModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ControlTunerEditModelCopyWith<_ControlTunerEditModel> get copyWith =>
      __$ControlTunerEditModelCopyWithImpl<_ControlTunerEditModel>(
          this, _$identity);

  @override
  String toString() {
    return 'ControlTunerEditModel(url: $url, friendlyName: $friendlyName, userAgent: $userAgent, tunerCount: $tunerCount, fallbackBitrateMbps: $fallbackBitrateMbps, selectedType: $selectedType, allowFmp4Container: $allowFmp4Container, allowStreamSharing: $allowStreamSharing, enableStreamLooping: $enableStreamLooping, ignoreDts: $ignoreDts, readAtNativeFramerate: $readAtNativeFramerate, importFavoritesOnly: $importFavoritesOnly, allowHWTranscoding: $allowHWTranscoding, isEditMode: $isEditMode, isDiscovering: $isDiscovering, tunerId: $tunerId, discoveryError: $discoveryError)';
  }
}

/// @nodoc
abstract mixin class _$ControlTunerEditModelCopyWith<$Res>
    implements $ControlTunerEditModelCopyWith<$Res> {
  factory _$ControlTunerEditModelCopyWith(_ControlTunerEditModel value,
          $Res Function(_ControlTunerEditModel) _then) =
      __$ControlTunerEditModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String url,
      String friendlyName,
      String userAgent,
      int tunerCount,
      int fallbackBitrateMbps,
      TunerType selectedType,
      bool allowFmp4Container,
      bool allowStreamSharing,
      bool enableStreamLooping,
      bool ignoreDts,
      bool readAtNativeFramerate,
      bool importFavoritesOnly,
      bool allowHWTranscoding,
      bool isEditMode,
      bool isDiscovering,
      String? tunerId,
      String? discoveryError});
}

/// @nodoc
class __$ControlTunerEditModelCopyWithImpl<$Res>
    implements _$ControlTunerEditModelCopyWith<$Res> {
  __$ControlTunerEditModelCopyWithImpl(this._self, this._then);

  final _ControlTunerEditModel _self;
  final $Res Function(_ControlTunerEditModel) _then;

  /// Create a copy of ControlTunerEditModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
    Object? friendlyName = null,
    Object? userAgent = null,
    Object? tunerCount = null,
    Object? fallbackBitrateMbps = null,
    Object? selectedType = null,
    Object? allowFmp4Container = null,
    Object? allowStreamSharing = null,
    Object? enableStreamLooping = null,
    Object? ignoreDts = null,
    Object? readAtNativeFramerate = null,
    Object? importFavoritesOnly = null,
    Object? allowHWTranscoding = null,
    Object? isEditMode = null,
    Object? isDiscovering = null,
    Object? tunerId = freezed,
    Object? discoveryError = freezed,
  }) {
    return _then(_ControlTunerEditModel(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      friendlyName: null == friendlyName
          ? _self.friendlyName
          : friendlyName // ignore: cast_nullable_to_non_nullable
              as String,
      userAgent: null == userAgent
          ? _self.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      tunerCount: null == tunerCount
          ? _self.tunerCount
          : tunerCount // ignore: cast_nullable_to_non_nullable
              as int,
      fallbackBitrateMbps: null == fallbackBitrateMbps
          ? _self.fallbackBitrateMbps
          : fallbackBitrateMbps // ignore: cast_nullable_to_non_nullable
              as int,
      selectedType: null == selectedType
          ? _self.selectedType
          : selectedType // ignore: cast_nullable_to_non_nullable
              as TunerType,
      allowFmp4Container: null == allowFmp4Container
          ? _self.allowFmp4Container
          : allowFmp4Container // ignore: cast_nullable_to_non_nullable
              as bool,
      allowStreamSharing: null == allowStreamSharing
          ? _self.allowStreamSharing
          : allowStreamSharing // ignore: cast_nullable_to_non_nullable
              as bool,
      enableStreamLooping: null == enableStreamLooping
          ? _self.enableStreamLooping
          : enableStreamLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      ignoreDts: null == ignoreDts
          ? _self.ignoreDts
          : ignoreDts // ignore: cast_nullable_to_non_nullable
              as bool,
      readAtNativeFramerate: null == readAtNativeFramerate
          ? _self.readAtNativeFramerate
          : readAtNativeFramerate // ignore: cast_nullable_to_non_nullable
              as bool,
      importFavoritesOnly: null == importFavoritesOnly
          ? _self.importFavoritesOnly
          : importFavoritesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      allowHWTranscoding: null == allowHWTranscoding
          ? _self.allowHWTranscoding
          : allowHWTranscoding // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _self.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isDiscovering: null == isDiscovering
          ? _self.isDiscovering
          : isDiscovering // ignore: cast_nullable_to_non_nullable
              as bool,
      tunerId: freezed == tunerId
          ? _self.tunerId
          : tunerId // ignore: cast_nullable_to_non_nullable
              as String?,
      discoveryError: freezed == discoveryError
          ? _self.discoveryError
          : discoveryError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
