// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_screen_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LibraryScreenModel {
  List<ViewModel> get views => throw _privateConstructorUsedError;
  ViewModel? get selectedViewModel => throw _privateConstructorUsedError;
  Set<LibraryViewType> get viewType => throw _privateConstructorUsedError;
  List<RecommendedModel> get recommendations =>
      throw _privateConstructorUsedError;
  List<RecommendedModel> get genres => throw _privateConstructorUsedError;
  List<ItemBaseModel> get favourites => throw _privateConstructorUsedError;

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LibraryScreenModelCopyWith<LibraryScreenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LibraryScreenModelCopyWith<$Res> {
  factory $LibraryScreenModelCopyWith(
          LibraryScreenModel value, $Res Function(LibraryScreenModel) then) =
      _$LibraryScreenModelCopyWithImpl<$Res, LibraryScreenModel>;
  @useResult
  $Res call(
      {List<ViewModel> views,
      ViewModel? selectedViewModel,
      Set<LibraryViewType> viewType,
      List<RecommendedModel> recommendations,
      List<RecommendedModel> genres,
      List<ItemBaseModel> favourites});
}

/// @nodoc
class _$LibraryScreenModelCopyWithImpl<$Res, $Val extends LibraryScreenModel>
    implements $LibraryScreenModelCopyWith<$Res> {
  _$LibraryScreenModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? views = null,
    Object? selectedViewModel = freezed,
    Object? viewType = null,
    Object? recommendations = null,
    Object? genres = null,
    Object? favourites = null,
  }) {
    return _then(_value.copyWith(
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as List<ViewModel>,
      selectedViewModel: freezed == selectedViewModel
          ? _value.selectedViewModel
          : selectedViewModel // ignore: cast_nullable_to_non_nullable
              as ViewModel?,
      viewType: null == viewType
          ? _value.viewType
          : viewType // ignore: cast_nullable_to_non_nullable
              as Set<LibraryViewType>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<RecommendedModel>,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<RecommendedModel>,
      favourites: null == favourites
          ? _value.favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LibraryScreenModelImplCopyWith<$Res>
    implements $LibraryScreenModelCopyWith<$Res> {
  factory _$$LibraryScreenModelImplCopyWith(_$LibraryScreenModelImpl value,
          $Res Function(_$LibraryScreenModelImpl) then) =
      __$$LibraryScreenModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ViewModel> views,
      ViewModel? selectedViewModel,
      Set<LibraryViewType> viewType,
      List<RecommendedModel> recommendations,
      List<RecommendedModel> genres,
      List<ItemBaseModel> favourites});
}

/// @nodoc
class __$$LibraryScreenModelImplCopyWithImpl<$Res>
    extends _$LibraryScreenModelCopyWithImpl<$Res, _$LibraryScreenModelImpl>
    implements _$$LibraryScreenModelImplCopyWith<$Res> {
  __$$LibraryScreenModelImplCopyWithImpl(_$LibraryScreenModelImpl _value,
      $Res Function(_$LibraryScreenModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? views = null,
    Object? selectedViewModel = freezed,
    Object? viewType = null,
    Object? recommendations = null,
    Object? genres = null,
    Object? favourites = null,
  }) {
    return _then(_$LibraryScreenModelImpl(
      views: null == views
          ? _value._views
          : views // ignore: cast_nullable_to_non_nullable
              as List<ViewModel>,
      selectedViewModel: freezed == selectedViewModel
          ? _value.selectedViewModel
          : selectedViewModel // ignore: cast_nullable_to_non_nullable
              as ViewModel?,
      viewType: null == viewType
          ? _value._viewType
          : viewType // ignore: cast_nullable_to_non_nullable
              as Set<LibraryViewType>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<RecommendedModel>,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<RecommendedModel>,
      favourites: null == favourites
          ? _value._favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as List<ItemBaseModel>,
    ));
  }
}

/// @nodoc

class _$LibraryScreenModelImpl implements _LibraryScreenModel {
  _$LibraryScreenModelImpl(
      {final List<ViewModel> views = const [],
      this.selectedViewModel,
      final Set<LibraryViewType> viewType = const {
        LibraryViewType.recommended,
        LibraryViewType.favourites
      },
      final List<RecommendedModel> recommendations = const [],
      final List<RecommendedModel> genres = const [],
      final List<ItemBaseModel> favourites = const []})
      : _views = views,
        _viewType = viewType,
        _recommendations = recommendations,
        _genres = genres,
        _favourites = favourites;

  final List<ViewModel> _views;
  @override
  @JsonKey()
  List<ViewModel> get views {
    if (_views is EqualUnmodifiableListView) return _views;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_views);
  }

  @override
  final ViewModel? selectedViewModel;
  final Set<LibraryViewType> _viewType;
  @override
  @JsonKey()
  Set<LibraryViewType> get viewType {
    if (_viewType is EqualUnmodifiableSetView) return _viewType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_viewType);
  }

  final List<RecommendedModel> _recommendations;
  @override
  @JsonKey()
  List<RecommendedModel> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final List<RecommendedModel> _genres;
  @override
  @JsonKey()
  List<RecommendedModel> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  final List<ItemBaseModel> _favourites;
  @override
  @JsonKey()
  List<ItemBaseModel> get favourites {
    if (_favourites is EqualUnmodifiableListView) return _favourites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favourites);
  }

  @override
  String toString() {
    return 'LibraryScreenModel(views: $views, selectedViewModel: $selectedViewModel, viewType: $viewType, recommendations: $recommendations, genres: $genres, favourites: $favourites)';
  }

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LibraryScreenModelImplCopyWith<_$LibraryScreenModelImpl> get copyWith =>
      __$$LibraryScreenModelImplCopyWithImpl<_$LibraryScreenModelImpl>(
          this, _$identity);
}

abstract class _LibraryScreenModel implements LibraryScreenModel {
  factory _LibraryScreenModel(
      {final List<ViewModel> views,
      final ViewModel? selectedViewModel,
      final Set<LibraryViewType> viewType,
      final List<RecommendedModel> recommendations,
      final List<RecommendedModel> genres,
      final List<ItemBaseModel> favourites}) = _$LibraryScreenModelImpl;

  @override
  List<ViewModel> get views;
  @override
  ViewModel? get selectedViewModel;
  @override
  Set<LibraryViewType> get viewType;
  @override
  List<RecommendedModel> get recommendations;
  @override
  List<RecommendedModel> get genres;
  @override
  List<ItemBaseModel> get favourites;

  /// Create a copy of LibraryScreenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LibraryScreenModelImplCopyWith<_$LibraryScreenModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
