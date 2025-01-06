import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as jelly;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/providers/image_provider.dart';

class EditItemsProvider {
  final List<EditingImageModel> serverImages;
  final List<EditingImageModel> images;
  final List<EditingImageModel> customImages;
  final EditingImageModel? selected;
  final List<EditingImageModel> selection;
  const EditItemsProvider({
    this.serverImages = const [],
    this.images = const [],
    this.customImages = const [],
    this.selected,
    this.selection = const [],
  });

  Future<void> setImage(
    jelly.ImageType type, {
    required Function(EditingImageModel? imageModel) uploadData,
    required Function(EditingImageModel? imageModel) uploadUrl,
  }) async {
    switch (type) {
      case jelly.ImageType.primary:
      case jelly.ImageType.logo:
        {
          if (selected == null) return;
          if (selected?.imageData != null) {
            await uploadData(selected!.copyWith(type: type));
          } else if (selected?.url != null) {
            await uploadUrl(selected!.copyWith(type: type));
          }
        }
      case jelly.ImageType.backdrop:
        {
          for (var element in selection) {
            if (element.imageData != null) {
              await uploadData(element.copyWith(type: type));
            } else if (element.url != null) {
              await uploadUrl(element.copyWith(type: type));
            }
          }
        }
      default:
    }
    return;
  }

  EditItemsProvider copyWith({
    List<EditingImageModel>? serverImages,
    List<EditingImageModel>? images,
    List<EditingImageModel>? customImages,
    ValueGetter<EditingImageModel?>? selected,
    List<EditingImageModel>? selection,
  }) {
    return EditItemsProvider(
      serverImages: serverImages ?? this.serverImages,
      images: images ?? this.images,
      customImages: customImages ?? this.customImages,
      selected: selected != null ? selected() : this.selected,
      selection: selection ?? this.selection,
    );
  }
}

class ItemEditingModel {
  final ItemBaseModel? item;
  final jelly.MetadataEditorInfo? editorInfo;
  final Map<String, dynamic>? json;
  final Map<String, dynamic>? editedJson;
  final bool includeAllImages;
  final EditItemsProvider primary;
  final EditItemsProvider logo;
  final EditItemsProvider backdrop;
  final bool saving;
  ItemEditingModel({
    this.item,
    this.editorInfo,
    this.json,
    this.editedJson,
    this.includeAllImages = false,
    this.primary = const EditItemsProvider(),
    this.logo = const EditItemsProvider(),
    this.backdrop = const EditItemsProvider(),
    this.saving = false,
  });

  Map<String, dynamic>? editAbleFields() {
    return editedJson == null
        ? {}
        : {
            "Name": editedJson?["Name"] as String?,
            "OriginalTitle": editedJson?["OriginalTitle"] as String?,
            "PremiereDate": editedJson?["PremiereDate"] != null ? DateTime.tryParse(editedJson!["PremiereDate"]) : null,
            "DateCreated": editedJson?["DateCreated"] != null ? DateTime.tryParse(editedJson!["DateCreated"]) : null,
            "ProductionYear": editedJson?["ProductionYear"] as int?,
            "Path": editedJson?["Path"] as String?,
            "Overview": editedJson?["Overview"] as String? ?? "",
          }
      ..removeWhere((key, value) => value == null);
  }

  Map<String, dynamic>? editAdvancedAbleFields(Ref ref) => editedJson == null
      ? {}
      : {
          if (item is SeriesModel) "DisplayOrder": DisplayOrder.fromMap(editedJson?["DisplayOrder"]),
          if (item is SeriesModel) ...{
            "OfficialRating": {
              for (String element in (editorInfo?.parentalRatingOptions?.map((e) => e.name).toSet()
                        ?..add(json?["OfficialRating"] as String?))
                      ?.nonNulls
                      .toList() ??
                  [])
                element: (editedJson?["OfficialRating"] as String?) == element
            },
            "CustomRating": {
              for (String element in (editorInfo?.parentalRatingOptions?.map((e) => e.name).toSet()
                        ?..add(json?["CustomRating"] as String?))
                      ?.nonNulls
                      .toList() ??
                  [])
                element: (editedJson?["CustomRating"] as String?) == element
            },
          },
          "People": editedJson?["People"] != null
              ? (editedJson!["People"] as List<dynamic>)
                  .map((e) => Person.fromBasePerson(jelly.BaseItemPerson.fromJson(e), ref))
                  .toList()
              : null,
          "ExternalUrls": editedJson?["ExternalUrls"] != null
              ? (editedJson!["ExternalUrls"] as List<dynamic>).map((e) => ExternalUrls.fromMap(e)).toList()
              : null,
          "CommunityRating": double.tryParse((editedJson?["CommunityRating"] as num?).toString()),
          "SeriesName": editedJson?["SeriesName"] as String?,
          "IndexNumber": editedJson?["IndexNumber"] as int?,
          "RunTimeTicks": (editedJson?["RunTimeTicks"] == null)
              ? null
              : Duration(milliseconds: editedJson?["RunTimeTicks"] ~/ 10000),
          "ParentIndexNumber": editedJson?["ParentIndexNumber"] as int?,
          if (item is SeriesModel) "Status": ShowStatus.fromMap(editedJson?["Status"] as String?),
          "Genres": editedJson?["Genres"] != null ? (List<String>.from(editedJson!["Genres"])) : null,
          "Tags": editedJson?["Tags"] != null ? (List<String>.from(editedJson?["Tags"])) : null,
          "Studios": editedJson?["Studios"] != null
              ? (editedJson!["Studios"] as List<dynamic>).map((e) => Studio.fromMap(e)).toList()
              : null,
          "SeriesStudio": editedJson?["SeriesStudio"] as String?,
          "LockData": editedJson?["LockData"] as bool? ?? false,
          "LockedFields": ((editedJson?["LockData"] as bool?) == false)
              ? EditorLockedFields.enabled(List<String>.from(editedJson?["LockedFields"]))
              : null,
        }
    ..removeWhere((key, value) => value == null);

