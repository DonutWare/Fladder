// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'audio_model.dart';

class MusicArtistModelMapper extends ClassMapperBase<MusicArtistModel> {
  MusicArtistModelMapper._();

  static MusicArtistModelMapper? _instance;
  static MusicArtistModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MusicArtistModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MusicArtistModel';

  static String _$name(MusicArtistModel v) => v.name;
  static const Field<MusicArtistModel, String> _f$name = Field('name', _$name);
  static String _$id(MusicArtistModel v) => v.id;
  static const Field<MusicArtistModel, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<MusicArtistModel> fields = const {
    #name: _f$name,
    #id: _f$id,
  };
  @override
  final bool ignoreNull = true;

  static MusicArtistModel _instantiate(DecodingData data) {
    return MusicArtistModel(name: data.dec(_f$name), id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin MusicArtistModelMappable {
  MusicArtistModelCopyWith<MusicArtistModel, MusicArtistModel, MusicArtistModel> get copyWith =>
      _MusicArtistModelCopyWithImpl<MusicArtistModel, MusicArtistModel>(this as MusicArtistModel, $identity, $identity);
}

extension MusicArtistModelValueCopy<$R, $Out> on ObjectCopyWith<$R, MusicArtistModel, $Out> {
  MusicArtistModelCopyWith<$R, MusicArtistModel, $Out> get $asMusicArtistModel =>
      $base.as((v, t, t2) => _MusicArtistModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MusicArtistModelCopyWith<$R, $In extends MusicArtistModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? id});
  MusicArtistModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MusicArtistModelCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, MusicArtistModel, $Out>
    implements MusicArtistModelCopyWith<$R, MusicArtistModel, $Out> {
  _MusicArtistModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MusicArtistModel> $mapper = MusicArtistModelMapper.ensureInitialized();
  @override
  $R call({String? name, String? id}) =>
      $apply(FieldCopyWithData({if (name != null) #name: name, if (id != null) #id: id}));
  @override
  MusicArtistModel $make(CopyWithData data) =>
      MusicArtistModel(name: data.get(#name, or: $value.name), id: data.get(#id, or: $value.id));

  @override
  MusicArtistModelCopyWith<$R2, MusicArtistModel, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MusicArtistModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AudioModelMapper extends SubClassMapperBase<AudioModel> {
  AudioModelMapper._();

  static AudioModelMapper? _instance;
  static AudioModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AudioModelMapper._());
      ItemStreamModelMapper.ensureInitialized().addSubMapper(_instance!);
      MusicArtistModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AudioModel';

  static String? _$album(AudioModel v) => v.album;
  static const Field<AudioModel, String> _f$album = Field('album', _$album, opt: true);
  static String? _$albumId(AudioModel v) => v.albumId;
  static const Field<AudioModel, String> _f$albumId = Field('albumId', _$albumId, opt: true);
  static List<MusicArtistModel> _$artists(AudioModel v) => v.artists;
  static const Field<AudioModel, List<MusicArtistModel>> _f$artists =
      Field('artists', _$artists, opt: true, def: const []);
  static List<MusicArtistModel> _$albumArtists(AudioModel v) => v.albumArtists;
  static const Field<AudioModel, List<MusicArtistModel>> _f$albumArtists =
      Field('albumArtists', _$albumArtists, opt: true, def: const []);
  static int? _$trackNumber(AudioModel v) => v.trackNumber;
  static const Field<AudioModel, int> _f$trackNumber = Field('trackNumber', _$trackNumber, opt: true);
  static Map<String, dynamic>? _$providerIds(AudioModel v) => v.providerIds;
  static const Field<AudioModel, Map<String, dynamic>> _f$providerIds = Field('providerIds', _$providerIds, opt: true);
  static double? _$normalizationGain(AudioModel v) => v.normalizationGain;
  static const Field<AudioModel, double> _f$normalizationGain =
      Field('normalizationGain', _$normalizationGain, opt: true);
  static String _$name(AudioModel v) => v.name;
  static const Field<AudioModel, String> _f$name = Field('name', _$name);
  static String _$id(AudioModel v) => v.id;
  static const Field<AudioModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(AudioModel v) => v.overview;
  static const Field<AudioModel, OverviewModel> _f$overview = Field('overview', _$overview);
  static String? _$parentId(AudioModel v) => v.parentId;
  static const Field<AudioModel, String> _f$parentId = Field('parentId', _$parentId);
  static String? _$playlistId(AudioModel v) => v.playlistId;
  static const Field<AudioModel, String> _f$playlistId = Field('playlistId', _$playlistId);
  static ImagesData? _$images(AudioModel v) => v.images;
  static const Field<AudioModel, ImagesData> _f$images = Field('images', _$images);
  static int? _$childCount(AudioModel v) => v.childCount;
  static const Field<AudioModel, int> _f$childCount = Field('childCount', _$childCount);
  static double? _$primaryRatio(AudioModel v) => v.primaryRatio;
  static const Field<AudioModel, double> _f$primaryRatio = Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(AudioModel v) => v.userData;
  static const Field<AudioModel, UserData> _f$userData = Field('userData', _$userData);
  static ImagesData? _$parentImages(AudioModel v) => v.parentImages;
  static const Field<AudioModel, ImagesData> _f$parentImages = Field('parentImages', _$parentImages);
  static MediaStreamsModel _$mediaStreams(AudioModel v) => v.mediaStreams;
  static const Field<AudioModel, MediaStreamsModel> _f$mediaStreams = Field('mediaStreams', _$mediaStreams);
  static bool? _$canDelete(AudioModel v) => v.canDelete;
  static const Field<AudioModel, bool> _f$canDelete = Field('canDelete', _$canDelete, opt: true);
  static bool? _$canDownload(AudioModel v) => v.canDownload;
  static const Field<AudioModel, bool> _f$canDownload = Field('canDownload', _$canDownload, opt: true);
  static dto.BaseItemKind? _$jellyType(AudioModel v) => v.jellyType;
  static const Field<AudioModel, dto.BaseItemKind> _f$jellyType = Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<AudioModel> fields = const {
    #album: _f$album,
    #albumId: _f$albumId,
    #artists: _f$artists,
    #albumArtists: _f$albumArtists,
    #trackNumber: _f$trackNumber,
    #providerIds: _f$providerIds,
    #normalizationGain: _f$normalizationGain,
    #name: _f$name,
    #id: _f$id,
    #overview: _f$overview,
    #parentId: _f$parentId,
    #playlistId: _f$playlistId,
    #images: _f$images,
    #childCount: _f$childCount,
    #primaryRatio: _f$primaryRatio,
    #userData: _f$userData,
    #parentImages: _f$parentImages,
    #mediaStreams: _f$mediaStreams,
    #canDelete: _f$canDelete,
    #canDownload: _f$canDownload,
    #jellyType: _f$jellyType,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AudioModel';
  @override
  late final ClassMapperBase superMapper = ItemStreamModelMapper.ensureInitialized();

  static AudioModel _instantiate(DecodingData data) {
    return AudioModel(
        album: data.dec(_f$album),
        albumId: data.dec(_f$albumId),
        artists: data.dec(_f$artists),
        albumArtists: data.dec(_f$albumArtists),
        trackNumber: data.dec(_f$trackNumber),
        providerIds: data.dec(_f$providerIds),
        normalizationGain: data.dec(_f$normalizationGain),
        name: data.dec(_f$name),
        id: data.dec(_f$id),
        overview: data.dec(_f$overview),
        parentId: data.dec(_f$parentId),
        playlistId: data.dec(_f$playlistId),
        images: data.dec(_f$images),
        childCount: data.dec(_f$childCount),
        primaryRatio: data.dec(_f$primaryRatio),
        userData: data.dec(_f$userData),
        parentImages: data.dec(_f$parentImages),
        mediaStreams: data.dec(_f$mediaStreams),
        canDelete: data.dec(_f$canDelete),
        canDownload: data.dec(_f$canDownload),
        jellyType: data.dec(_f$jellyType));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin AudioModelMappable {
  AudioModelCopyWith<AudioModel, AudioModel, AudioModel> get copyWith =>
      _AudioModelCopyWithImpl<AudioModel, AudioModel>(this as AudioModel, $identity, $identity);
}

extension AudioModelValueCopy<$R, $Out> on ObjectCopyWith<$R, AudioModel, $Out> {
  AudioModelCopyWith<$R, AudioModel, $Out> get $asAudioModel =>
      $base.as((v, t, t2) => _AudioModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AudioModelCopyWith<$R, $In extends AudioModel, $Out> implements ItemStreamModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, MusicArtistModel, MusicArtistModelCopyWith<$R, MusicArtistModel, MusicArtistModel>> get artists;
  ListCopyWith<$R, MusicArtistModel, MusicArtistModelCopyWith<$R, MusicArtistModel, MusicArtistModel>> get albumArtists;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>? get providerIds;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {String? album,
      String? albumId,
      List<MusicArtistModel>? artists,
      List<MusicArtistModel>? albumArtists,
      int? trackNumber,
      Map<String, dynamic>? providerIds,
      double? normalizationGain,
      String? name,
      String? id,
      OverviewModel? overview,
      String? parentId,
      String? playlistId,
      ImagesData? images,
      int? childCount,
      double? primaryRatio,
      UserData? userData,
      ImagesData? parentImages,
      MediaStreamsModel? mediaStreams,
      bool? canDelete,
      bool? canDownload,
      dto.BaseItemKind? jellyType});
  AudioModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AudioModelCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, AudioModel, $Out>
    implements AudioModelCopyWith<$R, AudioModel, $Out> {
  _AudioModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AudioModel> $mapper = AudioModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, MusicArtistModel, MusicArtistModelCopyWith<$R, MusicArtistModel, MusicArtistModel>> get artists =>
      ListCopyWith($value.artists, (v, t) => v.copyWith.$chain(t), (v) => call(artists: v));
  @override
  ListCopyWith<$R, MusicArtistModel, MusicArtistModelCopyWith<$R, MusicArtistModel, MusicArtistModel>>
      get albumArtists =>
          ListCopyWith($value.albumArtists, (v, t) => v.copyWith.$chain(t), (v) => call(albumArtists: v));
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
          {Object? album = $none,
          Object? albumId = $none,
          List<MusicArtistModel>? artists,
          List<MusicArtistModel>? albumArtists,
          Object? trackNumber = $none,
          Object? providerIds = $none,
          Object? normalizationGain = $none,
          String? name,
          String? id,
          OverviewModel? overview,
          Object? parentId = $none,
          Object? playlistId = $none,
          Object? images = $none,
          Object? childCount = $none,
          Object? primaryRatio = $none,
          UserData? userData,
          Object? parentImages = $none,
          MediaStreamsModel? mediaStreams,
          Object? canDelete = $none,
          Object? canDownload = $none,
          Object? jellyType = $none}) =>
      $apply(FieldCopyWithData({
        if (album != $none) #album: album,
        if (albumId != $none) #albumId: albumId,
        if (artists != null) #artists: artists,
        if (albumArtists != null) #albumArtists: albumArtists,
        if (trackNumber != $none) #trackNumber: trackNumber,
        if (providerIds != $none) #providerIds: providerIds,
        if (normalizationGain != $none) #normalizationGain: normalizationGain,
        if (name != null) #name: name,
        if (id != null) #id: id,
        if (overview != null) #overview: overview,
        if (parentId != $none) #parentId: parentId,
        if (playlistId != $none) #playlistId: playlistId,
        if (images != $none) #images: images,
        if (childCount != $none) #childCount: childCount,
        if (primaryRatio != $none) #primaryRatio: primaryRatio,
        if (userData != null) #userData: userData,
        if (parentImages != $none) #parentImages: parentImages,
        if (mediaStreams != null) #mediaStreams: mediaStreams,
        if (canDelete != $none) #canDelete: canDelete,
        if (canDownload != $none) #canDownload: canDownload,
        if (jellyType != $none) #jellyType: jellyType
      }));
  @override
  AudioModel $make(CopyWithData data) => AudioModel(
      album: data.get(#album, or: $value.album),
      albumId: data.get(#albumId, or: $value.albumId),
      artists: data.get(#artists, or: $value.artists),
      albumArtists: data.get(#albumArtists, or: $value.albumArtists),
      trackNumber: data.get(#trackNumber, or: $value.trackNumber),
      providerIds: data.get(#providerIds, or: $value.providerIds),
      normalizationGain: data.get(#normalizationGain, or: $value.normalizationGain),
      name: data.get(#name, or: $value.name),
      id: data.get(#id, or: $value.id),
      overview: data.get(#overview, or: $value.overview),
      parentId: data.get(#parentId, or: $value.parentId),
      playlistId: data.get(#playlistId, or: $value.playlistId),
      images: data.get(#images, or: $value.images),
      childCount: data.get(#childCount, or: $value.childCount),
      primaryRatio: data.get(#primaryRatio, or: $value.primaryRatio),
      userData: data.get(#userData, or: $value.userData),
      parentImages: data.get(#parentImages, or: $value.parentImages),
      mediaStreams: data.get(#mediaStreams, or: $value.mediaStreams),
      canDelete: data.get(#canDelete, or: $value.canDelete),
      canDownload: data.get(#canDownload, or: $value.canDownload),
      jellyType: data.get(#jellyType, or: $value.jellyType));

  @override
  AudioModelCopyWith<$R2, AudioModel, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AudioModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
