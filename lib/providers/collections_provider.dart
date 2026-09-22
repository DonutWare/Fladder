import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/boxset_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/util/map_bool_helper.dart';

final collectionStateProvider = StateProvider<List<BoxSetModel>>((ref) => []);

class _CollectionSetModel {
  final bool isLoading;
  final List<ItemBaseModel> items;
  final Map<BoxSetModel, bool?> collections;
  _CollectionSetModel({
    this.isLoading = false,
    required this.items,
    required this.collections,
  });

  _CollectionSetModel copyWith({
    bool? isLoading,
    List<ItemBaseModel>? items,
    Map<BoxSetModel, bool?>? collections,
  }) {
    return _CollectionSetModel(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      collections: collections ?? this.collections,
    );
  }
}

final collectionsProvider = StateNotifierProvider.autoDispose<BoxSetNotifier, _CollectionSetModel>((ref) {
  final notifier = BoxSetNotifier(ref)..setItems([]);
  return notifier;
});

class BoxSetNotifier extends StateNotifier<_CollectionSetModel> {
  BoxSetNotifier(this.ref) : super(_CollectionSetModel(items: [], collections: {}));
  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<void> setItems(List<ItemBaseModel> items) async {
    final collections = ref.read(collectionStateProvider);
    state = state.copyWith(
      collections: Map.fromIterables(collections, List.generate(collections.length, (index) => null)),
      items: items,
      isLoading: true,
    );
    return _init();
  }

  Future<void> _init() async {
    final collections = await api.usersUserIdItemsGet(
      recursive: true,
      includeItemTypes: [
        BaseItemKind.boxset,
      ],
    );

    final boxSets = collections.body?.items?.map((e) => BoxSetModel.fromBaseDto(e, ref)).toList();

    ref.read(collectionStateProvider.notifier).state = boxSets ?? [];

    state = state.copyWith(
      collections: Map.fromIterables(boxSets ?? [], List.generate(boxSets?.length ?? 0, (index) => null)),
    );

    for (final boxSet in boxSets ?? []) {
      final itemList = await api.usersUserIdItemsGet(
        parentId: boxSet.id,
      );
      state = state.copyWith(
        collections: state.collections
            .setKey(boxSet, itemList.body?.items?.map((e) => e.id).contains(state.items.firstOrNull?.id) ?? false),
      );
    }

    state = state.copyWith(isLoading: false);
  }

  Future<Response> toggleCollection(
      {required BoxSetModel boxSet, required bool value, required ItemBaseModel item}) async {
    final Response response = value
        ? await api.collectionsCollectionIdItemsPost(collectionId: boxSet.id, ids: [item.id])
        : await api.collectionsCollectionIdItemsDelete(collectionId: boxSet.id, ids: [item.id]);

    if (response.isSuccessful) {
      state = state.copyWith(collections: state.collections.setKey(boxSet, response.isSuccessful ? value : !value));
    }
    return response;
  }

  Future<Response> addToCollection({required BoxSetModel boxSet, required bool add}) async {
    final response = add
        ? await api.collectionsCollectionIdItemsPost(
            collectionId: boxSet.id, ids: state.items.map((e) => e.id).toList())
        : await api.collectionsCollectionIdItemsDelete(
            collectionId: boxSet.id, ids: state.items.map((e) => e.id).toList());

    if (response.isSuccessful) {
      state = state.copyWith(collections: state.collections.setKey(boxSet, response.isSuccessful ? add : !add));
    }
    return response;
  }

  Future<void> addToNewCollection({required String name}) async {
    final result = await api.collectionsPost(name: name, ids: state.items.map((e) => e.id).toList());
    if (result.isSuccessful) {
      await _init();
    }
  }
}
