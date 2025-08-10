// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'boxset_model.dart';

class BoxSetModelMapper extends SubClassMapperBase<BoxSetModel> {
  BoxSetModelMapper._();

  static BoxSetModelMapper? _instance;
  static BoxSetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoxSetModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      ItemBaseModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoxSetModel';

  static List<ItemBaseModel> _$items(BoxSetModel v) => v.items;
  static const Field<BoxSetModel, List<ItemBaseModel>> _f$items =
      Field('items', _$items, opt: true, def: const []);
  static String _$name(BoxSetModel v) => v.name;
  static const Field<BoxSetModel, String> _f$name = Field('name', _$name);
  static String _$id(BoxSetModel v) => v.id;
  static const Field<BoxSetModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(BoxSetModel v) => v.overview;
  static const Field<BoxSetModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(BoxSetModel v) => v.parentId;
  static const Field<BoxSetModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(BoxSetModel v) => v.playlistId;
  static const Field<BoxSetModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(BoxSetModel v) => v.images;
  static const Field<BoxSetModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(BoxSetModel v) => v.childCount;
  static const Field<BoxSetModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(BoxSetModel v) => v.primaryRatio;
  static const Field<BoxSetModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(BoxSetModel v) => v.userData;
  static const Field<BoxSetModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDelete(BoxSetModel v) => v.canDelete;
  static const Field<BoxSetModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete);
  static bool? _$canDownload(BoxSetModel v) => v.canDownload;
  static const Field<BoxSetModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload);
  static BaseItemKind? _$jellyType(BoxSetModel v) => v.jellyType;
  static const Field<BoxSetModel, BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<BoxSetModel> fields = const {
    #items: _f$items,
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
  final dynamic discriminatorValue = 'BoxSetModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static BoxSetModel _instantiate(DecodingData data) {
    return BoxSetModel(
        items: data.dec(_f$items),
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

mixin BoxSetModelMappable {
  BoxSetModelCopyWith<BoxSetModel, BoxSetModel, BoxSetModel> get copyWith =>
      _BoxSetModelCopyWithImpl<BoxSetModel, BoxSetModel>(
          this as BoxSetModel, $identity, $identity);
}

extension BoxSetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoxSetModel, $Out> {
  BoxSetModelCopyWith<$R, BoxSetModel, $Out> get $asBoxSetModel =>
      $base.as((v, t, t2) => _BoxSetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BoxSetModelCopyWith<$R, $In extends BoxSetModel, $Out>
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
      BaseItemKind? jellyType});
  BoxSetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BoxSetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoxSetModel, $Out>
    implements BoxSetModelCopyWith<$R, BoxSetModel, $Out> {
  _BoxSetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoxSetModel> $mapper =
      BoxSetModelMapper.ensureInitialized();
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
        if (items != null) #items: items,
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
  BoxSetModel $make(CopyWithData data) => BoxSetModel(
      items: data.get(#items, or: $value.items),
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
  BoxSetModelCopyWith<$R2, BoxSetModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoxSetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
