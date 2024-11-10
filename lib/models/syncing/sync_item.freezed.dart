// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncedItem {
  String get id => throw _privateConstructorUsedError;
  bool get syncing => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  bool get markedForDelete => throw _privateConstructorUsedError;
  String? get sortName => throw _privateConstructorUsedError;
  int? get fileSize => throw _privateConstructorUsedError;
  String? get videoFileName => throw _privateConstructorUsedError;
  MediaSegmentsModel? get mediaSegments => throw _privateConstructorUsedError;
  TrickPlayModel? get fTrickPlayModel => throw _privateConstructorUsedError;
  ImagesData? get fImages => throw _privateConstructorUsedError;
  List<Chapter> get fChapters => throw _privateConstructorUsedError;
  List<SubStreamModel> get subtitles => throw _privateConstructorUsedError;
  @UserDataJsonSerializer()
  UserData? get userData => throw _privateConstructorUsedError;

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncedItemCopyWith<SyncedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncedItemCopyWith<$Res> {
  factory $SyncedItemCopyWith(
          SyncedItem value, $Res Function(SyncedItem) then) =
      _$SyncedItemCopyWithImpl<$Res, SyncedItem>;
  @useResult
  $Res call(
      {String id,
      bool syncing,
      String? parentId,
      String userId,
      String? path,
      bool markedForDelete,
      String? sortName,
      int? fileSize,
      String? videoFileName,
      MediaSegmentsModel? mediaSegments,
      TrickPlayModel? fTrickPlayModel,
      ImagesData? fImages,
      List<Chapter> fChapters,
      List<SubStreamModel> subtitles,
      @UserDataJsonSerializer() UserData? userData});

  $MediaSegmentsModelCopyWith<$Res>? get mediaSegments;
  $TrickPlayModelCopyWith<$Res>? get fTrickPlayModel;
}

