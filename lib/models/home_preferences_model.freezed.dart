// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_preferences_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomePreferencesModel {
  List<String> get orderedLibraryIds;
  List<String> get latestItemsExcludes;
  bool get hidePlayedInLatest;
  List<String> get groupedFolders;
  List<MediaFolder> get availableFolders;
  bool get loading;

  /// Create a copy of HomePreferencesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomePreferencesModelCopyWith<HomePreferencesModel> get copyWith =>
      _$HomePreferencesModelCopyWithImpl<HomePreferencesModel>(this as HomePreferencesModel, _$identity);

  @override
  String toString() {
    return 'HomePreferencesModel(orderedLibraryIds: $orderedLibraryIds, latestItemsExcludes: $latestItemsExcludes, hidePlayedInLatest: $hidePlayedInLatest, groupedFolders: $groupedFolders, availableFolders: $availableFolders, loading: $loading)';
  }
}

/// @nodoc
abstract mixin class $HomePreferencesModelCopyWith<$Res> {
  factory $HomePreferencesModelCopyWith(HomePreferencesModel value, $Res Function(HomePreferencesModel) _then) =
      _$HomePreferencesModelCopyWithImpl;
  @useResult
  $Res call(
      {List<String> orderedLibraryIds,
      List<String> latestItemsExcludes,
      bool hidePlayedInLatest,
      List<String> groupedFolders,
      List<MediaFolder> availableFolders,
      bool loading});
}

/// @nodoc
class _$HomePreferencesModelCopyWithImpl<$Res> implements $HomePreferencesModelCopyWith<$Res> {
  _$HomePreferencesModelCopyWithImpl(this._self, this._then);

  final HomePreferencesModel _self;
  final $Res Function(HomePreferencesModel) _then;

