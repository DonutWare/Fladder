import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const playlist = [
    SyncPlayQueueEntry(itemId: 'a', playlistItemId: 'pa'),
    SyncPlayQueueEntry(itemId: 'b', playlistItemId: 'pb'),
    SyncPlayQueueEntry(itemId: 'c', playlistItemId: 'pc'),
    SyncPlayQueueEntry(itemId: 'd', playlistItemId: 'pd'),
  ];

  group('SyncPlayQueueTiming', () {
    final at = DateTime.utc(2026, 9, 2, 12, 0, 0);

    test('a paused group stays at the frame position', () {
      const timing = SyncPlayQueueTiming(startPositionTicks: 5000);
      expect(timing.positionTicksAt(at.add(const Duration(minutes: 5))), 5000);
    });

    test('a playing group is extrapolated from LastUpdate', () {
      final timing = SyncPlayQueueTiming(startPositionTicks: 5000, lastUpdate: at, isPlaying: true);
      expect(
        timing.positionTicksAt(at.add(const Duration(seconds: 3))),
        5000 + millisecondsToTicks(3000),
      );
    });

    test('a playing group without LastUpdate cannot be extrapolated', () {
      const timing = SyncPlayQueueTiming(startPositionTicks: 5000, isPlaying: true);
      expect(timing.positionTicksAt(at.add(const Duration(seconds: 3))), 5000);
    });
  });

  group('estimateGroupPositionTicks', () {
    final at = DateTime.utc(2026, 9, 2, 12, 0, 0);
    final remoteNow = at.add(const Duration(seconds: 10));
    final timing = SyncPlayQueueTiming(startPositionTicks: 1000, lastUpdate: at, isPlaying: true);

    test('an Unpause for the current item is extrapolated', () {
      final unpause = LastSyncPlayCommand(
        when: at.toIso8601String(),
        positionTicks: 5000,
        command: SyncPlayCommand.unpause,
        playlistItemId: 'pa',
      );
      expect(
        estimateGroupPositionTicks(
          lastCommand: unpause,
          currentPlaylistItemId: 'pa',
          queueTiming: timing,
          fallbackPositionTicks: 0,
          remoteNow: remoteNow,
        ),
        5000 + millisecondsToTicks(10000),
      );
    });

    test('a Pause or Seek freezes the playhead at the command position', () {
      for (final command in [SyncPlayCommand.pause, SyncPlayCommand.seek]) {
        final last = LastSyncPlayCommand(
          when: at.toIso8601String(),
          positionTicks: 5000,
          command: command,
          playlistItemId: 'pa',
        );
        expect(
          estimateGroupPositionTicks(
            lastCommand: last,
            currentPlaylistItemId: 'pa',
            queueTiming: timing,
            fallbackPositionTicks: 0,
            remoteNow: remoteNow,
          ),
          5000,
          reason: '$command must not extrapolate',
        );
      }
    });

    test('a command for another item yields to the queue frame timing', () {
      final stale = LastSyncPlayCommand(
        when: at.toIso8601String(),
        positionTicks: 5000,
        command: SyncPlayCommand.unpause,
        playlistItemId: 'pb',
      );
      expect(
        estimateGroupPositionTicks(
          lastCommand: stale,
          currentPlaylistItemId: 'pa',
          queueTiming: timing,
          fallbackPositionTicks: 0,
          remoteNow: remoteNow,
        ),
        1000 + millisecondsToTicks(10000),
      );
    });

    test('without any context the last state update position is used', () {
      expect(
        estimateGroupPositionTicks(
          lastCommand: null,
          currentPlaylistItemId: 'pa',
          queueTiming: null,
          fallbackPositionTicks: 777,
          remoteNow: remoteNow,
        ),
        777,
      );
    });
  });

  group('resolveQueueNavigation', () {
    test('adjacent following entry is NextItem', () {
      expect(
        resolveQueueNavigation(playlist: playlist, playingItemIndex: 1, targetItemId: 'c'),
        SyncPlayQueueNavigation.next,
      );
    });

    test('adjacent preceding entry is PreviousItem', () {
      expect(
        resolveQueueNavigation(playlist: playlist, playingItemIndex: 1, targetItemId: 'a'),
        SyncPlayQueueNavigation.previous,
      );
    });

    test('non-adjacent entry is SetPlaylistItem', () {
      expect(
        resolveQueueNavigation(playlist: playlist, playingItemIndex: 0, targetItemId: 'd'),
        SyncPlayQueueNavigation.setCurrentItem,
      );
    });

    test('unknown item needs a new queue', () {
      expect(
        resolveQueueNavigation(playlist: playlist, playingItemIndex: 0, targetItemId: 'z'),
        SyncPlayQueueNavigation.newQueue,
      );
    });

    test('empty queue needs a new queue', () {
      expect(
        resolveQueueNavigation(playlist: const [], playingItemIndex: -1, targetItemId: 'a'),
        SyncPlayQueueNavigation.newQueue,
      );
    });
  });

  group('SyncPlayState queue helpers', () {
    test('next and previous entries follow the playing index', () {
      final state = SyncPlayState(playlist: playlist, playingItemIndex: 1);
      expect(state.nextQueueEntry?.itemId, 'c');
      expect(state.previousQueueEntry?.itemId, 'a');
    });

    test('edges return null', () {
      expect(SyncPlayState(playlist: playlist, playingItemIndex: 0).previousQueueEntry, isNull);
      expect(SyncPlayState(playlist: playlist, playingItemIndex: 3).nextQueueEntry, isNull);
      expect(SyncPlayState().nextQueueEntry, isNull);
    });
  });
}
