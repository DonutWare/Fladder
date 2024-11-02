// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'library_search_model.dart';

class LibrarySearchModelMapper extends ClassMapperBase<LibrarySearchModel> {
  LibrarySearchModelMapper._();

  static LibrarySearchModelMapper? _instance;
  static LibrarySearchModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LibrarySearchModelMapper._());
      ItemBaseModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LibrarySearchModel';

  static bool _$loading(LibrarySearchModel v) => v.loading;
  static const Field<LibrarySearchModel, bool> _f$loading =
      Field('loading', _$loading, opt: true, def: false);
  static bool _$selecteMode(LibrarySearchModel v) => v.selecteMode;
  static const Field<LibrarySearchModel, bool> _f$selecteMode =
      Field('selecteMode', _$selecteMode, opt: true, def: false);
  static List<ItemBaseModel> _$folderOverwrite(LibrarySearchModel v) =>
      v.folderOverwrite;
  static const Field<LibrarySearchModel, List<ItemBaseModel>>
      _f$folderOverwrite =
      Field('folderOverwrite', _$folderOverwrite, opt: true, def: const []);
  static String _$searchQuery(LibrarySearchModel v) => v.searchQuery;
  static const Field<LibrarySearchModel, String> _f$searchQuery =
      Field('searchQuery', _$searchQuery, opt: true, def: "");
  static Map<ViewModel, bool> _$views(LibrarySearchModel v) => v.views;
  static const Field<LibrarySearchModel, Map<ViewModel, bool>> _f$views =
      Field('views', _$views, opt: true, def: const {});
  static List<ItemBaseModel> _$posters(LibrarySearchModel v) => v.posters;
  static const Field<LibrarySearchModel, List<ItemBaseModel>> _f$posters =
      Field('posters', _$posters, opt: true, def: const []);
  static List<ItemBaseModel> _$selectedPosters(LibrarySearchModel v) =>
      v.selectedPosters;
  static const Field<LibrarySearchModel, List<ItemBaseModel>>
      _f$selectedPosters =
      Field('selectedPosters', _$selectedPosters, opt: true, def: const []);
  static Map<ItemFilter, bool> _$filters(LibrarySearchModel v) => v.filters;
  static const Field<LibrarySearchModel, Map<ItemFilter, bool>> _f$filters =
      Field('filters', _$filters, opt: true, def: const {
    ItemFilter.isplayed: false,
    ItemFilter.isunplayed: false,
    ItemFilter.isresumable: false
  });
  static Map<String, bool> _$genres(LibrarySearchModel v) => v.genres;
  static const Field<LibrarySearchModel, Map<String, bool>> _f$genres =
      Field('genres', _$genres, opt: true, def: const {});
  static Map<Studio, bool> _$studios(LibrarySearchModel v) => v.studios;
  static const Field<LibrarySearchModel, Map<Studio, bool>> _f$studios =
      Field('studios', _$studios, opt: true, def: const {});
  static Map<String, bool> _$tags(LibrarySearchModel v) => v.tags;
  static const Field<LibrarySearchModel, Map<String, bool>> _f$tags =
      Field('tags', _$tags, opt: true, def: const {});
  static Map<int, bool> _$years(LibrarySearchModel v) => v.years;
  static const Field<LibrarySearchModel, Map<int, bool>> _f$years =
      Field('years', _$years, opt: true, def: const {});
  static Map<String, bool> _$officialRatings(LibrarySearchModel v) =>
      v.officialRatings;
  static const Field<LibrarySearchModel, Map<String, bool>> _f$officialRatings =
      Field('officialRatings', _$officialRatings, opt: true, def: const {});
  static Map<FladderItemType, bool> _$types(LibrarySearchModel v) => v.types;
  static const Field<LibrarySearchModel, Map<FladderItemType, bool>> _f$types =
      Field('types', _$types, opt: true, def: const {
    FladderItemType.audio: false,
    FladderItemType.boxset: false,
    FladderItemType.book: false,
    FladderItemType.collectionFolder: false,
    FladderItemType.episode: false,
    FladderItemType.folder: false,
    FladderItemType.movie: true,
    FladderItemType.musicAlbum: false,
    FladderItemType.musicVideo: false,
    FladderItemType.photo: false,
    FladderItemType.person: false,
    FladderItemType.photoAlbum: false,
    FladderItemType.series: true,
    FladderItemType.video: true
  });
  static bool _$favourites(LibrarySearchModel v) => v.favourites;
  static const Field<LibrarySearchModel, bool> _f$favourites =
      Field('favourites', _$favourites, opt: true, def: false);
  static SortingOptions _$sortingOption(LibrarySearchModel v) =>
      v.sortingOption;
  static const Field<LibrarySearchModel, SortingOptions> _f$sortingOption =
      Field('sortingOption', _$sortingOption,
          opt: true, def: SortingOptions.name);
  static SortingOrder _$sortOrder(LibrarySearchModel v) => v.sortOrder;
  static const Field<LibrarySearchModel, SortingOrder> _f$sortOrder =
      Field('sortOrder', _$sortOrder, opt: true, def: SortingOrder.ascending);
  static bool _$hideEmptyShows(LibrarySearchModel v) => v.hideEmptyShows;
  static const Field<LibrarySearchModel, bool> _f$hideEmptyShows =
      Field('hideEmptyShows', _$hideEmptyShows, opt: true, def: true);
  static bool _$recursive(LibrarySearchModel v) => v.recursive;
  static const Field<LibrarySearchModel, bool> _f$recursive =
      Field('recursive', _$recursive, opt: true, def: false);
  static GroupBy _$groupBy(LibrarySearchModel v) => v.groupBy;
  static const Field<LibrarySearchModel, GroupBy> _f$groupBy =
      Field('groupBy', _$groupBy, opt: true, def: GroupBy.none);
  static Map<String, int> _$lastIndices(LibrarySearchModel v) => v.lastIndices;
  static const Field<LibrarySearchModel, Map<String, int>> _f$lastIndices =
      Field('lastIndices', _$lastIndices, opt: true, def: const {});
  static Map<String, int> _$libraryItemCounts(LibrarySearchModel v) =>
      v.libraryItemCounts;
  static const Field<LibrarySearchModel, Map<String, int>>
      _f$libraryItemCounts =
      Field('libraryItemCounts', _$libraryItemCounts, opt: true, def: const {});
  static bool _$fetchingItems(LibrarySearchModel v) => v.fetchingItems;
  static const Field<LibrarySearchModel, bool> _f$fetchingItems =
      Field('fetchingItems', _$fetchingItems, opt: true, def: false);

  @override
  final MappableFields<LibrarySearchModel> fields = const {
    #loading: _f$loading,
    #selecteMode: _f$selecteMode,
    #folderOverwrite: _f$folderOverwrite,
    #searchQuery: _f$searchQuery,
    #views: _f$views,
    #posters: _f$posters,
    #selectedPosters: _f$selectedPosters,
    #filters: _f$filters,
    #genres: _f$genres,
    #studios: _f$studios,
    #tags: _f$tags,
    #years: _f$years,
    #officialRatings: _f$officialRatings,
    #types: _f$types,
    #favourites: _f$favourites,
    #sortingOption: _f$sortingOption,
    #sortOrder: _f$sortOrder,
    #hideEmptyShows: _f$hideEmptyShows,
    #recursive: _f$recursive,
    #groupBy: _f$groupBy,
    #lastIndices: _f$lastIndices,
    #libraryItemCounts: _f$libraryItemCounts,
    #fetchingItems: _f$fetchingItems,
  };
  @override
  final bool ignoreNull = true;

  static LibrarySearchModel _instantiate(DecodingData data) {
    return LibrarySearchModel(
        loading: data.dec(_f$loading),
        selecteMode: data.dec(_f$selecteMode),
        folderOverwrite: data.dec(_f$folderOverwrite),
        searchQuery: data.dec(_f$searchQuery),
        views: data.dec(_f$views),
        posters: data.dec(_f$posters),
        selectedPosters: data.dec(_f$selectedPosters),
        filters: data.dec(_f$filters),
        genres: data.dec(_f$genres),
        studios: data.dec(_f$studios),
        tags: data.dec(_f$tags),
        years: data.dec(_f$years),
        officialRatings: data.dec(_f$officialRatings),
        types: data.dec(_f$types),
        favourites: data.dec(_f$favourites),
        sortingOption: data.dec(_f$sortingOption),
        sortOrder: data.dec(_f$sortOrder),
        hideEmptyShows: data.dec(_f$hideEmptyShows),
        recursive: data.dec(_f$recursive),
        groupBy: data.dec(_f$groupBy),
        lastIndices: data.dec(_f$lastIndices),
        libraryItemCounts: data.dec(_f$libraryItemCounts),
        fetchingItems: data.dec(_f$fetchingItems));
  }

  @override
  final Function instantiate = _instantiate;

  static LibrarySearchModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LibrarySearchModel>(map);
  }

  static LibrarySearchModel fromJson(String json) {
    return ensureInitialized().decodeJson<LibrarySearchModel>(json);
  }
}

