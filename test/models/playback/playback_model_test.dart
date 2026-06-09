import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/models/playback/playback_model.dart';

void main() {
  group('useLocalSyncedCopy', () {
    test('plays local copy when synced and server is unreachable', () {
      expect(useLocalSyncedCopy(isSynced: true, serverReachable: false), isTrue);
    });

    test('uses server when synced and server is reachable', () {
      expect(useLocalSyncedCopy(isSynced: true, serverReachable: true), isFalse);
    });

    test('does not force local when item is not synced, even if server unreachable', () {
      expect(useLocalSyncedCopy(isSynced: false, serverReachable: false), isFalse);
    });

    test('uses server when not synced and server reachable', () {
      expect(useLocalSyncedCopy(isSynced: false, serverReachable: true), isFalse);
    });
  });
}
