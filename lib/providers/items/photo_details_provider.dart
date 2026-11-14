import 'package:chopper/chopper.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final photoDetailsProvider =
    StateNotifierProvider.autoDispose.family<PhotoDetailsNotifier, PhotoAlbumModel?, String>((ref, id) {
  return PhotoDetailsNotifier(ref);
});

class PhotoDetailsNotifier extends StateNotifier<PhotoAlbumModel?> {
  PhotoDetailsNotifier(this.ref) : super(null);

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response?> fetchDetails(ItemBaseModel item) async {
    String? albumId;
    if (item is PhotoModel) {
      albumId = item.albumId;
    } else if (item is PhotoAlbumModel) {
      albumId = item.id;
    }

    final albumData = await api.usersUserIdItemsItemIdGet(itemId: albumId);
    if (albumData.body == null) return albumData;
    PhotoAlbumModel newState = albumData.bodyOrThrow as PhotoAlbumModel;
    final response = await api.itemsGet(
      parentId: albumId,
      fields: [ItemFields.primaryimageaspectratio],
      sortBy: [ItemSortBy.sortname],
      includeItemTypes: [
        BaseItemKind.folder,
        BaseItemKind.photoalbum,
        BaseItemKind.photo,
        BaseItemKind.video,
      ],
      sortOrder: [SortOrder.ascending],
    );
    if (response.body == null) return null;
    newState = newState.copyWith(photos: response.body?.items.toList());
    state = newState;
    return null;
  }
}
