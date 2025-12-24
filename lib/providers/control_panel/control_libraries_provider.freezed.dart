// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_libraries_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlLibrariesModel implements DiagnosticableTreeMixin {
  List<ViewModel> get availableLibraries;
  ViewModel? get selectedLibrary;
  jelly.VirtualFolderInfo? get newVirtualFolder;
  List<jelly.CultureDto> get cultures;
  List<jelly.CountryInfo> get countries;
  List<jelly.VirtualFolderInfo> get virtualFolders;
  jelly.LibraryOptionsResultDto? get availableOptions;
  SystemFolders? get systemFolders;

  /// Create a copy of ControlLibrariesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ControlLibrariesModelCopyWith<ControlLibrariesModel> get copyWith =>
      _$ControlLibrariesModelCopyWithImpl<ControlLibrariesModel>(
          this as ControlLibrariesModel, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ControlLibrariesModel'))
      ..add(DiagnosticsProperty('availableLibraries', availableLibraries))
      ..add(DiagnosticsProperty('selectedLibrary', selectedLibrary))
      ..add(DiagnosticsProperty('newVirtualFolder', newVirtualFolder))
      ..add(DiagnosticsProperty('cultures', cultures))
      ..add(DiagnosticsProperty('countries', countries))
      ..add(DiagnosticsProperty('virtualFolders', virtualFolders))
      ..add(DiagnosticsProperty('availableOptions', availableOptions))
      ..add(DiagnosticsProperty('systemFolders', systemFolders));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ControlLibrariesModel(availableLibraries: $availableLibraries, selectedLibrary: $selectedLibrary, newVirtualFolder: $newVirtualFolder, cultures: $cultures, countries: $countries, virtualFolders: $virtualFolders, availableOptions: $availableOptions, systemFolders: $systemFolders)';
  }
}

/// @nodoc
abstract mixin class $ControlLibrariesModelCopyWith<$Res> {
  factory $ControlLibrariesModelCopyWith(ControlLibrariesModel value,
          $Res Function(ControlLibrariesModel) _then) =
      _$ControlLibrariesModelCopyWithImpl;
  @useResult
  $Res call(
      {List<ViewModel> availableLibraries,
      ViewModel? selectedLibrary,
      jelly.VirtualFolderInfo? newVirtualFolder,
      List<jelly.CultureDto> cultures,
      List<jelly.CountryInfo> countries,
      List<jelly.VirtualFolderInfo> virtualFolders,
      jelly.LibraryOptionsResultDto? availableOptions,
      SystemFolders? systemFolders});
}

