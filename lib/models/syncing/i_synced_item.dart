import 'dart:convert';

import 'package:isar/isar.dart';

import 'package:fladder/models/syncing/sync_item.dart';

part 'i_synced_item.g.dart';

// extension IsarExtensions on String? {
//   int get fastHash {
//     if (this == null) return 0;
//     var hash = 0xcbf29ce484222325;

//     var i = 0;
//     while (i < this!.length) {
//       final codeUnit = this!.codeUnitAt(i++);
//       hash ^= codeUnit >> 8;
//       hash *= 0x100000001b3;
//       hash ^= codeUnit & 0xFF;
//       hash *= 0x100000001b3;
//     }

//     return hash;
//   }
// }

@collection
class ISyncedItem {
  String? userId;
  String id;
  bool syncing;
  String? sortName;
  String? parentId;
  String? path;
  int? fileSize;
  String? videoFileName;
  String? trickPlayModel;
  String? mediaSegments;
  String? images;
  List<String>? chapters;
  List<String>? subtitles;
  String? userData;
  ISyncedItem({
    this.userId,
    required this.id,
    required this.syncing,
    this.sortName,
    this.parentId,
    this.path,
    this.fileSize,
    this.videoFileName,
    this.trickPlayModel,
    this.mediaSegments,
    this.images,
    this.chapters,
    this.subtitles,
    this.userData,
  });

  factory ISyncedItem.fromSynced(SyncedItem syncedItem, String? path) {
    return ISyncedItem(
      id: syncedItem.id,
      parentId: syncedItem.parentId,
      syncing: syncedItem.syncing,
      userId: syncedItem.userId,
      path: syncedItem.path?.replaceAll(path ?? "", '').substring(1),
      fileSize: syncedItem.fileSize,
      sortName: syncedItem.sortName,
      videoFileName: syncedItem.videoFileName,
      trickPlayModel: syncedItem.fTrickPlayModel != null ? jsonEncode(syncedItem.fTrickPlayModel?.toJson()) : null,
      mediaSegments: syncedItem.mediaSegments != null ? jsonEncode(syncedItem.mediaSegments?.toJson()) : null,
      images: syncedItem.fImages != null ? jsonEncode(syncedItem.fImages?.toJson()) : null,
      chapters: syncedItem.fChapters.map((e) => jsonEncode(e.toJson())).toList(),
      subtitles: syncedItem.subtitles.map((e) => jsonEncode(e.toJson())).toList(),
      userData: syncedItem.userData != null ? jsonEncode(syncedItem.userData?.toJson()) : null,
    );
  }
}
