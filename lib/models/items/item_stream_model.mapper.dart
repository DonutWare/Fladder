// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'item_stream_model.dart';

class ItemStreamModelMapper extends SubClassMapperBase<ItemStreamModel> {
  ItemStreamModelMapper._();

  static ItemStreamModelMapper? _instance;
  static ItemStreamModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ItemStreamModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ItemStreamModel';

  static ImagesData? _$parentImages(ItemStreamModel v) => v.parentImages;
  static const Field<ItemStreamModel, ImagesData> _f$parentImages =
      Field('parentImages', _$parentImages);
  static MediaStreamsModel _$mediaStreams(ItemStreamModel v) => v.mediaStreams;
  static const Field<ItemStreamModel, MediaStreamsModel> _f$mediaStreams =
      Field('mediaStreams', _$mediaStreams);
  static String _$name(ItemStreamModel v) => v.name;
  static const Field<ItemStreamModel, String> _f$name = Field('name', _$name);
  static String _$id(ItemStreamModel v) => v.id;
  static const Field<ItemStreamModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(ItemStreamModel v) => v.overview;
  static const Field<ItemStreamModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(ItemStreamModel v) => v.parentId;
  static const Field<ItemStreamModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(ItemStreamModel v) => v.playlistId;
  static const Field<ItemStreamModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(ItemStreamModel v) => v.images;
  static const Field<ItemStreamModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(ItemStreamModel v) => v.childCount;
  static const Field<ItemStreamModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(ItemStreamModel v) => v.primaryRatio;
  static const Field<ItemStreamModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(ItemStreamModel v) => v.userData;
  static const Field<ItemStreamModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDelete(ItemStreamModel v) => v.canDelete;
  static const Field<ItemStreamModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete);
  static bool? _$canDownload(ItemStreamModel v) => v.canDownload;
  static const Field<ItemStreamModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload);
  static dto.BaseItemKind? _$jellyType(ItemStreamModel v) => v.jellyType;
  static const Field<ItemStreamModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<ItemStreamModel> fields = const {
    #parentImages: _f$parentImages,
    #mediaStreams: _f$mediaStreams,
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
  final dynamic discriminatorValue = 'ItemStreamModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static ItemStreamModel _instantiate(DecodingData data) {
    return ItemStreamModel(
        parentImages: data.dec(_f$parentImages),
        mediaStreams: data.dec(_f$mediaStreams),
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

mixin ItemStreamModelMappable {
  ItemStreamModelCopyWith<ItemStreamModel, ItemStreamModel, ItemStreamModel>
      get copyWith => _ItemStreamModelCopyWithImpl(
          this as ItemStreamModel, $identity, $identity);
}

extension ItemStreamModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ItemStreamModel, $Out> {
  ItemStreamModelCopyWith<$R, ItemStreamModel, $Out> get $asItemStreamModel =>
      $base.as((v, t, t2) => _ItemStreamModelCopyWithImpl(v, t, t2));
}

abstract class ItemStreamModelCopyWith<$R, $In extends ItemStreamModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {ImagesData? parentImages,
      MediaStreamsModel? mediaStreams,
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
  ItemStreamModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ItemStreamModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ItemStreamModel, $Out>
    implements ItemStreamModelCopyWith<$R, ItemStreamModel, $Out> {
  _ItemStreamModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ItemStreamModel> $mapper =
      ItemStreamModelMapper.ensureInitialized();
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {Object? parentImages = $none,
          MediaStreamsModel? mediaStreams,
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
        if (parentImages != $none) #parentImages: parentImages,
        if (mediaStreams != null) #mediaStreams: mediaStreams,
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
  ItemStreamModel $make(CopyWithData data) => ItemStreamModel(
      parentImages: data.get(#parentImages, or: $value.parentImages),
      mediaStreams: data.get(#mediaStreams, or: $value.mediaStreams),
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
  ItemStreamModelCopyWith<$R2, ItemStreamModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ItemStreamModelCopyWithImpl($value, $cast, t);
}