mixin LibrarySearchModelMappable {
  String toJson() {
    return LibrarySearchModelMapper.ensureInitialized()
        .encodeJson<LibrarySearchModel>(this as LibrarySearchModel);
  }

  Map<String, dynamic> toMap() {
    return LibrarySearchModelMapper.ensureInitialized()
        .encodeMap<LibrarySearchModel>(this as LibrarySearchModel);
  }

  LibrarySearchModelCopyWith<LibrarySearchModel, LibrarySearchModel,
          LibrarySearchModel>
      get copyWith => _LibrarySearchModelCopyWithImpl(
          this as LibrarySearchModel, $identity, $identity);
  @override
  String toString() {
    return LibrarySearchModelMapper.ensureInitialized()
        .stringifyValue(this as LibrarySearchModel);
  }
}

extension LibrarySearchModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LibrarySearchModel, $Out> {
  LibrarySearchModelCopyWith<$R, LibrarySearchModel, $Out>
      get $asLibrarySearchModel =>
          $base.as((v, t, t2) => _LibrarySearchModelCopyWithImpl(v, t, t2));
}

abstract class LibrarySearchModelCopyWith<$R, $In extends LibrarySearchModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ItemBaseModel,
          ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>>
      get folderOverwrite;
  MapCopyWith<$R, ViewModel, bool, ObjectCopyWith<$R, bool, bool>> get views;
  ListCopyWith<$R, ItemBaseModel,
      ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>> get posters;
  ListCopyWith<$R, ItemBaseModel,
          ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>>
      get selectedPosters;
  MapCopyWith<$R, ItemFilter, bool, ObjectCopyWith<$R, bool, bool>> get filters;
  MapCopyWith<$R, String, bool, ObjectCopyWith<$R, bool, bool>> get genres;
  MapCopyWith<$R, Studio, bool, ObjectCopyWith<$R, bool, bool>> get studios;
  MapCopyWith<$R, String, bool, ObjectCopyWith<$R, bool, bool>> get tags;
  MapCopyWith<$R, int, bool, ObjectCopyWith<$R, bool, bool>> get years;
  MapCopyWith<$R, String, bool, ObjectCopyWith<$R, bool, bool>>
      get officialRatings;
  MapCopyWith<$R, FladderItemType, bool, ObjectCopyWith<$R, bool, bool>>
      get types;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>> get lastIndices;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
      get libraryItemCounts;
  $R call(
      {bool? loading,
      bool? selecteMode,
      List<ItemBaseModel>? folderOverwrite,
      String? searchQuery,
      Map<ViewModel, bool>? views,
      List<ItemBaseModel>? posters,
      List<ItemBaseModel>? selectedPosters,
      Map<ItemFilter, bool>? filters,
      Map<String, bool>? genres,
      Map<Studio, bool>? studios,
      Map<String, bool>? tags,
      Map<int, bool>? years,
      Map<String, bool>? officialRatings,
      Map<FladderItemType, bool>? types,
      bool? favourites,
      SortingOptions? sortingOption,
      SortingOrder? sortOrder,
      bool? hideEmptyShows,
      bool? recursive,
      GroupBy? groupBy,
      Map<String, int>? lastIndices,
      Map<String, int>? libraryItemCounts,
      bool? fetchingItems});
  LibrarySearchModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _LibrarySearchModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LibrarySearchModel, $Out>
    implements LibrarySearchModelCopyWith<$R, LibrarySearchModel, $Out> {
  _LibrarySearchModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LibrarySearchModel> $mapper =
      LibrarySearchModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ItemBaseModel,
          ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>>
      get folderOverwrite => ListCopyWith($value.folderOverwrite,
          (v, t) => v.copyWith.$chain(t), (v) => call(folderOverwrite: v));
  @override
  MapCopyWith<$R, ViewModel, bool, ObjectCopyWith<$R, bool, bool>> get views =>
      MapCopyWith($value.views, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(views: v));
  @override
  ListCopyWith<$R, ItemBaseModel,
          ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>>
      get posters => ListCopyWith($value.posters,
          (v, t) => v.copyWith.$chain(t), (v) => call(posters: v));
  @override
  ListCopyWith<$R, ItemBaseModel,
          ItemBaseModelCopyWith<$R, ItemBaseModel, ItemBaseModel>>
      get selectedPosters => ListCopyWith($value.selectedPosters,
          (v, t) => v.copyWith.$chain(t), (v) => call(selectedPosters: v));
  @override
  MapCopyWith<$R, ItemFilter, bool, ObjectCopyWith<$R, bool, bool>>
      get filters => MapCopyWith($value.filters,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(filters: v));
  @override
  MapCopyWith<$R, String, bool, ObjectCopyWith<$R, bool, bool>> get genres =>
      MapCopyWith($value.genres, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(genres: v));
  @override
  MapCopyWith<$R, Studio, bool, ObjectCopyWith<$R, bool, bool>> get studios =>
      MapCopyWith($value.studios, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(studios: v));
  @override
  MapCopyWith<$R, String, bool, ObjectCopyWith<$R, bool, bool>> get tags =>
      MapCopyWith($value.tags, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(tags: v));
  @override
  MapCopyWith<$R, int, bool, ObjectCopyWith<$R, bool, bool>> get years =>
      MapCopyWith($value.years, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(years: v));
  @override
  MapCopyWith<$R, String, bool, ObjectCopyWith<$R, bool, bool>>
      get officialRatings => MapCopyWith(
          $value.officialRatings,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(officialRatings: v));
  @override
  MapCopyWith<$R, FladderItemType, bool, ObjectCopyWith<$R, bool, bool>>
      get types => MapCopyWith($value.types,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(types: v));
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>> get lastIndices =>
      MapCopyWith($value.lastIndices, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(lastIndices: v));
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
      get libraryItemCounts => MapCopyWith(
          $value.libraryItemCounts,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(libraryItemCounts: v));
  @override
  $R call(
          {bool? loading,
          bool? selecteMode,
          List<ItemBaseModel>? folderOverwrite,
          String? searchQuery,
          Map<ViewModel, bool>? views,
          List<ItemBaseModel>? posters,
          List<ItemBaseModel>? selectedPosters,
          Map<ItemFilter, bool>? filters,
          Map<String, bool>? genres,
          Map<Studio, bool>? studios,
          Map<String, bool>? tags,
          Map<int, bool>? years,
          Map<String, bool>? officialRatings,
          Map<FladderItemType, bool>? types,
          bool? favourites,
          SortingOptions? sortingOption,
          SortingOrder? sortOrder,
          bool? hideEmptyShows,
          bool? recursive,
          GroupBy? groupBy,
          Map<String, int>? lastIndices,
          Map<String, int>? libraryItemCounts,
          bool? fetchingItems}) =>
      $apply(FieldCopyWithData({
        if (loading != null) #loading: loading,
        if (selecteMode != null) #selecteMode: selecteMode,
        if (folderOverwrite != null) #folderOverwrite: folderOverwrite,
        if (searchQuery != null) #searchQuery: searchQuery,
        if (views != null) #views: views,
        if (posters != null) #posters: posters,
        if (selectedPosters != null) #selectedPosters: selectedPosters,
        if (filters != null) #filters: filters,
        if (genres != null) #genres: genres,
        if (studios != null) #studios: studios,
        if (tags != null) #tags: tags,
        if (years != null) #years: years,
        if (officialRatings != null) #officialRatings: officialRatings,
        if (types != null) #types: types,
        if (favourites != null) #favourites: favourites,
        if (sortingOption != null) #sortingOption: sortingOption,
        if (sortOrder != null) #sortOrder: sortOrder,
        if (hideEmptyShows != null) #hideEmptyShows: hideEmptyShows,
        if (recursive != null) #recursive: recursive,
        if (groupBy != null) #groupBy: groupBy,
        if (lastIndices != null) #lastIndices: lastIndices,
        if (libraryItemCounts != null) #libraryItemCounts: libraryItemCounts,
        if (fetchingItems != null) #fetchingItems: fetchingItems
      }));
  @override
  LibrarySearchModel $make(CopyWithData data) => LibrarySearchModel(
      loading: data.get(#loading, or: $value.loading),
      selecteMode: data.get(#selecteMode, or: $value.selecteMode),
      folderOverwrite: data.get(#folderOverwrite, or: $value.folderOverwrite),
      searchQuery: data.get(#searchQuery, or: $value.searchQuery),
      views: data.get(#views, or: $value.views),
      posters: data.get(#posters, or: $value.posters),
      selectedPosters: data.get(#selectedPosters, or: $value.selectedPosters),
      filters: data.get(#filters, or: $value.filters),
      genres: data.get(#genres, or: $value.genres),
      studios: data.get(#studios, or: $value.studios),
      tags: data.get(#tags, or: $value.tags),
      years: data.get(#years, or: $value.years),
      officialRatings: data.get(#officialRatings, or: $value.officialRatings),
      types: data.get(#types, or: $value.types),
      favourites: data.get(#favourites, or: $value.favourites),
      sortingOption: data.get(#sortingOption, or: $value.sortingOption),
      sortOrder: data.get(#sortOrder, or: $value.sortOrder),
      hideEmptyShows: data.get(#hideEmptyShows, or: $value.hideEmptyShows),
      recursive: data.get(#recursive, or: $value.recursive),
      groupBy: data.get(#groupBy, or: $value.groupBy),
      lastIndices: data.get(#lastIndices, or: $value.lastIndices),
      libraryItemCounts:
          data.get(#libraryItemCounts, or: $value.libraryItemCounts),
      fetchingItems: data.get(#fetchingItems, or: $value.fetchingItems));

  @override
  LibrarySearchModelCopyWith<$R2, LibrarySearchModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LibrarySearchModelCopyWithImpl($value, $cast, t);
}
