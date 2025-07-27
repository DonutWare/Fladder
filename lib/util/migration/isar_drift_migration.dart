import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:fladder/models/syncing/database_item.dart';
import 'package:fladder/models/syncing/i_synced_item.dart';
import 'package:fladder/models/syncing/sync_item.dart';

Future<void> isarMigration(Ref ref, AppDatabase db, String savePath) async {
  if (kIsWeb) return;

  //Return if the database is already migrated or not empty
  final isNotEmtpy = await db.select(db.databaseItems).get().then((value) => value.isNotEmpty);
  if (isNotEmtpy) {
    log('Drift database is not empty, skipping migration');
    return;
  }

  //Open isar database
  final applicationDirectory = await getApplicationDocumentsDirectory();
  final isarPath = Directory(path.joinAll([applicationDirectory.path, 'Fladder', 'Database']));
  await isarPath.create(recursive: true);
  final isar = Isar.open(
    schemas: [ISyncedItemSchema],
    directory: isarPath.path,
  );

  //Fetch all synced items from the old database
  List<SyncedItem> items = isar.iSyncedItems
      .where()
      .findAll()
      .map((e) => SyncedItem.fromIsar(e, path.joinAll([savePath, e.userId ?? "Unkown User"])))
      .toList();

  //Clear any missing paths
  items = items.where((e) => e.path != null ? Directory(e.path!).existsSync() : false).toList();

  //Convert to drift database items
  final driftItems = items.map(
    (item) => DatabaseItemsCompanion(
      id: Value(item.id),
      parentId: Value(item.parentId),
      syncing: Value(item.syncing),
      userId: Value(item.userId),
      path: Value(item.path),
      fileSize: Value(item.fileSize),
      sortName: Value(item.sortName),
      videoFileName: Value(item.videoFileName),
      trickPlayModel: Value(item.fTrickPlayModel != null ? jsonEncode(item.fTrickPlayModel?.toJson()) : null),
      mediaSegments: Value(item.mediaSegments != null ? jsonEncode(item.mediaSegments?.toJson()) : null),
      images: Value(item.fImages != null ? jsonEncode(item.fImages?.toJson()) : null),
      chapters: Value(jsonEncode(item.fChapters.map((e) => e.toJson()).toList())),
      subtitles: Value(jsonEncode(item.subtitles.map((e) => e.toJson()).toList())),
      userData: Value(item.userData != null ? jsonEncode(item.userData?.toJson()) : null),
    ),
  );

  await db.batch((batch) {
    batch.insertAll(
      db.databaseItems,
      driftItems,
      mode: InsertMode.insertOrReplace,
    );
  });

  isar.close();

  //Delete isar database after a few versions?
  // await Future.delayed(const Duration(seconds: 1));
  // if (await isarPath.exists()) {
  //   log('Deleting old Fladder base folder: ${isarPath.path}');
  //   await isarPath.delete(recursive: true);
  // }
}
