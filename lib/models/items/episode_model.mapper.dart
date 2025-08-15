// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'episode_model.dart';

class EpisodeModelMapper extends SubClassMapperBase<EpisodeModel> {
  EpisodeModelMapper._();

  static EpisodeModelMapper? _instance;
  static EpisodeModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EpisodeModelMapper._());
      ItemStreamModelMapper.ensureInitialized().addSubMapper(_instance!);
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EpisodeModel';

  static String? _$seriesName(EpisodeModel v) => v.seriesName;
  static const Field<EpisodeModel, String> _f$seriesName =
      Field('seriesName', _$seriesName);
  static int _$season(EpisodeModel v) => v.season;
  static const Field<EpisodeModel, int> _f$season = Field('season', _$season);
  static int _$episode(EpisodeModel v) => v.episode;
  static const Field<EpisodeModel, int> _f$episode =
      Field('episode', _$episode);
  static int? _$episodeEnd(EpisodeModel v) => v.episodeEnd;
  static const Field<EpisodeModel, int> _f$episodeEnd =
      Field('episodeEnd', _$episodeEnd);
  static List<Chapter> _$chapters(EpisodeModel v) => v.chapters;
  static const Field<EpisodeModel, List<Chapter>> _f$chapters =
      Field('chapters', _$chapters, opt: true, def: const []);
  static ItemLocation? _$location(EpisodeModel v) => v.location;
  static const Field<EpisodeModel, ItemLocation> _f$location =
      Field('location', _$location, opt: true);
  static DateTime? _$dateAired(EpisodeModel v) => v.dateAired;
  static const Field<EpisodeModel, DateTime> _f$dateAired =
      Field('dateAired', _$dateAired, opt: true);
  static String _$name(EpisodeModel v) => v.name;
  static const Field<EpisodeModel, String> _f$name = Field('name', _$name);
  static String _$id(EpisodeModel v) => v.id;
  static const Field<EpisodeModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(EpisodeModel v) => v.overview;
  static const Field<EpisodeModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(EpisodeModel v) => v.parentId;
  static const Field<EpisodeModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(EpisodeModel v) => v.playlistId;
  static const Field<EpisodeModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(EpisodeModel v) => v.images;
  static const Field<EpisodeModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(EpisodeModel v) => v.childCount;
  static const Field<EpisodeModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(EpisodeModel v) => v.primaryRatio;
  static const Field<EpisodeModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(EpisodeModel v) => v.userData;
  static const Field<EpisodeModel, UserData> _f$userData =
      Field('userData', _$userData);
  static ImagesData? _$parentImages(EpisodeModel v) => v.parentImages;
  static const Field<EpisodeModel, ImagesData> _f$parentImages =
      Field('parentImages', _$parentImages);
  static MediaStreamsModel _$mediaStreams(EpisodeModel v) => v.mediaStreams;
  static const Field<EpisodeModel, MediaStreamsModel> _f$mediaStreams =
      Field('mediaStreams', _$mediaStreams);
  static bool? _$canDelete(EpisodeModel v) => v.canDelete;
  static const Field<EpisodeModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete, opt: true);
  static bool? _$canDownload(EpisodeModel v) => v.canDownload;
  static const Field<EpisodeModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload, opt: true);
  static dto.BaseItemKind? _$jellyType(EpisodeModel v) => v.jellyType;
  static const Field<EpisodeModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<EpisodeModel> fields = const {
    #seriesName: _f$seriesName,
    #season: _f$season,
    #episode: _f$episode,
    #episodeEnd: _f$episodeEnd,
    #chapters: _f$chapters,
    #location: _f$location,
    #dateAired: _f$dateAired,
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
  final dynamic discriminatorValue = 'EpisodeModel';
  @override
  late final ClassMapperBase superMapper =
      ItemStreamModelMapper.ensureInitialized();

  static EpisodeModel _instantiate(DecodingData data) {
    return EpisodeModel(
        seriesName: data.dec(_f$seriesName),
        season: data.dec(_f$season),
        episode: data.dec(_f$episode),
        episodeEnd: data.dec(_f$episodeEnd),
        chapters: data.dec(_f$chapters),
        location: data.dec(_f$location),
        dateAired: data.dec(_f$dateAired),
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

mixin EpisodeModelMappable {
  EpisodeModelCopyWith<EpisodeModel, EpisodeModel, EpisodeModel> get copyWith =>
      _EpisodeModelCopyWithImpl(this as EpisodeModel, $identity, $identity);
}

extension EpisodeModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EpisodeModel, $Out> {
  EpisodeModelCopyWith<$R, EpisodeModel, $Out> get $asEpisodeModel =>
      $base.as((v, t, t2) => _EpisodeModelCopyWithImpl(v, t, t2));
}

abstract class EpisodeModelCopyWith<$R, $In extends EpisodeModel, $Out>
    implements ItemStreamModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Chapter, ObjectCopyWith<$R, Chapter, Chapter>> get chapters;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {String? seriesName,
      int? season,
      int? episode,
      int? episodeEnd,
      List<Chapter>? chapters,
      ItemLocation? location,
      DateTime? dateAired,
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
  EpisodeModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EpisodeModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EpisodeModel, $Out>
    implements EpisodeModelCopyWith<$R, EpisodeModel, $Out> {
  _EpisodeModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EpisodeModel> $mapper =
      EpisodeModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Chapter, ObjectCopyWith<$R, Chapter, Chapter>>
      get chapters => ListCopyWith($value.chapters,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(chapters: v));
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {Object? seriesName = $none,
          int? season,
          int? episode,
          Object? episodeEnd = $none,
          List<Chapter>? chapters,
          Object? location = $none,
          Object? dateAired = $none,
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
        if (seriesName != $none) #seriesName: seriesName,
        if (season != null) #season: season,
        if (episode != null) #episode: episode,
        if (episodeEnd != $none) #episodeEnd: episodeEnd,
        if (chapters != null) #chapters: chapters,
        if (location != $none) #location: location,
        if (dateAired != $none) #dateAired: dateAired,
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
  EpisodeModel $make(CopyWithData data) => EpisodeModel(
      seriesName: data.get(#seriesName, or: $value.seriesName),
      season: data.get(#season, or: $value.season),
      episode: data.get(#episode, or: $value.episode),
      episodeEnd: data.get(#episodeEnd, or: $value.episodeEnd),
      chapters: data.get(#chapters, or: $value.chapters),
      location: data.get(#location, or: $value.location),
      dateAired: data.get(#dateAired, or: $value.dateAired),
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
  EpisodeModelCopyWith<$R2, EpisodeModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EpisodeModelCopyWithImpl($value, $cast, t);
}
