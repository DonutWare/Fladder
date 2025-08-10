// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'overview_model.dart';

class OverviewModelMapper extends ClassMapperBase<OverviewModel> {
  OverviewModelMapper._();

  static OverviewModelMapper? _instance;
  static OverviewModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OverviewModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OverviewModel';

  static Duration? _$runTime(OverviewModel v) => v.runTime;
  static const Field<OverviewModel, Duration> _f$runTime =
      Field('runTime', _$runTime, opt: true);
  static String _$summary(OverviewModel v) => v.summary;
  static const Field<OverviewModel, String> _f$summary =
      Field('summary', _$summary, opt: true, def: "");
  static int? _$yearAired(OverviewModel v) => v.yearAired;
  static const Field<OverviewModel, int> _f$yearAired =
      Field('yearAired', _$yearAired, opt: true);
  static DateTime? _$dateAdded(OverviewModel v) => v.dateAdded;
  static const Field<OverviewModel, DateTime> _f$dateAdded =
      Field('dateAdded', _$dateAdded, opt: true);
  static String? _$parentalRating(OverviewModel v) => v.parentalRating;
  static const Field<OverviewModel, String> _f$parentalRating =
      Field('parentalRating', _$parentalRating, opt: true);
  static int? _$productionYear(OverviewModel v) => v.productionYear;
  static const Field<OverviewModel, int> _f$productionYear =
      Field('productionYear', _$productionYear, opt: true);
  static double? _$criticRating(OverviewModel v) => v.criticRating;
  static const Field<OverviewModel, double> _f$criticRating =
      Field('criticRating', _$criticRating, opt: true);
  static double? _$communityRating(OverviewModel v) => v.communityRating;
  static const Field<OverviewModel, double> _f$communityRating =
      Field('communityRating', _$communityRating, opt: true);
  static Map<String, TrickPlayModel>? _$trickPlayInfo(OverviewModel v) =>
      v.trickPlayInfo;
  static const Field<OverviewModel, Map<String, TrickPlayModel>>
      _f$trickPlayInfo = Field('trickPlayInfo', _$trickPlayInfo, opt: true);
  static List<Chapter>? _$chapters(OverviewModel v) => v.chapters;
  static const Field<OverviewModel, List<Chapter>> _f$chapters =
      Field('chapters', _$chapters, opt: true);
  static List<ExternalUrls>? _$externalUrls(OverviewModel v) => v.externalUrls;
  static const Field<OverviewModel, List<ExternalUrls>> _f$externalUrls =
      Field('externalUrls', _$externalUrls, opt: true);
  static List<Studio> _$studios(OverviewModel v) => v.studios;
  static const Field<OverviewModel, List<Studio>> _f$studios =
      Field('studios', _$studios, opt: true, def: const []);
  static List<String> _$genres(OverviewModel v) => v.genres;
  static const Field<OverviewModel, List<String>> _f$genres =
      Field('genres', _$genres, opt: true, def: const []);
  static List<GenreItems> _$genreItems(OverviewModel v) => v.genreItems;
  static const Field<OverviewModel, List<GenreItems>> _f$genreItems =
      Field('genreItems', _$genreItems, opt: true, def: const []);
  static List<String> _$tags(OverviewModel v) => v.tags;
  static const Field<OverviewModel, List<String>> _f$tags =
      Field('tags', _$tags, opt: true, def: const []);
  static List<Person> _$people(OverviewModel v) => v.people;
  static const Field<OverviewModel, List<Person>> _f$people =
      Field('people', _$people, opt: true, def: const []);

  @override
  final MappableFields<OverviewModel> fields = const {
    #runTime: _f$runTime,
    #summary: _f$summary,
    #yearAired: _f$yearAired,
    #dateAdded: _f$dateAdded,
    #parentalRating: _f$parentalRating,
    #productionYear: _f$productionYear,
    #criticRating: _f$criticRating,
    #communityRating: _f$communityRating,
    #trickPlayInfo: _f$trickPlayInfo,
    #chapters: _f$chapters,
    #externalUrls: _f$externalUrls,
    #studios: _f$studios,
    #genres: _f$genres,
    #genreItems: _f$genreItems,
    #tags: _f$tags,
    #people: _f$people,
  };
  @override
  final bool ignoreNull = true;

