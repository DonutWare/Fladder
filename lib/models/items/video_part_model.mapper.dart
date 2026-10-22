// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'video_part_model.dart';

class VideoPartModelMapper extends SubClassMapperBase<VideoPartModel> {
  VideoPartModelMapper._();

  static VideoPartModelMapper? _instance;
  static VideoPartModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VideoPartModelMapper._());
      ItemStreamModelMapper.ensureInitialized().addSubMapper(_instance!);
      OverviewModelMapper.ensureInitialized();
      UserDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VideoPartModel';

  static String _$parentItemId(VideoPartModel v) => v.parentItemId;
  static const Field<VideoPartModel, String> _f$parentItemId = Field('parentItemId', _$parentItemId);
  static int _$partNumber(VideoPartModel v) => v.partNumber;
  static const Field<VideoPartModel, int> _f$partNumber = Field('partNumber', _$partNumber);
  static int _$totalParts(VideoPartModel v) => v.totalParts;
  static const Field<VideoPartModel, int> _f$totalParts = Field('totalParts', _$totalParts);
  static String _$name(VideoPartModel v) => v.name;
  static const Field<VideoPartModel, String> _f$name = Field('name', _$name);
  static String _$id(VideoPartModel v) => v.id;
  static const Field<VideoPartModel, String> _f$id = Field('id', _$id);
  static OverviewModel _$overview(VideoPartModel v) => v.overview;
  static const Field<VideoPartModel, OverviewModel> _f$overview = Field('overview', _$overview);
  static String? _$parentId(VideoPartModel v) => v.parentId;
  static const Field<VideoPartModel, String> _f$parentId = Field('parentId', _$parentId);
  static String? _$playlistId(VideoPartModel v) => v.playlistId;
  static const Field<VideoPartModel, String> _f$playlistId = Field('playlistId', _$playlistId);
  static ImagesData? _$images(VideoPartModel v) => v.images;
  static const Field<VideoPartModel, ImagesData> _f$images = Field('images', _$images);
  static int? _$childCount(VideoPartModel v) => v.childCount;
  static const Field<VideoPartModel, int> _f$childCount = Field('childCount', _$childCount);
  static double? _$primaryRatio(VideoPartModel v) => v.primaryRatio;
  static const Field<VideoPartModel, double> _f$primaryRatio = Field('primaryRatio', _$primaryRatio);
  static UserData _$userData(VideoPartModel v) => v.userData;
  static const Field<VideoPartModel, UserData> _f$userData = Field('userData', _$userData);
  static ImagesData? _$parentImages(VideoPartModel v) => v.parentImages;
  static const Field<VideoPartModel, ImagesData> _f$parentImages = Field('parentImages', _$parentImages);
  static MediaStreamsModel _$mediaStreams(VideoPartModel v) => v.mediaStreams;
  static const Field<VideoPartModel, MediaStreamsModel> _f$mediaStreams = Field('mediaStreams', _$mediaStreams);
  static bool? _$canDelete(VideoPartModel v) => v.canDelete;
  static const Field<VideoPartModel, bool> _f$canDelete = Field('canDelete', _$canDelete, opt: true);
  static bool? _$canDownload(VideoPartModel v) => v.canDownload;
  static const Field<VideoPartModel, bool> _f$canDownload = Field('canDownload', _$canDownload, opt: true);
  static dto.BaseItemKind? _$jellyType(VideoPartModel v) => v.jellyType;
  static const Field<VideoPartModel, dto.BaseItemKind> _f$jellyType = Field('jellyType', _$jellyType, opt: true);
  static int _$partCount(VideoPartModel v) => v.partCount;
  static const Field<VideoPartModel, int> _f$partCount = Field('partCount', _$partCount, opt: true, def: 1);

  @override
  final MappableFields<VideoPartModel> fields = const {
    #parentItemId: _f$parentItemId,
    #partNumber: _f$partNumber,
    #totalParts: _f$totalParts,
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
    #partCount: _f$partCount,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'VideoPartModel';
  @override
  late final ClassMapperBase superMapper = ItemStreamModelMapper.ensureInitialized();

  static VideoPartModel _instantiate(DecodingData data) {
    return VideoPartModel(
        parentItemId: data.dec(_f$parentItemId),
        partNumber: data.dec(_f$partNumber),
        totalParts: data.dec(_f$totalParts),
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
        jellyType: data.dec(_f$jellyType),
        partCount: data.dec(_f$partCount));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin VideoPartModelMappable {
  VideoPartModelCopyWith<VideoPartModel, VideoPartModel, VideoPartModel> get copyWith =>
      _VideoPartModelCopyWithImpl<VideoPartModel, VideoPartModel>(this as VideoPartModel, $identity, $identity);
}

extension VideoPartModelValueCopy<$R, $Out> on ObjectCopyWith<$R, VideoPartModel, $Out> {
  VideoPartModelCopyWith<$R, VideoPartModel, $Out> get $asVideoPartModel =>
      $base.as((v, t, t2) => _VideoPartModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VideoPartModelCopyWith<$R, $In extends VideoPartModel, $Out>
    implements ItemStreamModelCopyWith<$R, $In, $Out> {
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview;
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData;
  @override
  $R call(
      {String? parentItemId,
      int? partNumber,
      int? totalParts,
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
      dto.BaseItemKind? jellyType,
      int? partCount});
  VideoPartModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VideoPartModelCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, VideoPartModel, $Out>
    implements VideoPartModelCopyWith<$R, VideoPartModel, $Out> {
  _VideoPartModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VideoPartModel> $mapper = VideoPartModelMapper.ensureInitialized();
  @override
  OverviewModelCopyWith<$R, OverviewModel, OverviewModel> get overview =>
      $value.overview.copyWith.$chain((v) => call(overview: v));
  @override
  UserDataCopyWith<$R, UserData, UserData> get userData => $value.userData.copyWith.$chain((v) => call(userData: v));
  @override
  $R call(
          {String? parentItemId,
          int? partNumber,
          int? totalParts,
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
          Object? jellyType = $none,
          int? partCount}) =>
      $apply(FieldCopyWithData({
        if (parentItemId != null) #parentItemId: parentItemId,
        if (partNumber != null) #partNumber: partNumber,
        if (totalParts != null) #totalParts: totalParts,
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
        if (jellyType != $none) #jellyType: jellyType,
        if (partCount != null) #partCount: partCount
      }));
  @override
  VideoPartModel $make(CopyWithData data) => VideoPartModel(
      parentItemId: data.get(#parentItemId, or: $value.parentItemId),
      partNumber: data.get(#partNumber, or: $value.partNumber),
      totalParts: data.get(#totalParts, or: $value.totalParts),
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
      jellyType: data.get(#jellyType, or: $value.jellyType),
      partCount: data.get(#partCount, or: $value.partCount));

  @override
  VideoPartModelCopyWith<$R2, VideoPartModel, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _VideoPartModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
