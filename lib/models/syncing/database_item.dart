import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/user_provider.dart';

part 'database_item.g.dart';

@TableIndex(name: 'database_id', columns: {#id})
class DatabaseItems extends Table {
  TextColumn get userId => text()();
  TextColumn get id => text().withLength(min: 1)();
  BoolColumn get syncing => boolean()();
  TextColumn get sortName => text().nullable()();
  TextColumn get parentId => text().nullable()();
  TextColumn get path => text().nullable()();
  IntColumn get fileSize => integer().nullable()();
  TextColumn get videoFileName => text().nullable()();
  TextColumn get trickPlayModel => text().nullable()();
  TextColumn get mediaSegments => text().nullable()();
  TextColumn get images => text().nullable()();
  TextColumn get chapters => text().nullable()();
  TextColumn get subtitles => text().nullable()();
  TextColumn get userData => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [DatabaseItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase(this.ref, [QueryExecutor? executor]) : super(executor ?? _openConnection());

  final Ref ref;

  String get userId => ref.read(userProvider.select((value) => value?.id ?? ""));

  @override
  int get schemaVersion => 1;

  Future<void> clearDatabase() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }

  Selectable<SyncedItem> getItem(String id) =>
      (select(databaseItems)..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId))).map(databaseConverter);

  Selectable<SyncedItem> getParent(String id) =>
      (select(databaseItems)..where((tbl) => tbl.parentId.equals(id) & tbl.userId.equals(userId)))
          .map(databaseConverter);

  Selectable<SyncedItem> get getParentItems =>
      ((select(databaseItems)..where((tbl) => (tbl.parentId.isNull() & tbl.userId.equals(userId))))
            ..orderBy([(t) => OrderingTerm(expression: t.sortName)]))
          .map(databaseConverter);

  Selectable<SyncedItem> getChildren(String parentId) =>
      ((select(databaseItems)..where((tbl) => (tbl.parentId.equals(parentId) & tbl.userId.equals(userId))))
            ..orderBy([(t) => OrderingTerm(expression: t.sortName)]))
          .map(databaseConverter);

  Future<int> insertItem(SyncedItem item) async {
    final itemExists = await getItem(item.id).getSingleOrNull();
    if (itemExists != null) {
      return (update(databaseItems)..where((tbl) => tbl.id.equals(item.id) & tbl.userId.equals(userId)))
          .write(toDataBaseItem(item));
    } else {
      return into(databaseItems).insert(toDataBaseItem(item));
    }
  }

  Future<List<SyncedItem>> getNestedChildren(SyncedItem root) async {
    final itemType = root.createItemModel(ref)?.type;

    if (itemType == null) return [];

    final int maxDepth = switch (itemType) {
      FladderItemType.episode => 0,
      FladderItemType.movie => 0,
      FladderItemType.season => 1,
      FladderItemType.series => 2,
      _ => 1,
    };

    final all = <SyncedItem>[];
    List<SyncedItem> toProcess = [root];

    if (maxDepth == 0) {
      return [];
    }

    for (var i = 0; i < maxDepth; i++) {
      final futures = toProcess.map((item) => getChildren(item.id).get());
      final resultsList = await Future.wait(futures);

      final children = resultsList.expand((r) => r).toList();

      if (children.isEmpty) break;

      all.addAll(children);
      toProcess = children;
    }

    return all;
  }

  Future<void> insertMultipleEntries(List<SyncedItem> items) async {
    await batch((batch) {
      batch.insertAll(
        databaseItems,
        items.map(toDataBaseItem),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> deleteAllItems(List<SyncedItem> items) async => await batch((batch) {
        batch.deleteWhere(databaseItems, (tbl) => tbl.id.isIn(items.map((e) => e.id)));
      });

  DatabaseItemsCompanion toDataBaseItem(SyncedItem item) {
    return DatabaseItemsCompanion(
      id: Value(item.id),
      parentId: Value(item.parentId),
      syncing: Value(item.syncing),
      userId: Value(userId),
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
    );
  }

  SyncedItem databaseConverter(DatabaseItem dataItem) {
    final syncedItem = SyncedItem(
      id: dataItem.id,
      userId: dataItem.userId,
      parentId: dataItem.parentId,
      sortName: dataItem.sortName,
      syncing: dataItem.syncing,
      path: dataItem.path,
      fileSize: dataItem.fileSize,
      videoFileName: dataItem.videoFileName,
      fTrickPlayModel:
          dataItem.trickPlayModel != null ? TrickPlayModel.fromJson(jsonDecode(dataItem.trickPlayModel!)) : null,
      mediaSegments:
          dataItem.mediaSegments != null ? MediaSegmentsModel.fromJson(jsonDecode(dataItem.mediaSegments!)) : null,
      fImages: dataItem.images != null ? ImagesData.fromJson(jsonDecode(dataItem.images!)) : null,
      fChapters: (dataItem.chapters != null && dataItem.chapters!.isNotEmpty)
          ? (jsonDecode(dataItem.chapters!) as List).map((e) => Chapter.fromJson(e)).toList()
          : [],
      subtitles: (dataItem.subtitles != null && dataItem.subtitles!.isNotEmpty)
          ? (jsonDecode(dataItem.subtitles!) as List).map((e) => SubStreamModel.fromJson(e)).toList()
          : [],
      userData: dataItem.userData != null ? UserData.fromJson(jsonDecode(dataItem.userData!)) : null,
    );

    return syncedItem.copyWith(
      itemModel: syncedItem.createItemModel(ref),
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'syncedDatabase',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
