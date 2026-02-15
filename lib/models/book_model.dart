import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/overview_model.dart';

class BookModel extends ItemBaseModel {
  final String? parentName;
  final List<ItemBaseModel> items;
  BookModel(
      {this.items = const [],
      required this.parentName,
      required super.name,
      required super.id,
      required super.overview,
      required super.parentId,
      required super.playlistId,
      required super.images,
      required super.childCount,
      required super.primaryRatio,
      required super.userData,
      super.jellyType,
      required super.canDownload,
      required super.canDelete});

  @override
  String? get subText => parentName;

  @override
  String? detailedName(AppLocalizations l10n) => "$name ${parentName != null ? "\n ($parentName)" : ""} ";

  @override
  ItemBaseModel get parentBaseModel => copyWith(id: parentId);

  @override
  bool get playAble => true;

  int get currentPage => userData.playbackPositionTicks ~/ 10000;

  @override
  String playText(AppLocalizations l10n) => l10n.read(name);

  @override
  double get progress => userData.progress != 0 ? 100 : 0;

  @override
  String? unplayedLabel(AppLocalizations l10n) => userData.progress != 0 ? l10n.page(currentPage) : null;

  @override
  String playButtonLabel(AppLocalizations l10n) => progress != 0
      ? l10n.continuePage(currentPage)
      : userData.played == true
          ? "${l10n.restart} $name"
          : l10n.read(name);

  factory BookModel.fromBaseDto(BaseItemDto item, Ref? ref) {
    return BookModel(
      name: item.name ?? "",
      id: item.id ?? "",
      parentName: item.seriesName ?? item.seasonName,
      childCount: item.childCount,
      overview: OverviewModel.fromBaseItemDto(item, ref),
      userData: UserData.fromDto(item.userData),
      parentId: item.parentId,
      playlistId: item.playlistItemId,
      images: ref != null ? ImagesData.fromBaseItem(item, ref) : null,
      canDelete: item.canDelete,
      canDownload: item.canDownload,
      primaryRatio: item.primaryImageAspectRatio,
    );
  }
}
