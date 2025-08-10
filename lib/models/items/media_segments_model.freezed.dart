// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_segments_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaSegmentsModel {
  List<MediaSegment> get segments;

  /// Serializes this MediaSegmentsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'MediaSegmentsModel(segments: $segments)';
  }
}

/// Adds pattern-matching-related methods to [MediaSegmentsModel].
extension MediaSegmentsModelPatterns on MediaSegmentsModel {
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
    TResult Function(_MediaSegmentsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MediaSegmentsModel() when $default != null:
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
    TResult Function(_MediaSegmentsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaSegmentsModel():
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
    TResult? Function(_MediaSegmentsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaSegmentsModel() when $default != null:
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
    TResult Function(List<MediaSegment> segments)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MediaSegmentsModel() when $default != null:
        return $default(_that.segments);
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
    TResult Function(List<MediaSegment> segments) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaSegmentsModel():
        return $default(_that.segments);
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
    TResult? Function(List<MediaSegment> segments)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaSegmentsModel() when $default != null:
        return $default(_that.segments);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MediaSegmentsModel extends MediaSegmentsModel {
  _MediaSegmentsModel({final List<MediaSegment> segments = const []})
      : _segments = segments,
        super._();
  factory _MediaSegmentsModel.fromJson(Map<String, dynamic> json) =>
      _$MediaSegmentsModelFromJson(json);

  final List<MediaSegment> _segments;
  @override
  @JsonKey()
  List<MediaSegment> get segments {
    if (_segments is EqualUnmodifiableListView) return _segments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$MediaSegmentsModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'MediaSegmentsModel(segments: $segments)';
  }
}

/// @nodoc
mixin _$MediaSegment {
  MediaSegmentType get type;
  Duration get start;
  Duration get end;

  /// Serializes this MediaSegment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'MediaSegment(type: $type, start: $start, end: $end)';
  }
}

/// Adds pattern-matching-related methods to [MediaSegment].
extension MediaSegmentPatterns on MediaSegment {
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
    TResult Function(_MediaSegment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MediaSegment() when $default != null:
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
    TResult Function(_MediaSegment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaSegment():
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
    TResult? Function(_MediaSegment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaSegment() when $default != null:
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
    TResult Function(MediaSegmentType type, Duration start, Duration end)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MediaSegment() when $default != null:
        return $default(_that.type, _that.start, _that.end);
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
    TResult Function(MediaSegmentType type, Duration start, Duration end)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaSegment():
        return $default(_that.type, _that.start, _that.end);
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
    TResult? Function(MediaSegmentType type, Duration start, Duration end)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MediaSegment() when $default != null:
        return $default(_that.type, _that.start, _that.end);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MediaSegment extends MediaSegment {
  _MediaSegment({required this.type, required this.start, required this.end})
      : super._();
  factory _MediaSegment.fromJson(Map<String, dynamic> json) =>
      _$MediaSegmentFromJson(json);

  @override
  final MediaSegmentType type;
  @override
  final Duration start;
  @override
  final Duration end;

  @override
  Map<String, dynamic> toJson() {
    return _$MediaSegmentToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'MediaSegment(type: $type, start: $start, end: $end)';
  }
}

// dart format on