  /// Create a copy of HomePreferencesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderedLibraryIds = null,
    Object? latestItemsExcludes = null,
    Object? hidePlayedInLatest = null,
    Object? groupedFolders = null,
    Object? availableFolders = null,
    Object? loading = null,
  }) {
    return _then(_self.copyWith(
      orderedLibraryIds: null == orderedLibraryIds
          ? _self.orderedLibraryIds
          : orderedLibraryIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      latestItemsExcludes: null == latestItemsExcludes
          ? _self.latestItemsExcludes
          : latestItemsExcludes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hidePlayedInLatest: null == hidePlayedInLatest
          ? _self.hidePlayedInLatest
          : hidePlayedInLatest // ignore: cast_nullable_to_non_nullable
              as bool,
      groupedFolders: null == groupedFolders
          ? _self.groupedFolders
          : groupedFolders // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFolders: null == availableFolders
          ? _self.availableFolders
          : availableFolders // ignore: cast_nullable_to_non_nullable
              as List<MediaFolder>,
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomePreferencesModel].
extension HomePreferencesModelPatterns on HomePreferencesModel {
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
    TResult Function(_HomePreferencesModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomePreferencesModel() when $default != null:
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
    TResult Function(_HomePreferencesModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomePreferencesModel():
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
    TResult? Function(_HomePreferencesModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomePreferencesModel() when $default != null:
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
    TResult Function(List<String> orderedLibraryIds, List<String> latestItemsExcludes, bool hidePlayedInLatest,
            List<String> groupedFolders, List<MediaFolder> availableFolders, bool loading)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomePreferencesModel() when $default != null:
        return $default(_that.orderedLibraryIds, _that.latestItemsExcludes, _that.hidePlayedInLatest,
            _that.groupedFolders, _that.availableFolders, _that.loading);
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
    TResult Function(List<String> orderedLibraryIds, List<String> latestItemsExcludes, bool hidePlayedInLatest,
            List<String> groupedFolders, List<MediaFolder> availableFolders, bool loading)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomePreferencesModel():
        return $default(_that.orderedLibraryIds, _that.latestItemsExcludes, _that.hidePlayedInLatest,
            _that.groupedFolders, _that.availableFolders, _that.loading);
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
    TResult? Function(List<String> orderedLibraryIds, List<String> latestItemsExcludes, bool hidePlayedInLatest,
            List<String> groupedFolders, List<MediaFolder> availableFolders, bool loading)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomePreferencesModel() when $default != null:
        return $default(_that.orderedLibraryIds, _that.latestItemsExcludes, _that.hidePlayedInLatest,
            _that.groupedFolders, _that.availableFolders, _that.loading);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HomePreferencesModel extends HomePreferencesModel {
  const _HomePreferencesModel(
      {final List<String> orderedLibraryIds = const [],
      final List<String> latestItemsExcludes = const [],
      this.hidePlayedInLatest = false,
      final List<String> groupedFolders = const [],
      final List<MediaFolder> availableFolders = const [],
      this.loading = false})
      : _orderedLibraryIds = orderedLibraryIds,
        _latestItemsExcludes = latestItemsExcludes,
        _groupedFolders = groupedFolders,
        _availableFolders = availableFolders,
        super._();

  final List<String> _orderedLibraryIds;
  @override
  @JsonKey()
  List<String> get orderedLibraryIds {
    if (_orderedLibraryIds is EqualUnmodifiableListView) return _orderedLibraryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderedLibraryIds);
  }

  final List<String> _latestItemsExcludes;
  @override
  @JsonKey()
  List<String> get latestItemsExcludes {
    if (_latestItemsExcludes is EqualUnmodifiableListView) return _latestItemsExcludes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_latestItemsExcludes);
  }

  @override
  @JsonKey()
  final bool hidePlayedInLatest;
  final List<String> _groupedFolders;
  @override
  @JsonKey()
  List<String> get groupedFolders {
    if (_groupedFolders is EqualUnmodifiableListView) return _groupedFolders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupedFolders);
  }

  final List<MediaFolder> _availableFolders;
  @override
  @JsonKey()
  List<MediaFolder> get availableFolders {
    if (_availableFolders is EqualUnmodifiableListView) return _availableFolders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableFolders);
  }

  @override
  @JsonKey()
  final bool loading;

  /// Create a copy of HomePreferencesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomePreferencesModelCopyWith<_HomePreferencesModel> get copyWith =>
      __$HomePreferencesModelCopyWithImpl<_HomePreferencesModel>(this, _$identity);

  @override
  String toString() {
    return 'HomePreferencesModel(orderedLibraryIds: $orderedLibraryIds, latestItemsExcludes: $latestItemsExcludes, hidePlayedInLatest: $hidePlayedInLatest, groupedFolders: $groupedFolders, availableFolders: $availableFolders, loading: $loading)';
  }
}

/// @nodoc
abstract mixin class _$HomePreferencesModelCopyWith<$Res> implements $HomePreferencesModelCopyWith<$Res> {
  factory _$HomePreferencesModelCopyWith(_HomePreferencesModel value, $Res Function(_HomePreferencesModel) _then) =
      __$HomePreferencesModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<String> orderedLibraryIds,
      List<String> latestItemsExcludes,
      bool hidePlayedInLatest,
      List<String> groupedFolders,
      List<MediaFolder> availableFolders,
      bool loading});
}

/// @nodoc
class __$HomePreferencesModelCopyWithImpl<$Res> implements _$HomePreferencesModelCopyWith<$Res> {
  __$HomePreferencesModelCopyWithImpl(this._self, this._then);

  final _HomePreferencesModel _self;
  final $Res Function(_HomePreferencesModel) _then;

  /// Create a copy of HomePreferencesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orderedLibraryIds = null,
    Object? latestItemsExcludes = null,
    Object? hidePlayedInLatest = null,
    Object? groupedFolders = null,
    Object? availableFolders = null,
    Object? loading = null,
  }) {
    return _then(_HomePreferencesModel(
      orderedLibraryIds: null == orderedLibraryIds
          ? _self._orderedLibraryIds
          : orderedLibraryIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      latestItemsExcludes: null == latestItemsExcludes
          ? _self._latestItemsExcludes
          : latestItemsExcludes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hidePlayedInLatest: null == hidePlayedInLatest
          ? _self.hidePlayedInLatest
          : hidePlayedInLatest // ignore: cast_nullable_to_non_nullable
              as bool,
      groupedFolders: null == groupedFolders
          ? _self._groupedFolders
          : groupedFolders // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFolders: null == availableFolders
          ? _self._availableFolders
          : availableFolders // ignore: cast_nullable_to_non_nullable
              as List<MediaFolder>,
      loading: null == loading
          ? _self.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
