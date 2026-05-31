// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'artist_model.dart';

class ArtistModelMapper extends SubClassMapperBase<ArtistModel> {
  ArtistModelMapper._();

  static ArtistModelMapper? _instance;
  static ArtistModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArtistModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      AlbumModelMapper.ensureInitialized();
      AudioModelMapper.ensureInitialized();
      ArtistModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ArtistModel';

  static List<AlbumModel> _$albums(ArtistModel v) => v.albums;
  static const Field<ArtistModel, List<AlbumModel>> _f$albums = Field('albums', _$albums, opt: true, def: const []);
  static List<AudioModel> _$tracks(ArtistModel v) => v.tracks;
  static const Field<ArtistModel, List<AudioModel>> _f$tracks = Field('tracks', _$tracks, opt: true, def: const []);
  static List<ArtistModel> _$similarArtists(ArtistModel v) => v.similarArtists;
  static const Field<ArtistModel, List<ArtistModel>> _f$similarArtists =
      Field('similarArtists', _$similarArtists, opt: true, def: const []);
  static Map<String, dynamic>? _$providerIds(ArtistModel v) => v.providerIds;
  static const Field<ArtistModel, Map<String, dynamic>> _f$providerIds = Field('providerIds', _$providerIds, opt: true);
  static String _$name(ArtistModel v) => v.name;
  static const Field<ArtistModel, String> _f$name = Field('name', _$name);
  static String _$id(ArtistModel v) => v.id;
  static const Field<ArtistModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(ArtistModel v) => v.overview;
  static const Field<ArtistModel, OverviewModel> _f$overview = Field('overview', _$overview);
  static String? _$parentId(ArtistModel v) => v.parentId;
  static const Field<ArtistModel, String> _f$parentId = Field('parentId', _$parentId);
  static String? _$playlistId(ArtistModel v) => v.playlistId;
  static const Field<ArtistModel, String> _f$playlistId = Field('playlistId', _$playlistId);
  static ImagesData? _$images(ArtistModel v) => v.images;
  static const Field<ArtistModel, ImagesData> _f$images = Field('images', _$images);
  static int? _$childCount(ArtistModel v) => v.childCount;
  static const Field<ArtistModel, int> _f$childCount = Field('childCount', _$childCount);
  static double? _$primaryRatio(ArtistModel v) => v.primaryRatio;
  static const Field<ArtistModel, double> _f$primaryRatio = Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(ArtistModel v) => v.userData;
  static const Field<ArtistModel, UserData> _f$userData = Field('userData', _$userData);
  static bool? _$canDelete(ArtistModel v) => v.canDelete;
  static const Field<ArtistModel, bool> _f$canDelete = Field('canDelete', _$canDelete, opt: true);
  static bool? _$canDownload(ArtistModel v) => v.canDownload;
  static const Field<ArtistModel, bool> _f$canDownload = Field('canDownload', _$canDownload, opt: true);
  static dto.BaseItemKind? _$jellyType(ArtistModel v) => v.jellyType;
  static const Field<ArtistModel, dto.BaseItemKind> _f$jellyType = Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<ArtistModel> fields = const {
    #albums: _f$albums,
    #tracks: _f$tracks,
    #similarArtists: _f$similarArtists,
    #providerIds: _f$providerIds,
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
  final dynamic discriminatorValue = 'ArtistModel';
  @override
  late final ClassMapperBase superMapper = ItemBaseModelMapper.ensureInitialized();

  static ArtistModel _instantiate(DecodingData data) {
    return ArtistModel(
        albums: data.dec(_f$albums),
        tracks: data.dec(_f$tracks),
        similarArtists: data.dec(_f$similarArtists),
        providerIds: data.dec(_f$providerIds),
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

mixin ArtistModelMappable {
  ArtistModelCopyWith<ArtistModel, ArtistModel, ArtistModel> get copyWith =>
      _ArtistModelCopyWithImpl<ArtistModel, ArtistModel>(this as ArtistModel, $identity, $identity);
}

extension ArtistModelValueCopy<$R, $Out> on ObjectCopyWith<$R, ArtistModel, $Out> {
  ArtistModelCopyWith<$R, ArtistModel, $Out> get $asArtistModel =>
      $base.as((v, t, t2) => _ArtistModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ArtistModelCopyWith<$R, $In extends ArtistModel, $Out> implements ItemBaseModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, AlbumModel, AlbumModelCopyWith<$R, AlbumModel, AlbumModel>> get albums;
  ListCopyWith<$R, AudioModel, AudioModelCopyWith<$R, AudioModel, AudioModel>> get tracks;
  ListCopyWith<$R, ArtistModel, ArtistModelCopyWith<$R, ArtistModel, ArtistModel>> get similarArtists;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>? get providerIds;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {List<AlbumModel>? albums,
      List<AudioModel>? tracks,
      List<ArtistModel>? similarArtists,
      Map<String, dynamic>? providerIds,
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
  ArtistModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ArtistModelCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, ArtistModel, $Out>
    implements ArtistModelCopyWith<$R, ArtistModel, $Out> {
  _ArtistModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ArtistModel> $mapper = ArtistModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, AlbumModel, AlbumModelCopyWith<$R, AlbumModel, AlbumModel>> get albums =>
      ListCopyWith($value.albums, (v, t) => v.copyWith.$chain(t), (v) => call(albums: v));
  @override
  ListCopyWith<$R, AudioModel, AudioModelCopyWith<$R, AudioModel, AudioModel>> get tracks =>
      ListCopyWith($value.tracks, (v, t) => v.copyWith.$chain(t), (v) => call(tracks: v));
  @override
  ListCopyWith<$R, ArtistModel, ArtistModelCopyWith<$R, ArtistModel, ArtistModel>> get similarArtists =>
      ListCopyWith($value.similarArtists, (v, t) => v.copyWith.$chain(t), (v) => call(similarArtists: v));
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>? get providerIds => $value.providerIds != null
      ? MapCopyWith($value.providerIds!, (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(providerIds: v))
      : null;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData => $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {List<AlbumModel>? albums,
          List<AudioModel>? tracks,
          List<ArtistModel>? similarArtists,
          Object? providerIds = $none,
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
        if (albums != null) #albums: albums,
        if (tracks != null) #tracks: tracks,
        if (similarArtists != null) #similarArtists: similarArtists,
        if (providerIds != $none) #providerIds: providerIds,
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
  ArtistModel $make(CopyWithData data) => ArtistModel(
      albums: data.get(#albums, or: $value.albums),
      tracks: data.get(#tracks, or: $value.tracks),
      similarArtists: data.get(#similarArtists, or: $value.similarArtists),
      providerIds: data.get(#providerIds, or: $value.providerIds),
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
  ArtistModelCopyWith<$R2, ArtistModel, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ArtistModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
