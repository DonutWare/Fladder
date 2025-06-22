// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'photos_model.dart';

class PhotoAlbumModelMapper extends SubClassMapperBase<PhotoAlbumModel> {
  PhotoAlbumModelMapper._();

  static PhotoAlbumModelMapper? _instance;
  static PhotoAlbumModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PhotoAlbumModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      ItemBaseModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PhotoAlbumModel';

  static List<ItemBaseModel> _$photos(PhotoAlbumModel v) => v.photos;
  static const Field<PhotoAlbumModel, List<ItemBaseModel>> _f$photos =
      Field('photos', _$photos);
  static String _$name(PhotoAlbumModel v) => v.name;
  static const Field<PhotoAlbumModel, String> _f$name = Field('name', _$name);
  static String _$id(PhotoAlbumModel v) => v.id;
  static const Field<PhotoAlbumModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(PhotoAlbumModel v) => v.overview;
  static const Field<PhotoAlbumModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(PhotoAlbumModel v) => v.parentId;
  static const Field<PhotoAlbumModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(PhotoAlbumModel v) => v.playlistId;
  static const Field<PhotoAlbumModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(PhotoAlbumModel v) => v.images;
  static const Field<PhotoAlbumModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(PhotoAlbumModel v) => v.childCount;
  static const Field<PhotoAlbumModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(PhotoAlbumModel v) => v.primaryRatio;
  static const Field<PhotoAlbumModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(PhotoAlbumModel v) => v.userData;
  static const Field<PhotoAlbumModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDelete(PhotoAlbumModel v) => v.canDelete;
  static const Field<PhotoAlbumModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete, opt: true);
  static bool? _$canDownload(PhotoAlbumModel v) => v.canDownload;
  static const Field<PhotoAlbumModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload, opt: true);
  static dto.BaseItemKind? _$jellyType(PhotoAlbumModel v) => v.jellyType;
  static const Field<PhotoAlbumModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<PhotoAlbumModel> fields = const {
    #photos: _f$photos,
    #name: _f$name,
    #id: _f$id,
    #overview: _f$overview,
    #parentId: _f$parentId,
    #playlistId: _f$playlistId,
    #images: _f$images,
    #childCount: _f$childCount,
    #primaryRatio: _f$primaryRatio,
    #userData: _f$userData,
    #canDelete: _f$canDelete,
    #canDownload: _f$canDownload,
    #jellyType: _f$jellyType,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'PhotoAlbumModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static PhotoAlbumModel _instantiate(DecodingData data) {
    return PhotoAlbumModel(
        photos: data.dec(_f$photos),
        name: data.dec(_f$name),
        id: data.dec(_f$id),
        overview: data.dec(_f$overview),
        parentId: data.dec(_f$parentId),
        playlistId: data.dec(_f$playlistId),
        images: data.dec(_f$images),
        childCount: data.dec(_f$childCount),
        primaryRatio: data.dec(_f$primaryRatio),
        userData: data.dec(_f$userData),
        canDelete: data.dec(_f$canDelete),
        canDownload: data.dec(_f$canDownload),
        jellyType: data.dec(_f$jellyType));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin PhotoAlbumModelMappable {
  PhotoAlbumModelCopyWith<PhotoAlbumModel, PhotoAlbumModel, PhotoAlbumModel>
      get copyWith => _PhotoAlbumModelCopyWithImpl(
          this as PhotoAlbumModel, $identity, $identity);
}

extension PhotoAlbumModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PhotoAlbumModel, $Out> {
  PhotoAlbumModelCopyWith<$R, PhotoAlbumModel, $Out> get $asPhotoAlbumModel =>
      $base.as((v, t, t2) => _PhotoAlbumModelCopyWithImpl(v, t, t2));
}

abstract class PhotoAlbumModelCopyWith<$R, $In extends PhotoAlbumModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ItemBaseModel,
      ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>> get photos;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {List<ItemBaseModel>? photos,
      String? name,
      String? id,
      OverviewModel? overview,
      String? parentId,
      String? playlistId,
      ImagesData? images,
      int? childCount,
      double? primaryRatio,
      UserData? userData,
      bool? canDelete,
      bool? canDownload,
      dto.BaseItemKind? jellyType});
  PhotoAlbumModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PhotoAlbumModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PhotoAlbumModel, $Out>
    implements PhotoAlbumModelCopyWith<$R, PhotoAlbumModel, $Out> {
  _PhotoAlbumModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PhotoAlbumModel> $mapper =
      PhotoAlbumModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ItemBaseModel,
          ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>>
      get photos => ListCopyWith($value.photos, (v, t) => v.copyWith.$chain(t),
          (v) => call(photos: v));
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {List<ItemBaseModel>? photos,
          String? name,
          String? id,
          OverviewModel? overview,
          Object? parentId = $none,
          Object? playlistId = $none,
          Object? images = $none,
          Object? childCount = $none,
          Object? primaryRatio = $none,
          UserData? userData,
          Object? canDelete = $none,
          Object? canDownload = $none,
          Object? jellyType = $none}) =>
      $apply(FieldCopyWithData({
        if (photos != null) #photos: photos,
        if (name != null) #name: name,
        if (id != null) #id: id,
        if (overview != null) #overview: overview,
        if (parentId != $none) #parentId: parentId,
        if (playlistId != $none) #playlistId: playlistId,
        if (images != $none) #images: images,
        if (childCount != $none) #childCount: childCount,
        if (primaryRatio != $none) #primaryRatio: primaryRatio,
        if (userData != null) #userData: userData,
        if (canDelete != $none) #canDelete: canDelete,
        if (canDownload != $none) #canDownload: canDownload,
        if (jellyType != $none) #jellyType: jellyType
      }));
  @override
  PhotoAlbumModel $make(CopyWithData data) => PhotoAlbumModel(
      photos: data.get(#photos, or: $value.photos),
      name: data.get(#name, or: $value.name),
      id: data.get(#id, or: $value.id),
      overview: data.get(#overview, or: $value.overview),
      parentId: data.get(#parentId, or: $value.parentId),
      playlistId: data.get(#playlistId, or: $value.playlistId),
      images: data.get(#images, or: $value.images),
      childCount: data.get(#childCount, or: $value.childCount),
      primaryRatio: data.get(#primaryRatio, or: $value.primaryRatio),
      userData: data.get(#userData, or: $value.userData),
      canDelete: data.get(#canDelete, or: $value.canDelete),
      canDownload: data.get(#canDownload, or: $value.canDownload),
      jellyType: data.get(#jellyType, or: $value.jellyType));

  @override
  PhotoAlbumModelCopyWith<$R2, PhotoAlbumModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PhotoAlbumModelCopyWithImpl($value, $cast, t);
}

class PhotoModelMapper extends SubClassMapperBase<PhotoModel> {
  PhotoModelMapper._();

  static PhotoModelMapper? _instance;
  static PhotoModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PhotoModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PhotoModel';

  static String? _$albumId(PhotoModel v) => v.albumId;
  static const Field<PhotoModel, String> _f$albumId =
      Field('albumId', _$albumId);
  static DateTime? _$dateTaken(PhotoModel v) => v.dateTaken;
  static const Field<PhotoModel, DateTime> _f$dateTaken =
      Field('dateTaken', _$dateTaken);
  static ImagesData? _$thumbnail(PhotoModel v) => v.thumbnail;
  static const Field<PhotoModel, ImagesData> _f$thumbnail =
      Field('thumbnail', _$thumbnail);
  static FladderItemType _$internalType(PhotoModel v) => v.internalType;
  static const Field<PhotoModel, FladderItemType> _f$internalType =
      Field('internalType', _$internalType);
  static String _$name(PhotoModel v) => v.name;
  static const Field<PhotoModel, String> _f$name = Field('name', _$name);
  static String _$id(PhotoModel v) => v.id;
  static const Field<PhotoModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(PhotoModel v) => v.overview;
  static const Field<PhotoModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(PhotoModel v) => v.parentId;
  static const Field<PhotoModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(PhotoModel v) => v.playlistId;
  static const Field<PhotoModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(PhotoModel v) => v.images;
  static const Field<PhotoModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(PhotoModel v) => v.childCount;
  static const Field<PhotoModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(PhotoModel v) => v.primaryRatio;
  static const Field<PhotoModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(PhotoModel v) => v.userData;
  static const Field<PhotoModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDownload(PhotoModel v) => v.canDownload;
  static const Field<PhotoModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload);
  static bool? _$canDelete(PhotoModel v) => v.canDelete;
  static const Field<PhotoModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete);
  static dto.BaseItemKind? _$jellyType(PhotoModel v) => v.jellyType;
  static const Field<PhotoModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<PhotoModel> fields = const {
    #albumId: _f$albumId,
    #dateTaken: _f$dateTaken,
    #thumbnail: _f$thumbnail,
    #internalType: _f$internalType,
    #name: _f$name,
    #id: _f$id,
    #overview: _f$overview,
    #parentId: _f$parentId,
    #playlistId: _f$playlistId,
    #images: _f$images,
    #childCount: _f$childCount,
    #primaryRatio: _f$primaryRatio,
    #userData: _f$userData,
    #canDownload: _f$canDownload,
    #canDelete: _f$canDelete,
    #jellyType: _f$jellyType,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'PhotoModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static PhotoModel _instantiate(DecodingData data) {
    return PhotoModel(
        albumId: data.dec(_f$albumId),
        dateTaken: data.dec(_f$dateTaken),
        thumbnail: data.dec(_f$thumbnail),
        internalType: data.dec(_f$internalType),
        name: data.dec(_f$name),
        id: data.dec(_f$id),
        overview: data.dec(_f$overview),
        parentId: data.dec(_f$parentId),
        playlistId: data.dec(_f$playlistId),
        images: data.dec(_f$images),
        childCount: data.dec(_f$childCount),
        primaryRatio: data.dec(_f$primaryRatio),
        userData: data.dec(_f$userData),
        canDownload: data.dec(_f$canDownload),
        canDelete: data.dec(_f$canDelete),
        jellyType: data.dec(_f$jellyType));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin PhotoModelMappable {
  PhotoModelCopyWith<PhotoModel, PhotoModel, PhotoModel> get copyWith =>
      _PhotoModelCopyWithImpl(this as PhotoModel, $identity, $identity);
}

extension PhotoModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PhotoModel, $Out> {
  PhotoModelCopyWith<$R, PhotoModel, $Out> get $asPhotoModel =>
      $base.as((v, t, t2) => _PhotoModelCopyWithImpl(v, t, t2));
}

abstract class PhotoModelCopyWith<$R, $In extends PhotoModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {String? albumId,
      DateTime? dateTaken,
      ImagesData? thumbnail,
      FladderItemType? internalType,
      String? name,
      String? id,
      OverviewModel? overview,
      String? parentId,
      String? playlistId,
      ImagesData? images,
      int? childCount,
      double? primaryRatio,
      UserData? userData,
      bool? canDownload,
      bool? canDelete,
      dto.BaseItemKind? jellyType});
  PhotoModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PhotoModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PhotoModel, $Out>
    implements PhotoModelCopyWith<$R, PhotoModel, $Out> {
  _PhotoModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PhotoModel> $mapper =
      PhotoModelMapper.ensureInitialized();
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {Object? albumId = $none,
          Object? dateTaken = $none,
          Object? thumbnail = $none,
          FladderItemType? internalType,
          String? name,
          String? id,
          OverviewModel? overview,
          Object? parentId = $none,
          Object? playlistId = $none,
          Object? images = $none,
          Object? childCount = $none,
          Object? primaryRatio = $none,
          UserData? userData,
          Object? canDownload = $none,
          Object? canDelete = $none,
          Object? jellyType = $none}) =>
      $apply(FieldCopyWithData({
        if (albumId != $none) #albumId: albumId,
        if (dateTaken != $none) #dateTaken: dateTaken,
        if (thumbnail != $none) #thumbnail: thumbnail,
        if (internalType != null) #internalType: internalType,
        if (name != null) #name: name,
        if (id != null) #id: id,
        if (overview != null) #overview: overview,
        if (parentId != $none) #parentId: parentId,
        if (playlistId != $none) #playlistId: playlistId,
        if (images != $none) #images: images,
        if (childCount != $none) #childCount: childCount,
        if (primaryRatio != $none) #primaryRatio: primaryRatio,
        if (userData != null) #userData: userData,
        if (canDownload != $none) #canDownload: canDownload,
        if (canDelete != $none) #canDelete: canDelete,
        if (jellyType != $none) #jellyType: jellyType
      }));
  @override
  PhotoModel $make(CopyWithData data) => PhotoModel(
      albumId: data.get(#albumId, or: $value.albumId),
      dateTaken: data.get(#dateTaken, or: $value.dateTaken),
      thumbnail: data.get(#thumbnail, or: $value.thumbnail),
      internalType: data.get(#internalType, or: $value.internalType),
      name: data.get(#name, or: $value.name),
      id: data.get(#id, or: $value.id),
      overview: data.get(#overview, or: $value.overview),
      parentId: data.get(#parentId, or: $value.parentId),
      playlistId: data.get(#playlistId, or: $value.playlistId),
      images: data.get(#images, or: $value.images),
      childCount: data.get(#childCount, or: $value.childCount),
      primaryRatio: data.get(#primaryRatio, or: $value.primaryRatio),
      userData: data.get(#userData, or: $value.userData),
      canDownload: data.get(#canDownload, or: $value.canDownload),
      canDelete: data.get(#canDelete, or: $value.canDelete),
      jellyType: data.get(#jellyType, or: $value.jellyType));

  @override
  PhotoModelCopyWith<$R2, PhotoModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PhotoModelCopyWithImpl($value, $cast, t);
}
