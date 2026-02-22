import 'package:flutter/widgets.dart';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/api_result.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

class IdentifyModel {
  final ItemBaseModel? item;
  final String searchString;
  final List<ExternalIdInfo> externalIds;
  final Map<String, String> keys;
  final List<RemoteSearchResult> results;
  final int? year;
  final bool replaceAllImages;
  final bool processing;
  IdentifyModel({
    this.item,
    this.searchString = "",
    this.externalIds = const [],
    this.keys = const {},
    this.results = const [],
    this.year,
    this.replaceAllImages = true,
    this.processing = false,
  });

  Map<String, dynamic> get body => {
        "SearchInfo": {
          "ProviderIds": keys,
          "Name": searchString,
          "Year": year,
        },
        "ItemId": item?.id,
      }..removeWhere((key, value) => value == null);

  IdentifyModel copyWith({
    ValueGetter<ItemBaseModel?>? item,
    String? searchString,
    List<ExternalIdInfo>? externalIds,
    Map<String, String>? keys,
    List<RemoteSearchResult>? results,
    ValueGetter<int?>? year,
    bool? replaceAllImages,
    bool? processing,
  }) {
    return IdentifyModel(
      item: item != null ? item() : this.item,
      searchString: searchString ?? this.searchString,
      externalIds: externalIds ?? this.externalIds,
      keys: keys ?? this.keys,
      results: results ?? this.results,
      year: year != null ? year() : this.year,
      replaceAllImages: replaceAllImages ?? this.replaceAllImages,
      processing: processing ?? this.processing,
    );
  }
}

final simpleProviderProvider = StateProvider<String>((ref) {
  return "";
});

final identifyProvider = StateNotifierProvider.autoDispose.family<IdentifyNotifier, IdentifyModel, String>((ref, id) {
  return IdentifyNotifier(ref, id);
});

class IdentifyNotifier extends StateNotifier<IdentifyModel> {
  IdentifyNotifier(this.ref, this.id) : super(IdentifyModel());

  final String id;
  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<void> fetchInformation() async {
    state = state.copyWith(processing: true);
    final item = await api.usersUserIdItemsItemIdGet(itemId: id);
    final itemModel = item.bodyOrThrow;
    final response = await api.itemsItemIdExternalIdInfosGet(itemId: id);
    state = state.copyWith(
      item: () => itemModel,
      externalIds: response.body,
      searchString: itemModel.name,
      year: () => itemModel.overview.yearAired,
      keys: {for (var element in response.body ?? []) (element as ExternalIdInfo).key ?? "": ""},
    );
    state = state.copyWith(processing: false);
  }

  IdentifyModel update(IdentifyModel Function(IdentifyModel state) cb) => state = cb(state);

  void clearFields() {
    state = state.copyWith(
      searchString: "",
      year: () => null,
      keys: state.keys..updateAll((key, value) => ""),
    );
  }

  void updateKey(MapEntry<String, String> map) {
    state = state.copyWith(keys: state.keys..update(map.key, (value) => map.value));
  }

  Future<Response<List<RemoteSearchResult>>?> remoteSearch() async {
    if (state.item == null) return null;
    state = state.copyWith(processing: true);
    late Response<List<RemoteSearchResult>> response;
    switch (state.item) {
      case SeriesModel _:
        response = await api.itemsRemoteSearchSeriesPost(body: SeriesInfoRemoteSearchQuery.fromJson(state.body));
      case MovieModel _:
      default:
        response = await api.itemsRemoteSearchMoviePost(body: MovieInfoRemoteSearchQuery.fromJson(state.body));
    }
    state = state.copyWith(results: response.body, processing: false);
    return response;
  }

  Future<ApiResult<dynamic>?> setIdentity(RemoteSearchResult result) async {
    if (state.item == null) return null;
    state = state.copyWith(processing: true);
    final response = await api.itemsRemoteSearchApplyItemIdPost(
        itemId: state.item?.id ?? "", body: RemoteSearchResult.fromJson(result.toJson()));
    state = state.copyWith(processing: false);
    return response.apiResult;
  }
}