  static OverviewModel _instantiate(DecodingData data) {
    return OverviewModel(
        runTime: data.dec(_f$runTime),
        summary: data.dec(_f$summary),
        yearAired: data.dec(_f$yearAired),
        dateAdded: data.dec(_f$dateAdded),
        parentalRating: data.dec(_f$parentalRating),
        productionYear: data.dec(_f$productionYear),
        criticRating: data.dec(_f$criticRating),
        communityRating: data.dec(_f$communityRating),
        trickPlayInfo: data.dec(_f$trickPlayInfo),
        chapters: data.dec(_f$chapters),
        externalUrls: data.dec(_f$externalUrls),
        studios: data.dec(_f$studios),
        genres: data.dec(_f$genres),
        genreItems: data.dec(_f$genreItems),
        tags: data.dec(_f$tags),
        people: data.dec(_f$people));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin OverviewModelMappable {
  OverviewModelCopyWith<OverviewModel, OverviewModel, OverviewModel>
      get copyWith => _OverviewModelCopyWithImpl<OverviewModel, OverviewModel>(
          this as OverviewModel, $identity, $identity);
}

extension OverviewModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OverviewModel, $Out> {
  OverviewModelCopyWith<$R, OverviewModel, $Out> get $asOverviewModel =>
      $base.as((v, t, t2) => _OverviewModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OverviewModelCopyWith<$R, $In extends OverviewModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, TrickPlayModel,
      ObjectCopyWith<$R, TrickPlayModel, TrickPlayModel>>? get trickPlayInfo;
  ListCopyWith<$R, Chapter, ObjectCopyWith<$R, Chapter, Chapter>>? get chapters;
  ListCopyWith<$R, ExternalUrls,
      ObjectCopyWith<$R, ExternalUrls, ExternalUrls>>? get externalUrls;
  ListCopyWith<$R, Studio, ObjectCopyWith<$R, Studio, Studio>> get studios;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get genres;
  ListCopyWith<$R, GenreItems, ObjectCopyWith<$R, GenreItems, GenreItems>>
      get genreItems;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags;
  ListCopyWith<$R, Person, ObjectCopyWith<$R, Person, Person>> get people;
  $R call(
      {Duration? runTime,
      String? summary,
      int? yearAired,
      DateTime? dateAdded,
      String? parentalRating,
      int? productionYear,
      double? criticRating,
      double? communityRating,
      Map<String, TrickPlayModel>? trickPlayInfo,
      List<Chapter>? chapters,
      List<ExternalUrls>? externalUrls,
      List<Studio>? studios,
      List<String>? genres,
      List<GenreItems>? genreItems,
      List<String>? tags,
      List<Person>? people});
  OverviewModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _OverviewModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OverviewModel, $Out>
    implements OverviewModelCopyWith<$R, OverviewModel, $Out> {
  _OverviewModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OverviewModel> $mapper =
      OverviewModelMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, TrickPlayModel,
          ObjectCopyWith<$R, TrickPlayModel, TrickPlayModel>>?
      get trickPlayInfo => $value.trickPlayInfo != null
          ? MapCopyWith(
              $value.trickPlayInfo!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(trickPlayInfo: v))
          : null;
  @override
  ListCopyWith<$R, Chapter, ObjectCopyWith<$R, Chapter, Chapter>>?
      get chapters => $value.chapters != null
          ? ListCopyWith(
              $value.chapters!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(chapters: v))
          : null;
  @override
  ListCopyWith<$R, ExternalUrls,
          ObjectCopyWith<$R, ExternalUrls, ExternalUrls>>?
      get externalUrls => $value.externalUrls != null
          ? ListCopyWith(
              $value.externalUrls!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(externalUrls: v))
          : null;
  @override
  ListCopyWith<$R, Studio, ObjectCopyWith<$R, Studio, Studio>> get studios =>
      ListCopyWith($value.studios, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(studios: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get genres =>
      ListCopyWith($value.genres, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(genres: v));
  @override
  ListCopyWith<$R, GenreItems, ObjectCopyWith<$R, GenreItems, GenreItems>>
      get genreItems => ListCopyWith(
          $value.genreItems,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(genreItems: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags =>
      ListCopyWith($value.tags, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(tags: v));
  @override
  ListCopyWith<$R, Person, ObjectCopyWith<$R, Person, Person>> get people =>
      ListCopyWith($value.people, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(people: v));
  @override
  $R call(
          {Object? runTime = $none,
          String? summary,
          Object? yearAired = $none,
          Object? dateAdded = $none,
          Object? parentalRating = $none,
          Object? productionYear = $none,
          Object? criticRating = $none,
          Object? communityRating = $none,
          Object? trickPlayInfo = $none,
          Object? chapters = $none,
          Object? externalUrls = $none,
          List<Studio>? studios,
          List<String>? genres,
          List<GenreItems>? genreItems,
          List<String>? tags,
          List<Person>? people}) =>
      $apply(FieldCopyWithData({
        if (runTime != $none) #runTime: runTime,
        if (summary != null) #summary: summary,
        if (yearAired != $none) #yearAired: yearAired,
        if (dateAdded != $none) #dateAdded: dateAdded,
        if (parentalRating != $none) #parentalRating: parentalRating,
        if (productionYear != $none) #productionYear: productionYear,
        if (criticRating != $none) #criticRating: criticRating,
        if (communityRating != $none) #communityRating: communityRating,
        if (trickPlayInfo != $none) #trickPlayInfo: trickPlayInfo,
        if (chapters != $none) #chapters: chapters,
        if (externalUrls != $none) #externalUrls: externalUrls,
        if (studios != null) #studios: studios,
        if (genres != null) #genres: genres,
        if (genreItems != null) #genreItems: genreItems,
        if (tags != null) #tags: tags,
        if (people != null) #people: people
      }));
  @override
  OverviewModel $make(CopyWithData data) => OverviewModel(
      runTime: data.get(#runTime, or: $value.runTime),
      summary: data.get(#summary, or: $value.summary),
      yearAired: data.get(#yearAired, or: $value.yearAired),
      dateAdded: data.get(#dateAdded, or: $value.dateAdded),
      parentalRating: data.get(#parentalRating, or: $value.parentalRating),
      productionYear: data.get(#productionYear, or: $value.productionYear),
      criticRating: data.get(#criticRating, or: $value.criticRating),
      communityRating: data.get(#communityRating, or: $value.communityRating),
      trickPlayInfo: data.get(#trickPlayInfo, or: $value.trickPlayInfo),
      chapters: data.get(#chapters, or: $value.chapters),
      externalUrls: data.get(#externalUrls, or: $value.externalUrls),
      studios: data.get(#studios, or: $value.studios),
      genres: data.get(#genres, or: $value.genres),
      genreItems: data.get(#genreItems, or: $value.genreItems),
      tags: data.get(#tags, or: $value.tags),
      people: data.get(#people, or: $value.people));

  @override
  OverviewModelCopyWith<$R2, OverviewModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _OverviewModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
