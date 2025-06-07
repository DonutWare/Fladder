// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'item_base_model.dart';

class ItemBaseModelMapper extends ClassMapperBase<ItemBaseModel> {
  ItemBaseModelMapper._();

  static ItemBaseModelMapper? _instance;
  static ItemBaseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ItemBaseModelMapper._());
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ItemBaseModel';

  static String _$name(ItemBaseModel v) => v.name;
  static const Field<ItemBaseModel, String> _f$name = Field('name', _$name);
  static String _$id(ItemBaseModel v) => v.id;
  static const Field<ItemBaseModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(ItemBaseModel v) => v.overview;
  static const Field<ItemBaseModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(ItemBaseModel v) => v.parentId;
  static const Field<ItemBaseModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(ItemBaseModel v) => v.playlistId;
  static const Field<ItemBaseModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(ItemBaseModel v) => v.images;
  static const Field<ItemBaseModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(ItemBaseModel v) => v.childCount;
  static const Field<ItemBaseModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(ItemBaseModel v) => v.primaryRatio;
  static const Field<ItemBaseModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(ItemBaseModel v) => v.userData;
  static const Field<ItemBaseModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDownload(ItemBaseModel v) => v.canDownload;
  static const Field<ItemBaseModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload);
  static bool? _$canDelete(ItemBaseModel v) => v.canDelete;
  static const Field<ItemBaseModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete);
  static dto.BaseItemKind? _$jellyType(ItemBaseModel v) => v.jellyType;
  static const Field<ItemBaseModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType);

  @override
  final MappableFields<ItemBaseModel> fields = const {
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

  static ItemBaseModel _instantiate(DecodingData data) {
    return ItemBaseModel(
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

mixin ItemBaseModelMappable {
  ItemBaseModelCopyWith<ItemBaseModel, ItemBaseModel, ItemBaseModel>
      get copyWith => _ItemBaseModelCopyWithImpl(
          this as ItemBaseModel, $identity, $identity);
}

extension ItemBaseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ItemBaseModel, $Out> {
  ItemBaseModelCopyWith<$R, ItemBaseModel, $Out> get $asItemBaseModel =>
      $base.as((v, t, t2) => _ItemBaseModelCopyWithImpl(v, t, t2));
}

abstract class ItemBaseModelCopyWith<$R, $In extends ItemBaseModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  UserDataCopyWith<$R, UserData, UserData> get userData;
  $R call(
      {String? name,
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
  ItemBaseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ItemBaseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ItemBaseModel, $Out>
    implements ItemBaseModelCopyWith<$R, ItemBaseModel, $Out> {
  _ItemBaseModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ItemBaseModel> $mapper =
      ItemBaseModelMapper.ensureInitialized();
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {String? name,
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
  ItemBaseModel $make(CopyWithData data) => ItemBaseModel(
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
  ItemBaseModelCopyWith<$R2, ItemBaseModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ItemBaseModelCopyWithImpl($value, $cast, t);
}
