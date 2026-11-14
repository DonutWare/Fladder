import 'package:chopper/chopper.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/folder_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final folderDetailsProvider =
    StateNotifierProvider.autoDispose.family<FolderDetailsNotifier, FolderModel?, String>((ref, id) {
  return FolderDetailsNotifier(ref);
});

class FolderDetailsNotifier extends StateNotifier<FolderModel?> {
  FolderDetailsNotifier(this.ref) : super(null);

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response?> fetchDetails(String id) async {
    if (state == null) {
      final folderItem = await api.usersUserIdItemsItemIdGet(itemId: id);

      if (folderItem.body != null) {
        state = folderItem.bodyOrThrow as FolderModel;
      }
    }

    final response = await api.itemsGet(
      parentId: id,
      sortBy: [ItemSortBy.sortname, ItemSortBy.name],
      sortOrder: [SortOrder.ascending],
      fields: [
        ItemFields.primaryimageaspectratio,
        ItemFields.childcount,
      ],
    );

    state = state?.copyWith(items: response.body?.items.where((element) => element.childCount != 0).toList());
    return response;
  }
}
