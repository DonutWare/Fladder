// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeSettingsModel {
  Set<LayoutMode> get screenLayouts;
  Set<ViewSize> get layoutStates;
  HomeBanner get homeBanner;
  HomeCarouselSettings get carouselSettings;
  HomeNextUp get nextUp;

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeSettingsModelCopyWith<HomeSettingsModel> get copyWith =>
      _$HomeSettingsModelCopyWithImpl<HomeSettingsModel>(
          this as HomeSettingsModel, _$identity);

  /// Serializes this HomeSettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'HomeSettingsModel(screenLayouts: $screenLayouts, layoutStates: $layoutStates, homeBanner: $homeBanner, carouselSettings: $carouselSettings, nextUp: $nextUp)';
  }
}

/// @nodoc
abstract mixin class $HomeSettingsModelCopyWith<$Res> {
  factory $HomeSettingsModelCopyWith(
          HomeSettingsModel value, $Res Function(HomeSettingsModel) _then) =
      _$HomeSettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {Set<LayoutMode> screenLayouts,
      Set<ViewSize> layoutStates,
      HomeBanner homeBanner,
      HomeCarouselSettings carouselSettings,
      HomeNextUp nextUp});
}

/// @nodoc
class _$HomeSettingsModelCopyWithImpl<$Res>
    implements $HomeSettingsModelCopyWith<$Res> {
  _$HomeSettingsModelCopyWithImpl(this._self, this._then);

  final HomeSettingsModel _self;
  final $Res Function(HomeSettingsModel) _then;

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screenLayouts = null,
    Object? layoutStates = null,
    Object? homeBanner = null,
    Object? carouselSettings = null,
    Object? nextUp = null,
  }) {
    return _then(_self.copyWith(
      screenLayouts: null == screenLayouts
          ? _self.screenLayouts
          : screenLayouts // ignore: cast_nullable_to_non_nullable
              as Set<LayoutMode>,
      layoutStates: null == layoutStates
          ? _self.layoutStates
          : layoutStates // ignore: cast_nullable_to_non_nullable
              as Set<ViewSize>,
      homeBanner: null == homeBanner
          ? _self.homeBanner
          : homeBanner // ignore: cast_nullable_to_non_nullable
              as HomeBanner,
      carouselSettings: null == carouselSettings
          ? _self.carouselSettings
          : carouselSettings // ignore: cast_nullable_to_non_nullable
              as HomeCarouselSettings,
      nextUp: null == nextUp
          ? _self.nextUp
          : nextUp // ignore: cast_nullable_to_non_nullable
              as HomeNextUp,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomeSettingsModel].
extension HomeSettingsModelPatterns on HomeSettingsModel {
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
    TResult Function(_HomeSettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeSettingsModel() when $default != null:
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
    TResult Function(_HomeSettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeSettingsModel():
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
    TResult? Function(_HomeSettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeSettingsModel() when $default != null:
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
            Set<LayoutMode> screenLayouts,
            Set<ViewSize> layoutStates,
            HomeBanner homeBanner,
            HomeCarouselSettings carouselSettings,
            HomeNextUp nextUp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeSettingsModel() when $default != null:
        return $default(_that.screenLayouts, _that.layoutStates,
            _that.homeBanner, _that.carouselSettings, _that.nextUp);
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
            Set<LayoutMode> screenLayouts,
            Set<ViewSize> layoutStates,
            HomeBanner homeBanner,
            HomeCarouselSettings carouselSettings,
            HomeNextUp nextUp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeSettingsModel():
        return $default(_that.screenLayouts, _that.layoutStates,
            _that.homeBanner, _that.carouselSettings, _that.nextUp);
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
            Set<LayoutMode> screenLayouts,
            Set<ViewSize> layoutStates,
            HomeBanner homeBanner,
            HomeCarouselSettings carouselSettings,
            HomeNextUp nextUp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeSettingsModel() when $default != null:
        return $default(_that.screenLayouts, _that.layoutStates,
            _that.homeBanner, _that.carouselSettings, _that.nextUp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeSettingsModel extends HomeSettingsModel {
  _HomeSettingsModel(
      {final Set<LayoutMode> screenLayouts = const {...LayoutMode.values},
      final Set<ViewSize> layoutStates = const {...ViewSize.values},
      required this.homeBanner,
      this.carouselSettings = HomeCarouselSettings.combined,
      this.nextUp = HomeNextUp.separate})
      : _screenLayouts = screenLayouts,
        _layoutStates = layoutStates,
        super._();
  factory _HomeSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$HomeSettingsModelFromJson(json);

  final Set<LayoutMode> _screenLayouts;
  @override
  @JsonKey()
  Set<LayoutMode> get screenLayouts {
    if (_screenLayouts is EqualUnmodifiableSetView) return _screenLayouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_screenLayouts);
  }

  final Set<ViewSize> _layoutStates;
  @override
  @JsonKey()
  Set<ViewSize> get layoutStates {
    if (_layoutStates is EqualUnmodifiableSetView) return _layoutStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_layoutStates);
  }

  @override
  final HomeBanner homeBanner;
  @override
  @JsonKey()
  final HomeCarouselSettings carouselSettings;
  @override
  @JsonKey()
  final HomeNextUp nextUp;

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeSettingsModelCopyWith<_HomeSettingsModel> get copyWith =>
      __$HomeSettingsModelCopyWithImpl<_HomeSettingsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeSettingsModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'HomeSettingsModel(screenLayouts: $screenLayouts, layoutStates: $layoutStates, homeBanner: $homeBanner, carouselSettings: $carouselSettings, nextUp: $nextUp)';
  }
}

/// @nodoc
abstract mixin class _$HomeSettingsModelCopyWith<$Res>
    implements $HomeSettingsModelCopyWith<$Res> {
  factory _$HomeSettingsModelCopyWith(
          _HomeSettingsModel value, $Res Function(_HomeSettingsModel) _then) =
      __$HomeSettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Set<LayoutMode> screenLayouts,
      Set<ViewSize> layoutStates,
      HomeBanner homeBanner,
      HomeCarouselSettings carouselSettings,
      HomeNextUp nextUp});
}

/// @nodoc
class __$HomeSettingsModelCopyWithImpl<$Res>
    implements _$HomeSettingsModelCopyWith<$Res> {
  __$HomeSettingsModelCopyWithImpl(this._self, this._then);

  final _HomeSettingsModel _self;
  final $Res Function(_HomeSettingsModel) _then;

  /// Create a copy of HomeSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? screenLayouts = null,
    Object? layoutStates = null,
    Object? homeBanner = null,
    Object? carouselSettings = null,
    Object? nextUp = null,
  }) {
    return _then(_HomeSettingsModel(
      screenLayouts: null == screenLayouts
          ? _self._screenLayouts
          : screenLayouts // ignore: cast_nullable_to_non_nullable
              as Set<LayoutMode>,
      layoutStates: null == layoutStates
          ? _self._layoutStates
          : layoutStates // ignore: cast_nullable_to_non_nullable
              as Set<ViewSize>,
      homeBanner: null == homeBanner
          ? _self.homeBanner
          : homeBanner // ignore: cast_nullable_to_non_nullable
              as HomeBanner,
      carouselSettings: null == carouselSettings
          ? _self.carouselSettings
          : carouselSettings // ignore: cast_nullable_to_non_nullable
              as HomeCarouselSettings,
      nextUp: null == nextUp
          ? _self.nextUp
          : nextUp // ignore: cast_nullable_to_non_nullable
              as HomeNextUp,
    ));
  }
}

// dart format on
