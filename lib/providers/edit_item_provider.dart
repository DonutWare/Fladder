import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/item_editing_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/screens/metadata/edit_item.dart';

final editItemProvider =
    StateNotifierProvider.autoDispose<EditItemNotifier, ItemEditingModel>((ref) => EditItemNotifier(ref));

class EditItemNotifier extends StateNotifier<ItemEditingModel> {
  EditItemNotifier(this.ref) : super(ItemEditingModel());

  final Ref ref;

  late final api = ref.read(jellyApiProvider);

  Map<String, dynamic>? get getFields => state.editAbleFields();
  Map<String, dynamic>? get advancedFields => state.editAdvancedAbleFields(ref);

  Future<void> fetchInformation(String id) async {
    state = ItemEditingModel();
    final itemResponse = await api.usersUserIdItemsItemIdGet(
      itemId: id,
    );
    final itemModel = itemResponse.body;
    if (itemModel == null) return;
    final images = await api.itemsItemIdImagesGet(itemId: itemModel.id);

    state = state.copyWith(
      item: () => itemModel,
      json: () => jsonDecode(itemResponse.bodyString),
      editedJson: () => jsonDecode(itemResponse.bodyString),
      primary: state.primary.copyWith(
        serverImages: images.body
            ?.where((element) => element.imageType == ImageType.primary)
            .map((e) => EditingImageModel.fromImage(e, itemModel.id, ref))
            .toList(),
      ),
      logo: state.logo.copyWith(
        serverImages: images.body
            ?.where((element) => element.imageType == ImageType.logo)
            .map((e) => EditingImageModel.fromImage(e, itemModel.id, ref))
            .toList(),
      ),
      backdrop: state.backdrop.copyWith(
        serverImages: images.body
            ?.where((element) => element.imageType == ImageType.backdrop)
            .map((e) => EditingImageModel.fromImage(e, itemModel.id, ref))
            .toList(),
      ),
    );
    final response = await api.itemsItemIdMetadataEditorGet(itemId: id);
    state = state.copyWith(
      editorInfo: () => response.bodyOrThrow,
    );
  }

  Future<Response<dynamic>?> fetchRemoteImages({ImageType type = ImageType.primary}) async {
    final currentItem = state.item;
    if (currentItem == null) return null;
    final response = await api.itemsItemIdRemoteImagesGet(
      itemId: currentItem.id,
      type: type,
      includeAllLanguages: state.includeAllImages,
    );
    final newImages = (response.body?.images ?? []).map((e) => EditingImageModel.fromDto(e)).toList();
    switch (type) {
      case ImageType.backdrop:
        state = state.copyWith(backdrop: state.backdrop.copyWith(images: newImages));
      case ImageType.logo:
        state = state.copyWith(logo: state.logo.copyWith(images: newImages));
      case ImageType.primary:
      default:
        state = state.copyWith(primary: state.primary.copyWith(images: newImages));
    }
    return response;
  }

  Future<void> updateField(MapEntry<String, dynamic> field) async {
    final editedJson = state.editedJson;
    editedJson?.update(
      field.key,
      (value) => field.value,
      ifAbsent: () => editedJson.addEntries({field}),
    );

    state = state.copyWith(
      editedJson: () => editedJson,
    );
  }

  Future<void> resetChanged() async {
    state = state.copyWith(
      editedJson: () => state.json,
    );
  }

