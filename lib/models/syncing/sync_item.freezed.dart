// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncedItem {
  String get id;
  bool get syncing;
  String? get parentId;
  String get userId;
  String? get path;
  bool get markedForDelete;
  String? get sortName;
  int? get fileSize;
  String? get videoFileName;
  MediaSegmentsModel? get mediaSegments;
  TrickPlayModel? get fTrickPlayModel;
  ImagesData? get fImages;
  List<Chapter> get fChapters;
  List<SubStreamModel> get subtitles;
  bool get unSyncedData;
  @UserDataJsonSerializer()
  UserData? get userData; // ignore: invalid_annotation_target
  @JsonKey(includeFromJson: false, includeToJson: false)
  ItemBaseModel? get itemModel;

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyncedItemCopyWith<SyncedItem> get copyWith =>
      _$SyncedItemCopyWithImpl<SyncedItem>(this as SyncedItem, _$identity);

  @override
  String toString() {
    return 'SyncedItem(id: $id, syncing: $syncing, parentId: $parentId, userId: $userId, path: $path, markedForDelete: $markedForDelete, sortName: $sortName, fileSize: $fileSize, videoFileName: $videoFileName, mediaSegments: $mediaSegments, fTrickPlayModel: $fTrickPlayModel, fImages: $fImages, fChapters: $fChapters, subtitles: $subtitles, unSyncedData: $unSyncedData, userData: $userData, itemModel: $itemModel)';
  }
}

/// @nodoc
abstract mixin class $SyncedItemCopyWith<$Res> {
  factory $SyncedItemCopyWith(
          SyncedItem value, $Res Function(SyncedItem) _then) =
      _$SyncedItemCopyWithImpl;
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
      bool unSyncedData,
      @UserDataJsonSerializer() UserData? userData,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ItemBaseModel? itemModel});

  $TrickPlayModelCopyWith<$Res>? get fTrickPlayModel;
}

/// @nodoc
class _$SyncedItemCopyWithImpl<$Res> implements $SyncedItemCopyWith<$Res> {
  _$SyncedItemCopyWithImpl(this._self, this._then);

