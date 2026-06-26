// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'playlist_model.dart';

class PlaylistModelMapper extends SubClassMapperBase<PlaylistModel> {
  PlaylistModelMapper._();

  static PlaylistModelMapper? _instance;
  static PlaylistModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlaylistModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PlaylistModel';

  static String _$name(PlaylistModel v) => v.name;
  static const Field<PlaylistModel, String> _f$name = Field('name', _$name);
  static String _$id(PlaylistModel v) => v.id;
  static const Field<PlaylistModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(PlaylistModel v) => v.overview;
  static const Field<PlaylistModel, OverviewModel> _f$overview = Field('overview', _$overview);
  static String? _$parentId(PlaylistModel v) => v.parentId;
  static const Field<PlaylistModel, String> _f$parentId = Field('parentId', _$parentId);
  static String? _$playlistId(PlaylistModel v) => v.playlistId;
  static const Field<PlaylistModel, String> _f$playlistId = Field('playlistId', _$playlistId);
  static ImagesData? _$images(PlaylistModel v) => v.images;
  static const Field<PlaylistModel, ImagesData> _f$images = Field('images', _$images);
  static int? _$childCount(PlaylistModel v) => v.childCount;
  static const Field<PlaylistModel, int> _f$childCount = Field('childCount', _$childCount);
  static double? _$primaryRatio(PlaylistModel v) => v.primaryRatio;
  static const Field<PlaylistModel, double> _f$primaryRatio = Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(PlaylistModel v) => v.userData;
  static const Field<PlaylistModel, UserData> _f$userData = Field('userData', _$userData);
  static bool? _$canDelete(PlaylistModel v) => v.canDelete;
  static const Field<PlaylistModel, bool> _f$canDelete = Field('canDelete', _$canDelete, opt: true);
  static bool? _$canDownload(PlaylistModel v) => v.canDownload;
  static const Field<PlaylistModel, bool> _f$canDownload = Field('canDownload', _$canDownload, opt: true);
  static BaseItemKind? _$jellyType(PlaylistModel v) => v.jellyType;
  static const Field<PlaylistModel, BaseItemKind> _f$jellyType = Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<PlaylistModel> fields = const {
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
  final dynamic discriminatorValue = 'PlaylistModel';
  @override
  late final ClassMapperBase superMapper = ItemBaseModelMapper.ensureInitialized();

  static PlaylistModel _instantiate(DecodingData data) {
    return PlaylistModel(
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

mixin PlaylistModelMappable {
  PlaylistModelCopyWith<PlaylistModel, PlaylistModel, PlaylistModel> get copyWith =>
      _PlaylistModelCopyWithImpl<PlaylistModel, PlaylistModel>(this as PlaylistModel, $identity, $identity);
}

extension PlaylistModelValueCopy<$R, $Out> on ObjectCopyWith<$R, PlaylistModel, $Out> {
  PlaylistModelCopyWith<$R, PlaylistModel, $Out> get $asPlaylistModel =>
      $base.as((v, t, t2) => _PlaylistModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlaylistModelCopyWith<$R, $In extends PlaylistModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
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
      bool? canDelete,
      bool? canDownload,
      BaseItemKind? jellyType});
  PlaylistModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlaylistModelCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, PlaylistModel, $Out>
    implements PlaylistModelCopyWith<$R, PlaylistModel, $Out> {
  _PlaylistModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlaylistModel> $mapper = PlaylistModelMapper.ensureInitialized();
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData => $value.userData.copyWith.$chain((v) => call(userData: v));
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
          Object? canDelete = $none,
          Object? canDownload = $none,
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
        if (canDelete != $none) #canDelete: canDelete,
        if (canDownload != $none) #canDownload: canDownload,
        if (jellyType != $none) #jellyType: jellyType
      }));
  @override
  PlaylistModel $make(CopyWithData data) => PlaylistModel(
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
  PlaylistModelCopyWith<$R2, PlaylistModel, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlaylistModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
