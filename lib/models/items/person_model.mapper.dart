// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'person_model.dart';

class PersonModelMapper extends SubClassMapperBase<PersonModel> {
  PersonModelMapper._();

  static PersonModelMapper? _instance;
  static PersonModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersonModelMapper._());
      ItemBaseModelMapper.ensureInitialized().addSubMapper(_instance!);
      MovieModelMapper.ensureInitialized();
      SeriesModelMapper.ensureInitialized();
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PersonModel';

  static DateTime? _$dateOfBirth(PersonModel v) => v.dateOfBirth;
  static const Field<PersonModel, DateTime> _f$dateOfBirth =
      Field('dateOfBirth', _$dateOfBirth, opt: true);
  static List<String> _$birthPlace(PersonModel v) => v.birthPlace;
  static const Field<PersonModel, List<String>> _f$birthPlace =
      Field('birthPlace', _$birthPlace);
  static List<MovieModel> _$movies(PersonModel v) => v.movies;
  static const Field<PersonModel, List<MovieModel>> _f$movies =
      Field('movies', _$movies);
  static List<SeriesModel> _$series(PersonModel v) => v.series;
  static const Field<PersonModel, List<SeriesModel>> _f$series =
      Field('series', _$series);
  static String _$name(PersonModel v) => v.name;
  static const Field<PersonModel, String> _f$name = Field('name', _$name);
  static String _$id(PersonModel v) => v.id;
  static const Field<PersonModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(PersonModel v) => v.overview;
  static const Field<PersonModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(PersonModel v) => v.parentId;
  static const Field<PersonModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(PersonModel v) => v.playlistId;
  static const Field<PersonModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(PersonModel v) => v.images;
  static const Field<PersonModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(PersonModel v) => v.childCount;
  static const Field<PersonModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(PersonModel v) => v.primaryRatio;
  static const Field<PersonModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(PersonModel v) => v.userData;
  static const Field<PersonModel, UserData> _f$userData =
      Field('userData', _$userData);
  static bool? _$canDownload(PersonModel v) => v.canDownload;
  static const Field<PersonModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload, opt: true);
  static bool? _$canDelete(PersonModel v) => v.canDelete;
  static const Field<PersonModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete, opt: true);
  static BaseItemKind? _$jellyType(PersonModel v) => v.jellyType;
  static const Field<PersonModel, BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<PersonModel> fields = const {
    #dateOfBirth: _f$dateOfBirth,
    #birthPlace: _f$birthPlace,
    #movies: _f$movies,
    #series: _f$series,
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
  final dynamic discriminatorValue = 'PersonModel';
  @override
  late final ClassMapperBase superMapper =
      ItemBaseModelMapper.ensureInitialized();

  static PersonModel _instantiate(DecodingData data) {
    return PersonModel(
        dateOfBirth: data.dec(_f$dateOfBirth),
        birthPlace: data.dec(_f$birthPlace),
        movies: data.dec(_f$movies),
        series: data.dec(_f$series),
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

mixin PersonModelMappable {
  PersonModelCopyWith<PersonModel, PersonModel, PersonModel> get copyWith =>
      _PersonModelCopyWithImpl(this as PersonModel, $identity, $identity);
}

extension PersonModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PersonModel, $Out> {
  PersonModelCopyWith<$R, PersonModel, $Out> get $asPersonModel =>
      $base.as((v, t, t2) => _PersonModelCopyWithImpl(v, t, t2));
}

abstract class PersonModelCopyWith<$R, $In extends PersonModel, $Out>
    implements ItemBaseModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get birthPlace;
  ListCopyWith<$R, MovieModel, MovieModelCopyWith<$R, MovieModel, MovieModel>>
      get movies;
  ListCopyWith<$R, SeriesModel,
      SeriesModelCopyWith<$R, SeriesModel, SeriesModel>> get series;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {DateTime? dateOfBirth,
      List<String>? birthPlace,
      List<MovieModel>? movies,
      List<SeriesModel>? series,
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
      BaseItemKind? jellyType});
  PersonModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PersonModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PersonModel, $Out>
    implements PersonModelCopyWith<$R, PersonModel, $Out> {
  _PersonModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PersonModel> $mapper =
      PersonModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get birthPlace =>
      ListCopyWith($value.birthPlace, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(birthPlace: v));
  @override
  ListCopyWith<$R, MovieModel, MovieModelCopyWith<$R, MovieModel, MovieModel>>
      get movies => ListCopyWith($value.movies, (v, t) => v.copyWith.$chain(t),
          (v) => call(movies: v));
  @override
  ListCopyWith<$R, SeriesModel,
          SeriesModelCopyWith<$R, SeriesModel, SeriesModel>>
      get series => ListCopyWith($value.series, (v, t) => v.copyWith.$chain(t),
          (v) => call(series: v));
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData =>
      $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {Object? dateOfBirth = $none,
          List<String>? birthPlace,
          List<MovieModel>? movies,
          List<SeriesModel>? series,
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
        if (dateOfBirth != $none) #dateOfBirth: dateOfBirth,
        if (birthPlace != null) #birthPlace: birthPlace,
        if (movies != null) #movies: movies,
        if (series != null) #series: series,
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
  PersonModel $make(CopyWithData data) => PersonModel(
      dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
      birthPlace: data.get(#birthPlace, or: $value.birthPlace),
      movies: data.get(#movies, or: $value.movies),
      series: data.get(#series, or: $value.series),
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
  PersonModelCopyWith<$R2, PersonModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PersonModelCopyWithImpl($value, $cast, t);
}
