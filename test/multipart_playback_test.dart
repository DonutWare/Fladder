import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/overview_model.dart';
import 'package:fladder/models/items/video_part_model.dart';
import 'package:fladder/models/playback/multipart_playback.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/duration_extensions.dart';

void main() {
  dto.UserItemDataDto userData({
    bool played = false,
    double progress = 0,
    Duration position = Duration.zero,
  }) {
    return dto.UserItemDataDto(
      played: played,
      playedPercentage: progress,
      playbackPositionTicks: position.toRuntimeTicks,
    );
  }

  MovieModel movie({
    String id = 'movie1',
    Duration runtime = const Duration(minutes: 30),
    dto.UserItemDataDto? data,
  }) {
    final dtoItem = dto.BaseItemDto(
      id: id,
      name: 'Movie',
      type: enums.BaseItemKind.movie,
      runTimeTicks: runtime.toRuntimeTicks,
      userData: data,
    );

    // The `ref == null` branch of MovieModel.fromBaseDto does not populate the
    // runtime, so rebuild the overview from the same DTO.
    return MovieModel.fromBaseDto(dtoItem, null).copyWith(
      overview: OverviewModel.fromBaseItemDto(dtoItem, null),
    );
  }

  VideoPartModel part({
    required String id,
    required int partNumber,
    int totalParts = 3,
    String parentId = 'movie1',
    Duration runtime = const Duration(minutes: 30),
    dto.UserItemDataDto? data,
  }) {
    return VideoPartModel.fromBaseDto(
      dto.BaseItemDto(
        id: id,
        name: 'Part $partNumber',
        type: enums.BaseItemKind.video,
        runTimeTicks: runtime.toRuntimeTicks,
        userData: data,
      ),
      null,
      parentItemId: parentId,
      partNumber: partNumber,
      totalParts: totalParts,
    );
  }

  MultipartGroup defaultGroup({MovieModel? main, List<VideoPartModel>? parts}) {
    return MultipartGroup.fromMain(
      main ?? movie(),
      parts ??
          [
            part(id: 'p2', partNumber: 2),
            part(id: 'p3', partNumber: 3),
          ],
    )!;
  }

  SyncedItem syncedItem({
    required String id,
    String? parentId,
    String? partOfId,
    int? partNumber,
    int? totalParts,
  }) {
    return SyncedItem(
      id: id,
      userId: 'user',
      parentId: parentId,
      partOfId: partOfId,
      partNumber: partNumber,
      totalParts: totalParts,
    );
  }

  group('MultipartGroup construction', () {
    test('requires at least one additional part', () {
      expect(MultipartGroup.fromMain(movie(), const []), isNull);
    });

    test('requires a non-zero runtime for every part', () {
      final main = movie(runtime: Duration.zero);
      expect(MultipartGroup.fromMain(main, [part(id: 'p2', partNumber: 2)]), isNull);
    });

    test('orders parts by part number', () {
      final group = MultipartGroup.fromMain(movie(), [
        part(id: 'p3', partNumber: 3),
        part(id: 'p2', partNumber: 2),
      ])!;

      expect(group.parts.map((item) => item.id), ['movie1', 'p2', 'p3']);
    });

    test('fromQueue resolves the group for the main item and for a part', () {
      final main = movie();
      final p2 = part(id: 'p2', partNumber: 2);
      final p3 = part(id: 'p3', partNumber: 3);
      final queue = <ItemBaseModel>[main, p2, p3];

      expect(MultipartGroup.fromQueue(queue, main)?.parentId, 'movie1');
      expect(MultipartGroup.fromQueue(queue, p2)?.parentId, 'movie1');
    });

    test('fromQueue returns null when no parts are present', () {
      final main = movie();
      expect(MultipartGroup.fromQueue([main], main), isNull);
    });
  });

  group('Aggregate math', () {
    test('sums the runtime of every part', () {
      expect(defaultGroup().totalDuration, const Duration(minutes: 90));
    });

    test('combines local positions using the preceding part runtimes', () {
      final group = defaultGroup();

      expect(group.combinedPosition(group.main, const Duration(minutes: 15)), const Duration(minutes: 15));
      expect(group.combinedPosition(group.parts[1], const Duration(minutes: 15)), const Duration(minutes: 45));
      expect(group.combinedPosition(group.parts[2], Duration.zero), const Duration(minutes: 60));
    });

    test('clamps positions to the current part runtime', () {
      final group = defaultGroup();

      expect(group.combinedPosition(group.parts[1], const Duration(minutes: 45)), const Duration(minutes: 60));
      expect(group.aggregateProgress(group.parts[2], const Duration(minutes: 45)), 100.0);
    });

    test('computes aggregate progress across three equal parts', () {
      final group = defaultGroup();

      expect(group.aggregateProgress(group.main, const Duration(minutes: 15)), closeTo(16.666, 0.01));
      expect(group.aggregateProgress(group.parts[1], const Duration(minutes: 15)), closeTo(50.0, 0.001));
      expect(group.aggregateProgress(group.parts[2], Duration.zero), closeTo(66.666, 0.01));
      expect(group.aggregateProgress(group.parts[2], const Duration(minutes: 30)), 100.0);
    });

    test('scales parent ticks to the Part 1 runtime', () {
      final group = defaultGroup();

      expect(
        group.parentPositionTicks(group.parts[1], const Duration(minutes: 15)),
        const Duration(minutes: 15).toRuntimeTicks,
      );
      expect(
        group.parentPositionTicks(group.parts[2], Duration.zero),
        closeTo(const Duration(minutes: 20).toRuntimeTicks.toDouble(), 20000),
      );
      expect(
        group.parentPositionTicks(group.parts[2], const Duration(minutes: 30)),
        const Duration(minutes: 30).toRuntimeTicks,
      );
      expect(
        group.parentPositionTicks(group.parts[2], const Duration(minutes: 45)),
        const Duration(minutes: 30).toRuntimeTicks,
      );
    });
  });

  group('Aggregate update policy', () {
    final now = DateTime.utc(2026, 1, 1);

    test('Part 1 keeps its local position and is never scaled', () {
      final group = defaultGroup();

      expect(group.progressUpdate(group.main, const Duration(minutes: 15)), isNull);

      final stop = group.stopUpdate(group.main, const Duration(minutes: 45))!;
      expect(stop.itemId, 'movie1');
      expect(stop.playbackPositionTicks, const Duration(minutes: 30).toRuntimeTicks);
      expect(stop.played, isFalse);
    });

    test('Part 2 and later write scaled parent progress', () {
      final group = defaultGroup();
      final update = group.progressUpdate(group.parts[1], const Duration(minutes: 15), now: now)!;

      expect(update.itemId, 'movie1');
      expect(update.playbackPositionTicks, const Duration(minutes: 15).toRuntimeTicks);
      expect(update.played, isFalse);
      expect(update.lastPlayed, now);
    });

    test('reset clears the parent and every additional part', () {
      final group = defaultGroup();
      final updates = group.resetUpdates();

      expect(updates.map((update) => update.itemId), ['movie1', 'p2', 'p3']);
      expect(updates.every((update) => update.playbackPositionTicks == 0), isTrue);
      expect(updates.every((update) => update.played == false), isTrue);
    });

    test('completion is only detected on the final part', () {
      final group = defaultGroup();

      expect(group.shouldMarkCompleted(group.parts[1], const Duration(minutes: 30)), isFalse);
      expect(group.shouldMarkCompleted(group.parts[2], const Duration(minutes: 20)), isFalse);
      expect(group.shouldMarkCompleted(group.parts[2], const Duration(minutes: 29)), isTrue);
      expect(group.shouldMarkCompleted(group.parts[2], const Duration(minutes: 30)), isTrue);
    });
  });

  group('Resume selection', () {
    test('explicit positions and selected parts bypass auto-resume', () {
      final main = movie();
      final p2 = part(id: 'p2', partNumber: 2);

      expect(MultipartGroup.bypassesAutoResume(main, null), isFalse);
      expect(MultipartGroup.bypassesAutoResume(main, Duration.zero), isTrue);
      expect(MultipartGroup.bypassesAutoResume(p2, null), isTrue);
    });

    test('finished logical item restarts Part 1 and resets the group', () {
      final group = MultipartGroup.fromMain(
        movie(data: userData(played: true, progress: 100)),
        [
          part(id: 'p2', partNumber: 2, data: userData(played: true, progress: 100)),
          part(id: 'p3', partNumber: 3, data: userData(played: true, progress: 100)),
        ],
      )!;

      final decision = group.resumeDecision();
      expect(decision.item.id, 'movie1');
      expect(decision.startPosition, Duration.zero);
      expect(decision.resetGroup, isTrue);
    });

    test('legacy Part 1-only completion resumes the first unplayed part', () {
      final group = MultipartGroup.fromMain(
        movie(data: userData(played: true, progress: 100)),
        [
          part(id: 'p2', partNumber: 2),
          part(id: 'p3', partNumber: 3),
        ],
      )!;

      final decision = group.resumeDecision();
      expect(decision.item.id, 'p2');
      expect(decision.startPosition, Duration.zero);
      expect(decision.resetGroup, isFalse);
    });

    test('resumes the in-progress later part', () {
      final group = MultipartGroup.fromMain(
        movie(),
        [
          part(
            id: 'p2',
            partNumber: 2,
            data: userData(progress: 30, position: const Duration(minutes: 9)),
          ),
          part(id: 'p3', partNumber: 3),
        ],
      )!;

      final decision = group.resumeDecision();
      expect(decision.item.id, 'p2');
      expect(decision.startPosition, const Duration(minutes: 9));
    });

    test('resumes the first unplayed part when an earlier part was played', () {
      final group = MultipartGroup.fromMain(
        movie(),
        [
          part(id: 'p2', partNumber: 2, data: userData(played: true, progress: 100)),
          part(id: 'p3', partNumber: 3),
        ],
      )!;

      final decision = group.resumeDecision();
      expect(decision.item.id, 'p3');
    });

    test('resumes Part 1 locally when no later part has started', () {
      final group = MultipartGroup.fromMain(
        movie(data: userData(progress: 50, position: const Duration(minutes: 15))),
        [
          part(id: 'p2', partNumber: 2),
          part(id: 'p3', partNumber: 3),
        ],
      )!;

      final decision = group.resumeDecision();
      expect(decision.item.id, 'movie1');
      expect(decision.startPosition, const Duration(minutes: 15));
      expect(decision.resetGroup, isFalse);
    });

    test('clamps a stale Part 1 position to its runtime', () {
      final group = MultipartGroup.fromMain(
        movie(data: userData(progress: 50, position: const Duration(minutes: 90))),
        [
          part(id: 'p2', partNumber: 2),
          part(id: 'p3', partNumber: 3),
        ],
      )!;

      final decision = group.resumeDecision();
      expect(decision.item.id, 'movie1');
      expect(decision.startPosition, const Duration(minutes: 30));
    });
  });

  group('Aggregate display', () {
    test('computes watched time from per-part user data', () {
      final group = MultipartGroup.fromMain(
        movie(data: userData(progress: 50, position: const Duration(minutes: 15))),
        [
          part(id: 'p2', partNumber: 2),
          part(id: 'p3', partNumber: 3),
        ],
      )!;

      expect(group.part1Played, isFalse);
      expect(group.aggregateProgressForDisplay, closeTo(16.666, 0.01));
    });

    test('counts Part 1 as fully watched once a later part started', () {
      final group = MultipartGroup.fromMain(
        movie(data: userData(progress: 10)),
        [
          part(id: 'p2', partNumber: 2, data: userData(progress: 50)),
          part(id: 'p3', partNumber: 3),
        ],
      )!;

      expect(group.part1Played, isTrue);
      expect(group.aggregateProgressForDisplay, closeTo(50.0, 0.001));
    });

    test('reports the logical item as watched when everything is played', () {
      final group = MultipartGroup.fromMain(
        movie(data: userData(played: true, progress: 100)),
        [
          part(id: 'p2', partNumber: 2, data: userData(played: true, progress: 100)),
          part(id: 'p3', partNumber: 3, data: userData(played: true, progress: 100)),
        ],
      )!;

      expect(group.allPartsPlayed, isTrue);
      expect(group.aggregateProgressForDisplay, 100.0);
    });
  });

  group('Offline queue ordering', () {
    test('interleaves parts directly after their parent', () {
      final movie = syncedItem(id: 'movie1');
      final p2 = syncedItem(id: 'p2', partOfId: 'movie1', partNumber: 2);
      final p3 = syncedItem(id: 'p3', partOfId: 'movie1', partNumber: 3);

      final queue = SyncNotifier.interleaveSyncedVideoQueue(
        [movie],
        {
          'movie1': [p2, p3]
        },
        current: p2,
      );

      expect(queue.map((item) => item.id), ['movie1', 'p2', 'p3']);
    });

    test('keeps episodes and their parts in order', () {
      final e1 = syncedItem(id: 'e1');
      final e2 = syncedItem(id: 'e2');
      final p2 = syncedItem(id: 'p2', partOfId: 'e1', partNumber: 2);

      final queue = SyncNotifier.interleaveSyncedVideoQueue(
        [e1, e2],
        {
          'e1': [p2]
        },
        current: p2,
      );

      expect(queue.map((item) => item.id), ['e1', 'p2', 'e2']);
    });

    test('appends the current part when it is missing from the queue', () {
      final e1 = syncedItem(id: 'e1');
      final p2 = syncedItem(id: 'p2', partOfId: 'e1', partNumber: 2);

      final queue = SyncNotifier.interleaveSyncedVideoQueue([e1], const {}, current: p2);

      expect(queue.map((item) => item.id), ['e1', 'p2']);
    });
  });

  group('Offline aggregate user data', () {
    final now = DateTime.utc(2026, 1, 1);

    test('Part 1 keeps its clamped local position and stays unplayed', () {
      final updated = MultipartGroup.part1UserData(
        const UserData(),
        const Duration(minutes: 45),
        const Duration(minutes: 30),
        now: now,
      )!;

      expect(updated.playbackPositionTicks, const Duration(minutes: 30).toRuntimeTicks);
      expect(updated.progress, 100);
      expect(updated.played, isFalse);
      expect(updated.lastPlayed, now);
    });

    test('later parts store scaled parent ticks and aggregate progress', () {
      final updated = MultipartGroup.parentProgressUserData(
        const UserData(played: true),
        123456,
        42.5,
        now: now,
      )!;

      expect(updated.playbackPositionTicks, 123456);
      expect(updated.progress, 42.5);
      expect(updated.played, isFalse);
      expect(updated.lastPlayed, now);
    });

    test('completion marks the parent played and increments play count', () {
      final updated = MultipartGroup.completedParentUserData(
        const UserData(playCount: 2),
        now: now,
      )!;

      expect(updated.played, isTrue);
      expect(updated.playbackPositionTicks, 0);
      expect(updated.progress, 100);
      expect(updated.playCount, 3);
      expect(updated.lastPlayed, now);
    });
  });
}
