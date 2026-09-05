import 'package:fladder/models/syncplay/syncplay_models.dart';
import 'package:fladder/providers/syncplay/handlers/syncplay_message_handler.dart';
import 'package:flutter_test/flutter_test.dart';

// The full SyncPlayController needs Ref + Chopper + WebSocket; these cover the invariants it relies on.

SyncPlayMessageHandler _handler({
  required List<String> calls,
  void Function(SyncPlayState Function(SyncPlayState))? onStateUpdate,
}) {
  return SyncPlayMessageHandler(
    onStateUpdate: onStateUpdate ?? (_) {},
    startPlayback: (id, ticks, reason) async {
      calls.add('start:$id:$ticks:$reason');
    },
    getContext: () => null,
    onGroupJoined: () => calls.add('joined'),
    onGroupJoinFailed: () => calls.add('joinFailed'),
    onGroupLeftOrKicked: () => calls.add('leftOrKicked'),
    onStateUpdateToPlaying: () => calls.add('toPlaying'),
    onGroupGone: ({required bool wasKicked}) => calls.add('gone:$wasKicked'),
  );
}

Map<String, dynamic> _playQueue({
  required String reason,
  required List<(String, String)> items,
  int playingItemIndex = 0,
  int startPositionTicks = 0,
  bool isPlaying = false,
  DateTime? lastUpdate,
}) {
  return <String, dynamic>{
    'Type': 'PlayQueue',
    'Data': <String, dynamic>{
      'Reason': reason,
      'LastUpdate': (lastUpdate ?? DateTime.now().toUtc()).toIso8601String(),
      'Playlist': [
        for (final (itemId, playlistItemId) in items)
          <String, dynamic>{'ItemId': itemId, 'PlaylistItemId': playlistItemId},
      ],
      'PlayingItemIndex': playingItemIndex,
      'StartPositionTicks': startPositionTicks,
      'IsPlaying': isPlaying,
      'ShuffleMode': 'Sorted',
      'RepeatMode': 'RepeatNone',
    },
  };
}