  ItemEditingModel copyWith({
    ValueGetter<ItemBaseModel?>? item,
    ValueGetter<jelly.MetadataEditorInfo?>? editorInfo,
    ValueGetter<Map<String, dynamic>?>? json,
    ValueGetter<Map<String, dynamic>?>? editedJson,
    bool? includeAllImages,
    EditItemsProvider? primary,
    EditItemsProvider? logo,
    EditItemsProvider? backdrop,
    bool? saving,
  }) {
    return ItemEditingModel(
      item: item != null ? item() : this.item,
      editorInfo: editorInfo != null ? editorInfo() : this.editorInfo,
      json: json != null ? json() : this.json,
      editedJson: editedJson != null ? editedJson() : this.editedJson,
      includeAllImages: includeAllImages ?? this.includeAllImages,
      primary: primary ?? this.primary,
      logo: logo ?? this.logo,
      backdrop: backdrop ?? this.backdrop,
      saving: saving ?? this.saving,
    );
  }
}

class EditingImageModel {
  final String providerName;
  final String? url;
  final Uint8List? imageData;
  final int? index;
  final int height;
  final int width;
  final double communityRating;
  final int voteCount;
  final String language;
  final jelly.ImageType type;
  final jelly.RatingType ratingType;
  EditingImageModel({
    required this.providerName,
    this.url,
    this.imageData,
    this.index,
    this.height = 0,
    this.width = 0,
    this.communityRating = 0.0,
    this.voteCount = 0,
    this.language = "",
    this.type = jelly.ImageType.primary,
    this.ratingType = jelly.RatingType.likes,
  });

  double get ratio {
    if (width == 0 && height == 0) return 1;
    final ratio = (width.toDouble() / height.toDouble()).clamp(0.1, 5).toDouble();
    if (ratio < 0) {
      return 1;
    } else {
      return ratio;
    }
  }

  factory EditingImageModel.fromDto(jelly.RemoteImageInfo info) {
    return EditingImageModel(
      providerName: info.providerName ?? "",
      url: info.url ?? "",
      height: info.height ?? 0,
      width: info.width ?? 0,
      communityRating: info.communityRating ?? 0.0,
      voteCount: info.voteCount ?? 0,
      language: info.language ?? "",
      type: info.type ?? jelly.ImageType.primary,
      ratingType: info.ratingType ?? jelly.RatingType.likes,
    );
  }

  factory EditingImageModel.fromImage(jelly.ImageInfo info, String itemId, Ref ref) {
    return EditingImageModel(
      providerName: "",
      url: switch (info.imageType ?? ImageType.primary) {
        ImageType.backdrop => ref.read(imageUtilityProvider).getBackdropOrigImage(
              itemId,
              info.imageIndex ?? 0,
              info.hashCode.toString(),
            ),
        _ => ref.read(imageUtilityProvider).getItemsOrigImageUrl(
              itemId,
              type: info.imageType ?? ImageType.primary,
            ),
      },
      index: info.imageIndex,
      height: info.height ?? 0,
      width: info.width ?? 0,
      type: info.imageType ?? ImageType.primary,
    );
  }

  EditingImageModel copyWith({
    String? providerName,
    ValueGetter<String?>? url,
    ValueGetter<Uint8List?>? imageData,
    ValueGetter<int?>? index,
    int? height,
    int? width,
    double? communityRating,
    int? voteCount,
    String? language,
    jelly.ImageType? type,
    jelly.RatingType? ratingType,
  }) {
    return EditingImageModel(
      providerName: providerName ?? this.providerName,
      url: url != null ? url() : this.url,
      imageData: imageData != null ? imageData() : this.imageData,
      index: index != null ? index() : this.index,
      height: height ?? this.height,
      width: width ?? this.width,
      communityRating: communityRating ?? this.communityRating,
      voteCount: voteCount ?? this.voteCount,
      language: language ?? this.language,
      type: type ?? this.type,
      ratingType: ratingType ?? this.ratingType,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditingImageModel &&
        other.providerName == providerName &&
        other.url == url &&
        other.imageData == imageData &&
        other.height == height &&
        other.width == width &&
        other.communityRating == communityRating &&
        other.voteCount == voteCount &&
        other.language == language &&
        other.type == type &&
        other.ratingType == ratingType;
  }

  @override
  int get hashCode {
    return providerName.hashCode ^
        url.hashCode ^
        imageData.hashCode ^
        height.hashCode ^
        width.hashCode ^
        communityRating.hashCode ^
        voteCount.hashCode ^
        language.hashCode ^
        type.hashCode ^
        ratingType.hashCode;
  }
}
