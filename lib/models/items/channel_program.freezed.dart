// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChannelProgram {
  String get id;
  String get channelId;
  String get name;
  String get officialRating;
  int get productionYear;
  int get indexNumber;
  int get parentIndexNumber;
  String? get episodeTitle;
  DateTime get startDate;
  DateTime get endDate;
  ImagesData? get images;
  bool get isSeries;
  String? get overview;

  /// Serializes this ChannelProgram to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'ChannelProgram(id: $id, channelId: $channelId, name: $name, officialRating: $officialRating, productionYear: $productionYear, indexNumber: $indexNumber, parentIndexNumber: $parentIndexNumber, episodeTitle: $episodeTitle, startDate: $startDate, endDate: $endDate, images: $images, isSeries: $isSeries, overview: $overview)';
  }
}

/// Adds pattern-matching-related methods to [ChannelProgram].
extension ChannelProgramPatterns on ChannelProgram {
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
    TResult Function(_ChannelProgram value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelProgram() when $default != null:
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
    TResult Function(_ChannelProgram value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelProgram():
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
    TResult? Function(_ChannelProgram value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelProgram() when $default != null:
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
            String id,
            String channelId,
            String name,
            String officialRating,
            int productionYear,
            int indexNumber,
            int parentIndexNumber,
            String? episodeTitle,
            DateTime startDate,
            DateTime endDate,
            ImagesData? images,
            bool isSeries,
            String? overview)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelProgram() when $default != null:
        return $default(
            _that.id,
            _that.channelId,
            _that.name,
            _that.officialRating,
            _that.productionYear,
            _that.indexNumber,
            _that.parentIndexNumber,
            _that.episodeTitle,
            _that.startDate,
            _that.endDate,
            _that.images,
            _that.isSeries,
            _that.overview);
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
            String id,
            String channelId,
            String name,
            String officialRating,
            int productionYear,
            int indexNumber,
            int parentIndexNumber,
            String? episodeTitle,
            DateTime startDate,
            DateTime endDate,
            ImagesData? images,
            bool isSeries,
            String? overview)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelProgram():
        return $default(
            _that.id,
            _that.channelId,
            _that.name,
            _that.officialRating,
            _that.productionYear,
            _that.indexNumber,
            _that.parentIndexNumber,
            _that.episodeTitle,
            _that.startDate,
            _that.endDate,
            _that.images,
            _that.isSeries,
            _that.overview);
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
            String id,
            String channelId,
            String name,
            String officialRating,
            int productionYear,
            int indexNumber,
            int parentIndexNumber,
            String? episodeTitle,
            DateTime startDate,
            DateTime endDate,
            ImagesData? images,
            bool isSeries,
            String? overview)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelProgram() when $default != null:
        return $default(
            _that.id,
            _that.channelId,
            _that.name,
            _that.officialRating,
            _that.productionYear,
            _that.indexNumber,
            _that.parentIndexNumber,
            _that.episodeTitle,
            _that.startDate,
            _that.endDate,
            _that.images,
            _that.isSeries,
            _that.overview);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChannelProgram extends ChannelProgram {
  _ChannelProgram(
      {required this.id,
      required this.channelId,
      required this.name,
      required this.officialRating,
      required this.productionYear,
      required this.indexNumber,
      required this.parentIndexNumber,
      this.episodeTitle,
      required this.startDate,
      required this.endDate,
      this.images,
      required this.isSeries,
      this.overview})
      : super._();
  factory _ChannelProgram.fromJson(Map<String, dynamic> json) =>
      _$ChannelProgramFromJson(json);

  @override
  final String id;
  @override
  final String channelId;
  @override
  final String name;
  @override
  final String officialRating;
  @override
  final int productionYear;
  @override
  final int indexNumber;
  @override
  final int parentIndexNumber;
  @override
  final String? episodeTitle;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final ImagesData? images;
  @override
  final bool isSeries;
  @override
  final String? overview;

  @override
  Map<String, dynamic> toJson() {
    return _$ChannelProgramToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ChannelProgram(id: $id, channelId: $channelId, name: $name, officialRating: $officialRating, productionYear: $productionYear, indexNumber: $indexNumber, parentIndexNumber: $parentIndexNumber, episodeTitle: $episodeTitle, startDate: $startDate, endDate: $endDate, images: $images, isSeries: $isSeries, overview: $overview)';
  }
}

// dart format on