void main() {
  group('SyncPlayState lifecycle reset', () {
    test('copyWith clears all in-flight playback flags', () {
      final mid = SyncPlayState(
        isInGroup: true,
        groupId: 'g1',
        groupName: 'movie night',
        groupState: SyncPlayGroupState.playing,
        playingItemId: 'item-1',
        playlistItemId: 'plist-1',
        positionTicks: 1234,
        startPlaybackInProgress: true,
        startingPlaylistItemId: 'plist-1',
        isProcessingCommand: true,
        processingCommandType: SyncPlayCommand.unpause,
        isFollowingGroupPlayback: false,
      );

      final cleared = mid.copyWith(
        isInGroup: false,
        groupId: null,
        groupName: null,
        groupState: SyncPlayGroupState.idle,
        participants: const [],
        isProcessingCommand: false,
        processingCommandType: null,
        positionTicks: 0,
        playingItemId: null,
        playlistItemId: null,
        startPlaybackInProgress: false,
        startingPlaylistItemId: null,
        isFollowingGroupPlayback: true,
      );

      expect(cleared.isInGroup, isFalse);
      expect(cleared.groupId, isNull);
      expect(cleared.startPlaybackInProgress, isFalse);
      expect(cleared.startingPlaylistItemId, isNull);
      expect(cleared.processingCommandType, isNull);
      expect(cleared.playingItemId, isNull);
      expect(cleared.isFollowingGroupPlayback, isTrue);
    });
  });

  group('resolveSyncPlayOverlay', () {
    test('nothing outside a group or while halted', () {
      expect(resolveSyncPlayOverlay(SyncPlayState(groupState: SyncPlayGroupState.waiting)), SyncPlayOverlay.none);
      expect(
        resolveSyncPlayOverlay(SyncPlayState(
          isInGroup: true,
          isFollowingGroupPlayback: false,
          groupState: SyncPlayGroupState.waiting,
        )),
        SyncPlayOverlay.none,
      );
    });

    test('a queue switch wins over a command, a command over the group waiting', () {
      expect(
        resolveSyncPlayOverlay(SyncPlayState(
          isInGroup: true,
          startPlaybackInProgress: true,
          isProcessingCommand: true,
          processingCommandType: SyncPlayCommand.seek,
          groupState: SyncPlayGroupState.waiting,
        )),
        SyncPlayOverlay.switching,
      );
      expect(
        resolveSyncPlayOverlay(SyncPlayState(
          isInGroup: true,
          isProcessingCommand: true,
          processingCommandType: SyncPlayCommand.seek,
          groupState: SyncPlayGroupState.waiting,
        )),
        SyncPlayOverlay.command,
      );
    });

    test('the group waiting shows on every device, even one with nothing to do', () {
      expect(
        resolveSyncPlayOverlay(SyncPlayState(isInGroup: true, groupState: SyncPlayGroupState.waiting)),
        SyncPlayOverlay.waiting,
      );
      expect(
        resolveSyncPlayOverlay(SyncPlayState(isInGroup: true, groupState: SyncPlayGroupState.playing)),
        SyncPlayOverlay.none,
      );
    });
  });

  group('SyncPlayMessageHandler state updates', () {
    test('Waiting/Buffer only updates state, never replies', () async {
      final calls = <String>[];
      SyncPlayState? written;
      final handler = _handler(
        calls: calls,
        onStateUpdate: (updater) => written = updater(SyncPlayState(isInGroup: true)),
      );

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'StateUpdate',
        'Data': <String, dynamic>{'State': 'Waiting', 'Reason': 'Buffer'},
      }, SyncPlayState(isInGroup: true));
      await Future<void>.delayed(const Duration(milliseconds: 5));

      expect(calls, isEmpty);
      expect(written?.groupState, SyncPlayGroupState.waiting);
    });

    test('Waiting/Unpause only updates state, never replies', () async {
      final calls = <String>[];
      final handler = _handler(calls: calls);

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'StateUpdate',
        'Data': <String, dynamic>{'State': 'Waiting', 'Reason': 'Unpause'},
      }, SyncPlayState(isInGroup: true));
      await Future<void>.delayed(const Duration(milliseconds: 5));

      expect(calls, isEmpty);
    });

    test('Playing hands recovery to the controller', () {
      final calls = <String>[];
      final handler = _handler(calls: calls);

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'StateUpdate',
        'Data': <String, dynamic>{'State': 'Playing', 'Reason': 'Unpause'},
      }, SyncPlayState(isInGroup: true));

      expect(calls, ['toPlaying']);
    });
  });

  group('SyncPlayMessageHandler membership', () {
    test('LibraryAccessDenied fails the join and clears the group', () {
      final calls = <String>[];
      SyncPlayState? written;
      final handler = _handler(
        calls: calls,
        onStateUpdate: (updater) => written = updater(SyncPlayState(isInGroup: true, groupId: 'g')),
      );

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'LibraryAccessDenied',
        'Data': <String, dynamic>{'GroupId': 'g', 'Data': ''},
      }, SyncPlayState());

      expect(calls, ['joinFailed']);
      expect(written?.isInGroup, isFalse);
      expect(written?.groupId, isNull);
    });

    test('GroupJoined leaves the following flag to the controller', () {
      // A silent rejoin after a socket drop must not un-halt a device the
      // user halted; user-initiated joins set the flag themselves.
      final calls = <String>[];
      SyncPlayState? written;
      final handler = _handler(
        calls: calls,
        onStateUpdate: (updater) => written = updater(SyncPlayState(isFollowingGroupPlayback: false)),
      );

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'GroupJoined',
        'Data': <String, dynamic>{
          'GroupId': 'g',
          'GroupName': 'Movie night',
          'State': 'Paused',
          'Participants': ['alice'],
          'LastUpdatedAt': DateTime.now().toUtc().toIso8601String(),
        },
      }, SyncPlayState());

      expect(calls, ['joined']);
      expect(written?.isInGroup, isTrue);
      expect(written?.isFollowingGroupPlayback, isFalse);
      expect(written?.groupState, SyncPlayGroupState.paused);
    });

    test('NotInGroup for a failed join does not stop local playback', () {
      final calls = <String>[];
      final handler = _handler(calls: calls);

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'NotInGroup',
        'Data': <String, dynamic>{'GroupId': 'g', 'Data': ''},
      }, SyncPlayState(isInGroup: false));

      expect(calls, ['joinFailed']);
    });

    test('NotInGroup while in a group tears playback down and reports the kick', () {
      final calls = <String>[];
      final handler = _handler(calls: calls);

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'NotInGroup',
        'Data': <String, dynamic>{'GroupId': 'g', 'Data': ''},
      }, SyncPlayState(isInGroup: true, groupId: 'g'));

      expect(calls, ['leftOrKicked', 'gone:true', 'joinFailed']);
    });

    test('GroupDoesNotExist for a stale id does not stop local playback', () {
      final calls = <String>[];
      final handler = _handler(calls: calls);

      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'GroupDoesNotExist',
        'Data': <String, dynamic>{'GroupId': 'g', 'Data': ''},
      }, SyncPlayState(isInGroup: false));

      expect(calls, ['joinFailed']);
    });
  });

  group('SyncPlayMessageHandler play queue', () {
    test('stores the playlist, playing index and starts playback with the reason', () {
      final calls = <String>[];
      SyncPlayState? written;
      final handler = _handler(
        calls: calls,
        onStateUpdate: (updater) => written = updater(SyncPlayState(isInGroup: true)),
      );

      handler.handleGroupUpdate(
        _playQueue(
          reason: 'NewPlaylist',
          items: const [('a', 'pa'), ('b', 'pb'), ('c', 'pc')],
          playingItemIndex: 1,
          startPositionTicks: 5000,
        ),
        SyncPlayState(isInGroup: true),
      );

      expect(calls, ['start:b:5000:NewPlaylist']);
      expect(written?.playlist.length, 3);
      expect(written?.playingItemIndex, 1);
      expect(written?.playlistItemId, 'pb');
      expect(written?.playingItemId, 'b');
    });

    test('stores the frame timing for position extrapolation', () {
      final calls = <String>[];
      SyncPlayState? written;
      final handler = _handler(
        calls: calls,
        onStateUpdate: (updater) => written = updater(SyncPlayState(isInGroup: true)),
      );
      final at = DateTime.utc(2026, 9, 2, 12, 0, 0);

      handler.handleGroupUpdate(
        _playQueue(
          reason: 'NewPlaylist',
          items: [('item-1', 'plist-1')],
          startPositionTicks: 5000,
          isPlaying: true,
          lastUpdate: at,
        ),
        SyncPlayState(isInGroup: true),
      );

      final timing = written?.queueTiming;
      expect(timing, isNotNull);
      expect(timing?.startPositionTicks, 5000);
      expect(timing?.isPlaying, isTrue);
      expect(timing?.lastUpdate, at);
    });

    test('an older PlayQueue frame is ignored', () {
      final calls = <String>[];
      final handler = _handler(calls: calls);
      final now = DateTime.now().toUtc();

      handler.handleGroupUpdate(
        _playQueue(reason: 'NewPlaylist', items: const [('a', 'pa')], lastUpdate: now),
        SyncPlayState(isInGroup: true),
      );
      handler.handleGroupUpdate(
        _playQueue(
          reason: 'NewPlaylist',
          items: const [('z', 'pz')],
          lastUpdate: now.subtract(const Duration(seconds: 1)),
        ),
        SyncPlayState(isInGroup: true, playingItemId: 'a'),
      );

      expect(calls, ['start:a:0:NewPlaylist']);
    });

    test('a rejoin accepts a PlayQueue frame with an unchanged LastUpdate', () {
      final calls = <String>[];
      final handler = _handler(calls: calls);
      final now = DateTime.now().toUtc();
      final frame = _playQueue(reason: 'NewPlaylist', items: const [('a', 'pa')], lastUpdate: now);

      handler.handleGroupUpdate(frame, SyncPlayState(isInGroup: true));
      handler.handleGroupUpdate(<String, dynamic>{
        'Type': 'GroupJoined',
        'Data': <String, dynamic>{'GroupId': 'g', 'GroupName': 'n', 'State': 'Waiting', 'Participants': []},
      }, SyncPlayState(isInGroup: true));
      handler.handleGroupUpdate(frame, SyncPlayState(isInGroup: true, playingItemId: 'a'));

      expect(calls, ['start:a:0:NewPlaylist', 'joined', 'start:a:0:NewPlaylist']);
    });

    test('an empty playlist clears the playing item without starting playback', () {
      final calls = <String>[];
      SyncPlayState? written;
      final handler = _handler(
        calls: calls,
        onStateUpdate: (updater) => written = updater(SyncPlayState(isInGroup: true, playingItemId: 'a')),
      );

      handler.handleGroupUpdate(
        _playQueue(reason: 'NewPlaylist', items: const [], playingItemIndex: -1),
        SyncPlayState(isInGroup: true, playingItemId: 'a'),
      );

      expect(calls, isEmpty);
      expect(written?.playingItemId, isNull);
      expect(written?.playingItemIndex, -1);
    });
  });
}
