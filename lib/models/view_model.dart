import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';

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
  final int childCount;
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
    required this.childCount,
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
    int? childCount,
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
      childCount: childCount ?? this.childCount,
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
      collectionType: CollectionType.values
              .firstWhereOrNull((element) => element.name.toLowerCase() == item.collectionType?.value?.toLowerCase()) ??
          CollectionType.folders,
      playAccess: item.playAccess ?? PlayAccess.none,
      childCount: item.childCount ?? 0,
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

  @override
  String toString() {
    return 'ViewModel(name: $name, id: $id, serverId: $serverId, dateCreated: $dateCreated, canDelete: $canDelete, canDownload: $canDownload, parentId: $parentId, collectionType: $collectionType, playAccess: $playAccess, recentlyAdded: $recentlyAdded, childCount: $childCount)';
  }
}