/// @nodoc
class _$SyncedItemCopyWithImpl<$Res, $Val extends SyncedItem>
    implements $SyncedItemCopyWith<$Res> {
  _$SyncedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? syncing = null,
    Object? parentId = freezed,
    Object? userId = null,
    Object? path = freezed,
    Object? markedForDelete = null,
    Object? sortName = freezed,
    Object? fileSize = freezed,
    Object? videoFileName = freezed,
    Object? mediaSegments = freezed,
    Object? fTrickPlayModel = freezed,
    Object? fImages = freezed,
    Object? fChapters = null,
    Object? subtitles = null,
    Object? userData = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      syncing: null == syncing
          ? _value.syncing
          : syncing // ignore: cast_nullable_to_non_nullable
              as bool,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      markedForDelete: null == markedForDelete
          ? _value.markedForDelete
          : markedForDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      sortName: freezed == sortName
          ? _value.sortName
          : sortName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      videoFileName: freezed == videoFileName
          ? _value.videoFileName
          : videoFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaSegments: freezed == mediaSegments
          ? _value.mediaSegments
          : mediaSegments // ignore: cast_nullable_to_non_nullable
              as MediaSegmentsModel?,
      fTrickPlayModel: freezed == fTrickPlayModel
          ? _value.fTrickPlayModel
          : fTrickPlayModel // ignore: cast_nullable_to_non_nullable
              as TrickPlayModel?,
      fImages: freezed == fImages
          ? _value.fImages
          : fImages // ignore: cast_nullable_to_non_nullable
              as ImagesData?,
      fChapters: null == fChapters
          ? _value.fChapters
          : fChapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
      subtitles: null == subtitles
          ? _value.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<SubStreamModel>,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
    ) as $Val);
  }

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MediaSegmentsModelCopyWith<$Res>? get mediaSegments {
    if (_value.mediaSegments == null) {
      return null;
    }

    return $MediaSegmentsModelCopyWith<$Res>(_value.mediaSegments!, (value) {
      return _then(_value.copyWith(mediaSegments: value) as $Val);
    });
  }

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrickPlayModelCopyWith<$Res>? get fTrickPlayModel {
    if (_value.fTrickPlayModel == null) {
      return null;
    }

    return $TrickPlayModelCopyWith<$Res>(_value.fTrickPlayModel!, (value) {
      return _then(_value.copyWith(fTrickPlayModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SyncItemImplCopyWith<$Res>
    implements $SyncedItemCopyWith<$Res> {
  factory _$$SyncItemImplCopyWith(
          _$SyncItemImpl value, $Res Function(_$SyncItemImpl) then) =
      __$$SyncItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      bool syncing,
      String? parentId,
      String userId,
      String? path,
      bool markedForDelete,
      String? sortName,
      int? fileSize,
      String? videoFileName,
      MediaSegmentsModel? mediaSegments,
      TrickPlayModel? fTrickPlayModel,
      ImagesData? fImages,
      List<Chapter> fChapters,
      List<SubStreamModel> subtitles,
      @UserDataJsonSerializer() UserData? userData});

  @override
  $MediaSegmentsModelCopyWith<$Res>? get mediaSegments;
  @override
  $TrickPlayModelCopyWith<$Res>? get fTrickPlayModel;
}

/// @nodoc
class __$$SyncItemImplCopyWithImpl<$Res>
    extends _$SyncedItemCopyWithImpl<$Res, _$SyncItemImpl>
    implements _$$SyncItemImplCopyWith<$Res> {
  __$$SyncItemImplCopyWithImpl(
      _$SyncItemImpl _value, $Res Function(_$SyncItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? syncing = null,
    Object? parentId = freezed,
    Object? userId = null,
    Object? path = freezed,
    Object? markedForDelete = null,
    Object? sortName = freezed,
    Object? fileSize = freezed,
    Object? videoFileName = freezed,
    Object? mediaSegments = freezed,
    Object? fTrickPlayModel = freezed,
    Object? fImages = freezed,
    Object? fChapters = null,
    Object? subtitles = null,
    Object? userData = freezed,
  }) {
    return _then(_$SyncItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      syncing: null == syncing
          ? _value.syncing
          : syncing // ignore: cast_nullable_to_non_nullable
              as bool,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      markedForDelete: null == markedForDelete
          ? _value.markedForDelete
          : markedForDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      sortName: freezed == sortName
          ? _value.sortName
          : sortName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      videoFileName: freezed == videoFileName
          ? _value.videoFileName
          : videoFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaSegments: freezed == mediaSegments
          ? _value.mediaSegments
          : mediaSegments // ignore: cast_nullable_to_non_nullable
              as MediaSegmentsModel?,
      fTrickPlayModel: freezed == fTrickPlayModel
          ? _value.fTrickPlayModel
          : fTrickPlayModel // ignore: cast_nullable_to_non_nullable
              as TrickPlayModel?,
      fImages: freezed == fImages
          ? _value.fImages
          : fImages // ignore: cast_nullable_to_non_nullable
              as ImagesData?,
      fChapters: null == fChapters
          ? _value._fChapters
          : fChapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
      subtitles: null == subtitles
          ? _value._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<SubStreamModel>,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
    ));
  }
}

/// @nodoc

class _$SyncItemImpl extends _SyncItem {
  _$SyncItemImpl(
      {required this.id,
      this.syncing = false,
      this.parentId,
      required this.userId,
      this.path,
      this.markedForDelete = false,
      this.sortName,
      this.fileSize,
      this.videoFileName,
      this.mediaSegments,
      this.fTrickPlayModel,
      this.fImages,
      final List<Chapter> fChapters = const [],
      final List<SubStreamModel> subtitles = const [],
      @UserDataJsonSerializer() this.userData})
      : _fChapters = fChapters,
        _subtitles = subtitles,
        super._();

  @override
  final String id;
  @override
  @JsonKey()
  final bool syncing;
  @override
  final String? parentId;
  @override
  final String userId;
  @override
  final String? path;
  @override
  @JsonKey()
  final bool markedForDelete;
  @override
  final String? sortName;
  @override
  final int? fileSize;
  @override
  final String? videoFileName;
  @override
  final MediaSegmentsModel? mediaSegments;
  @override
  final TrickPlayModel? fTrickPlayModel;
  @override
  final ImagesData? fImages;
  final List<Chapter> _fChapters;
  @override
  @JsonKey()
  List<Chapter> get fChapters {
    if (_fChapters is EqualUnmodifiableListView) return _fChapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fChapters);
  }

  final List<SubStreamModel> _subtitles;
  @override
  @JsonKey()
  List<SubStreamModel> get subtitles {
    if (_subtitles is EqualUnmodifiableListView) return _subtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtitles);
  }

  @override
  @UserDataJsonSerializer()
  final UserData? userData;

  @override
  String toString() {
    return 'SyncedItem(id: $id, syncing: $syncing, parentId: $parentId, userId: $userId, path: $path, markedForDelete: $markedForDelete, sortName: $sortName, fileSize: $fileSize, videoFileName: $videoFileName, mediaSegments: $mediaSegments, fTrickPlayModel: $fTrickPlayModel, fImages: $fImages, fChapters: $fChapters, subtitles: $subtitles, userData: $userData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.syncing, syncing) || other.syncing == syncing) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.markedForDelete, markedForDelete) ||
                other.markedForDelete == markedForDelete) &&
            (identical(other.sortName, sortName) ||
                other.sortName == sortName) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.videoFileName, videoFileName) ||
                other.videoFileName == videoFileName) &&
            (identical(other.mediaSegments, mediaSegments) ||
                other.mediaSegments == mediaSegments) &&
            (identical(other.fTrickPlayModel, fTrickPlayModel) ||
                other.fTrickPlayModel == fTrickPlayModel) &&
            (identical(other.fImages, fImages) || other.fImages == fImages) &&
            const DeepCollectionEquality()
                .equals(other._fChapters, _fChapters) &&
            const DeepCollectionEquality()
                .equals(other._subtitles, _subtitles) &&
            (identical(other.userData, userData) ||
                other.userData == userData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      syncing,
      parentId,
      userId,
      path,
      markedForDelete,
      sortName,
      fileSize,
      videoFileName,
      mediaSegments,
      fTrickPlayModel,
      fImages,
      const DeepCollectionEquality().hash(_fChapters),
      const DeepCollectionEquality().hash(_subtitles),
      userData);

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncItemImplCopyWith<_$SyncItemImpl> get copyWith =>
      __$$SyncItemImplCopyWithImpl<_$SyncItemImpl>(this, _$identity);
}

