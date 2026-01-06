// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directory_browser_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DirectoryBrowserModel {
  String? get parentFolder;
  String? get currentPath;
  List<String> get paths;
  bool get loading;

  /// Create a copy of DirectoryBrowserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectoryBrowserModelCopyWith<DirectoryBrowserModel> get copyWith =>
      _$DirectoryBrowserModelCopyWithImpl<DirectoryBrowserModel>(
          this as DirectoryBrowserModel, _$identity);

  @override
  String toString() {
    return 'DirectoryBrowserModel(parentFolder: $parentFolder, currentPath: $currentPath, paths: $paths, loading: $loading)';
  }
}

/// @nodoc
abstract mixin class $DirectoryBrowserModelCopyWith<$Res> {
  factory $DirectoryBrowserModelCopyWith(DirectoryBrowserModel value,
          $Res Function(DirectoryBrowserModel) _then) =
      _$DirectoryBrowserModelCopyWithImpl;
  @useResult
  $Res call(
      {String? parentFolder,
      String? currentPath,
      List<String> paths,
      bool loading});
}

/// @nodoc
class _$DirectoryBrowserModelCopyWithImpl<$Res>
    implements $DirectoryBrowserModelCopyWith<$Res> {
  _$DirectoryBrowserModelCopyWithImpl(this._self, this._then);

  final DirectoryBrowserModel _self;
  final $Res Function(DirectoryBrowserModel) _then;

  /// Create a copy of DirectoryBrowserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentFolder = freezed,
    Object? currentPath = freezed,
    Object? paths = null,
    Object? loading = null,
  }) {
    return _then(_self.copyWith(
      parentFolder: freezed == parentFolder
          ? _self.parentFolder
          : parentFolder // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPath: freezed == currentPath
          ? _self.currentPath
          : currentPath // ignore: cast_nullable_to_non_nullable
              as String?,
      paths: null == paths
          ? _self.paths
          : paths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [DirectoryBrowserModel].
extension DirectoryBrowserModelPatterns on DirectoryBrowserModel {
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
    TResult Function(_DirectoryBrowserModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DirectoryBrowserModel() when $default != null:
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
    TResult Function(_DirectoryBrowserModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectoryBrowserModel():
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
    TResult? Function(_DirectoryBrowserModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectoryBrowserModel() when $default != null:
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
    TResult Function(String? parentFolder, String? currentPath,
            List<String> paths, bool loading)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DirectoryBrowserModel() when $default != null:
        return $default(
            _that.parentFolder, _that.currentPath, _that.paths, _that.loading);
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
    TResult Function(String? parentFolder, String? currentPath,
            List<String> paths, bool loading)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectoryBrowserModel():
        return $default(
            _that.parentFolder, _that.currentPath, _that.paths, _that.loading);
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
    TResult? Function(String? parentFolder, String? currentPath,
            List<String> paths, bool loading)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectoryBrowserModel() when $default != null:
        return $default(
            _that.parentFolder, _that.currentPath, _that.paths, _that.loading);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DirectoryBrowserModel implements DirectoryBrowserModel {
  const _DirectoryBrowserModel(
      {this.parentFolder,
      this.currentPath,
      final List<String> paths = const [],
      this.loading = false})
      : _paths = paths;

  @override
  final String? parentFolder;
  @override
  final String? currentPath;
  final List<String> _paths;
  @override
  @JsonKey()
  List<String> get paths {
    if (_paths is EqualUnmodifiableListView) return _paths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paths);
  }

  @override
  @JsonKey()
  final bool loading;

  /// Create a copy of DirectoryBrowserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectoryBrowserModelCopyWith<_DirectoryBrowserModel> get copyWith =>
      __$DirectoryBrowserModelCopyWithImpl<_DirectoryBrowserModel>(
          this, _$identity);

  @override
  String toString() {
    return 'DirectoryBrowserModel(parentFolder: $parentFolder, currentPath: $currentPath, paths: $paths, loading: $loading)';
  }
}

/// @nodoc
abstract mixin class _$DirectoryBrowserModelCopyWith<$Res>
    implements $DirectoryBrowserModelCopyWith<$Res> {
  factory _$DirectoryBrowserModelCopyWith(_DirectoryBrowserModel value,
          $Res Function(_DirectoryBrowserModel) _then) =
      __$DirectoryBrowserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? parentFolder,
      String? currentPath,
      List<String> paths,
      bool loading});
}

/// @nodoc
class __$DirectoryBrowserModelCopyWithImpl<$Res>
    implements _$DirectoryBrowserModelCopyWith<$Res> {
  __$DirectoryBrowserModelCopyWithImpl(this._self, this._then);

  final _DirectoryBrowserModel _self;
  final $Res Function(_DirectoryBrowserModel) _then;

  /// Create a copy of DirectoryBrowserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? parentFolder = freezed,
    Object? currentPath = freezed,
    Object? paths = null,
    Object? loading = null,
  }) {
    return _then(_DirectoryBrowserModel(
      parentFolder: freezed == parentFolder
          ? _self.parentFolder
          : parentFolder // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPath: freezed == currentPath
          ? _self.currentPath
          : currentPath // ignore: cast_nullable_to_non_nullable
              as String?,
      paths: null == paths
          ? _self._paths
          : paths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
