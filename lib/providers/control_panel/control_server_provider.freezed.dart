// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_server_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlServerModel {
  String get name;
  jelly.LocalizationOption? get language;
  List<jelly.LocalizationOption>? get availableLanguages;
  String get cachePath;
  String get metaDataPath;
  bool get quickConnectEnabled;
  int get maxConcurrentLibraryScan;
  int get maxImageDecodingThreads;

  /// Create a copy of ControlServerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ControlServerModelCopyWith<ControlServerModel> get copyWith =>
      _$ControlServerModelCopyWithImpl<ControlServerModel>(
          this as ControlServerModel, _$identity);

  @override
  String toString() {
    return 'ControlServerModel(name: $name, language: $language, availableLanguages: $availableLanguages, cachePath: $cachePath, metaDataPath: $metaDataPath, quickConnectEnabled: $quickConnectEnabled, maxConcurrentLibraryScan: $maxConcurrentLibraryScan, maxImageDecodingThreads: $maxImageDecodingThreads)';
  }
}

/// @nodoc
abstract mixin class $ControlServerModelCopyWith<$Res> {
  factory $ControlServerModelCopyWith(
          ControlServerModel value, $Res Function(ControlServerModel) _then) =
      _$ControlServerModelCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      jelly.LocalizationOption? language,
      List<jelly.LocalizationOption>? availableLanguages,
      String cachePath,
      String metaDataPath,
      bool quickConnectEnabled,
      int maxConcurrentLibraryScan,
      int maxImageDecodingThreads});
}

