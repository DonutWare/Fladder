// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'special_feature_model.dart';

class SpecialFeatureModelMapper
    extends SubClassMapperBase<SpecialFeatureModel> {
  SpecialFeatureModelMapper._();

  static SpecialFeatureModelMapper? _instance;
  static SpecialFeatureModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SpecialFeatureModelMapper._());
      ItemStreamModelMapper.ensureInitialized().addSubMapper(_instance!);
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SpecialFeatureModel';

  static List<Chapter> _$chapters(SpecialFeatureModel v) => v.chapters;
  static const Field<SpecialFeatureModel, List<Chapter>> _f$chapters =
      Field('chapters', _$chapters, opt: true, def: const []);
  static ItemLocation? _$location(SpecialFeatureModel v) => v.location;
  static const Field<SpecialFeatureModel, ItemLocation> _f$location =
      Field('location', _$location, opt: true);
  static DateTime? _$dateAired(SpecialFeatureModel v) => v.dateAired;
  static const Field<SpecialFeatureModel, DateTime> _f$dateAired =
      Field('dateAired', _$dateAired, opt: true);
  static String _$name(SpecialFeatureModel v) => v.name;
  static const Field<SpecialFeatureModel, String> _f$name =
      Field('name', _$name);
  static String _$id(SpecialFeatureModel v) => v.id;
  static const Field<SpecialFeatureModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(SpecialFeatureModel v) => v.overview;
  static const Field<SpecialFeatureModel, OverviewModel> _f$overview =
      Field('overview', _$overview);
  static String? _$parentId(SpecialFeatureModel v) => v.parentId;
  static const Field<SpecialFeatureModel, String> _f$parentId =
      Field('parentId', _$parentId);
  static String? _$playlistId(SpecialFeatureModel v) => v.playlistId;
  static const Field<SpecialFeatureModel, String> _f$playlistId =
      Field('playlistId', _$playlistId);
  static ImagesData? _$images(SpecialFeatureModel v) => v.images;
  static const Field<SpecialFeatureModel, ImagesData> _f$images =
      Field('images', _$images);
  static int? _$childCount(SpecialFeatureModel v) => v.childCount;
  static const Field<SpecialFeatureModel, int> _f$childCount =
      Field('childCount', _$childCount);
  static double? _$primaryRatio(SpecialFeatureModel v) => v.primaryRatio;
  static const Field<SpecialFeatureModel, double> _f$primaryRatio =
      Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(SpecialFeatureModel v) => v.userData;
  static const Field<SpecialFeatureModel, UserData> _f$userData =
      Field('userData', _$userData);
  static ImagesData? _$parentImages(SpecialFeatureModel v) => v.parentImages;
  static const Field<SpecialFeatureModel, ImagesData> _f$parentImages =
      Field('parentImages', _$parentImages);
  static MediaStreamsModel _$mediaStreams(SpecialFeatureModel v) =>
      v.mediaStreams;
  static const Field<SpecialFeatureModel, MediaStreamsModel> _f$mediaStreams =
      Field('mediaStreams', _$mediaStreams);
  static bool? _$canDelete(SpecialFeatureModel v) => v.canDelete;
  static const Field<SpecialFeatureModel, bool> _f$canDelete =
      Field('canDelete', _$canDelete, opt: true);
  static bool? _$canDownload(SpecialFeatureModel v) => v.canDownload;
  static const Field<SpecialFeatureModel, bool> _f$canDownload =
      Field('canDownload', _$canDownload, opt: true);
  static dto.BaseItemKind? _$jellyType(SpecialFeatureModel v) => v.jellyType;
  static const Field<SpecialFeatureModel, dto.BaseItemKind> _f$jellyType =
      Field('jellyType', _$jellyType, opt: true);

  @override
  final MappableFields<SpecialFeatureModel> fields = const {
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
  final dynamic discriminatorValue = 'SpecialFeatureModel';
  @override
  late final ClassMapperBase superMapper =
      ItemStreamModelMapper.ensureInitialized();

  static SpecialFeatureModel _instantiate(DecodingData data) {
    return SpecialFeatureModel(
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

mixin SpecialFeatureModelMappable {
  SpecialFeatureModelCopyWith<SpecialFeatureModel, SpecialFeatureModel,
      SpecialFeatureModel> get copyWith => _SpecialFeatureModelCopyWithImpl<
          SpecialFeatureModel, SpecialFeatureModel>(
      this as SpecialFeatureModel, $identity, $identity);
}

extension SpecialFeatureModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SpecialFeatureModel, $Out> {
  SpecialFeatureModelCopyWith<$R, SpecialFeatureModel, $Out>
      get $asSpecialFeatureModel => $base.as(
          (v, t, t2) => _SpecialFeatureModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SpecialFeatureModelCopyWith<$R, $In extends SpecialFeatureModel,
    $Out> implements ItemStreamModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Chapter, ObjectCopyWith<$R, Chapter, Chapter>> get chapters;
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {List<Chapter>? chapters,
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
  SpecialFeatureModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SpecialFeatureModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SpecialFeatureModel, $Out>
    implements SpecialFeatureModelCopyWith<$R, SpecialFeatureModel, $Out> {
  _SpecialFeatureModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SpecialFeatureModel> $mapper =
      SpecialFeatureModelMapper.ensureInitialized();
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
          {List<Chapter>? chapters,
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
  SpecialFeatureModel $make(CopyWithData data) => SpecialFeatureModel(
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
  SpecialFeatureModelCopyWith<$R2, SpecialFeatureModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SpecialFeatureModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