/// @nodoc
class _$ControlLibrariesModelCopyWithImpl<$Res>
    implements $ControlLibrariesModelCopyWith<$Res> {
  _$ControlLibrariesModelCopyWithImpl(this._self, this._then);

  final ControlLibrariesModel _self;
  final $Res Function(ControlLibrariesModel) _then;

  /// Create a copy of ControlLibrariesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableLibraries = null,
    Object? selectedLibrary = freezed,
    Object? newVirtualFolder = freezed,
    Object? cultures = null,
    Object? countries = null,
    Object? virtualFolders = null,
    Object? availableOptions = freezed,
    Object? systemFolders = freezed,
  }) {
    return _then(_self.copyWith(
      availableLibraries: null == availableLibraries
          ? _self.availableLibraries
          : availableLibraries // ignore: cast_nullable_to_non_nullable
              as List<ViewModel>,
      selectedLibrary: freezed == selectedLibrary
          ? _self.selectedLibrary
          : selectedLibrary // ignore: cast_nullable_to_non_nullable
              as ViewModel?,
      newVirtualFolder: freezed == newVirtualFolder
          ? _self.newVirtualFolder
          : newVirtualFolder // ignore: cast_nullable_to_non_nullable
              as jelly.VirtualFolderInfo?,
      cultures: null == cultures
          ? _self.cultures
          : cultures // ignore: cast_nullable_to_non_nullable
              as List<jelly.CultureDto>,
      countries: null == countries
          ? _self.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<jelly.CountryInfo>,
      virtualFolders: null == virtualFolders
          ? _self.virtualFolders
          : virtualFolders // ignore: cast_nullable_to_non_nullable
              as List<jelly.VirtualFolderInfo>,
      availableOptions: freezed == availableOptions
          ? _self.availableOptions
          : availableOptions // ignore: cast_nullable_to_non_nullable
              as jelly.LibraryOptionsResultDto?,
      systemFolders: freezed == systemFolders
          ? _self.systemFolders
          : systemFolders // ignore: cast_nullable_to_non_nullable
              as SystemFolders?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ControlLibrariesModel].
extension ControlLibrariesModelPatterns on ControlLibrariesModel {
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
    TResult Function(_ControlLibrariesModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlLibrariesModel() when $default != null:
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
    TResult Function(_ControlLibrariesModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlLibrariesModel():
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
    TResult? Function(_ControlLibrariesModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlLibrariesModel() when $default != null:
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
            List<ViewModel> availableLibraries,
            ViewModel? selectedLibrary,
            jelly.VirtualFolderInfo? newVirtualFolder,
            List<jelly.CultureDto> cultures,
            List<jelly.CountryInfo> countries,
            List<jelly.VirtualFolderInfo> virtualFolders,
            jelly.LibraryOptionsResultDto? availableOptions,
            SystemFolders? systemFolders)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ControlLibrariesModel() when $default != null:
        return $default(
            _that.availableLibraries,
            _that.selectedLibrary,
            _that.newVirtualFolder,
            _that.cultures,
            _that.countries,
            _that.virtualFolders,
            _that.availableOptions,
            _that.systemFolders);
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
            List<ViewModel> availableLibraries,
            ViewModel? selectedLibrary,
            jelly.VirtualFolderInfo? newVirtualFolder,
            List<jelly.CultureDto> cultures,
            List<jelly.CountryInfo> countries,
            List<jelly.VirtualFolderInfo> virtualFolders,
            jelly.LibraryOptionsResultDto? availableOptions,
            SystemFolders? systemFolders)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlLibrariesModel():
        return $default(
            _that.availableLibraries,
            _that.selectedLibrary,
            _that.newVirtualFolder,
            _that.cultures,
            _that.countries,
            _that.virtualFolders,
            _that.availableOptions,
            _that.systemFolders);
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
            List<ViewModel> availableLibraries,
            ViewModel? selectedLibrary,
            jelly.VirtualFolderInfo? newVirtualFolder,
            List<jelly.CultureDto> cultures,
            List<jelly.CountryInfo> countries,
            List<jelly.VirtualFolderInfo> virtualFolders,
            jelly.LibraryOptionsResultDto? availableOptions,
            SystemFolders? systemFolders)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ControlLibrariesModel() when $default != null:
        return $default(
            _that.availableLibraries,
            _that.selectedLibrary,
            _that.newVirtualFolder,
            _that.cultures,
            _that.countries,
            _that.virtualFolders,
            _that.availableOptions,
            _that.systemFolders);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ControlLibrariesModel extends ControlLibrariesModel
    with DiagnosticableTreeMixin {
  _ControlLibrariesModel(
      {final List<ViewModel> availableLibraries = const [],
      this.selectedLibrary,
      this.newVirtualFolder,
      final List<jelly.CultureDto> cultures = const [],
      final List<jelly.CountryInfo> countries = const [],
      final List<jelly.VirtualFolderInfo> virtualFolders = const [],
      this.availableOptions,
      this.systemFolders})
      : _availableLibraries = availableLibraries,
        _cultures = cultures,
        _countries = countries,
        _virtualFolders = virtualFolders,
        super._();

  final List<ViewModel> _availableLibraries;
  @override
  @JsonKey()
  List<ViewModel> get availableLibraries {
    if (_availableLibraries is EqualUnmodifiableListView)
      return _availableLibraries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableLibraries);
  }

  @override
  final ViewModel? selectedLibrary;
  @override
  final jelly.VirtualFolderInfo? newVirtualFolder;
  final List<jelly.CultureDto> _cultures;
  @override
  @JsonKey()
  List<jelly.CultureDto> get cultures {
    if (_cultures is EqualUnmodifiableListView) return _cultures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cultures);
  }

  final List<jelly.CountryInfo> _countries;
  @override
  @JsonKey()
  List<jelly.CountryInfo> get countries {
    if (_countries is EqualUnmodifiableListView) return _countries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  final List<jelly.VirtualFolderInfo> _virtualFolders;
  @override
  @JsonKey()
  List<jelly.VirtualFolderInfo> get virtualFolders {
    if (_virtualFolders is EqualUnmodifiableListView) return _virtualFolders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_virtualFolders);
  }

  @override
  final jelly.LibraryOptionsResultDto? availableOptions;
  @override
  final SystemFolders? systemFolders;

  /// Create a copy of ControlLibrariesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ControlLibrariesModelCopyWith<_ControlLibrariesModel> get copyWith =>
      __$ControlLibrariesModelCopyWithImpl<_ControlLibrariesModel>(
          this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ControlLibrariesModel'))
      ..add(DiagnosticsProperty('availableLibraries', availableLibraries))
      ..add(DiagnosticsProperty('selectedLibrary', selectedLibrary))
      ..add(DiagnosticsProperty('newVirtualFolder', newVirtualFolder))
      ..add(DiagnosticsProperty('cultures', cultures))
      ..add(DiagnosticsProperty('countries', countries))
      ..add(DiagnosticsProperty('virtualFolders', virtualFolders))
      ..add(DiagnosticsProperty('availableOptions', availableOptions))
      ..add(DiagnosticsProperty('systemFolders', systemFolders));
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ControlLibrariesModel(availableLibraries: $availableLibraries, selectedLibrary: $selectedLibrary, newVirtualFolder: $newVirtualFolder, cultures: $cultures, countries: $countries, virtualFolders: $virtualFolders, availableOptions: $availableOptions, systemFolders: $systemFolders)';
  }
}

/// @nodoc
abstract mixin class _$ControlLibrariesModelCopyWith<$Res>
    implements $ControlLibrariesModelCopyWith<$Res> {
  factory _$ControlLibrariesModelCopyWith(_ControlLibrariesModel value,
          $Res Function(_ControlLibrariesModel) _then) =
      __$ControlLibrariesModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<ViewModel> availableLibraries,
      ViewModel? selectedLibrary,
      jelly.VirtualFolderInfo? newVirtualFolder,
      List<jelly.CultureDto> cultures,
      List<jelly.CountryInfo> countries,
      List<jelly.VirtualFolderInfo> virtualFolders,
      jelly.LibraryOptionsResultDto? availableOptions,
      SystemFolders? systemFolders});
}

