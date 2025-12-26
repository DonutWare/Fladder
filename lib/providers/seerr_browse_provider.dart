import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/seerr/seerr_search_model.dart';
import 'package:fladder/providers/seerr_api_provider.dart';

part 'seerr_browse_provider.freezed.dart';
part 'seerr_browse_provider.g.dart';

@riverpod
class SeerrSearch extends _$SeerrSearch {
  @override
  SeerrSearchModel build() => SeerrSearchModel();

  void setQuery(String value) {
    state = state.copyWith(query: value);
  }

  Future<void> submit([String? value]) async {
    final query = (value ?? state.query).trim();
    state = state.copyWith(query: query);
    if (query.isEmpty) {
      state = state.copyWith(results: []);
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final api = ref.read(seerrApiProvider);
      final items = await api.searchPosters(query: query);

      state = state.copyWith(results: items, isLoading: false);
    } catch (error, _) {
      state = state.copyWith(results: [], isLoading: false);
    }
  }
}

@Freezed(copyWith: true)
abstract class SeerrSearchModel with _$SeerrSearchModel {
  factory SeerrSearchModel({
    @Default("") String query,
    @Default([]) List<SeerrSearchResultItem> results,
    @Default(false) bool isLoading,
  }) = _SeerrSearchModel;
}
