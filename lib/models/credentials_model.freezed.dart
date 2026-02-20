// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credentials_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CredentialsModel implements DiagnosticableTreeMixin {
  String get token;
  String get url;
  String? get localUrl;
  String get serverName;
  String get serverId;
  String get deviceId;

  /// Create a copy of CredentialsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CredentialsModelCopyWith<CredentialsModel> get copyWith =>
      _$CredentialsModelCopyWithImpl<CredentialsModel>(
          this as CredentialsModel, _$identity);

  /// Serializes this CredentialsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CredentialsModel'))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('localUrl', localUrl))
      ..add(DiagnosticsProperty('serverName', serverName))
      ..add(DiagnosticsProperty('serverId', serverId))
      ..add(DiagnosticsProperty('deviceId', deviceId));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CredentialsModel(token: $token, url: $url, localUrl: $localUrl, serverName: $serverName, serverId: $serverId, deviceId: $deviceId)';
  }
}

/// @nodoc
abstract mixin class $CredentialsModelCopyWith<$Res> {
  factory $CredentialsModelCopyWith(
          CredentialsModel value, $Res Function(CredentialsModel) _then) =
      _$CredentialsModelCopyWithImpl;
  @useResult
  $Res call(
      {String token,
      String url,
      String? localUrl,
      String serverName,
      String serverId,
      String deviceId});
}

/// @nodoc
class _$CredentialsModelCopyWithImpl<$Res>
    implements $CredentialsModelCopyWith<$Res> {
  _$CredentialsModelCopyWithImpl(this._self, this._then);

  final CredentialsModel _self;
  final $Res Function(CredentialsModel) _then;

  /// Create a copy of CredentialsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? url = null,
    Object? localUrl = freezed,
    Object? serverName = null,
    Object? serverId = null,
    Object? deviceId = null,
  }) {
    return _then(_self.copyWith(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      localUrl: freezed == localUrl
          ? _self.localUrl
          : localUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      serverName: null == serverName
          ? _self.serverName
          : serverName // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: null == serverId
          ? _self.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CredentialsModel].
extension CredentialsModelPatterns on CredentialsModel {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CredentialsModel value)? internal,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CredentialsModel() when internal != null:
        return internal(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_CredentialsModel value) internal,
  }) {
    final _that = this;
    switch (_that) {
      case _CredentialsModel():
        return internal(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CredentialsModel value)? internal,
  }) {
    final _that = this;
    switch (_that) {
      case _CredentialsModel() when internal != null:
        return internal(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token, String url, String? localUrl,
            String serverName, String serverId, String deviceId)?
        internal,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CredentialsModel() when internal != null:
        return internal(_that.token, _that.url, _that.localUrl,
            _that.serverName, _that.serverId, _that.deviceId);
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
  TResult when<TResult extends Object?>({
    required TResult Function(String token, String url, String? localUrl,
            String serverName, String serverId, String deviceId)
        internal,
  }) {
    final _that = this;
    switch (_that) {
      case _CredentialsModel():
        return internal(_that.token, _that.url, _that.localUrl,
            _that.serverName, _that.serverId, _that.deviceId);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token, String url, String? localUrl,
            String serverName, String serverId, String deviceId)?
        internal,
  }) {
    final _that = this;
    switch (_that) {
      case _CredentialsModel() when internal != null:
        return internal(_that.token, _that.url, _that.localUrl,
            _that.serverName, _that.serverId, _that.deviceId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CredentialsModel extends CredentialsModel with DiagnosticableTreeMixin {
  _CredentialsModel(
      {this.token = "",
      this.url = "",
      this.localUrl,
      this.serverName = "",
      this.serverId = "",
      this.deviceId = ""})
      : super._();
  factory _CredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$CredentialsModelFromJson(json);

  @override
  @JsonKey()
  final String token;
  @override
  @JsonKey()
  final String url;
  @override
  final String? localUrl;
  @override
  @JsonKey()
  final String serverName;
  @override
  @JsonKey()
  final String serverId;
  @override
  @JsonKey()
  final String deviceId;

  /// Create a copy of CredentialsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CredentialsModelCopyWith<_CredentialsModel> get copyWith =>
      __$CredentialsModelCopyWithImpl<_CredentialsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CredentialsModelToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CredentialsModel.internal'))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('localUrl', localUrl))
      ..add(DiagnosticsProperty('serverName', serverName))
      ..add(DiagnosticsProperty('serverId', serverId))
      ..add(DiagnosticsProperty('deviceId', deviceId));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CredentialsModel.internal(token: $token, url: $url, localUrl: $localUrl, serverName: $serverName, serverId: $serverId, deviceId: $deviceId)';
  }
}

/// @nodoc
abstract mixin class _$CredentialsModelCopyWith<$Res>
    implements $CredentialsModelCopyWith<$Res> {
  factory _$CredentialsModelCopyWith(
          _CredentialsModel value, $Res Function(_CredentialsModel) _then) =
      __$CredentialsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String token,
      String url,
      String? localUrl,
      String serverName,
      String serverId,
      String deviceId});
}

/// @nodoc
class __$CredentialsModelCopyWithImpl<$Res>
    implements _$CredentialsModelCopyWith<$Res> {
  __$CredentialsModelCopyWithImpl(this._self, this._then);

  final _CredentialsModel _self;
  final $Res Function(_CredentialsModel) _then;

  /// Create a copy of CredentialsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
    Object? url = null,
    Object? localUrl = freezed,
    Object? serverName = null,
    Object? serverId = null,
    Object? deviceId = null,
  }) {
    return _then(_CredentialsModel(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      localUrl: freezed == localUrl
          ? _self.localUrl
          : localUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      serverName: null == serverName
          ? _self.serverName
          : serverName // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: null == serverId
          ? _self.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