/// @nodoc
class __$ControlLibrariesModelCopyWithImpl<$Res>
    implements _$ControlLibrariesModelCopyWith<$Res> {
  __$ControlLibrariesModelCopyWithImpl(this._self, this._then);

  final _ControlLibrariesModel _self;
  final $Res Function(_ControlLibrariesModel) _then;

  /// Create a copy of ControlLibrariesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? availableLibraries = null,
    Object? selectedLibrary = freezed,
    Object? newVirtualFolder = freezed,
    Object? cultures = null,
    Object? countries = null,
    Object? virtualFolders = null,
    Object? availableOptions = freezed,
    Object? systemFolders = freezed,
  }) {
    return _then(_ControlLibrariesModel(
      availableLibraries: null == availableLibraries
          ? _self._availableLibraries
          : availableLibraries // ignore: cast_nullable_to_non_nullable
              as List<ViewModel>,
      selectedLibrary: freezed == selectedLibrary
          ? _self.selectedLibrary
          : selectedLibrary // ignore: cast_nullable_to_non_nullable
              as ViewModel?,
      newVirtualFolder: freezed == newVirtualFolder
          ? _self.newVirtualFolder
          : newVirtualFolder // ignore: cast_nullable_to_non_nullable
              as jelly.VirtualFolderInfo?,
      cultures: null == cultures
          ? _self._cultures
          : cultures // ignore: cast_nullable_to_non_nullable
              as List<jelly.CultureDto>,
      countries: null == countries
          ? _self._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<jelly.CountryInfo>,
      virtualFolders: null == virtualFolders
          ? _self._virtualFolders
          : virtualFolders // ignore: cast_nullable_to_non_nullable
              as List<jelly.VirtualFolderInfo>,
      availableOptions: freezed == availableOptions
          ? _self.availableOptions
          : availableOptions // ignore: cast_nullable_to_non_nullable
              as jelly.LibraryOptionsResultDto?,
      systemFolders: freezed == systemFolders
          ? _self.systemFolders
          : systemFolders // ignore: cast_nullable_to_non_nullable
              as SystemFolders?,
    ));
  }
}

// dart format on