  Future<Response<ItemBaseModel>?> saveInformation(Set<MetaEditOptions> options) async {
    final currentItem = state.item;
    if (currentItem == null) return null;
    final jsonBody = state.editedJson;
    if (jsonBody == null) return null;
    state = state.copyWith(saving: true);
    Response<dynamic>? response;
    if (options.contains(MetaEditOptions.general)) {
      response = await api.itemsItemIdPost(
        itemId: currentItem.id,
        body: BaseItemDto.fromJson(jsonBody),
      );
    }

    if (options.contains(MetaEditOptions.primary)) {
      await state.primary.setImage(
        ImageType.primary,
        uploadData: uploadImage,
        uploadUrl: _setImage,
      );
    }
    if (options.contains(MetaEditOptions.logo)) {
      await state.logo.setImage(
        ImageType.logo,
        uploadData: uploadImage,
        uploadUrl: _setImage,
      );
    }

    if (options.contains(MetaEditOptions.backdrops)) {
      await state.backdrop.setImage(
        ImageType.backdrop,
        uploadData: uploadImage,
        uploadUrl: _setImage,
      );
    }

    final newItem = await api.usersUserIdItemsItemIdGet(itemId: currentItem.id);

    state = state.copyWith(saving: false);
    return response?.copyWith(body: newItem.body);
  }

  Future<Response<dynamic>?> uploadImage(EditingImageModel? imageModel) async {
    final currentItem = state.item;
    if (currentItem == null || imageModel == null) return null;
    final response = await api.itemIdImagesImageTypePost(
      imageModel.type,
      currentItem.id,
      imageModel.imageData!,
    );
    return response;
  }

  Future<Response<dynamic>?> _setImage(EditingImageModel? imageModel) async {
    final currentItem = state.item;
    if (currentItem == null) return null;
    if (imageModel == null) return null;
    return await api.itemsItemIdRemoteImagesDownloadPost(
      itemId: state.item?.id,
      type: imageModel.type,
      imageUrl: imageModel.url,
    );
  }

  void selectImage(ImageType type, EditingImageModel? image) {
    switch (type) {
      case ImageType.primary:
        state = state.copyWith(
            primary: state.primary.copyWith(selected: () => state.primary.selected == image ? null : image));
      case ImageType.logo:
        state = state.copyWith(logo: state.logo.copyWith(selected: () => state.logo.selected == image ? null : image));
      default:
        if (image == null) return;
        state = state.copyWith(
          backdrop: state.backdrop.copyWith(
            selection: state.backdrop.selection.contains(image)
                ? (List.of(state.backdrop.selection)..remove(image))
                : [...state.backdrop.selection, image],
          ),
        );
        return;
    }
  }

  void setIncludeImages(bool value) => state = state.copyWith(includeAllImages: value);

  void addCustomImages(ImageType type, Iterable<EditingImageModel> list) {
    switch (type) {
      case ImageType.primary:
        state = state.copyWith(
          primary: state.primary.copyWith(
            customImages: [...state.primary.customImages, ...list],
            selected: () => list.firstOrNull,
          ),
        );
        return;
      case ImageType.logo:
        state = state.copyWith(
          logo: state.logo.copyWith(
            customImages: [...state.logo.customImages, ...list],
            selected: () => list.firstOrNull,
          ),
        );
        return;
      case ImageType.backdrop:
        state = state.copyWith(
          backdrop: state.backdrop.copyWith(
              customImages: [...state.backdrop.customImages, ...list],
              selection: [...state.backdrop.selection, ...list]),
        );
      default:
        return;
    }
  }

  Future<Response<dynamic>?> deleteImage(ImageType type, EditingImageModel image) async {
    final currentItem = state.item;
    if (currentItem == null) return null;
    final response = await api.itemsItemIdImagesImageTypeDelete(
      itemId: state.item?.id,
      imageType: type,
      imageIndex: image.index,
    );
    switch (type) {
      case ImageType.primary:
        state = state.copyWith(
          primary: state.primary
              .copyWith(serverImages: state.primary.serverImages..removeWhere((element) => element == image)),
        );
      case ImageType.logo:
        state = state.copyWith(
          logo: state.logo.copyWith(serverImages: state.logo.serverImages..removeWhere((element) => element == image)),
        );
      case ImageType.backdrop:
        state = state.copyWith(
          backdrop: state.backdrop
              .copyWith(serverImages: state.backdrop.serverImages..removeWhere((element) => element == image)),
        );
      default:
    }
    return response;
  }
}
