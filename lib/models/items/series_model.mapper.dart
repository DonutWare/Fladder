// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'series_model.dart';

class SeriesModelMapper extends SubClassMapperBase<SeriesModel> {
  SeriesModelMapper._();

  static SeriesModelMapper? _instance;
  static SeriesModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SeriesModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      EpisodeModelMapper.ensureInitialized();
      SeasonModelMapper.ensureInitialized();
      ItemBaseModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SeriesModel';

  static List<EpisodeModel>? _$availableEpisodes(SeriesModel v) =>
      v.availableEpisodes;
  static const Field<SeriesModel, List<EpisodeModel>> _f$availableEpisodes =
      Field('availableEpisodes', _$availableEpisodes, opt: true);
  static List<SeasonModel>? _$seasons(SeriesModel v) => v.seasons;
  static const Field<SeriesModel, List<SeasonModel>> _f$seasons =
      Field('seasons', _$seasons, opt: true);
  static String _$originalTitle(SeriesModel v) => v.originalTitle;
  static const Field<SeriesModel, String> _f$originalTitle =
      Field('originalTitle', _$originalTitle);
  static String _$sortName(SeriesModel v) => v.sortName;
  static const Field<SeriesModel, String> _f$sortName =
      Field('sortName', _$sortName);
  static String _$status(SeriesModel v) => v.status;
  static const Field<SeriesModel, String> _f$status = Field('status', _$status);
  static List<ItemBaseModel> _$related(SeriesModel v) => v.related;
  static const Field<SeriesModel, List<ItemBaseModel>> _f$related =
      Field('related', _$related, opt: true, def: const []);
  static String _$name(SeriesModel v) => v.name;
  static const Field<SeriesModel, String> _f$name = Field('name', _$name);
  static String _$id(SeriesModel v) => v.id;
  static const Field<SeriesModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(SeriesModel v) => v.overview;
  static const Field<SeriesModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(SeriesModel v) => v.parentId;
  static const Field<SeriesModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(SeriesModel v) => v.playlistId;
  static const Field<SeriesModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(SeriesModel v) => v.images;
  static const Field<SeriesModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(SeriesModel v) => v.childCount;
  static const Field<SeriesModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(SeriesModel v) => v.primaryRatio;
  static const Field<SeriesModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(SeriesModel v) => v.userData;
  static const Field<SeriesModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDownload(SeriesModel v) => v.canDownload;
  static const Field<SeriesModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload, opt: true);
  static bool? _$canDelete(SeriesModel v) => v.canDelete;
  static const Field<SeriesModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete, opt: true);
  static dto.BaseItemKind? _$jellyType(SeriesModel v) => v.jellyType;
  static const Field<SeriesModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<SeriesModel> fields = const {
    #availableEpisodes: _f$availableEpisodes,
    #seasons: _f$seasons,
    #originalTitle: _f$originalTitle,
    #sortName: _f$sortName,
    #status: _f$status,
    #related: _f$related,
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

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'SeriesModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static SeriesModel _instantiate(DecodingData data) {
    return SeriesModel(
        availableEpisodes: data.dec(_f$availableEpisodes),
        seasons: data.dec(_f$seasons),
        originalTitle: data.dec(_f$originalTitle),
        sortName: data.dec(_f$sortName),
        status: data.dec(_f$status),
        related: data.dec(_f$related),
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

mixin SeriesModelMappable {
  SeriesModelCopyWith<SeriesModel, SeriesModel, SeriesModel> get copyWith =>
      _SeriesModelCopyWithImpl<SeriesModel, SeriesModel>(
          this as SeriesModel, $identity, $identity);
}

extension SeriesModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SeriesModel, $Out> {
  SeriesModelCopyWith<$R, SeriesModel, $Out> get $asSeriesModel =>
      $base.as((v, t, t2) => _SeriesModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SeriesModelCopyWith<$R, $In extends SeriesModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, EpisodeModel,
          EpisodeModelCopyWith<$R, EpisodeModel, EpisodeModel>>?
      get availableEpisodes;
  ListCopyWith<$R, SeasonModel,
      SeasonModelCopyWith<$R, SeasonModel, SeasonModel>>? get seasons;
  ListCopyWith<$R, ItemBaseModel,
      ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>> get related;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {List<EpisodeModel>? availableEpisodes,
      List<SeasonModel>? seasons,
      String? originalTitle,
      String? sortName,
      String? status,
      List<ItemBaseModel>? related,
      String? name,
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
  SeriesModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SeriesModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SeriesModel, $Out>
    implements SeriesModelCopyWith<$R, SeriesModel, $Out> {
  _SeriesModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SeriesModel> $mapper =
      SeriesModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, EpisodeModel,
          EpisodeModelCopyWith<$R, EpisodeModel, EpisodeModel>>?
      get availableEpisodes => $value.availableEpisodes != null
          ? ListCopyWith($value.availableEpisodes!,
              (v, t) => v.copyWith.$chain(t), (v) => call(availableEpisodes: v))
          : null;
  @override
  ListCopyWith<$R, SeasonModel,
          SeasonModelCopyWith<$R, SeasonModel, SeasonModel>>?
      get seasons => $value.seasons != null
          ? ListCopyWith($value.seasons!, (v, t) => v.copyWith.$chain(t),
              (v) => call(seasons: v))
          : null;
  @override
  ListCopyWith<$R, ItemBaseModel,
          ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>>
      get related => ListCopyWith($value.related,
          (v, t) => v.copyWith.$chain(t), (v) => call(related: v));
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {Object? availableEpisodes = $none,
          Object? seasons = $none,
          String? originalTitle,
          String? sortName,
          String? status,
          List<ItemBaseModel>? related,
          String? name,
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
        if (availableEpisodes != $none) #availableEpisodes: availableEpisodes,
        if (seasons != $none) #seasons: seasons,
        if (originalTitle != null) #originalTitle: originalTitle,
        if (sortName != null) #sortName: sortName,
        if (status != null) #status: status,
        if (related != null) #related: related,
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
  SeriesModel $make(CopyWithData data) => SeriesModel(
      availableEpisodes:
          data.get(#availableEpisodes, or: $value.availableEpisodes),
      seasons: data.get(#seasons, or: $value.seasons),
      originalTitle: data.get(#originalTitle, or: $value.originalTitle),
      sortName: data.get(#sortName, or: $value.sortName),
      status: data.get(#status, or: $value.status),
      related: data.get(#related, or: $value.related),
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
  SeriesModelCopyWith<$R2, SeriesModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SeriesModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
