// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'season_model.dart';

class SeasonModelMapper extends SubClassMapperBase<SeasonModel> {
  SeasonModelMapper._();

  static SeasonModelMapper? _instance;
  static SeasonModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SeasonModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      EpisodeModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SeasonModel';

  static ImagesData? _$parentImages(SeasonModel v) => v.parentImages;
  static const Field<SeasonModel, ImagesData> _f$parentImages =
      Field('parentImages', _$parentImages);
  static String _$seasonName(SeasonModel v) => v.seasonName;
  static const Field<SeasonModel, String> _f$seasonName =
      Field('seasonName', _$seasonName);
  static List<EpisodeModel> _$episodes(SeasonModel v) => v.episodes;
  static const Field<SeasonModel, List<EpisodeModel>> _f$episodes =
      Field('episodes', _$episodes, opt: true, def: const []);
  static int _$episodeCount(SeasonModel v) => v.episodeCount;
  static const Field<SeasonModel, int> _f$episodeCount =
      Field('episodeCount', _$episodeCount);
  static String _$seriesId(SeasonModel v) => v.seriesId;
  static const Field<SeasonModel, String> _f$seriesId =
      Field('seriesId', _$seriesId);
  static int _$season(SeasonModel v) => v.season;
  static const Field<SeasonModel, int> _f$season = Field('season', _$season);
  static String _$seriesName(SeasonModel v) => v.seriesName;
  static const Field<SeasonModel, String> _f$seriesName =
      Field('seriesName', _$seriesName);
  static String _$name(SeasonModel v) => v.name;
  static const Field<SeasonModel, String> _f$name = Field('name', _$name);
  static String _$id(SeasonModel v) => v.id;
  static const Field<SeasonModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(SeasonModel v) => v.overview;
  static const Field<SeasonModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(SeasonModel v) => v.parentId;
  static const Field<SeasonModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(SeasonModel v) => v.playlistId;
  static const Field<SeasonModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(SeasonModel v) => v.images;
  static const Field<SeasonModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(SeasonModel v) => v.childCount;
  static const Field<SeasonModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(SeasonModel v) => v.primaryRatio;
  static const Field<SeasonModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(SeasonModel v) => v.userData;
  static const Field<SeasonModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDelete(SeasonModel v) => v.canDelete;
  static const Field<SeasonModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete);
  static bool? _$canDownload(SeasonModel v) => v.canDownload;
  static const Field<SeasonModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload);
  static dto.BaseItemKind? _$jellyType(SeasonModel v) => v.jellyType;
  static const Field<SeasonModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<SeasonModel> fields = const {
    #parentImages: _f$parentImages,
    #seasonName: _f$seasonName,
    #episodes: _f$episodes,
    #episodeCount: _f$episodeCount,
    #seriesId: _f$seriesId,
    #season: _f$season,
    #seriesName: _f$seriesName,
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
  final dynamic discriminatorValue = 'SeasonModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static SeasonModel _instantiate(DecodingData data) {
    return SeasonModel(
        parentImages: data.dec(_f$parentImages),
        seasonName: data.dec(_f$seasonName),
        episodes: data.dec(_f$episodes),
        episodeCount: data.dec(_f$episodeCount),
        seriesId: data.dec(_f$seriesId),
        season: data.dec(_f$season),
        seriesName: data.dec(_f$seriesName),
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

  static SeasonModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SeasonModel>(map);
  }

  static SeasonModel fromJson(String json) {
    return ensureInitialized().decodeJson<SeasonModel>(json);
  }
}

mixin SeasonModelMappable {
  String toJson() {
    return SeasonModelMapper.ensureInitialized()
        .encodeJson<SeasonModel>(this as SeasonModel);
  }

  Map<String, dynamic> toMap() {
    return SeasonModelMapper.ensureInitialized()
        .encodeMap<SeasonModel>(this as SeasonModel);
  }

  SeasonModelCopyWith<SeasonModel, SeasonModel, SeasonModel> get copyWith =>
      _SeasonModelCopyWithImpl(this as SeasonModel, $identity, $identity);
  @override
  String toString() {
    return SeasonModelMapper.ensureInitialized()
        .stringifyValue(this as SeasonModel);
  }
}

extension SeasonModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SeasonModel, $Out> {
  SeasonModelCopyWith<$R, SeasonModel, $Out> get $asSeasonModel =>
      $base.as((v, t, t2) => _SeasonModelCopyWithImpl(v, t, t2));
}

abstract class SeasonModelCopyWith<$R, $In extends SeasonModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, EpisodeModel,
      EpisodeModelCopyWith<$R, EpisodeModel, EpisodeModel>> get episodes;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {ImagesData? parentImages,
      String? seasonName,
      List<EpisodeModel>? episodes,
      int? episodeCount,
      String? seriesId,
      int? season,
      String? seriesName,
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
  SeasonModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SeasonModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SeasonModel, $Out>
    implements SeasonModelCopyWith<$R, SeasonModel, $Out> {
  _SeasonModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SeasonModel> $mapper =
      SeasonModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, EpisodeModel,
          EpisodeModelCopyWith<$R, EpisodeModel, EpisodeModel>>
      get episodes => ListCopyWith($value.episodes,
          (v, t) => v.copyWith.$chain(t), (v) => call(episodes: v));
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {Object? parentImages = $none,
          String? seasonName,
          List<EpisodeModel>? episodes,
          int? episodeCount,
          String? seriesId,
          int? season,
          String? seriesName,
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
        if (seasonName != null) #seasonName: seasonName,
        if (episodes != null) #episodes: episodes,
        if (episodeCount != null) #episodeCount: episodeCount,
        if (seriesId != null) #seriesId: seriesId,
        if (season != null) #season: season,
        if (seriesName != null) #seriesName: seriesName,
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
  SeasonModel $make(CopyWithData data) => SeasonModel(
      parentImages: data.get(#parentImages, or: $value.parentImages),
      seasonName: data.get(#seasonName, or: $value.seasonName),
      episodes: data.get(#episodes, or: $value.episodes),
      episodeCount: data.get(#episodeCount, or: $value.episodeCount),
      seriesId: data.get(#seriesId, or: $value.seriesId),
      season: data.get(#season, or: $value.season),
      seriesName: data.get(#seriesName, or: $value.seriesName),
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
  SeasonModelCopyWith<$R2, SeasonModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SeasonModelCopyWithImpl($value, $cast, t);
}
