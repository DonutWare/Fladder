// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'folder_model.dart';

class FolderModelMapper extends SubClassMapperBase<FolderModel> {
  FolderModelMapper._();

  static FolderModelMapper? _instance;
  static FolderModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FolderModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      ItemBaseModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FolderModel';

  static List<ItemBaseModel> _$items(FolderModel v) => v.items;
  static const Field<FolderModel, List<ItemBaseModel>> _f$items =
      Field('items', _$items);
  static OverviewModel _$overview(FolderModel v) => v.overview;
  static const Field<FolderModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(FolderModel v) => v.parentId;
  static const Field<FolderModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(FolderModel v) => v.playlistId;
  static const Field<FolderModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(FolderModel v) => v.images;
  static const Field<FolderModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(FolderModel v) => v.childCount;
  static const Field<FolderModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(FolderModel v) => v.primaryRatio;
  static const Field<FolderModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(FolderModel v) => v.userData;
  static const Field<FolderModel, UserData> _f$userData =
      Field('userData', _$userData);
  static String _$name(FolderModel v) => v.name;
  static const Field<FolderModel, String> _f$name = Field('name', _$name);
  static String _$id(FolderModel v) => v.id;
  static const Field<FolderModel, String> _f$id = Field('id', _$id);
  static bool? _$canDownload(FolderModel v) => v.canDownload;
  static const Field<FolderModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload, opt: true);
  static bool? _$canDelete(FolderModel v) => v.canDelete;
  static const Field<FolderModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete, opt: true);
  static BaseItemKind? _$jellyType(FolderModel v) => v.jellyType;
  static const Field<FolderModel, BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<FolderModel> fields = const {
    #items: _f$items,
    #overview: _f$overview,
    #parentId: _f$parentId,
    #playlistId: _f$playlistId,
    #images: _f$images,
    #childCount: _f$childCount,
    #primaryRatio: _f$primaryRatio,
    #userData: _f$userData,
    #name: _f$name,
    #id: _f$id,
    #canDownload: _f$canDownload,
    #canDelete: _f$canDelete,
    #jellyType: _f$jellyType,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'FolderModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static FolderModel _instantiate(DecodingData data) {
    return FolderModel(
        items: data.dec(_f$items),
        overview: data.dec(_f$overview),
        parentId: data.dec(_f$parentId),
        playlistId: data.dec(_f$playlistId),
        images: data.dec(_f$images),
        childCount: data.dec(_f$childCount),
        primaryRatio: data.dec(_f$primaryRatio),
        userData: data.dec(_f$userData),
        name: data.dec(_f$name),
        id: data.dec(_f$id),
        canDownload: data.dec(_f$canDownload),
        canDelete: data.dec(_f$canDelete),
        jellyType: data.dec(_f$jellyType));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin FolderModelMappable {
  FolderModelCopyWith<FolderModel, FolderModel, FolderModel> get copyWith =>
      _FolderModelCopyWithImpl<FolderModel, FolderModel>(
          this as FolderModel, $identity, $identity);
}

extension FolderModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FolderModel, $Out> {
  FolderModelCopyWith<$R, FolderModel, $Out> get $asFolderModel =>
      $base.as((v, t, t2) => _FolderModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FolderModelCopyWith<$R, $In extends FolderModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ItemBaseModel,
      ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>> get items;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {List<ItemBaseModel>? items,
      OverviewModel? overview,
      String? parentId,
      String? playlistId,
      ImagesData? images,
      int? childCount,
      double? primaryRatio,
      UserData? userData,
      String? name,
      String? id,
      bool? canDownload,
      bool? canDelete,
      BaseItemKind? jellyType});
  FolderModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FolderModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FolderModel, $Out>
    implements FolderModelCopyWith<$R, FolderModel, $Out> {
  _FolderModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FolderModel> $mapper =
      FolderModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ItemBaseModel,
          ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>>
      get items => ListCopyWith(
          $value.items, (v, t) => v.copyWith.$chain(t), (v) => call(items: v));
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {List<ItemBaseModel>? items,
          OverviewModel? overview,
          Object? parentId = $none,
          Object? playlistId = $none,
          Object? images = $none,
          Object? childCount = $none,
          Object? primaryRatio = $none,
          UserData? userData,
          String? name,
          String? id,
          Object? canDownload = $none,
          Object? canDelete = $none,
          Object? jellyType = $none}) =>
      $apply(FieldCopyWithData({
        if (items != null) #items: items,
        if (overview != null) #overview: overview,
        if (parentId != $none) #parentId: parentId,
        if (playlistId != $none) #playlistId: playlistId,
        if (images != $none) #images: images,
        if (childCount != $none) #childCount: childCount,
        if (primaryRatio != $none) #primaryRatio: primaryRatio,
        if (userData != null) #userData: userData,
        if (name != null) #name: name,
        if (id != null) #id: id,
        if (canDownload != $none) #canDownload: canDownload,
        if (canDelete != $none) #canDelete: canDelete,
        if (jellyType != $none) #jellyType: jellyType
      }));
  @override
  FolderModel $make(CopyWithData data) => FolderModel(
      items: data.get(#items, or: $value.items),
      overview: data.get(#overview, or: $value.overview),
      parentId: data.get(#parentId, or: $value.parentId),
      playlistId: data.get(#playlistId, or: $value.playlistId),
      images: data.get(#images, or: $value.images),
      childCount: data.get(#childCount, or: $value.childCount),
      primaryRatio: data.get(#primaryRatio, or: $value.primaryRatio),
      userData: data.get(#userData, or: $value.userData),
      name: data.get(#name, or: $value.name),
      id: data.get(#id, or: $value.id),
      canDownload: data.get(#canDownload, or: $value.canDownload),
      canDelete: data.get(#canDelete, or: $value.canDelete),
      jellyType: data.get(#jellyType, or: $value.jellyType));

  @override
  FolderModelCopyWith<$R2, FolderModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FolderModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
