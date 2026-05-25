// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'album_model.dart';

class AlbumModelMapper extends SubClassMapperBase<AlbumModel> {
  AlbumModelMapper._();

  static AlbumModelMapper? _instance;
  static AlbumModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlbumModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      AudioModelMapper.ensureInitialized();
      AlbumModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AlbumModel';

  static List<String> _$artistIds(AlbumModel v) => v.artistIds;
  static const Field<AlbumModel, List<String>> _f$artistIds =
      Field('artistIds', _$artistIds, opt: true, def: const []);
  static String _$albumArtist(AlbumModel v) => v.albumArtist;
  static const Field<AlbumModel, String> _f$albumArtist =
      Field('albumArtist', _$albumArtist);
  static List<String> _$albumArtistIds(AlbumModel v) => v.albumArtistIds;
  static const Field<AlbumModel, List<String>> _f$albumArtistIds =
      Field('albumArtistIds', _$albumArtistIds, opt: true, def: const []);
  static List<AudioModel> _$tracks(AlbumModel v) => v.tracks;
  static const Field<AlbumModel, List<AudioModel>> _f$tracks =
      Field('tracks', _$tracks, opt: true, def: const []);
  static List<AlbumModel> _$relatedAlbums(AlbumModel v) => v.relatedAlbums;
  static const Field<AlbumModel, List<AlbumModel>> _f$relatedAlbums =
      Field('relatedAlbums', _$relatedAlbums, opt: true, def: const []);
  static List<AudioModel> _$relatedTracks(AlbumModel v) => v.relatedTracks;
  static const Field<AlbumModel, List<AudioModel>> _f$relatedTracks =
      Field('relatedTracks', _$relatedTracks, opt: true, def: const []);
  static Map<String, dynamic>? _$providerIds(AlbumModel v) => v.providerIds;
  static const Field<AlbumModel, Map<String, dynamic>> _f$providerIds =
      Field('providerIds', _$providerIds, opt: true);
  static String _$name(AlbumModel v) => v.name;
  static const Field<AlbumModel, String> _f$name = Field('name', _$name);
  static String _$id(AlbumModel v) => v.id;
  static const Field<AlbumModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(AlbumModel v) => v.overview;
  static const Field<AlbumModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(AlbumModel v) => v.parentId;
  static const Field<AlbumModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(AlbumModel v) => v.playlistId;
  static const Field<AlbumModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(AlbumModel v) => v.images;
  static const Field<AlbumModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(AlbumModel v) => v.childCount;
  static const Field<AlbumModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(AlbumModel v) => v.primaryRatio;
  static const Field<AlbumModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(AlbumModel v) => v.userData;
  static const Field<AlbumModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDelete(AlbumModel v) => v.canDelete;
  static const Field<AlbumModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete, opt: true);
  static bool? _$canDownload(AlbumModel v) => v.canDownload;
  static const Field<AlbumModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload, opt: true);
  static dto.BaseItemKind? _$jellyType(AlbumModel v) => v.jellyType;
  static const Field<AlbumModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<AlbumModel> fields = const {
    #artistIds: _f$artistIds,
    #albumArtist: _f$albumArtist,
    #albumArtistIds: _f$albumArtistIds,
    #tracks: _f$tracks,
    #relatedAlbums: _f$relatedAlbums,
    #relatedTracks: _f$relatedTracks,
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
  final dynamic discriminatorValue = 'AlbumModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static AlbumModel _instantiate(DecodingData data) {
    return AlbumModel(
        artistIds: data.dec(_f$artistIds),
        albumArtist: data.dec(_f$albumArtist),
        albumArtistIds: data.dec(_f$albumArtistIds),
        tracks: data.dec(_f$tracks),
        relatedAlbums: data.dec(_f$relatedAlbums),
        relatedTracks: data.dec(_f$relatedTracks),
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

mixin AlbumModelMappable {
  AlbumModelCopyWith<AlbumModel, AlbumModel, AlbumModel> get copyWith =>
      _AlbumModelCopyWithImpl<AlbumModel, AlbumModel>(
          this as AlbumModel, $identity, $identity);
}

extension AlbumModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AlbumModel, $Out> {
  AlbumModelCopyWith<$R, AlbumModel, $Out> get $asAlbumModel =>
      $base.as((v, t, t2) => _AlbumModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AlbumModelCopyWith<$R, $In extends AlbumModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get artistIds;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get albumArtistIds;
  ListCopyWith<$R, AudioModel, AudioModelCopyWith<$R, AudioModel, AudioModel>>
      get tracks;
  ListCopyWith<$R, AlbumModel, AlbumModelCopyWith<$R, AlbumModel, AlbumModel>>
      get relatedAlbums;
  ListCopyWith<$R, AudioModel, AudioModelCopyWith<$R, AudioModel, AudioModel>>
      get relatedTracks;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get providerIds;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {List<String>? artistIds,
      String? albumArtist,
      List<String>? albumArtistIds,
      List<AudioModel>? tracks,
      List<AlbumModel>? relatedAlbums,
      List<AudioModel>? relatedTracks,
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
  AlbumModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AlbumModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AlbumModel, $Out>
    implements AlbumModelCopyWith<$R, AlbumModel, $Out> {
  _AlbumModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AlbumModel> $mapper =
      AlbumModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get artistIds =>
      ListCopyWith($value.artistIds, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(artistIds: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get albumArtistIds => ListCopyWith(
          $value.albumArtistIds,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(albumArtistIds: v));
  @override
  ListCopyWith<$R, AudioModel, AudioModelCopyWith<$R, AudioModel, AudioModel>>
      get tracks => ListCopyWith($value.tracks, (v, t) => v.copyWith.$chain(t),
          (v) => call(tracks: v));
  @override
  ListCopyWith<$R, AlbumModel, AlbumModelCopyWith<$R, AlbumModel, AlbumModel>>
      get relatedAlbums => ListCopyWith($value.relatedAlbums,
          (v, t) => v.copyWith.$chain(t), (v) => call(relatedAlbums: v));
  @override
  ListCopyWith<$R, AudioModel, AudioModelCopyWith<$R, AudioModel, AudioModel>>
      get relatedTracks => ListCopyWith($value.relatedTracks,
          (v, t) => v.copyWith.$chain(t), (v) => call(relatedTracks: v));
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get providerIds => $value.providerIds != null
          ? MapCopyWith(
              $value.providerIds!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(providerIds: v))
          : null;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {List<String>? artistIds,
          String? albumArtist,
          List<String>? albumArtistIds,
          List<AudioModel>? tracks,
          List<AlbumModel>? relatedAlbums,
          List<AudioModel>? relatedTracks,
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
        if (artistIds != null) #artistIds: artistIds,
        if (albumArtist != null) #albumArtist: albumArtist,
        if (albumArtistIds != null) #albumArtistIds: albumArtistIds,
        if (tracks != null) #tracks: tracks,
        if (relatedAlbums != null) #relatedAlbums: relatedAlbums,
        if (relatedTracks != null) #relatedTracks: relatedTracks,
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
  AlbumModel $make(CopyWithData data) => AlbumModel(
      artistIds: data.get(#artistIds, or: $value.artistIds),
      albumArtist: data.get(#albumArtist, or: $value.albumArtist),
      albumArtistIds: data.get(#albumArtistIds, or: $value.albumArtistIds),
      tracks: data.get(#tracks, or: $value.tracks),
      relatedAlbums: data.get(#relatedAlbums, or: $value.relatedAlbums),
      relatedTracks: data.get(#relatedTracks, or: $value.relatedTracks),
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
  AlbumModelCopyWith<$R2, AlbumModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AlbumModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
