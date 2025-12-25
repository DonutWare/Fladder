import 'dart:async';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/collection_types.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_button.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class ViewModel {
  final String name;
  final String id;
  final String serverId;
  final DateTime dateCreated;
  final bool canDelete;
  final bool canDownload;
  final String parentId;
  final CollectionType collectionType;
  final dto.PlayAccess playAccess;
  final List<ItemBaseModel> recentlyAdded;
  final ImagesData? imageData;
  final int childCount;
  final String? path;
  final double? refreshProgress;
  ViewModel({
    required this.name,
    required this.id,
    required this.serverId,
    required this.dateCreated,
    required this.canDelete,
    required this.canDownload,
    required this.parentId,
    required this.collectionType,
    required this.playAccess,
    required this.recentlyAdded,
    required this.imageData,
    required this.childCount,
    required this.path,
    this.refreshProgress,
  });

  ViewModel copyWith({
    String? name,
    String? id,
    String? serverId,
    DateTime? dateCreated,
    bool? canDelete,
    bool? canDownload,
    String? parentId,
    CollectionType? collectionType,
    dto.PlayAccess? playAccess,
    List<ItemBaseModel>? recentlyAdded,
    ImagesData? imageData,
    int? childCount,
    String? path,
  }) {
    return ViewModel(
      name: name ?? this.name,
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      dateCreated: dateCreated ?? this.dateCreated,
      canDelete: canDelete ?? this.canDelete,
      canDownload: canDownload ?? this.canDownload,
      parentId: parentId ?? this.parentId,
      collectionType: collectionType ?? this.collectionType,
      playAccess: playAccess ?? this.playAccess,
      recentlyAdded: recentlyAdded ?? this.recentlyAdded,
      imageData: imageData ?? this.imageData,
      childCount: childCount ?? this.childCount,
      path: path ?? this.path,
    );
  }

  factory ViewModel.fromBodyDto(dto.BaseItemDto item, Ref ref) {
    return ViewModel(
      name: item.name ?? "",
      id: item.id ?? "",
      serverId: item.serverId ?? "",
      dateCreated: item.dateCreated ?? DateTime.now(),
      canDelete: item.canDelete ?? false,
      canDownload: item.canDownload ?? false,
      parentId: item.parentId ?? "",
      recentlyAdded: [],
      imageData: ImagesData.fromBaseItem(item, ref),
      collectionType: item.collectionType ?? CollectionType.folders,
      playAccess: item.playAccess ?? PlayAccess.none,
      childCount: item.childCount ?? 0,
      path: "",
    );
  }

  factory ViewModel.fromVirtualFolder(dto.VirtualFolderInfo item, Ref ref) {
    return ViewModel(
      name: item.name ?? "",
      id: item.itemId ?? "",
      serverId: "",
      dateCreated: DateTime.now(),
      canDelete: false,
      canDownload: false,
      parentId: "",
      recentlyAdded: [],
      imageData: item.primaryImageItemId != null
          ? ImagesData.fromBaseItem(
              dto.BaseItemDto(
                id: item.itemId,
                imageTags: {'Primary': item.primaryImageItemId},
              ),
              ref)
          : null,
      collectionType: CollectionType.values
              .firstWhereOrNull((element) => element.name.toLowerCase() == item.collectionType?.value?.toLowerCase()) ??
          CollectionType.folders,
      playAccess: PlayAccess.none,
      childCount: 0,
      path: "",
      refreshProgress: item.refreshProgress,
    );
  }

  @override
  bool operator ==(covariant ViewModel other) {
    if (identical(this, other)) return true;
    return other.id == id && other.serverId == serverId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ serverId.hashCode;
  }

  NavigationButton toNavigationButton(
    bool selected,
    bool horizontal,
    bool expanded,
    FutureOr Function() action, {
    FutureOr Function()? onLongPress,
    List<ItemAction>? trailing,
    Widget? customIcon,
  }) {
    return NavigationButton(
      label: name,
      selected: selected,
      onPressed: action,
      onLongPress: onLongPress,
      horizontal: horizontal,
      expanded: expanded,
      customIcon: customIcon,
      trailing: trailing ?? [],
      selectedIcon: Icon(collectionType.icon),
      icon: Icon(collectionType.iconOutlined),
    );
  }

  @override
  String toString() {
    return 'ViewModel(name: $name, id: $id, serverId: $serverId, dateCreated: $dateCreated, canDelete: $canDelete, canDownload: $canDownload, parentId: $parentId, collectionType: $collectionType, playAccess: $playAccess, recentlyAdded: $recentlyAdded, childCount: $childCount)';
  }
}