/// @nodoc
class _$ControlServerModelCopyWithImpl<$Res>
    implements $ControlServerModelCopyWith<$Res> {
  _$ControlServerModelCopyWithImpl(this._self, this._then);

  final ControlServerModel _self;
  final $Res Function(ControlServerModel) _then;

  /// Create a copy of ControlServerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? language = freezed,
    Object? availableLanguages = freezed,
    Object? cachePath = null,
    Object? metaDataPath = null,
    Object? quickConnectEnabled = null,
    Object? maxConcurrentLibraryScan = null,
    Object? maxImageDecodingThreads = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as jelly.LocalizationOption?,
      availableLanguages: freezed == availableLanguages
          ? _self.availableLanguages
          : availableLanguages // ignore: cast_nullable_to_non_nullable
              as List<jelly.LocalizationOption>?,
      cachePath: null == cachePath
          ? _self.cachePath
          : cachePath // ignore: cast_nullable_to_non_nullable
              as String,
      metaDataPath: null == metaDataPath
          ? _self.metaDataPath
          : metaDataPath // ignore: cast_nullable_to_non_nullable
              as String,
      quickConnectEnabled: null == quickConnectEnabled
          ? _self.quickConnectEnabled
          : quickConnectEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      maxConcurrentLibraryScan: null == maxConcurrentLibraryScan
          ? _self.maxConcurrentLibraryScan
          : maxConcurrentLibraryScan // ignore: cast_nullable_to_non_nullable
              as int,
      maxImageDecodingThreads: null == maxImageDecodingThreads
          ? _self.maxImageDecodingThreads
          : maxImageDecodingThreads // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ControlServerModel].
extension ControlServerModelPatterns on ControlServerModel {
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
    TResult Function(_ControlServerModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlServerModel() when $default != null:
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
    TResult Function(_ControlServerModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlServerModel():
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
    TResult? Function(_ControlServerModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlServerModel() when $default != null:
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
            String name,
            jelly.LocalizationOption? language,
            List<jelly.LocalizationOption>? availableLanguages,
            String cachePath,
            String metaDataPath,
            bool quickConnectEnabled,
            int maxConcurrentLibraryScan,
            int maxImageDecodingThreads)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlServerModel() when $default != null:
        return $default(
            _that.name,
            _that.language,
            _that.availableLanguages,
            _that.cachePath,
            _that.metaDataPath,
            _that.quickConnectEnabled,
            _that.maxConcurrentLibraryScan,
            _that.maxImageDecodingThreads);
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
            String name,
            jelly.LocalizationOption? language,
            List<jelly.LocalizationOption>? availableLanguages,
            String cachePath,
            String metaDataPath,
            bool quickConnectEnabled,
            int maxConcurrentLibraryScan,
            int maxImageDecodingThreads)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlServerModel():
        return $default(
            _that.name,
            _that.language,
            _that.availableLanguages,
            _that.cachePath,
            _that.metaDataPath,
            _that.quickConnectEnabled,
            _that.maxConcurrentLibraryScan,
            _that.maxImageDecodingThreads);
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
            String name,
            jelly.LocalizationOption? language,
            List<jelly.LocalizationOption>? availableLanguages,
            String cachePath,
            String metaDataPath,
            bool quickConnectEnabled,
            int maxConcurrentLibraryScan,
            int maxImageDecodingThreads)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlServerModel() when $default != null:
        return $default(
            _that.name,
            _that.language,
            _that.availableLanguages,
            _that.cachePath,
            _that.metaDataPath,
            _that.quickConnectEnabled,
            _that.maxConcurrentLibraryScan,
            _that.maxImageDecodingThreads);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ControlServerModel implements ControlServerModel {
  _ControlServerModel(
      {this.name = "",
      this.language,
      final List<jelly.LocalizationOption>? availableLanguages,
      this.cachePath = "",
      this.metaDataPath = "",
      this.quickConnectEnabled = false,
      this.maxConcurrentLibraryScan = 1,
      this.maxImageDecodingThreads = 1})
      : _availableLanguages = availableLanguages;

  @override
  @JsonKey()
  final String name;
  @override
  final jelly.LocalizationOption? language;
  final List<jelly.LocalizationOption>? _availableLanguages;
  @override
  List<jelly.LocalizationOption>? get availableLanguages {
    final value = _availableLanguages;
    if (value == null) return null;
    if (_availableLanguages is EqualUnmodifiableListView)
      return _availableLanguages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final String cachePath;
  @override
  @JsonKey()
  final String metaDataPath;
  @override
  @JsonKey()
  final bool quickConnectEnabled;
  @override
  @JsonKey()
  final int maxConcurrentLibraryScan;
  @override
  @JsonKey()
  final int maxImageDecodingThreads;

  /// Create a copy of ControlServerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ControlServerModelCopyWith<_ControlServerModel> get copyWith =>
      __$ControlServerModelCopyWithImpl<_ControlServerModel>(this, _$identity);

  @override
  String toString() {
    return 'ControlServerModel(name: $name, language: $language, availableLanguages: $availableLanguages, cachePath: $cachePath, metaDataPath: $metaDataPath, quickConnectEnabled: $quickConnectEnabled, maxConcurrentLibraryScan: $maxConcurrentLibraryScan, maxImageDecodingThreads: $maxImageDecodingThreads)';
  }
}

/// @nodoc
abstract mixin class _$ControlServerModelCopyWith<$Res>
    implements $ControlServerModelCopyWith<$Res> {
  factory _$ControlServerModelCopyWith(
          _ControlServerModel value, $Res Function(_ControlServerModel) _then) =
      __$ControlServerModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      jelly.LocalizationOption? language,
      List<jelly.LocalizationOption>? availableLanguages,
      String cachePath,
      String metaDataPath,
      bool quickConnectEnabled,
      int maxConcurrentLibraryScan,
      int maxImageDecodingThreads});
}

/// @nodoc
class __$ControlServerModelCopyWithImpl<$Res>
    implements _$ControlServerModelCopyWith<$Res> {
  __$ControlServerModelCopyWithImpl(this._self, this._then);

  final _ControlServerModel _self;
  final $Res Function(_ControlServerModel) _then;

  /// Create a copy of ControlServerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? language = freezed,
    Object? availableLanguages = freezed,
    Object? cachePath = null,
    Object? metaDataPath = null,
    Object? quickConnectEnabled = null,
    Object? maxConcurrentLibraryScan = null,
    Object? maxImageDecodingThreads = null,
  }) {
    return _then(_ControlServerModel(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as jelly.LocalizationOption?,
      availableLanguages: freezed == availableLanguages
          ? _self._availableLanguages
          : availableLanguages // ignore: cast_nullable_to_non_nullable
              as List<jelly.LocalizationOption>?,
      cachePath: null == cachePath
          ? _self.cachePath
          : cachePath // ignore: cast_nullable_to_non_nullable
              as String,
      metaDataPath: null == metaDataPath
          ? _self.metaDataPath
          : metaDataPath // ignore: cast_nullable_to_non_nullable
              as String,
      quickConnectEnabled: null == quickConnectEnabled
          ? _self.quickConnectEnabled
          : quickConnectEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      maxConcurrentLibraryScan: null == maxConcurrentLibraryScan
          ? _self.maxConcurrentLibraryScan
          : maxConcurrentLibraryScan // ignore: cast_nullable_to_non_nullable
              as int,
      maxImageDecodingThreads: null == maxImageDecodingThreads
          ? _self.maxImageDecodingThreads
          : maxImageDecodingThreads // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
