// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_filters_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibraryFiltersModel {
  String get id;
  String get name;
  bool get isFavourite;
  List<String> get ids;
  LibraryFilterModel get filter;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LibraryFiltersModelCopyWith<LibraryFiltersModel> get copyWith =>
      _$LibraryFiltersModelCopyWithImpl<LibraryFiltersModel>(
          this as LibraryFiltersModel, _$identity);

  /// Serializes this LibraryFiltersModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'LibraryFiltersModel(id: $id, name: $name, isFavourite: $isFavourite, ids: $ids, filter: $filter)';
  }
}

/// @nodoc
abstract mixin class $LibraryFiltersModelCopyWith<$Res> {
  factory $LibraryFiltersModelCopyWith(
          LibraryFiltersModel value, $Res Function(LibraryFiltersModel) _then) =
      _$LibraryFiltersModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      bool isFavourite,
      List<String> ids,
      LibraryFilterModel filter});

  $LibraryFilterModelCopyWith<$Res> get filter;
}

/// @nodoc
class _$LibraryFiltersModelCopyWithImpl<$Res>
    implements $LibraryFiltersModelCopyWith<$Res> {
  _$LibraryFiltersModelCopyWithImpl(this._self, this._then);

  final LibraryFiltersModel _self;
  final $Res Function(LibraryFiltersModel) _then;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isFavourite = null,
    Object? ids = null,
    Object? filter = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: null == isFavourite
          ? _self.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      ids: null == ids
          ? _self.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filter: null == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as LibraryFilterModel,
    ));
  }

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LibraryFilterModelCopyWith<$Res> get filter {
    return $LibraryFilterModelCopyWith<$Res>(_self.filter, (value) {
      return _then(_self.copyWith(filter: value));
    });
  }
}

/// Adds pattern-matching-related methods to [LibraryFiltersModel].
extension LibraryFiltersModelPatterns on LibraryFiltersModel {
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
    TResult Function(_LibraryFiltersModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel() when $default != null:
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
    TResult Function(_LibraryFiltersModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel():
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
    TResult? Function(_LibraryFiltersModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel() when $default != null:
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
    TResult Function(String id, String name, bool isFavourite, List<String> ids,
            LibraryFilterModel filter)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel() when $default != null:
        return $default(
            _that.id, _that.name, _that.isFavourite, _that.ids, _that.filter);
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
    TResult Function(String id, String name, bool isFavourite, List<String> ids,
            LibraryFilterModel filter)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel():
        return $default(
            _that.id, _that.name, _that.isFavourite, _that.ids, _that.filter);
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
    TResult? Function(String id, String name, bool isFavourite,
            List<String> ids, LibraryFilterModel filter)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LibraryFiltersModel() when $default != null:
        return $default(
            _that.id, _that.name, _that.isFavourite, _that.ids, _that.filter);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LibraryFiltersModel extends LibraryFiltersModel {
  _LibraryFiltersModel(
      {required this.id,
      required this.name,
      required this.isFavourite,
      final List<String> ids = const [],
      this.filter = const LibraryFilterModel()})
      : _ids = ids,
        super._();
  factory _LibraryFiltersModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryFiltersModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool isFavourite;
  final List<String> _ids;
  @override
  @JsonKey()
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  @JsonKey()
  final LibraryFilterModel filter;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LibraryFiltersModelCopyWith<_LibraryFiltersModel> get copyWith =>
      __$LibraryFiltersModelCopyWithImpl<_LibraryFiltersModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LibraryFiltersModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'LibraryFiltersModel(id: $id, name: $name, isFavourite: $isFavourite, ids: $ids, filter: $filter)';
  }
}

/// @nodoc
abstract mixin class _$LibraryFiltersModelCopyWith<$Res>
    implements $LibraryFiltersModelCopyWith<$Res> {
  factory _$LibraryFiltersModelCopyWith(_LibraryFiltersModel value,
          $Res Function(_LibraryFiltersModel) _then) =
      __$LibraryFiltersModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      bool isFavourite,
      List<String> ids,
      LibraryFilterModel filter});

  @override
  $LibraryFilterModelCopyWith<$Res> get filter;
}

/// @nodoc
class __$LibraryFiltersModelCopyWithImpl<$Res>
    implements _$LibraryFiltersModelCopyWith<$Res> {
  __$LibraryFiltersModelCopyWithImpl(this._self, this._then);

  final _LibraryFiltersModel _self;
  final $Res Function(_LibraryFiltersModel) _then;

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isFavourite = null,
    Object? ids = null,
    Object? filter = null,
  }) {
    return _then(_LibraryFiltersModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: null == isFavourite
          ? _self.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      ids: null == ids
          ? _self._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filter: null == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as LibraryFilterModel,
    ));
  }

  /// Create a copy of LibraryFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LibraryFilterModelCopyWith<$Res> get filter {
    return $LibraryFilterModelCopyWith<$Res>(_self.filter, (value) {
      return _then(_self.copyWith(filter: value));
    });
  }
}

// dart format on
