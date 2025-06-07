// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'movie_model.dart';

class MovieModelMapper extends SubClassMapperBase<MovieModel> {
  MovieModelMapper._();

  static MovieModelMapper? _instance;
  static MovieModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MovieModelMapper._());
      ItemStreamModelMapper.ensureInitialized().addSubMapper(_instance!);
      ItemBaseModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MovieModel';

  static String _$originalTitle(MovieModel v) => v.originalTitle;
  static const Field<MovieModel, String> _f$originalTitle =
      Field('originalTitle', _$originalTitle);
  static String? _$path(MovieModel v) => v.path;
  static const Field<MovieModel, String> _f$path =
      Field('path', _$path, opt: true);
  static List<Chapter> _$chapters(MovieModel v) => v.chapters;
  static const Field<MovieModel, List<Chapter>> _f$chapters =
      Field('chapters', _$chapters, opt: true, def: const []);
  static DateTime _$premiereDate(MovieModel v) => v.premiereDate;
  static const Field<MovieModel, DateTime> _f$premiereDate =
      Field('premiereDate', _$premiereDate);
  static String _$sortName(MovieModel v) => v.sortName;
  static const Field<MovieModel, String> _f$sortName =
      Field('sortName', _$sortName);
  static String _$status(MovieModel v) => v.status;
  static const Field<MovieModel, String> _f$status = Field('status', _$status);
  static List<ItemBaseModel> _$related(MovieModel v) => v.related;
  static const Field<MovieModel, List<ItemBaseModel>> _f$related =
      Field('related', _$related, opt: true, def: const []);
  static String _$name(MovieModel v) => v.name;
  static const Field<MovieModel, String> _f$name = Field('name', _$name);
  static String _$id(MovieModel v) => v.id;
  static const Field<MovieModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(MovieModel v) => v.overview;
  static const Field<MovieModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(MovieModel v) => v.parentId;
  static const Field<MovieModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(MovieModel v) => v.playlistId;
  static const Field<MovieModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(MovieModel v) => v.images;
  static const Field<MovieModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(MovieModel v) => v.childCount;
  static const Field<MovieModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(MovieModel v) => v.primaryRatio;
  static const Field<MovieModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(MovieModel v) => v.userData;
  static const Field<MovieModel, UserData> _f$userData =
      Field('userData', _$userData);
  static ImagesData? _$parentImages(MovieModel v) => v.parentImages;
  static const Field<MovieModel, ImagesData> _f$parentImages =
      Field('parentImages', _$parentImages);
  static MediaStreamsModel _$mediaStreams(MovieModel v) => v.mediaStreams;
  static const Field<MovieModel, MediaStreamsModel> _f$mediaStreams =
      Field('mediaStreams', _$mediaStreams);
  static bool? _$canDownload(MovieModel v) => v.canDownload;
  static const Field<MovieModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload);
  static bool? _$canDelete(MovieModel v) => v.canDelete;
  static const Field<MovieModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete);
  static dto.BaseItemKind? _$jellyType(MovieModel v) => v.jellyType;
  static const Field<MovieModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<MovieModel> fields = const {
    #originalTitle: _f$originalTitle,
    #path: _f$path,
    #chapters: _f$chapters,
    #premiereDate: _f$premiereDate,
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
    #parentImages: _f$parentImages,
    #mediaStreams: _f$mediaStreams,
    #canDownload: _f$canDownload,
    #canDelete: _f$canDelete,
    #jellyType: _f$jellyType,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'MovieModel';
  @override
  late final ClassMapperBase superMapper =
      ItemStreamModelMapper.ensureInitialized();

  static MovieModel _instantiate(DecodingData data) {
    return MovieModel(
        originalTitle: data.dec(_f$originalTitle),
        path: data.dec(_f$path),
        chapters: data.dec(_f$chapters),
        premiereDate: data.dec(_f$premiereDate),
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
        parentImages: data.dec(_f$parentImages),
        mediaStreams: data.dec(_f$mediaStreams),
        canDownload: data.dec(_f$canDownload),
        canDelete: data.dec(_f$canDelete),
        jellyType: data.dec(_f$jellyType));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin MovieModelMappable {
  MovieModelCopyWith<MovieModel, MovieModel, MovieModel> get copyWith =>
      _MovieModelCopyWithImpl(this as MovieModel, $identity, $identity);
}

extension MovieModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MovieModel, $Out> {
  MovieModelCopyWith<$R, MovieModel, $Out> get $asMovieModel =>
      $base.as((v, t, t2) => _MovieModelCopyWithImpl(v, t, t2));
}

abstract class MovieModelCopyWith<$R, $In extends MovieModel, $Out>
    implements ItemStreamModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Chapter, ObjectCopyWith<$R, Chapter, Chapter>> get chapters;
  ListCopyWith<$R, ItemBaseModel,
      ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>> get related;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {String? originalTitle,
      String? path,
      List<Chapter>? chapters,
      DateTime? premiereDate,
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
      ImagesData? parentImages,
      MediaStreamsModel? mediaStreams,
      bool? canDownload,
      bool? canDelete,
      dto.BaseItemKind? jellyType});
  MovieModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MovieModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MovieModel, $Out>
    implements MovieModelCopyWith<$R, MovieModel, $Out> {
  _MovieModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MovieModel> $mapper =
      MovieModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Chapter, ObjectCopyWith<$R, Chapter, Chapter>>
      get chapters => ListCopyWith($value.chapters,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(chapters: v));
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
          {String? originalTitle,
          Object? path = $none,
          List<Chapter>? chapters,
          DateTime? premiereDate,
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
          Object? parentImages = $none,
          MediaStreamsModel? mediaStreams,
          Object? canDownload = $none,
          Object? canDelete = $none,
          Object? jellyType = $none}) =>
      $apply(FieldCopyWithData({
        if (originalTitle != null) #originalTitle: originalTitle,
        if (path != $none) #path: path,
        if (chapters != null) #chapters: chapters,
        if (premiereDate != null) #premiereDate: premiereDate,
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
        if (parentImages != $none) #parentImages: parentImages,
        if (mediaStreams != null) #mediaStreams: mediaStreams,
        if (canDownload != $none) #canDownload: canDownload,
        if (canDelete != $none) #canDelete: canDelete,
        if (jellyType != $none) #jellyType: jellyType
      }));
  @override
  MovieModel $make(CopyWithData data) => MovieModel(
      originalTitle: data.get(#originalTitle, or: $value.originalTitle),
      path: data.get(#path, or: $value.path),
      chapters: data.get(#chapters, or: $value.chapters),
      premiereDate: data.get(#premiereDate, or: $value.premiereDate),
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
      parentImages: data.get(#parentImages, or: $value.parentImages),
      mediaStreams: data.get(#mediaStreams, or: $value.mediaStreams),
      canDownload: data.get(#canDownload, or: $value.canDownload),
      canDelete: data.get(#canDelete, or: $value.canDelete),
      jellyType: data.get(#jellyType, or: $value.jellyType));

  @override
  MovieModelCopyWith<$R2, MovieModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MovieModelCopyWithImpl($value, $cast, t);
}