  final SyncedItem _self;
  final $Res Function(SyncedItem) _then;

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
    Object? unSyncedData = null,
    Object? userData = freezed,
    Object? itemModel = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      syncing: null == syncing
          ? _self.syncing
          : syncing // ignore: cast_nullable_to_non_nullable
              as bool,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      markedForDelete: null == markedForDelete
          ? _self.markedForDelete
          : markedForDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      sortName: freezed == sortName
          ? _self.sortName
          : sortName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _self.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      videoFileName: freezed == videoFileName
          ? _self.videoFileName
          : videoFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaSegments: freezed == mediaSegments
          ? _self.mediaSegments
          : mediaSegments // ignore: cast_nullable_to_non_nullable
              as MediaSegmentsModel?,
      fTrickPlayModel: freezed == fTrickPlayModel
          ? _self.fTrickPlayModel
          : fTrickPlayModel // ignore: cast_nullable_to_non_nullable
              as TrickPlayModel?,
      fImages: freezed == fImages
          ? _self.fImages
          : fImages // ignore: cast_nullable_to_non_nullable
              as ImagesData?,
      fChapters: null == fChapters
          ? _self.fChapters
          : fChapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
      subtitles: null == subtitles
          ? _self.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<SubStreamModel>,
      unSyncedData: null == unSyncedData
          ? _self.unSyncedData
          : unSyncedData // ignore: cast_nullable_to_non_nullable
              as bool,
      userData: freezed == userData
          ? _self.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
      itemModel: freezed == itemModel
          ? _self.itemModel
          : itemModel // ignore: cast_nullable_to_non_nullable
              as ItemBaseModel?,
    ));
  }

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrickPlayModelCopyWith<$Res>? get fTrickPlayModel {
    if (_self.fTrickPlayModel == null) {
      return null;
    }

    return $TrickPlayModelCopyWith<$Res>(_self.fTrickPlayModel!, (value) {
      return _then(_self.copyWith(fTrickPlayModel: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SyncedItem].
extension SyncedItemPatterns on SyncedItem {
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
    TResult Function(_SyncItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncItem() when $default != null:
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
    TResult Function(_SyncItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncItem():
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
    TResult? Function(_SyncItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncItem() when $default != null:
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
            bool unSyncedData,
            @UserDataJsonSerializer() UserData? userData,
            @JsonKey(includeFromJson: false, includeToJson: false)
            ItemBaseModel? itemModel)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncItem() when $default != null:
        return $default(
            _that.id,
            _that.syncing,
            _that.parentId,
            _that.userId,
            _that.path,
            _that.markedForDelete,
            _that.sortName,
            _that.fileSize,
            _that.videoFileName,
            _that.mediaSegments,
            _that.fTrickPlayModel,
            _that.fImages,
            _that.fChapters,
            _that.subtitles,
            _that.unSyncedData,
            _that.userData,
            _that.itemModel);
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
            bool unSyncedData,
            @UserDataJsonSerializer() UserData? userData,
            @JsonKey(includeFromJson: false, includeToJson: false)
            ItemBaseModel? itemModel)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncItem():
        return $default(
            _that.id,
            _that.syncing,
            _that.parentId,
            _that.userId,
            _that.path,
            _that.markedForDelete,
            _that.sortName,
            _that.fileSize,
            _that.videoFileName,
            _that.mediaSegments,
            _that.fTrickPlayModel,
            _that.fImages,
            _that.fChapters,
            _that.subtitles,
            _that.unSyncedData,
            _that.userData,
            _that.itemModel);
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
            bool unSyncedData,
            @UserDataJsonSerializer() UserData? userData,
            @JsonKey(includeFromJson: false, includeToJson: false)
            ItemBaseModel? itemModel)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncItem() when $default != null:
        return $default(
            _that.id,
            _that.syncing,
            _that.parentId,
            _that.userId,
            _that.path,
            _that.markedForDelete,
            _that.sortName,
            _that.fileSize,
            _that.videoFileName,
            _that.mediaSegments,
            _that.fTrickPlayModel,
            _that.fImages,
            _that.fChapters,
            _that.subtitles,
            _that.unSyncedData,
            _that.userData,
            _that.itemModel);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SyncItem extends SyncedItem {
  _SyncItem(
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
      this.unSyncedData = false,
      @UserDataJsonSerializer() this.userData,
      @JsonKey(includeFromJson: false, includeToJson: false) this.itemModel})
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
  @JsonKey()
  final bool unSyncedData;
  @override
  @UserDataJsonSerializer()
  final UserData? userData;
// ignore: invalid_annotation_target
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ItemBaseModel? itemModel;

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyncItemCopyWith<_SyncItem> get copyWith =>
      __$SyncItemCopyWithImpl<_SyncItem>(this, _$identity);

  @override
  String toString() {
    return 'SyncedItem(id: $id, syncing: $syncing, parentId: $parentId, userId: $userId, path: $path, markedForDelete: $markedForDelete, sortName: $sortName, fileSize: $fileSize, videoFileName: $videoFileName, mediaSegments: $mediaSegments, fTrickPlayModel: $fTrickPlayModel, fImages: $fImages, fChapters: $fChapters, subtitles: $subtitles, unSyncedData: $unSyncedData, userData: $userData, itemModel: $itemModel)';
  }
}

/// @nodoc
abstract mixin class _$SyncItemCopyWith<$Res>
    implements $SyncedItemCopyWith<$Res> {
  factory _$SyncItemCopyWith(_SyncItem value, $Res Function(_SyncItem) _then) =
      __$SyncItemCopyWithImpl;
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
      bool unSyncedData,
      @UserDataJsonSerializer() UserData? userData,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ItemBaseModel? itemModel});

  @override
  $TrickPlayModelCopyWith<$Res>? get fTrickPlayModel;
}

/// @nodoc
class __$SyncItemCopyWithImpl<$Res> implements _$SyncItemCopyWith<$Res> {
  __$SyncItemCopyWithImpl(this._self, this._then);

  final _SyncItem _self;
  final $Res Function(_SyncItem) _then;

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    Object? unSyncedData = null,
    Object? userData = freezed,
    Object? itemModel = freezed,
  }) {
    return _then(_SyncItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      syncing: null == syncing
          ? _self.syncing
          : syncing // ignore: cast_nullable_to_non_nullable
              as bool,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      markedForDelete: null == markedForDelete
          ? _self.markedForDelete
          : markedForDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      sortName: freezed == sortName
          ? _self.sortName
          : sortName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _self.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      videoFileName: freezed == videoFileName
          ? _self.videoFileName
          : videoFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaSegments: freezed == mediaSegments
          ? _self.mediaSegments
          : mediaSegments // ignore: cast_nullable_to_non_nullable
              as MediaSegmentsModel?,
      fTrickPlayModel: freezed == fTrickPlayModel
          ? _self.fTrickPlayModel
          : fTrickPlayModel // ignore: cast_nullable_to_non_nullable
              as TrickPlayModel?,
      fImages: freezed == fImages
          ? _self.fImages
          : fImages // ignore: cast_nullable_to_non_nullable
              as ImagesData?,
      fChapters: null == fChapters
          ? _self._fChapters
          : fChapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
      subtitles: null == subtitles
          ? _self._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<SubStreamModel>,
      unSyncedData: null == unSyncedData
          ? _self.unSyncedData
          : unSyncedData // ignore: cast_nullable_to_non_nullable
              as bool,
      userData: freezed == userData
          ? _self.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
      itemModel: freezed == itemModel
          ? _self.itemModel
          : itemModel // ignore: cast_nullable_to_non_nullable
              as ItemBaseModel?,
    ));
  }

  /// Create a copy of SyncedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrickPlayModelCopyWith<$Res>? get fTrickPlayModel {
    if (_self.fTrickPlayModel == null) {
      return null;
    }

    return $TrickPlayModelCopyWith<$Res>(_self.fTrickPlayModel!, (value) {
      return _then(_self.copyWith(fTrickPlayModel: value));
    });
  }
}

// dart format on
