import 'package:chopper/chopper.dart';
import 'package:fladder/models/search_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, SearchModel>((ref) {
  return SearchNotifier(ref);
});

class SearchNotifier extends StateNotifier<SearchModel> {
  SearchNotifier(this.ref) : super(SearchModel());

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response?> searchQuery() async {
    if (state.searchQuery.isEmpty) return null;
    state = state.copyWith(loading: true);
    final response = await api.itemsGet(
      recursive: true,
      searchTerm: state.searchQuery,
    );

    state = state.copyWith(
      resultCount: response.body?.totalRecordCount ?? 0,
      results: (response.body?.items)?.groupedItems,
    );
    state = state.copyWith(loading: false);
    return response;
  }

  void setQuery(String searchQuery) {
    state = state.copyWith(searchQuery: searchQuery);
  }

  void clear() {
    state = SearchModel();
  }
}