abstract class _SyncItem extends SyncedItem {
  factory _SyncItem(
      {required final String id,
      final bool syncing,
      final String? parentId,
      required final String userId,
      final String? path,
      final bool markedForDelete,
      final String? sortName,
      final int? fileSize,
      final String? videoFileName,
      final MediaSegmentsModel? mediaSegments,
      final TrickPlayModel? fTrickPlayModel,
      final ImagesData? fImages,
      final List<Chapter> fChapters,
      final List<SubStreamModel> subtitles,
      @UserDataJsonSerializer() final UserData? userData}) = _$SyncItemImpl;
  _SyncItem._() : super._();

  @override
  String get id;
  @override
  bool get syncing;
  @override
  String? get parentId;
  @override
  String get userId;
  @override
  String? get path;
  @override
  bool get markedForDelete;
  @override
  String? get sortName;
  @override
  int? get fileSize;
  @override
  String? get videoFileName;
  @override
  MediaSegmentsModel? get mediaSegments;
  @override
  TrickPlayModel? get fTrickPlayModel;
  @override
  ImagesData? get fImages;
  @override
  List<Chapter> get fChapters;
  @override
  List<SubStreamModel> get subtitles;
  @override
  @UserDataJsonSerializer()
  UserData? get userData;

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncItemImplCopyWith<_$SyncItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
