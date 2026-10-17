import 'dart:ffi';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/open.dart';

import 'package:fladder/models/syncing/database_item.dart';

const _v1Schema = '''
CREATE TABLE database_items (
  user_id TEXT NOT NULL,
  id TEXT NOT NULL,
  syncing INTEGER NOT NULL DEFAULT 0,
  sort_name TEXT NULL,
  parent_id TEXT NULL,
  path TEXT NULL,
  file_size INTEGER NULL,
  video_file_name TEXT NULL,
  trick_play_model TEXT NULL,
  media_segments TEXT NULL,
  images TEXT NULL,
  chapters TEXT NULL,
  subtitles TEXT NULL,
  un_synced_data INTEGER NOT NULL DEFAULT 0,
  user_data TEXT NULL,
  PRIMARY KEY (user_id, id)
);
''';

void main() {
  if (Platform.isLinux) {
    // The sandbox ships the versioned library only; sqlite3 defaults to the
    // unversioned `libsqlite3.so` dev symlink.
    open.overrideFor(OperatingSystem.linux, () => DynamicLibrary.open('libsqlite3.so.0'));
  }

  test('adds part columns when upgrading a v1 database', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final dbProvider = Provider<AppDatabase>((ref) {
      return AppDatabase(
        ref,
        NativeDatabase.memory(setup: (database) {
          database.execute(_v1Schema);
          database.execute('PRAGMA user_version = 1');
        }),
      );
    });

    final db = container.read(dbProvider);
    addTearDown(db.close);

    final columns = await db.customSelect("PRAGMA table_info('database_items')").get();
    final columnNames = columns.map((row) => row.read<String>('name')).toSet();

    expect(columnNames, containsAll(['part_of_id', 'part_number', 'total_parts']));

    final version = await db.customSelect('PRAGMA user_version').getSingle();
    expect(version.read<int>('user_version'), 2);
  }, skip: Platform.isWindows ? 'System SQLite is not available to Dart unit tests on Windows' : false);
}
